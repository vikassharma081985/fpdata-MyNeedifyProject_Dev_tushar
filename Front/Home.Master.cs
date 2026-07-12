using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using BLL;

namespace FaduPrice.Pages
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected string appURL;
        protected void Page_Load(object sender, EventArgs e)
        {
            appURL = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
            if (!appURL.EndsWith("/")) appURL += "/";
            //Session["UserId"] ="1";
            //Session["UserName"] = "Apoorv";

            //if (!Request.Browser.IsMobileDevice)
            //{
            //    Response.Redirect("http://faduprice.in");
            //}
            // Always set UserId hidden field and UI state on every page load (not just first)
            if (Session["UserId"] != null && Session["UserName"] != null)
            {
                MasterhdnUserId.Value = Session["UserId"].ToString();
                string orgScript = Session["OrgId"] != null ? "$('[id$=SellerDashboard]').show();" : "$('[id$=SellerDashboard]').hide();";
                string script = $@"
                    (function() {{
                        $('[id$=lblUserName]').text('Hi, {Session["UserName"]}');
                        $('[id$=LoggedinUser]').show();
                        $('[id$=NotLoggedIn]').hide();
                        $('[id$=lnkLogin]').hide();
                        $('[id$=lnkLogout]').show();
                        {orgScript}
                    }})();
                ";
                ScriptManager.RegisterStartupScript(this, GetType(), "LoginState", script, true);
            }

            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["UserName"] != null)
                {
                    BindNotifications(Convert.ToInt32(Session["UserId"]));
                    BindAddress(Convert.ToInt32(Session["UserId"]));
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
        }

        public void BindAddress(int userId)
        {
            StringBuilder sb = new StringBuilder();

            using (BusinessLogicLayer objBll = new BusinessLogicLayer())
            {
                objBll.IntUserId = userId;

                using (DataTable dt = objBll.GetUserAddressV1())
                {
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        int count = 0;

                        foreach (DataRow row in dt.Rows)
                        {
                            string contactId = Convert.ToString(row["ContactId"]);
                            string mobile = Convert.ToString(row["Mobile"]);
                            string name = Convert.ToString(row["Name"]);
                            string building = Convert.ToString(row["Building"]);
                            string locality = Convert.ToString(row["Locality"]);
                            string city = Convert.ToString(row["City"]);
                            string state = Convert.ToString(row["State"]);
                            string pincode = Convert.ToString(row["Pincode"]);

                            string activeClass = count == 0 ? "active" : "";

                            sb.Append($@"
                    <div class='location-box {activeClass}'>
                        <div style='display: flex; justify-content: space-between; align-items: center;'>
                            <div class='location-name'>{name}</div>
                            <a href='#' class='edit-address-link' style='color: #7C519B; font-weight: bold; font-size: 12px;'
                               data-id='{contactId}'
                               data-name='{System.Web.HttpUtility.HtmlAttributeEncode(name)}'
                               data-mobile='{System.Web.HttpUtility.HtmlAttributeEncode(mobile)}'
                               data-building='{System.Web.HttpUtility.HtmlAttributeEncode(building)}'
                               data-locality='{System.Web.HttpUtility.HtmlAttributeEncode(locality)}'
                               data-city='{System.Web.HttpUtility.HtmlAttributeEncode(city)}'
                               data-state='{System.Web.HttpUtility.HtmlAttributeEncode(state)}'
                               data-pincode='{System.Web.HttpUtility.HtmlAttributeEncode(pincode)}'
                               onclick='event.stopPropagation(); OpenEditAddressModal(this); return false;'>
                                <i class='fa fa-edit'></i> Edit
                            </a>
                        </div>

                        <div class='location-address'>
                            {building}, {locality}, {city},
                            {state} - {pincode}
                        </div>");

                            if (count == 0)
                            {
                                sb.Append("<div class='default-tag'>Default address</div>");
                            }

                            sb.Append("</div>");

                            count++;
                        }
                    }
                    else
                    {
                        sb.Append(@"
                <div class='text-center' style='padding:20px;'>
                    No address found
                </div>");
                    }
                }
            }

            divUserAddresses.InnerHtml = sb.ToString();
        }
        //if (divNotificationsMobile != null) divNotificationsMobile.InnerHtml = notificationHtml;
        //if (divNotificationsDesktop != null) divNotificationsDesktop.InnerHtml = notificationHtml;
    }
}