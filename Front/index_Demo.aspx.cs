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
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindData();
            if (Request["Logout"] != null)
            {
                if (Request["Logout"] == "1")
                {
                    Session.Abandon();
                    Session.Clear();
                    Session.RemoveAll();
                    Response.Redirect("http://faduprice.in/Pages/Index.aspx?Logout=true");
                }
            }
        }

        private void BindData()
        {
            int index = -1;
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                using (DataSet dsMain = objFp.GetHomePageData())
                {
                    index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {
                                rptSlider.DataSource = dt;
                                rptSlider.DataBind();

                                string Bullets = "";
                                for (int i = 0; i < dt.Rows.Count; i++)
                                {
                                    Bullets += " <li  class='MyBullets' data-target='#myCarousel' data-slide-to='"+i+"'></li>";
                                }
                                litBullets.Text = Bullets;
                            }
                        }
                    }

                    index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {
                                rptWomenCollection.DataSource = dt;
                                rptWomenCollection.DataBind();
                                divWomenCollNoRecord.Visible = false;
                            }
                            else
                            {
                                divWomenCollNoRecord.Visible = true;
                            
                            }
                        }
                    }

                    index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {
                                rptMenCollection.DataSource = dt;
                                rptMenCollection.DataBind();
                                divMenCollNoRecord.Visible = false;

                            }
                            else
                            {
                                divMenCollNoRecord.Visible = true;
                            }
                        }
                    }

                    index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {

                            }
                        }
                    }

                }
            }
        }

        #region "LoginDetails"

        [WebMethod(EnableSession = true)]
        public static string LoginDetails(string UserName, string Password)
        {
            //System.Threading.Thread.Sleep(2000);
            return CheckLoginDetails(UserName, Password);
        }
        public static string CheckLoginDetails(string UserName, string Password)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.Name = UserName;
                objFp.Password = Password;
                using (DataSet dsMain = objFp.GetLoginFrontDetails())
                {
                    using (DataTable LoginDetails = dsMain.Tables[0])
                    {
                        if (LoginDetails.Rows.Count > 0)
                        {
                            HttpContext context = HttpContext.Current;
                            context.Session["UserName"] = LoginDetails.Rows[0]["FirstName"].ToString();
                            context.Session["UserId"] = LoginDetails.Rows[0]["UserId"].ToString();
                            return Newtonsoft.Json.JsonConvert.SerializeObject(LoginDetails);
                        }
                        else
                        {
                            return "";
                        }

                    }
                }
            }
        }
        #endregion


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindCart(string UserId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = UserId;
                using (DataSet ds = obj.BindCart())
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                    return rtrn;
                }
                
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string RemoveCartItem(string CartId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.ItemId = Convert.ToInt32(CartId);
                obj.RemoveCartItem();
                return "";
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Logout(string TestId)
        {
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.RemoveAll();
            HttpContext.Current.Response.Redirect("http://faduprice.in/Pages/Index.aspx?Logout=1");
            return "";   
        }
    }
}