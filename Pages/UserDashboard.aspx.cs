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
                lblEmployeeName.Text = Session["EmployeeName"].ToString();
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
                using (DataTable dt = obj.GetDashboardROLEWISEMENU(RoleID))
                {
                    lvMenu.DataSource = dt;
                    lvMenu.DataBind();
                }
            }
        }
        
    }
}