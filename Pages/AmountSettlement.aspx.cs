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
using Newtonsoft.Json;

namespace WSBillingMaster
{
    public partial class AmountSettlement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string FetchTransactionDetails(string TransactionId)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.TransactionId = TransactionId;
                using (DataTable dt = objBLL.FetchTransactionDetail())
                {
                    //return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    return JsonConvert.SerializeObject(dt);
                }
            }
        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SaveAmountSettlement(int CustomerId, string Mobile, string FName, string TransactionId, float SettlementAmt, string Remarks, string PaymodeId)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                try
                {
                    objBLL.CustomerId = CustomerId;
                    objBLL.Mobile = Mobile;
                    objBLL.FirstName = FName;
                    objBLL.TransactionId = TransactionId;
                    objBLL.SettlementAmt = SettlementAmt;
                    objBLL.Remarks = Remarks;
                    objBLL.PaymentMode = PaymodeId;
                    objBLL.IntUserId = 1;
                    string ReceiptId = objBLL.AddSettlementAmount();
                    return ReceiptId;
                }
                catch (Exception ex)
                {
                    return ex.Message.ToString();
                }
                
            }
        }
    }
    
}