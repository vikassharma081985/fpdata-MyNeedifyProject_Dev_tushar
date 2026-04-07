using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using BLL;

namespace WSBillingMaster.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string ValidateUser(string User, string Password)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.UserName = User;
                objBLL.Password = Password;
                using (DataTable dt = objBLL.GetLoginDetails())
                {
                    if (dt.Rows.Count > 0)
                    {
                        HttpContext.Current.Session["EmployeeId"] = dt.Rows[0]["EmployeeId"].ToString();
                        HttpContext.Current.Session["EmployeeName"] = dt.Rows[0]["EmployeeName"].ToString();
                        HttpContext.Current.Session["RoleId"] = dt.Rows[0]["RoleId"].ToString();
                        HttpContext.Current.Session["UserId"] = dt.Rows[0]["EmployeeId"].ToString();
                        HttpContext.Current.Session["OrgId"] = dt.Rows[0]["OrgId"].ToString();      //2026-01-11 by HEMANT
                        return "1";
                    }
                    else
                        return "0";
                }
            }
        }
    }
}