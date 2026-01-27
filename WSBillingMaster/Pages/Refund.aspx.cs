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
    public partial class Refund : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Search(string Invoice)
        {
            Invoice = Invoice.ToUpper();
           using(BusinessLogicLayer obj=new BusinessLogicLayer())
           {
               obj.TransactionId =Convert.ToString(Invoice.Replace("RC000", ""));
               using (DataTable dt = obj.SearchInvoice())
               {
                   string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                   return rtrn;
               }
           }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string RefundTransaction(string TDId)
        {
            
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.TransactionId = TDId;
                int RowsEffected = obj.Refund();
                return RowsEffected.ToString();
               
            }
        }
    }
}