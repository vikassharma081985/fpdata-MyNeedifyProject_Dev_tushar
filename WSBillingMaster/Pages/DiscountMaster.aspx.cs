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

namespace WSBillingMaster.Pages
{
    public partial class DiscountMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string ManageDiscount(string DiscountId, string DiscountName, string DiscountPer, string IsActive)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.DiscountId = Convert.ToInt32(DiscountId);
                obj.DiscountName = DiscountName;
                obj.DiscountPer = Convert.ToSingle(DiscountPer);
                obj.IsActive = Convert.ToInt32(IsActive);
                return obj.ManageDiscount().ToString();
            }
        }
         [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindDiscountData()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                //return obj.ManageDiscount().ToString();
                string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(obj.BindDiscountData());
                return rtrn;
                
            }
        }
         [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
         public static string RemoveDiscount(int DiscountId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.DiscountId = DiscountId;
                return obj.RemoveDiscount().ToString();
                
            }
        }

        
        
    }
}