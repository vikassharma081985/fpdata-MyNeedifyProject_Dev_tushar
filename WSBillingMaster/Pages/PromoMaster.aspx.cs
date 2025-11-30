using BLL;
using DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace WSBillingMaster.Pages
{
    public partial class PromoMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Save(string GroupName, int PromocodeNumbers, int MinTransactionRequired, int CashbackAmount, string ValidTill, string SMSText)
        {
            try
            {
                for (int i = 0; i < PromocodeNumbers; i++)
                {
                    Guid obj = Guid.NewGuid();
                    string PromoCode = obj.ToString().ToUpper().Substring(0,8);

                    string SMS = SMSText.Replace("{promocode}", PromoCode);

                    StringBuilder sb = new StringBuilder();
                    sb.Append("INSERT INTO tblPromoCode(PromoCode,PromoGroup,MinTransactionRequired,CashbackAmount,ValidTill,SMSText) values(@PromoCode,@PromoGroup,@MinTransactionRequired,@CashbackAmount,@ValidTill,@SMSText)");
                    using (SqlCommand dbSqlCommand = new SqlCommand())
                    {
                        using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                        {
                            dbSqlCommand.CommandText = sb.ToString();
                            dbSqlCommand.CommandType = CommandType.Text;
                            dbSqlCommand.Parameters.AddWithValue("@PromoCode", PromoCode);
                            dbSqlCommand.Parameters.AddWithValue("@PromoGroup", GroupName);
                            dbSqlCommand.Parameters.AddWithValue("@MinTransactionRequired", MinTransactionRequired);
                            dbSqlCommand.Parameters.AddWithValue("@CashbackAmount", CashbackAmount);
                            dbSqlCommand.Parameters.AddWithValue("@ValidTill", Convert.ToDateTime(ValidTill).ToString("yyyy-MM-dd 23:59:59"));
                            dbSqlCommand.Parameters.AddWithValue("@SMSText", SMS);
                           
                            objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);

                        }
                    }
                }

                return "1";
            }
            catch
            {
                return "0";
            }
        }
    }
}