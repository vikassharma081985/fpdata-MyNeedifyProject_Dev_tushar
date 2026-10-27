using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class ManageTeamHierarchy : System.Web.UI.Page
    {
        private int CurrentRoleId = 0;
        private int CurrentUserId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Authentication Check
            if (Session["EmployeeId"] == null && Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (Session["RoleId"] != null)
            {
                int.TryParse(Session["RoleId"].ToString(), out CurrentRoleId);
            }

            if (Session["UserId"] != null)
            {
                int.TryParse(Session["UserId"].ToString(), out CurrentUserId);
            }
            else if (Session["EmployeeId"] != null)
            {
                int.TryParse(Session["EmployeeId"].ToString(), out CurrentUserId);
            }

            // 2. Authorization Check: Super Admin and Admin Roles
            using (BusinessLogicLayer bll = new BusinessLogicLayer())
            {
                bool isSuperAdmin = bll.IsSuperAdminRole(CurrentRoleId);
                bool isAdmin = bll.IsAdminRole(CurrentRoleId);
                bool canManage = isSuperAdmin || isAdmin;
                Session["IsSuperAdmin"] = isSuperAdmin;
                Session["IsAdmin"] = isAdmin;

                if (!canManage)
                {
                    pnlAccessDenied.Visible = true;
                    pnlMainContent.Visible = false;
                    return;
                }
            }

            pnlAccessDenied.Visible = false;
            pnlMainContent.Visible = true;

            if (!IsPostBack)
            {
                BindOrganizations();
            }
        }

        private void BindOrganizations()
        {
            using (BusinessLogicLayer bll = new BusinessLogicLayer())
            {
                bool isSuperAdmin = Session["IsSuperAdmin"] != null && (bool)Session["IsSuperAdmin"];
                int sessionOrgId = 0;
                if (Session["OrgId"] != null)
                {
                    int.TryParse(Session["OrgId"].ToString(), out sessionOrgId);
                }

                DataTable dtOrgs = bll.GetOrganizationsList();
                if (dtOrgs != null && dtOrgs.Rows.Count > 0)
                {
                    if (!isSuperAdmin && sessionOrgId > 0)
                    {
                        // Admin role: scoped to their assigned organization
                        DataView dv = dtOrgs.DefaultView;
                        dv.RowFilter = "OrgId = " + sessionOrgId;
                        DataTable dtFiltered = dv.ToTable();
                        if (dtFiltered.Rows.Count > 0)
                        {
                            ddlOrganization.DataSource = dtFiltered;
                            ddlOrganization.DataTextField = "OrgName";
                            ddlOrganization.DataValueField = "OrgId";
                            ddlOrganization.DataBind();
                            ddlOrganization.SelectedValue = sessionOrgId.ToString();
                            ddlOrganization.Enabled = false;
                            lblSelectedOrgInfo.Text = "<span class='label label-info' style='font-size:12px;'><span class='glyphicon glyphicon-lock'></span> Organization: " + dtFiltered.Rows[0]["OrgName"].ToString() + " (Admin View)</span>";
                        }
                        else
                        {
                            ddlOrganization.DataSource = dtOrgs;
                            ddlOrganization.DataTextField = "OrgName";
                            ddlOrganization.DataValueField = "OrgId";
                            ddlOrganization.DataBind();
                            if (ddlOrganization.Items.FindByValue(sessionOrgId.ToString()) != null)
                                ddlOrganization.SelectedValue = sessionOrgId.ToString();
                            ddlOrganization.Enabled = false;
                        }
                    }
                    else
                    {
                        // Super Admin: can view and manage any organization
                        ddlOrganization.DataSource = dtOrgs;
                        ddlOrganization.DataTextField = "OrgName";
                        ddlOrganization.DataValueField = "OrgId";
                        ddlOrganization.DataBind();
                        ddlOrganization.Enabled = true;

                        // Pre-select current Session OrgId if available
                        if (sessionOrgId > 0 && ddlOrganization.Items.FindByValue(sessionOrgId.ToString()) != null)
                        {
                            ddlOrganization.SelectedValue = sessionOrgId.ToString();
                        }
                    }

                    LoadHierarchyForSelectedOrg();
                }
                else
                {
                    ddlOrganization.Items.Clear();
                    ddlOrganization.Items.Add(new ListItem("No Organizations Found", "0"));
                    lblSelectedOrgInfo.Text = "";
                    litSimpleTree.Text = "<div class='text-muted'>No organizations found.</div>";
                    rptEmployees.DataSource = null;
                    rptEmployees.DataBind();
                }
            }
        }

        protected void ddlOrganization_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMsg.Text = "";
            LoadHierarchyForSelectedOrg();
        }

        private void LoadHierarchyForSelectedOrg()
        {
            int orgId = 0;
            if (ddlOrganization.SelectedValue != null)
            {
                int.TryParse(ddlOrganization.SelectedValue, out orgId);
            }

            lblSelectedOrgInfo.Text = orgId > 0 ? ("Selected Org ID: " + orgId) : "";

            using (BusinessLogicLayer bll = new BusinessLogicLayer())
            {
                // 1. Bind Employee Dropdown for this Org
                DataTable dtEmps = bll.GetEmployeesByOrg(orgId);
                ddlEmployee.Items.Clear();
                ddlEmployee.Items.Add(new ListItem("-- Select Employee to Assign --", "0"));

                if (dtEmps != null && dtEmps.Rows.Count > 0)
                {
                    foreach (DataRow row in dtEmps.Rows)
                    {
                        string empName = row["FullName"].ToString();
                        string empId = row["EmployeeId"] != DBNull.Value ? row["EmployeeId"].ToString() : "";
                        string role = row["RoleName"] != DBNull.Value ? row["RoleName"].ToString() : "";
                        string label = empName + " (" + role + (string.IsNullOrEmpty(empId) ? "" : " - " + empId) + ")";
                        ddlEmployee.Items.Add(new ListItem(label, row["UserId"].ToString()));
                    }
                }

                // Reset Manager Dropdown
                BindManagerDropdown(0, orgId, 0);

                // 2. Fetch and Bind Hierarchy for this Org
                DataTable dtHierarchy = bll.GetTeamHierarchy(orgId > 0 ? (int?)orgId : null, null, null);

                if (dtHierarchy != null && dtHierarchy.Rows.Count > 0)
                {
                    rptEmployees.DataSource = dtHierarchy;
                    rptEmployees.DataBind();

                    litSimpleTree.Text = BuildSimpleTreeHtml(dtHierarchy);
                }
                else
                {
                    rptEmployees.DataSource = null;
                    rptEmployees.DataBind();
                    litSimpleTree.Text = "<div class='text-muted' style='padding:15px;'><span class='glyphicon glyphicon-info-sign'></span> No employees found for this organization.</div>";
                }
            }
        }

        protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMsg.Text = "";
            int selectedEmpId = 0;
            int.TryParse(ddlEmployee.SelectedValue, out selectedEmpId);

            int orgId = 0;
            int.TryParse(ddlOrganization.SelectedValue, out orgId);

            if (selectedEmpId > 0)
            {
                // Find current manager of selected employee
                int currentManagerId = 0;
                using (BusinessLogicLayer bll = new BusinessLogicLayer())
                {
                    DataTable dtHierarchy = bll.GetTeamHierarchy(orgId > 0 ? (int?)orgId : null, null, null);
                    if (dtHierarchy != null)
                    {
                        foreach (DataRow r in dtHierarchy.Rows)
                        {
                            if (Convert.ToInt32(r["UserId"]) == selectedEmpId)
                            {
                                if (r["ManagerId"] != DBNull.Value)
                                    int.TryParse(r["ManagerId"].ToString(), out currentManagerId);
                                break;
                            }
                        }
                    }
                }

                BindManagerDropdown(selectedEmpId, orgId, currentManagerId);
            }
            else
            {
                BindManagerDropdown(0, orgId, 0);
            }
        }

        private void BindManagerDropdown(int selectedEmpId, int orgId, int currentManagerId)
        {
            ddlManager.Items.Clear();
            ddlManager.Items.Add(new ListItem("-- None (Top Level / Head of Org) --", "0"));

            if (selectedEmpId > 0 && orgId > 0)
            {
                using (BusinessLogicLayer bll = new BusinessLogicLayer())
                {
                    DataTable dtPotential = bll.GetPotentialManagers(selectedEmpId, orgId);
                    if (dtPotential != null && dtPotential.Rows.Count > 0)
                    {
                        foreach (DataRow r in dtPotential.Rows)
                        {
                            string mgrName = r["FullName"].ToString();
                            string role = r["RoleName"] != DBNull.Value ? r["RoleName"].ToString() : "";
                            ddlManager.Items.Add(new ListItem(mgrName + " (" + role + ")", r["UserId"].ToString()));
                        }
                    }
                }

                if (currentManagerId > 0 && ddlManager.Items.FindByValue(currentManagerId.ToString()) != null)
                {
                    ddlManager.SelectedValue = currentManagerId.ToString();
                }
            }
        }

        protected void btnSaveHierarchy_Click(object sender, EventArgs e)
        {
            int selectedEmpId = 0;
            int.TryParse(ddlEmployee.SelectedValue, out selectedEmpId);

            if (selectedEmpId <= 0)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Please select an employee first.";
                return;
            }

            int selectedMgrId = 0;
            int.TryParse(ddlManager.SelectedValue, out selectedMgrId);

            int? newManagerId = (selectedMgrId > 0) ? (int?)selectedMgrId : null;

            using (BusinessLogicLayer bll = new BusinessLogicLayer())
            {
                string message;
                bool success = bll.UpdateUserManager(selectedEmpId, newManagerId, CurrentUserId, out message);

                if (success)
                {
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "<span class='glyphicon glyphicon-ok'></span> " + message;
                    LoadHierarchyForSelectedOrg();
                }
                else
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "<span class='glyphicon glyphicon-exclamation-sign'></span> " + message;
                }
            }
        }

        protected void lnkSelectEmp_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string userId = btn.CommandArgument;

            if (ddlEmployee.Items.FindByValue(userId) != null)
            {
                ddlEmployee.SelectedValue = userId;
                ddlEmployee_SelectedIndexChanged(sender, e);
            }
        }

        protected void lnkMakeRoot_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int userId = Convert.ToInt32(btn.CommandArgument);

            using (BusinessLogicLayer bll = new BusinessLogicLayer())
            {
                string msg;
                bool success = bll.UpdateUserManager(userId, null, CurrentUserId, out msg);
                if (success)
                {
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "<span class='glyphicon glyphicon-ok'></span> Employee promoted to Top Level (Root).";
                    LoadHierarchyForSelectedOrg();
                }
                else
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "<span class='glyphicon glyphicon-exclamation-sign'></span> " + msg;
                }
            }
        }

        public string GetLevelCss(object levelObj)
        {
            if (levelObj == null || levelObj == DBNull.Value) return "lvl-1";
            int lvl = Convert.ToInt32(levelObj);
            switch (lvl)
            {
                case 1: return "lvl-1";
                case 2: return "lvl-2";
                case 3: return "lvl-3";
                default: return "lvl-4";
            }
        }

        private string BuildSimpleTreeHtml(DataTable dt)
        {
            if (dt == null || dt.Rows.Count == 0) return "";

            var allRows = dt.AsEnumerable().ToList();
            var managerLookup = allRows.ToLookup(r =>
            {
                if (r["ManagerId"] == DBNull.Value || Convert.ToInt32(r["ManagerId"]) == 0)
                    return 0;
                return Convert.ToInt32(r["ManagerId"]);
            });

            var rootMembers = managerLookup[0].ToList();

            if (rootMembers.Count == 0 && allRows.Count > 0)
            {
                int minLevel = allRows.Min(r => Convert.ToInt32(r["HierarchyLevel"]));
                rootMembers = allRows.Where(r => Convert.ToInt32(r["HierarchyLevel"]) == minLevel).ToList();
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<ul>");
            foreach (var root in rootMembers)
            {
                RenderSimpleNode(sb, root, managerLookup);
            }
            sb.Append("</ul>");

            return sb.ToString();
        }

        private void RenderSimpleNode(StringBuilder sb, DataRow row, ILookup<int, DataRow> lookup)
        {
            int userId = Convert.ToInt32(row["UserId"]);
            string fullName = row["FullName"].ToString();
            string roleName = row["RoleName"] != DBNull.Value ? row["RoleName"].ToString() : "Employee";
            string empId = row["EmployeeId"] != DBNull.Value ? row["EmployeeId"].ToString() : "";
            int level = row["HierarchyLevel"] != DBNull.Value ? Convert.ToInt32(row["HierarchyLevel"]) : 1;

            var children = lookup[userId].ToList();
            bool isRoot = (level == 1);

            sb.Append("<li>");
            sb.Append("<div class='emp-badge-card " + (isRoot ? "is-root" : "is-sub") + "'>");
            sb.Append("<span class='glyphicon " + (isRoot ? "glyphicon-user" : "glyphicon-arrow-right") + "' style='margin-right:5px; color:" + (isRoot ? "#8e44ad" : "#3498db") + ";'></span>");
            sb.Append("<strong>" + HttpUtility.HtmlEncode(fullName) + "</strong>");
            sb.Append("<span class='emp-role-tag'>" + HttpUtility.HtmlEncode(roleName) + "</span>");
            sb.Append("<span class='emp-level-tag " + GetLevelCss(level) + "'>Level " + level + "</span>");
            if (!string.IsNullOrEmpty(empId))
            {
                sb.Append(" <small class='text-muted' style='margin-left:4px;'>(" + HttpUtility.HtmlEncode(empId) + ")</small>");
            }
            sb.Append("</div>");

            if (children.Count > 0)
            {
                sb.Append("<ul>");
                foreach (var child in children)
                {
                    RenderSimpleNode(sb, child, lookup);
                }
                sb.Append("</ul>");
            }

            sb.Append("</li>");
        }
    }
}
