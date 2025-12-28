using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Runtime.Remoting.Contexts;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Newtonsoft.Json;

namespace WSBillingMaster.Pages
{
    public partial class ExpenseManager : System.Web.UI.Page
    {
        //public static string apiBaseUrl = "https://localhost:7089/api/";
        //public static string apiBaseUrl = "https://198.38.88.185/api/";
        public static string apiKey = "nQuWK7pMKI@";

        protected void Page_Load(object sender, EventArgs e)
        
        {
            if (Session["UserName"] == null || Session["UserId"] == null)
            {
                Session.Clear();
                Session.Abandon();

                Response.Clear();
                Response.Write(@"
                    <script type='text/javascript'>
                        alert('Please login first to use this tool.');
                        window.location.href='/Front/Index.aspx';
                    </script>
                ");

                HttpContext.Current.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                string userName = Session["UserName"].ToString();
                string userId = Session["UserId"].ToString();
                hdnUserId.Value = userId;
            }
            //if (!IsPostBack)
            //{
            //    if (Session["UserName"] == null || Session["UserId"] == null)
            //    {
            //        Session.Clear();
            //        Session.Abandon();
            //        //Response.Redirect("~/Front/Index.aspx", true);
            //        ScriptManager.RegisterStartupScript(
            //            this,
            //            this.GetType(),
            //            "SessionExpired",
            //            "alert('Please login first to use this tool.'); window.location.href='/Front/Index.aspx';",
            //            true
            //        );

            //        return;
            //    }
            //    string userName = Session["UserName"].ToString();
            //    string userId = Session["UserId"].ToString();
            //    hdnUserId.Value = userId;
            //}
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindExpenseMaster()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.BindExpenseMaster())
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    return rtrn;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindExpenseSubCategory(int categoryId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.BindExpenseSubCategoryByCategoryId(categoryId))
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    return rtrn;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Save(List<Expense> data)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    obj.ExpenseDate =  Convert.ToDateTime(data[0].Date).ToString("yyyy-MM-dd");
                    obj.ExpenseId = data[0].ExpenseId;
                    obj.SubCategoryId = data[0].SubExpenseId;
                    //obj.ExpenseFile = data[0].File.Replace(@"C:\fakepath\","");
                    obj.ExpenseFile = data[0].File?.Split('|')?[0] ?? "";
                    obj.ExpenseDescription = data[0].Description;
                    obj.Amount = data[0].Amount;
					obj.Rate = data[0].Rate;
                    obj.Quantity = data[0].Quantity;
                    string url = HttpContext.Current.Request.UrlReferrer.PathAndQuery.ToString();
					int idx = url.IndexOf('?');
					string query = idx >= 0 ? url.Substring(idx) : "";
                    obj.FetchUserId = Convert.ToString(data[0].userId); // (HttpUtility.ParseQueryString(query).Get("UserId"));
                    obj.OrgId = 0;//Convert.ToInt32(HttpUtility.ParseQueryString(query).Get("OrgId"));
                    obj.EmpId = 0;// Convert.ToInt32(HttpUtility.ParseQueryString(query).Get("EmpId"));
                    

                    int a = obj.SaveExpense();
                    return "1";
                }
                catch
                {
                    return "0";
                }
            }
        }

       [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SearchExpense(string FromDate, string ToDate, int? ExpenseId = null, string UserId=null)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    if (FromDate != null && FromDate != "")
                        obj.FromDate = Convert.ToDateTime(FromDate).ToString("yyyy-MM-dd");
                    if (ToDate != null && ToDate != "")
                        obj.ToDate = Convert.ToDateTime(ToDate).ToString("yyyy-MM-dd");
                    if (ExpenseId != null || ExpenseId != 0)
                    {
                        obj.ExpenseId = ExpenseId ?? 0;
                    }
                    string url = HttpContext.Current.Request.UrlReferrer.PathAndQuery.ToString();
                    int idx = url.IndexOf('?');
                    string query = idx >= 0 ? url.Substring(idx) : "";
                    string uID = UserId;
                    string uID2 = HttpUtility.ParseQueryString(query).Get("UserId");
                    if (uID != null && uID != "")
                        obj.FetchUserId = (uID);
                    obj.OrgId = Convert.ToInt32(HttpUtility.ParseQueryString(query).Get("OrgId"));
                    obj.EmpId = Convert.ToInt32(HttpUtility.ParseQueryString(query).Get("EmpId"));
                    //int ExpStatus;
                     if (uID != null && uID != "" && Convert.ToInt32(obj.FetchUserId) > 0)
                    {
                        obj.ExpenseStatus = 1;
                    }
                    else if (obj.OrgId > 0)
                    {
                        obj.ExpenseStatus = 2;
                    }
                    obj.FetchUserId = uID;
                    obj.ExpenseDataStatus = "Reimbursement Created";
                    using (DataTable dt = obj.SearchExpense())
                    {
                        string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                        return rtrn;
                    }

                }
                catch (Exception ex)
                {
                    Console.WriteLine($"An error occurred: {ex.Message}");
                    return ex.Message;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string CallSaveReimbursementAPI(object payload)
        {
            var handler = new HttpClientHandler
            {
                ServerCertificateCustomValidationCallback =
                HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
            };
            var apiBaseUrl = ConfigurationManager.AppSettings["ApiBaseUrl"];
            string apiUrl = $"{apiBaseUrl}Expense/SaveReimbursement";

            using (HttpClient client = new HttpClient(handler))
            {
                client.DefaultRequestHeaders.Add("x-api-key", apiKey);

                var json = JsonConvert.SerializeObject(payload);
                var content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");

                var response = client.PostAsync(apiUrl, content).Result;
                //string responseData = response.Content.ReadAsStringAsync().Result;

                if (!response.IsSuccessStatusCode)
                {
                    return JsonConvert.SerializeObject(new
                    {
                        error = true,
                        message = "API Error: " + response.StatusCode
                    });
                }

                string responseData = response.Content.ReadAsStringAsync().Result;
                return responseData;
            }
        }

        [WebMethod]
        public static string SaveSignature(string imageData, string expenseIds)
        {
            try
            {
                // Remove base64 header
                string base64 = imageData.Replace("data:image/png;base64,", "");
                byte[] bytes = Convert.FromBase64String(base64);

                string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/Signatures/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = "SIGN_" + expenseIds + ".png";
                string[] existingFiles = Directory.GetFiles(folderPath, fileName);
                foreach (string file in existingFiles)
                {
                    File.Delete(file);
                }
                string fullPath = Path.Combine(folderPath, fileName);
                File.WriteAllBytes(fullPath, bytes);

                return fileName; // or relative path
            }
            catch
            {
                return "";
            }
        }

        [WebMethod]
        public static string UpdateExpense(List<Expense> data)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    var item = data[0];
                    obj.Id = item.Id;
                    obj.ExpenseDate = Convert.ToDateTime(item.Date).ToString("yyyy-MM-dd");
                    obj.ExpenseId = item.ExpenseId;
                    obj.SubCategoryId = item.SubExpenseId;
                    obj.ExpenseFile = string.IsNullOrEmpty(item.File) ? "" : item.File.Split('|')[0];
                    obj.ExpenseDescription = item.Description;
                    obj.Amount = item.Amount;
                    obj.Rate = item.Rate;
                    obj.Quantity = item.Quantity;
                    obj.FetchUserId = item.userId.ToString();

                    int result = obj.UpdateExpense(); // Implement in BLL
                    return result > 0 ? "1" : "0";
                }
                catch { return "0"; }
            }
        }
    }

    public class Expense
    {
        public int Id { get; set; }
        public string Date { get; set; }
        public int ExpenseId { get; set; }
        public int SubExpenseId { get; set; }
        public string File { get; set; }
        public string Description { get; set; }
        public decimal Amount { get; set; }
        public int userId { get; set; }
        public decimal Rate { get; set; }
        public int Quantity { get; set; }


    }
}