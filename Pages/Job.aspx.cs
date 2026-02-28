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

        private void BindJobs()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                DataTable dt = objBLL.GetJobRegistrations(txtSearchSkill.Text.Trim(), txtSearchLocation.Text.Trim(), ddlSearchExperience.SelectedValue);
                rptJobs.DataSource = dt;
                rptJobs.DataBind();
            }
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
