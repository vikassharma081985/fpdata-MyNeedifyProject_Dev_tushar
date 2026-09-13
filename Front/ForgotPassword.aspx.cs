using System.Web.Services;
using System.Data.SqlClient;
using System.Web;
using System;
using System.Net.Mail;
using System.Data;
using BLL;
using System.Web.Script.Services;
using DocumentFormat.OpenXml.Spreadsheet;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;
using System.Configuration;
using Newtonsoft.Json;
using System.Net.Http;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualBasic.ApplicationServices;

namespace FaduPrice.Front
{
    
    public partial class ForgotPassword : System.Web.UI.Page
    {
        public class UserDetails
        {
            public int UserId { get; set; }
            public string Email { get; set; }
            public string Mobile { get; set; }
        }
        private static string connStr;
        //=
        //    System.Configuration.ConfigurationManager
        //    .ConnectionStrings["DBCS"].ConnectionString;
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool VerifyOtp(string email, string otp)
        {
            int userId = GetUserIdByEmail(email);
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.UserId = userId.ToString();
                objBLL.Password = otp;
                bool dt = objBLL.verifyOTP();
                    if (dt)
                    {
                        return true;
                        //return "1";
                    }
                    else
                        return false;
                

            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SendOtp(string emailOrPhone)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(emailOrPhone))
                    return "Please enter email or phone number";
                BusinessLogicLayer objBLL = new BusinessLogicLayer();
                
                objBLL.Input = emailOrPhone.Trim();
                DataTable dtUser = objBLL.GetUserDetailsByEmailOrPhone();


                //UserDetails user =
                //    GetUserDetailsByEmailOrPhone(emailOrPhone.Trim());
                DataRow row = dtUser.Rows[0];

                int userId = Convert.ToInt32(row["UserId"]);

                string mobileNumber = row["Mobile"] == DBNull.Value
                    ? ""
                    : row["Mobile"].ToString();

                if (dtUser == null || dtUser.Rows.Count == 0)
                    return "Email or phone number is not registered";

                if (string.IsNullOrWhiteSpace(mobileNumber))
                    return "No mobile number is registered with this account";

                string otp = OtpHelper.GenerateOTP();

                int result = SaveOtp(userId, otp);

                if (result <= 0)
                    return "Unable to generate OTP";

                // Send OTP to user's registered phone
                EmailHelper.SendOtpSms(mobileNumber, otp);

                HttpContext.Current.Session["ResetUserId"] = userId;
                HttpContext.Current.Session["ResetUserPhone"] = mobileNumber;

