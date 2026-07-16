using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
 
namespace FaduPrice.Front
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
                                rptElectronics.DataSource = dt;
                                rptElectronics.DataBind();
                                divElectronicsNoRecord.Visible = false;
                            }
                            else
                            {
                                divElectronicsNoRecord.Visible = true;
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
                objFp.UserName = UserName;
                //objFp.Password = Password;
                string passEncryp = PasswordHelper.HashPasswordSHA256(Password);
                objFp.Password = passEncryp;
                using (DataSet dsMain = objFp.GetLoginFrontDetails())
                {
                    using (DataTable LoginDetails = dsMain.Tables[0])
                    {
                        if (LoginDetails.Rows.Count > 0)
                        {
                            HttpContext context = HttpContext.Current;
                            context.Session["UserName"] = LoginDetails.Rows[0]["FirstName"].ToString();
                            context.Session["UserId"] = LoginDetails.Rows[0]["UserId"].ToString();
                            string orgId = Convert.ToString(LoginDetails.Rows[0]["OrgId"]);

                            if (!string.IsNullOrWhiteSpace(orgId))
                            {
                                context.Session["OrgId"] = orgId;
                                context.Session["RoleId"] = LoginDetails.Rows[0]["RoleId"].ToString();
                                context.Session["EmployeeName"] = LoginDetails.Rows[0]["EmployeeName"].ToString();
                                context.Session["EmployeeId"] = LoginDetails.Rows[0]["EmployeeId"].ToString();
                            }
                            else
                            {
                                context.Session["OrgId"] = null;
                                context.Session["RoleId"] = null;
                                context.Session["EmployeeName"] = null;
                                context.Session["EmployeeId"] = null;
                            }
                            return Newtonsoft.Json.JsonConvert.SerializeObject(LoginDetails);
                        }
                        else
                        {
                            return Newtonsoft.Json.JsonConvert.SerializeObject(LoginDetails);
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

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string RemoveCartItem(string CartId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.ItemId = Convert.ToInt32(CartId);
                obj.LoggedInUser = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
                obj.RemoveCartItem();
                return "";
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Logout(string TestId)
        {
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.RemoveAll();
            HttpContext.Current.Response.Redirect("https://myneedify.com//Front/Index.aspx?Logout=1");
            return "";   
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetMenu()
        {
            string MenuString = string.Empty;
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                MenuString = objFp.GetMenuData();
            }
            return MenuString;
            //dbo.GetMenus
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetNotificationsData(string UserId)
        {
            using (BusinessLogicLayer objBll = new BusinessLogicLayer())
            {
                objBll.IntUserId = Convert.ToInt32(UserId);
                using (DataTable dt = objBll.GetHiringDetailsByUserId("Requested"))
                {
                    string notificationHtml = "";
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
                    return notificationHtml;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetAddressData(string UserId)
        {
            StringBuilder sb = new StringBuilder();

            using (BusinessLogicLayer objBll = new BusinessLogicLayer())
            {
                objBll.IntUserId = Convert.ToInt32(UserId);

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

            return sb.ToString();
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string AddNewAddress(string UserId, string Name, string Mobile, string Building, string Locality, string City, string State, string Pincode)
        {
            using (BusinessLogicLayer objBll = new BusinessLogicLayer())
            {
                objBll.IntUserId = Convert.ToInt32(UserId);
                objBll.Name = Name;
                objBll.Mobile = Mobile;
                objBll.Building = Building;
                objBll.Locality = Locality;
                objBll.City = City;
                objBll.State = State;
                objBll.Pincode = Pincode;

                return objBll.AddNewAddress().ToString();
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string UpdateAddress(string ContactId, string UserId, string Name, string Mobile, string Building, string Locality, string City, string State, string Pincode)
        {
            using (BusinessLogicLayer objBll = new BusinessLogicLayer())
            {
                objBll.ContactId = Convert.ToInt32(ContactId);
                objBll.IntUserId = Convert.ToInt32(UserId);
                objBll.Name = Name;
                objBll.Mobile = Mobile;
                objBll.Building = Building;
                objBll.Locality = Locality;
                objBll.City = City;
                objBll.State = State;
                objBll.Pincode = Pincode;

                return objBll.UpdateAddress().ToString();
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<ListItem> GetStateMaster()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetStateMaster())
                {
                    List<ListItem> StateMaster = new List<ListItem>();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        StateMaster.Add(new ListItem
                        {
                            Value = dt.Rows[i]["ID"].ToString(),
                            Text = dt.Rows[i]["State"].ToString()
                        });
                    }

                    return StateMaster;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<ListItem> GetCityMasterByStateID(int stateID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetCityMasterByStateID(stateID))
                {
                    List<ListItem> cityMaster = new List<ListItem>();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        cityMaster.Add(new ListItem
                        {
                            Value = dt.Rows[i]["ID"].ToString(),
                            Text = dt.Rows[i]["City"].ToString()
                        });
                    }

                    return cityMaster;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<ListItem> GetAreaMasterByCityID(int CityID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetAreaMasterByCityID(CityID))
                {
                    List<ListItem> AreaMaster = new List<ListItem>();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        AreaMaster.Add(new ListItem
                        {
                            Value = dt.Rows[i]["pincode"].ToString(),
                            Text = dt.Rows[i]["Area"].ToString()
                        });
                    }

                    return AreaMaster;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string btnSignup(string txtFirstName, string txtLastName, string txtMobile, string txtEmail, string txtPassword1)
        {
            string rtrn = "0";
            string passEncryp = PasswordHelper.HashPasswordSHA256(txtPassword1); ;
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.FirstName = txtFirstName;
                objFp.LastName = txtLastName;
                objFp.Mobile = txtMobile;
                objFp.Email = txtEmail;
                objFp.Password = passEncryp;
                using (DataTable dt = objFp.SaveSignUp())
                {
                    if (dt.Rows.Count > 0)
                    {
                        rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);                        
                    }
                    else
                    {
                        rtrn = "0";                       

                    }
                }
            }
            return rtrn;
        }
    }
}