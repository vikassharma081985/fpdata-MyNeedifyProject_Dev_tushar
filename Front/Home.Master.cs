using BLL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace FaduPrice.Pages
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected string appURL;
        protected void Page_Load(object sender, EventArgs e)
        {
            appURL = ConfigurationManager.AppSettings["appURL"];
            //Session["UserId"] ="1";
            //Session["UserName"] = "Apoorv";

            //if (!Request.Browser.IsMobileDevice)
            //{
            //    Response.Redirect("http://faduprice.in");
            //}
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["UserName"] != null)
                { //Modified by SHubham at late night, dont trust //////////////////////////////////////////////////////
                   /* MasterhdnUserId.Value = Session["UserId"].ToString();
                    LoggedinUser.Style["display"] = "";
                    lnkLogin.Style["display"] = "none";
                    lblUserName.Style["display"] = "";
                    lnkLogout.Style["display"] = "";
                    lblUserName.InnerText = "Hi, " + Session["UserName"].ToString();// +" <span class='caret'></span> "; */
                    //UserName1.Text = "Welcome ,"+ Session["UserName"].ToString();
                    
                    //UserName1.Text = "Welcome ,"+ Session["UserName"].ToString();
                    BindNotifications(Convert.ToInt32(Session["UserId"]));
                }
                GetMenu();

            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("https://myneedify.com//Front/Index.aspx");
        }
               
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {

                objFp.FirstName = txtFirstName.Text;
                objFp.LastName = txtLastName.Text;
                objFp.Mobile = txtMobile.Text;
                objFp.Email = txtEmail.Text;
                objFp.Password = txtPassword1.Text;
                using (DataTable dt = objFp.SaveSignUp())
                {
                    if (dt.Rows.Count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Thankyou for signing up with us. Login to continue');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Provided Email is already exists.');", true);

                    }

                }
            }
        }
        public void GetMenu()
        {
            string MenuString = string.Empty;
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                MenuString = objFp.GetMenuData();
            }
            divmenu.InnerHtml = MenuString;
            //return MenuString;
            //dbo.GetMenus
        }

        public void BindNotifications(int userId)
        {
            string notificationHtml = "";
            using (BusinessLogicLayer objBll = new BusinessLogicLayer())
            {
                objBll.IntUserId = userId;
                using (DataTable dt = objBll.GetHiringDetailsByUserId("Requested"))
                {
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string hireId = row["HireId"].ToString();
                            string companyName = row["CompanyName"] != DBNull.Value ? row["CompanyName"].ToString() : "Service";
                            string title = string.Format("New Request from {0}", companyName);
                            notificationHtml += string.Format("<a href=\"../Pages/NewHire.aspx?HireId={0}\" class=\"dropdown-item\">{1}</a>", hireId, title);
                        }
                    }
                    else
                    {
                        notificationHtml = "<span class=\"dropdown-item text-muted\">No notifications</span>";
                    }
                }
            }
            if (divNotificationsMobile != null) divNotificationsMobile.InnerHtml = notificationHtml;
            if (divNotificationsDesktop != null) divNotificationsDesktop.InnerHtml = notificationHtml;
        }                
    }
}