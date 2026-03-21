using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Microsoft.VisualBasic.Logging;

namespace WSBillingMaster.Pages
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    // Skip check on login page
            //    if (Request.Url.AbsolutePath.ToLower().Contains("index.aspx"))
            //        return;

                //    if (Session["UserName"] == null || Session["UserId"] == null)
                //    {
                //        Session.Clear();
                //        Session.Abandon();

                //        ScriptManager.RegisterStartupScript(
                //            this,
                //            this.GetType(),
                //            "SessionExpired",
                //            "alert('Please login first to use this tool.'); window.location.href='/Front/Index.aspx';",
                //            true
                //        );
                //    }
                //}

            if (Session["OrgId"] != null)
            {
                bindSellerLogo(Convert.ToInt32(Session["OrgId"]));
            }            
            
            else if (Session["UserName"] != null || Session["UserId"] != null)
            {
                imgSellerLogo.Src = "../Images/system/mylogo.png";
            }

            else
            {
                Response.Redirect("Login.aspx");
            }

        }

        public void bindSellerLogo(int OrgId)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                DataTable dt = objBLL.GetSellerLogoBySellerId(OrgId);
                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    imgSellerLogo.Src = dr["Logo"]?.ToString();
                }
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "Logout",
                "alert('You have been logged out successfully.'); window.location.href='/Front/Index.aspx';",
                true
            );
        }
    }
}