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

namespace FaduPrice.Front
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
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

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SendOtp(string email)
        {
            int userId = GetUserIdByEmail(email);
            if (userId == 0)
                return "Email not registered";

            string otp = OtpHelper.GenerateOTP();

            int result = SaveOtp(userId, otp);
            if (result > 0)
            {
                //EmailHelper.SendOtpEmail(email, otp);
                HttpContext.Current.Session["ResetUserId"] = userId;
                return "OTP sent";

            }
            else
            {
                return "0";
            }
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
        }

    }
}