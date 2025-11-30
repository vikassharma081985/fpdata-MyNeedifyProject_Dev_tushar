using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class Settlement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtFromDate.Text = "01-Feb-2020";
            txtToDate.Text = System.DateTime.Now.ToString("dd-MMM-yyyy");

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Search(string FromDate, string ToDate, string Mobile)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(@"SELECT SettlementId,CustomerId,Amount,Name,Mobile,dtEntry,Remarks from (SELECT MAX(SettlementId) SettlementId, sl.CustomerId , SUM(Amount) Amount, Name,Mobile ,CONVERT(VARCHAR,MIN(dtEntry),106) dtEntry,
                        ISNULL(MAX(Remarks),'') Remarks FROM tblSettlement sl
                        WHERE dtEntry >=@FromDate AND dtEntry <=@ToDate  ");
            if (Mobile != "")
                sb.Append(" AND Mobile=@Mobile");
            sb.Append(" GROUP BY CustomerId  ,Name,Mobile)t WHERE Amount < 0");

            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = sb.ToString();
                    dbSqlCommand.CommandType = CommandType.Text;
                    dbSqlCommand.Parameters.AddWithValue("@FromDate", Convert.ToDateTime(FromDate).ToString("yyyy-MM-dd 00:00:00"));
                    dbSqlCommand.Parameters.AddWithValue("@ToDate", Convert.ToDateTime(ToDate).ToString("yyyy-MM-dd 23:59:59"));
                    if (Mobile != "")
                        dbSqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    using (DataTable dt = objDALCIILibrary.GetDataTable(dbSqlCommand))
                    {
                        string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                        return rtrn;
                    }
                }
            }
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SaveSettlement(string SettlementId, string Amount, string Remarks)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                sb.Append(@"INSERT INTO tblSettlement(CustomerId,Amount,TransactionId, Name,Mobile,Remarks) 
                        SELECT CustomerId,@Amount,TransactionId, Name,Mobile,@Remarks from tblSettlement WHERE SettlementId=@SettlementId");
                using (SqlCommand dbSqlCommand = new SqlCommand())
                {
                    using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                    {
                        dbSqlCommand.CommandText = sb.ToString();
                        dbSqlCommand.CommandType = CommandType.Text;
                        dbSqlCommand.Parameters.AddWithValue("@SettlementId", SettlementId);
                        dbSqlCommand.Parameters.AddWithValue("@Amount", Amount);
                        dbSqlCommand.Parameters.AddWithValue("@Remarks", Remarks);
                        objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);
                        return "1";
                    }
                }
            }
            catch
            {
                return "0";

            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SendSMS(string Mobile, string SMSText)
        {
            return sendMessage(Mobile, SMSText);
           
        }

        public static string sendMessage(string phoneNo, string message)
        {
            string url = "http://login.bulksmsgateway.in/sendmessage.php";
            string result = "";
            message = HttpUtility.UrlPathEncode(message);
            String strPost = "?user=" + HttpUtility.UrlPathEncode("vikas259") + "&password=" + HttpUtility.UrlPathEncode("Vikas@12345") + "&sender=" + HttpUtility.UrlPathEncode("TestId") + "&mobile=" + HttpUtility.UrlPathEncode(phoneNo) + "&type=" + HttpUtility.UrlPathEncode("3") + "&message=" + message;
            StreamWriter myWriter = null;
            HttpWebRequest objRequest = (HttpWebRequest)WebRequest.Create(url + strPost);
            objRequest.Method = "POST";
            objRequest.ContentLength = Encoding.UTF8.GetByteCount(strPost);
            objRequest.ContentType = "application/x-www-form-urlencoded";
            try
            {
                myWriter = new StreamWriter(objRequest.GetRequestStream());
                myWriter.Write(strPost);
            }
            catch (Exception e)
            {
                return "0";
            }
            finally
            {
                myWriter.Close();
            }
            HttpWebResponse objResponse = (HttpWebResponse)objRequest.GetResponse();
            using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
            {
                result = sr.ReadToEnd();

            }
            return "1";
        }
    }
}