using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FaduPrice.Pages
{
    public partial class MyAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Session["UserId"] = "1";
                if (Session["UserId"] != null)
                {
                    BindData();
                    hdnUserId.Value = Session["UserId"].ToString(); 
                }
                else
                {
                    Response.Redirect("https://myneedify.com//Front/Index.aspx");
                }
            }
        }

        private void BindData()
        {
            int tabIndex = -1;
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.UserId = Session["UserId"].ToString();

                using (DataSet dsMain = objFp.GetMyAccountData())
                {
                    tabIndex++;
                    using (DataTable dt = dsMain.Tables[tabIndex])
                    {
                        if (dt.Rows.Count > 0)
                        {
                            txtFirstName.Text = dt.Rows[0]["FirstName"].ToString();
                            txtLastName.Text = dt.Rows[0]["LastName"].ToString();
                            txtMobile.Text = dt.Rows[0]["Mobile"].ToString();
                            txtEmail.Text = dt.Rows[0]["Email"].ToString();
                            hdnPassword.Value = dt.Rows[0]["Password"].ToString();
                            lblUserName.Text = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
                            lblEmail.Text = dt.Rows[0]["Email"].ToString();
                        }

                    }

                    tabIndex++;
                    //commentedby Raju 
                    using (DataTable dt = dsMain.Tables[tabIndex])
                    {
                        if (dt.Rows.Count > 0)
                        {
                            rptUserAddresss.DataSource = dt;
                            rptUserAddresss.DataBind();
                        }
                    }
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string UpdateUserData(string FirstName,string LastName,string Mobile,string Email,string UserId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = UserId;
                obj.FirstName = FirstName;
                obj.LastName = LastName;
                obj.Email = Email;
                obj.Mobile = Mobile;
                int rowsEffected = obj.UpdateUserData();
                return rowsEffected.ToString();
            }
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string ChangePassword(string Password, string UserId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = UserId;
                obj.Password = Password;
                int rowsEffected = obj.ChangePassword();
                return rowsEffected.ToString();
            }
        }


        
    }
}