using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL;

namespace WSBillingMaster.Pages
{
    public partial class Job : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindJobs();
            }
        }

        private System.Collections.Generic.List<int> _hiredRegIds = new System.Collections.Generic.List<int>();

        private void BindJobs()
        {
            if (Session["UserId"] != null)
            {
                using (BusinessLogicLayer bll = new BusinessLogicLayer())
                {
                    bll.IntUserId = Convert.ToInt32(Session["UserId"]);
                    DataTable hiredDt = bll.GetHiredRegIdsByUser();
                    if (hiredDt != null && hiredDt.Rows.Count > 0)
                    {
                        foreach (DataRow row in hiredDt.Rows)
                        {
                            _hiredRegIds.Add(Convert.ToInt32(row["RegId"]));
                        }
                    }
                }
            }

            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                string category = selectedJobCategory.Value;
                string keyword = txtSearchSkill.Text.Trim();
                string skill = category.Length == 0 ? keyword : category;
                DataTable registrations = objBLL.GetJobRegistrations(
                    skill, txtSearchLocation.Text.Trim(), ddlSearchExperience.SelectedValue);

                if (registrations != null && category.Length > 0)
                {
                    for (int index = registrations.Rows.Count - 1; index >= 0; index--)
                    {
                        string registeredSkill = Convert.ToString(registrations.Rows[index]["Skill"]).Trim();
                        if (!string.Equals(registeredSkill, category, StringComparison.OrdinalIgnoreCase) ||
                            registeredSkill.IndexOf(keyword, StringComparison.OrdinalIgnoreCase) < 0)
                        {
                            registrations.Rows.RemoveAt(index);
                        }
                    }
                }

                rptJobs.DataSource = registrations;
                rptJobs.DataBind();
                jobSearchEmpty.Visible = rptJobs.Items.Count == 0;
            }
        }

        protected bool IsCandidateHired(int regId)
        {
            return _hiredRegIds.Contains(regId);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindJobs();
        }

        protected void rptJobs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            //if (e.CommandName == "Hire")
            //{
            //    int regId = Convert.ToInt32(e.CommandArgument);
            //    Response.Redirect("Registration.aspx?RegId=" + regId);
            //}
        }
    }
}
