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
                DataTable dt = objBLL.GetJobRegistrations(txtSearchSkill.Text.Trim(), txtSearchLocation.Text.Trim(), ddlSearchExperience.SelectedValue);
                rptJobs.DataSource = dt;
                rptJobs.DataBind();
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
