using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using BLL;

namespace WSBillingMaster.Pages
{
    public partial class RegistrationList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null || Session["UserId"] == null)
            {
                Session.Clear();
                Session.Abandon();

                Response.Clear();
                Response.Write(@"
                    <script type='text/javascript'>
                        alert('Please login first to use this tool.');
                        window.location.href='/Front/Index.aspx';
                    </script>
                ");

                HttpContext.Current.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                BindRegistrationList();
            }
        }

        private void BindRegistrationList()
        {
            try
            {
                using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                {
                    DataTable dt = objBLL.GetRegistrationList();
                    gvRegistrations.DataSource = dt;
                    gvRegistrations.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading registrations: " + ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }

        protected void gvRegistrations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int regId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditReg")
            {
                Response.Redirect("Registration.aspx?RegId=" + regId);
            }
            else if (e.CommandName == "DeleteReg")
            {
                DeleteRegistration(regId);
            }
        }

        private void DeleteRegistration(int regId)
        {
            try
            {
                using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                {
                    objBLL.RegId = regId;
                    int result = objBLL.DeleteRegistration();
                    if (result > 0)
                    {
                        lblMessage.Text = "Registration deleted successfully!";
                        lblMessage.CssClass = "text-success";
                        BindRegistrationList();
                    }
                    else
                    {
                        BindRegistrationList();
                        //lblMessage.Text = "Error deleting registration.";
                        //lblMessage.CssClass = "text-danger";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }
    }
}
