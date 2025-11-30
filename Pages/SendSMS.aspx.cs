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
    public partial class SendSMS : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindGroup();
            }


        }

        private void BindGroup()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT Distinct PromoGroup from tblPromoCode WHERE IsValid=1");
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = sb.ToString();
                    dbSqlCommand.CommandType = CommandType.Text;
                    using (DataTable dt = objDALCIILibrary.GetDataTable(dbSqlCommand))
                    {
                        if (dt.Rows.Count > 0)
                        {
                            ddlGroup.DataSource = dt;
                            ddlGroup.DataTextField = "PromoGroup";
                            ddlGroup.DataValueField = "PromoGroup";
                            ddlGroup.DataBind();
                            ddlGroup.Items.Insert(0, new ListItem("", "0"));

                        }
                    }

                }
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string result = sendMessage(txtMobile.Text, txtSMS.Text);
            if (result == "1")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('SMS Send Successfully !');", true);

                txtMobile.Text = "";
                txtSMS.Text = "";
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Some Error Occured, Please try again !');", true);

            }
        }

        public string sendMessage(string phoneNo, string message)
        {
            string url = "http://login.bulksmsgateway.in/sendmessage.php";
            string result = "";
            message = HttpUtility.UrlPathEncode(message);
            String strPost = "?user=" + HttpUtility.UrlPathEncode("vikas259") + "&password=" + HttpUtility.UrlPathEncode("vikas@2525") + "&sender=" + HttpUtility.UrlPathEncode("TestId") + "&mobile=" + HttpUtility.UrlPathEncode(phoneNo) + "&type=" + HttpUtility.UrlPathEncode("3") + "&message=" + message;
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

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindNumbers(string GroupName)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Select Distinct Mobile from tblCustomer WHERE Mobile Not IN (SELECT ISNULL(AssignedMobile,'0') FROM tblPromoCode WHERE PromoGroup='" + GroupName + "') AND LEN(Mobile)=10");
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = sb.ToString();
                    dbSqlCommand.CommandType = CommandType.Text;
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
        public static string SendGroupSMS(string PromoGroup, string Mobile)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("SELECT top 1 PromoId,SMSText FROM tblPromoCode WHERE PromoGroup='" + PromoGroup + "' AND IsValid=1 AND AssignedMobile is NULL");
                using (SqlCommand dbSqlCommand = new SqlCommand())
                {
                    using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                    {
                        dbSqlCommand.CommandText = sb.ToString();
                        dbSqlCommand.CommandType = CommandType.Text;
                        using (DataTable dt = objDALCIILibrary.GetDataTable(dbSqlCommand))
                        {
                            if (dt.Rows.Count > 0)
                            {
                                sb = new StringBuilder();
                                sb.Append("UPDATE tblPromoCode SET AssignedMobile='" + Mobile + "' WHERE PromoId='" + dt.Rows[0]["PromoId"] + "'");
                                dbSqlCommand.CommandText = sb.ToString();
                                dbSqlCommand.CommandType = CommandType.Text;
                                int RowEffected = objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);
                                if (RowEffected > 0)
                                {
                                    string url = "http://login.bulksmsgateway.in/sendmessage.php";
                                    string result = "";
                                    string message = HttpUtility.UrlPathEncode(dt.Rows[0]["SMSText"].ToString());
                                    String strPost = "?user=" + HttpUtility.UrlPathEncode("vikas259") + "&password=" + HttpUtility.UrlPathEncode("Vikas@12345") + "&sender=" + HttpUtility.UrlPathEncode("TestId") + "&mobile=" + HttpUtility.UrlPathEncode(Mobile) + "&type=" + HttpUtility.UrlPathEncode("3") + "&message=" + message;
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
                                }
                            }
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