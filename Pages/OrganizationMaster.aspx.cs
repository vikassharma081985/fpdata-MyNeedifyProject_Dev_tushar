using BLL;
using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster
{
    public partial class OrganizationMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //BindOrganization();    
            }
        }
        /*public void BindOrganization()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                using (DataTable dt = objBLL.BindOrganizationMasterDetails())
                {
                    if (dt.Rows.Count > 0)
                    {
                        grdOrganizations.DataSource = dt;
                        grdOrganizations.DataBind();
                    }
                    else
                    {
                        grdOrganizations.DataSource = null;
                        grdOrganizations.DataBind();
                    }
                }
            }
        }*/
        
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static int AddOrganizationMaster(string SellerName, string LastName,  string BrandName, string DisplayName, string GST, string SellerAddress, string Mobile, string LandLineNumber, string Email, string Website, string Password, int BusinessId, int SellerId, string Username, string ProfileImage)
        {
            if(SellerId==0)
            {
                using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                {
                    try
                    {
                        objBLL.SellerName = SellerName;
                        objBLL.LastName = LastName;
                        objBLL.BrandName = BrandName;
                        objBLL.DisplayName = DisplayName;
                        objBLL.GST = GST;
                        objBLL.SellerAddress = SellerAddress;
                        objBLL.BusinessId = BusinessId;
                        objBLL.Mobile = Mobile;
                        objBLL.LandLineNumber = LandLineNumber;
                        objBLL.Email = Email;
                        objBLL.Website = Website;
                        objBLL.Password = Password;
                        objBLL.UserName= Username;
                        objBLL.OrgProfileImage = ProfileImage;
                        objBLL.UserId = "1";
                        int NewOrganizationId = objBLL.AddOrganizationMasterDetails();
                        return NewOrganizationId;
                    }
                    catch (Exception ex)
                    {
                        return -1;
                    }
                }
            }
            else
            {
                using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                {
                    try
                    {
                        objBLL.SellerId = SellerId;
                        objBLL.SellerName = SellerName;
                        objBLL.LastName = LastName;
                        objBLL.BrandName = BrandName;
                        objBLL.DisplayName = DisplayName;
                        objBLL.GST = GST;
                        objBLL.SellerAddress = SellerAddress;
                        objBLL.BusinessId = BusinessId;
                        objBLL.Mobile = Mobile;
                        objBLL.LandLineNumber = LandLineNumber;
                        objBLL.Email = Email;
                        objBLL.Website = Website;
                        objBLL.Password = Password;
                        objBLL.OrgProfileImage = ProfileImage;
                        objBLL.UserId = "1";
                        int NewOrganizationId = objBLL.UpdateOrganizationMasterDetails();
                        return NewOrganizationId;
                    }
                    catch (Exception ex)
                    {
                        return -1;
                    }
                }
            }
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindCategory()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                using (DataTable dt = objBLL.BindWSCategory())
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    return rtrn;
                }
                
            }
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindOrganizationMasterDetails()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                using (DataTable dt = objBLL.BindOrganizationMasterDetails())
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    return rtrn;
                }

            }
        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static int DeleteOrganizationMaster(int Id, bool IsActive)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                try
                {
                    objBLL.SellerId = Id;
                    objBLL.OrgStatus = IsActive;
                    int OrganizationId = objBLL.DeleteOrganizationMasterDetails();
                    return OrganizationId;
                }
                catch (Exception ex)
                {
                    return -1;
                }
            }
        }

        protected void btnDisplayOrgPopup_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddOrganization.aspx");
        }

        }
}