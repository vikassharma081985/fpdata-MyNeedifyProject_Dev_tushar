using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        public string RoleId = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeId"] != null && Session["RoleId"] != null)
            {
                RoleId = Session["RoleId"].ToString();
                BindRoleWiseMenu(Convert.ToInt32(RoleId));
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void BindRoleWiseMenu(int RoleID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                bool isSuperAdmin = obj.IsSuperAdminRole(RoleID);
                bool isAdmin = obj.IsAdminRole(RoleID);
                bool canManageHierarchy = isSuperAdmin || isAdmin;
                Session["IsSuperAdmin"] = isSuperAdmin;
                Session["IsAdmin"] = isAdmin;
                Session["CanManageHierarchy"] = canManageHierarchy;

                using (DataTable dt = obj.GetDashboardROLEWISEMENU(RoleID))
                {
                    DataTable menuDt = (dt != null) ? dt.Copy() : new DataTable();

                    if (!menuDt.Columns.Contains("MenuName")) menuDt.Columns.Add("MenuName", typeof(string));
                    if (!menuDt.Columns.Contains("MenuUrl")) menuDt.Columns.Add("MenuUrl", typeof(string));
                    if (!menuDt.Columns.Contains("MenuClass")) menuDt.Columns.Add("MenuClass", typeof(string));

                    bool hasHierarchyMenu = false;
                    for (int i = menuDt.Rows.Count - 1; i >= 0; i--)
                    {
                        DataRow row = menuDt.Rows[i];
                        string url = row["MenuUrl"] != null ? row["MenuUrl"].ToString() : "";
                        if (url.IndexOf("ManageTeamHierarchy.aspx", StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            if (!canManageHierarchy)
                            {
                                menuDt.Rows.RemoveAt(i);
                            }
                            else
                            {
                                hasHierarchyMenu = true;
                            }
                        }
                    }

                    // For Super Admin and Admin: ensure Employee Hierarchy tile appears on dashboard
                    if (canManageHierarchy && !hasHierarchyMenu)
                    {
                        DataRow newRow = menuDt.NewRow();
                        newRow["MenuName"] = "Employee Hierarchy";
                        newRow["MenuUrl"] = "ManageTeamHierarchy.aspx";
                        newRow["MenuClass"] = "glyphicon-tree-conifer";
                        menuDt.Rows.Add(newRow);
                    }

                    lvMenu.DataSource = menuDt;
                    lvMenu.DataBind();
                }
            }
        }
    }
}