                return "OTP sent";
            }
            catch (Exception ex)
            {
                // Log ex
                System.Diagnostics.Debug.WriteLine(
            "SendOtp Error: " + ex);
                return "Server error. Please try again.";
            }
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SetPassword(string email, string password)
        {
            string rtrn = "0";
            string passEncryp = PasswordHelper.HashPasswordSHA256(password);
            int userId = GetUserIdByEmail(email);
            if (userId == 0)
                return "Email not registered";

            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.UserId = userId.ToString();
                objFp.Password = passEncryp;
                using (DataTable dt = objFp.SetPassword())
                {
                    if (dt.Rows.Count > 0)
                    {
                        rtrn = "SUCCESS";
                    }
                    else
                    {
                        rtrn = "0";

                    }
                }
            }
            return rtrn;
        }
        private static int GetUserIdByEmail(string email)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.Email = email;
                using (DataSet dt = objBLL.GetUserIdByEmail(email))
                {
                    using (DataTable userDetails = dt.Tables[0])
                    {
                        if (userDetails.Rows.Count > 0)
                        {
                            int id = Convert.ToInt32(userDetails.Rows[0]["UserId"].ToString());
                            return id;
                            //return "1";
                        }
                        else
                            return 0;
                    }
                }
            }
        }
        private static UserDetails GetUserDetailsByEmailOrPhone(string input)
        {
            UserDetails user = null;

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "Proc_GetUserDetailsByEmailOrPhone", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@Input", SqlDbType.NVarChar, 100).Value =
                        input.Trim();

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            user = new UserDetails
                            {
                                UserId = Convert.ToInt32(dr["UserId"]),
                                Email = dr["Email"] == DBNull.Value
                                    ? ""
                                    : dr["Email"].ToString(),

                                Mobile = dr["MobileNumber"] == DBNull.Value
                                    ? ""
                                    : dr["MobileNumber"].ToString()
                            };
                        }
                    }
                }
            }

            return user;
        }
        private static int SaveOtp(int userId, string otp)
        {

            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.UserId = userId.ToString();
                objBLL.Password = otp;
                using (DataTable dt = objBLL.saveOTP())
                {
                    if (dt.Rows.Count > 0)
                    {
                        return 1;
                        //return "1";
                    }
                    else
                        return 0;
                }

            }

        }
        


        public static class OtpHelper
        {
            public static string GenerateOTP()
            {
                Random rnd = new Random();
                return rnd.Next(1000, 9999).ToString(); // 4 digit OTP
            }
        }
        public static class EmailHelper
        {
            public static void SendOtpEmail(string toEmail, string otp)
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(toEmail);
                mail.Subject = "My Needify - Password Reset OTP";
                mail.Body = $"Your OTP is: {otp}\nIt is valid for 10 minutes.";
                mail.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient();
                smtp.Send(mail);
            }
            private static readonly HttpClient _httpClient = new HttpClient();

            public static void SendOtpSms(string mobileNumber, string otp)
            {
                try
                {
                    if (string.IsNullOrWhiteSpace(mobileNumber))
                        throw new ArgumentException("Mobile number is required.");

                    if (string.IsNullOrWhiteSpace(otp))
                        throw new ArgumentException("OTP is required.");

                    // Remove spaces, + and -
                    string cleanMobile = mobileNumber
                        .Trim()
                        .Replace(" ", "")
                        .Replace("-", "")
                        .Replace("+", "");

                    // If your database contains 10-digit Indian numbers,
                    // add country code if required by your provider.
                    if (cleanMobile.Length == 10)
                    {
                        //cleanMobile = cleanMobile;
                    }

                    string username = ConfigurationManager.AppSettings["VialogueUsername"];
                    string apiKey = ConfigurationManager.AppSettings["VialogueApiKey"];
                    string entityId = ConfigurationManager.AppSettings["VialogueEntityId"];

                    string templateId = "1277178619545929442";
                    string signature = "MYNEED";

                    string message =
                        $"Your MyNeedify Password Reset OTP is {otp}. " +
                        $"This OTP is valid for 15 minutes. " +
                        $"Please do not share it with anyone. " +
                        $"Rahul Enterprises";

                    var requestData = new
                    {
                        username = username,

                        dest = new List<long>
                {
                    long.Parse("+917889000646")
                },

                        apikey = apiKey,

                        signature = signature,

                        msgtxt = message,

                        entityid = entityId,

                        templateid = templateId,

                        source = "otp"
                    };

                    string json = JsonConvert.SerializeObject(requestData);

                    using (var content = new StringContent(
                        json,
                        Encoding.UTF8,
                        "application/json"))
                    {
                        HttpResponseMessage response =
                            _httpClient
                                .PostAsync(
                                    "https://smsapi.vialogue.io/pushapi",
                                    content)
                                .GetAwaiter()
                                .GetResult();

                        string responseBody =
                            response.Content
                                .ReadAsStringAsync()
                                .GetAwaiter()
                                .GetResult();

                        // Log responseBody here while testing
                        System.Diagnostics.Debug.WriteLine(
    "VIALOGUE HTTP STATUS: " + (int)response.StatusCode);

                        System.Diagnostics.Debug.WriteLine(
                            "VIALOGUE RESPONSE: " + responseBody);
                        if (!response.IsSuccessStatusCode)
                        {
                            throw new Exception(
                                "Vialogue API failed. HTTP " +
                                (int)response.StatusCode +
                                ". Response: " +
                                responseBody);
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log ex here
                    throw;
                }
            }

        }

    }
}