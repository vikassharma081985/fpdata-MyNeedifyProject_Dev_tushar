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
        public static string apiKey = "nQuWK7pMKI@";
        private static int OrgId = 0;
        private static int EmployeeId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null && Session["UserId"] == null && Session["EmployeeId"] == null)
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
                int currentUserId = 0;
                int currentRoleId = 0;
                int currentOrgId = 0;

                if (Session["UserId"] != null) int.TryParse(Session["UserId"].ToString(), out currentUserId);
                else if (Session["EmployeeId"] != null) int.TryParse(Session["EmployeeId"].ToString(), out currentUserId);

                if (Session["RoleId"] != null) int.TryParse(Session["RoleId"].ToString(), out currentRoleId);
                if (Session["OrgId"] != null) int.TryParse(Session["OrgId"].ToString(), out currentOrgId);

                hdnUserId.Value = currentUserId.ToString();
                hdnRoleId.Value = currentRoleId.ToString();
                hdnOrgId.Value = currentOrgId.ToString();

                OrgId = currentOrgId;
                EmployeeId = currentUserId;

                using (BusinessLogicLayer bll = new BusinessLogicLayer())
                {
                    bool isSuperAdmin = bll.IsSuperAdminRole(currentRoleId);
                    bool isAdmin = bll.IsAdminRole(currentRoleId);
                    bool hasSubordinates = bll.CheckUserHasSubordinates(currentUserId);
                    bool isApprover = isSuperAdmin || isAdmin || hasSubordinates;
                    hdnIsApprover.Value = isApprover ? "1" : "0";
                }
            }
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
                    obj.ExpenseDate = Convert.ToDateTime(data[0].Date).ToString("yyyy-MM-dd");
                    obj.ExpenseId = data[0].ExpenseId;
                    obj.SubCategoryId = data[0].SubExpenseId;
                    obj.ExpenseFile = data[0].File?.Split('|')?[0] ?? "";
                    obj.ExpenseFile2 = data[0].File2?.Split('|')?[0] ?? "";
                    obj.ExpenseDescription = data[0].Description;
                    obj.Amount = data[0].Amount;
                    obj.Rate = data[0].Rate;
                    obj.Quantity = data[0].Quantity;
                    obj.BillNumber = data[0].BillNumber;
                    obj.IsPaid = data[0].IsPaid;
                    obj.PaymentMode = data[0].PaymentMode;
                    obj.FetchUserId = OrgId > 0 ? Convert.ToString(EmployeeId) : Convert.ToString(data[0].userId);
                    obj.OrgId = OrgId;
                    obj.EmpId = EmployeeId;

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
        public static string SearchExpense(string FromDate, string ToDate, int? ExpenseId = null, string UserId = null)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    if (!string.IsNullOrEmpty(FromDate))
                        obj.FromDate = Convert.ToDateTime(FromDate).ToString("yyyy-MM-dd");
                    if (!string.IsNullOrEmpty(ToDate))
                        obj.ToDate = Convert.ToDateTime(ToDate).ToString("yyyy-MM-dd");
                    if (ExpenseId.HasValue && ExpenseId.Value != 0)
                        obj.ExpenseId = ExpenseId.Value;

                    string uID = UserId;
                    if (!string.IsNullOrEmpty(uID))
                        obj.FetchUserId = uID;

                    obj.OrgId = OrgId;
                    obj.EmpId = EmployeeId;

                    if (!string.IsNullOrEmpty(uID) && Convert.ToInt32(obj.FetchUserId) > 0)
                        obj.ExpenseStatus = 1;
                    else if (obj.OrgId > 0)
                        obj.ExpenseStatus = 2;

                    obj.FetchUserId = uID;
                    obj.ExpenseDataStatus = "Reimbursement Created";
                    using (DataTable dt = obj.SearchExpense())
                    {
                        return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    }
                }
                catch (Exception ex)
                {
                    return ex.Message;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string ReimbursementHistoryData(string LoggedInUserID = null)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    string uID = LoggedInUserID;
                    using (DataTable dt = obj.ReimbursementHistoryData(uID))
                    {
                        return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    }
                }
                catch (Exception ex)
                {
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
                ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
            };
            var apiBaseUrl = ConfigurationManager.AppSettings["ApiBaseUrl"];
            string apiUrl = $"{apiBaseUrl}/Expense/SaveReimbursement";
            try
            {
                using (HttpClient client = new HttpClient(handler))
                {
                    client.DefaultRequestHeaders.Add("x-api-key", apiKey);

                    var json = JsonConvert.SerializeObject(payload);
                    var content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");

                    var response = client.PostAsync(apiUrl, content).Result;

                    if (!response.IsSuccessStatusCode)
                    {
                        string responseData1 = response.Content.ReadAsStringAsync().Result;
                        return JsonConvert.SerializeObject(new
                        {
                            error = true,
                            message = "API Error: " + response.StatusCode + ": " + responseData1
                        });
                    }

                    string responseData = response.Content.ReadAsStringAsync().Result;
                    return responseData;
                }
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(new
                {
                    error = true,
                    message = apiUrl + "Exception: " + ex.Message
                });
            }
        }

        [WebMethod]
        public static string SaveSignature(string imageData, string expenseIds)
        {
            try
            {
                string base64 = imageData.Replace("data:image/png;base64,", "");
                byte[] bytes = Convert.FromBase64String(base64);

                string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/Signatures/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = "SIGN_" + Guid.NewGuid() + ".png";
                string[] existingFiles = Directory.GetFiles(folderPath, fileName);
                foreach (string file in existingFiles)
                {
                    File.Delete(file);
                }
                string fullPath = Path.Combine(folderPath, fileName);
                File.WriteAllBytes(fullPath, bytes);

                return fileName;
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
                    obj.ExpenseFile2 = string.IsNullOrEmpty(item.File2) ? "" : item.File2.Split('|')[0];
                    obj.ExpenseDescription = item.Description;
                    obj.Amount = item.Amount;
                    obj.Rate = item.Rate;
                    obj.Quantity = item.Quantity;
                    obj.BillNumber = item.BillNumber;
                    obj.IsPaid = item.IsPaid;
                    obj.PaymentMode = item.PaymentMode;
                    obj.FetchUserId = item.userId.ToString();

                    int result = obj.UpdateExpense();
                    return result > 0 ? "1" : "0";
                }
                catch { return "0"; }
            }
        }

        #region Hierarchy-Based Expense Approvals WebMethods

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetTeamExpensesForApproval(string FromDate, string ToDate, string Status, int? SubordinateUserId = null)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    int currentUserId = 0;
                    int currentOrgId = 0;

                    if (HttpContext.Current.Session["UserId"] != null)
                        int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out currentUserId);
                    else if (HttpContext.Current.Session["EmployeeId"] != null)
                        int.TryParse(HttpContext.Current.Session["EmployeeId"].ToString(), out currentUserId);

                    if (HttpContext.Current.Session["OrgId"] != null)
                        int.TryParse(HttpContext.Current.Session["OrgId"].ToString(), out currentOrgId);

                    using (DataTable dt = obj.GetExpensesForApproval(currentUserId, currentOrgId > 0 ? (int?)currentOrgId : null, Status, FromDate, ToDate, SubordinateUserId))
                    {
                        return JsonConvert.SerializeObject(dt);
                    }
                }
                catch (Exception ex)
                {
                    return JsonConvert.SerializeObject(new { error = true, message = ex.Message });
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string ApproveExpenseAjax(long ExpenseId, string Remarks = "")
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    int currentUserId = 0;
                    if (HttpContext.Current.Session["UserId"] != null)
                        int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out currentUserId);
                    else if (HttpContext.Current.Session["EmployeeId"] != null)
                        int.TryParse(HttpContext.Current.Session["EmployeeId"].ToString(), out currentUserId);

                    if (currentUserId <= 0)
                        return JsonConvert.SerializeObject(new { success = false, message = "Session expired. Please log in again." });

                    int result = obj.ApproveExpense(ExpenseId, currentUserId, Remarks);
                    return JsonConvert.SerializeObject(new { success = (result > 0), message = result > 0 ? "Expense approved successfully." : "Failed to approve expense." });
                }
                catch (Exception ex)
                {
                    return JsonConvert.SerializeObject(new { success = false, message = ex.Message });
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string RejectExpenseAjax(long ExpenseId, string Reason)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    if (string.IsNullOrWhiteSpace(Reason))
                        return JsonConvert.SerializeObject(new { success = false, message = "Rejection reason is required." });

                    int currentUserId = 0;
                    if (HttpContext.Current.Session["UserId"] != null)
                        int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out currentUserId);
                    else if (HttpContext.Current.Session["EmployeeId"] != null)
                        int.TryParse(HttpContext.Current.Session["EmployeeId"].ToString(), out currentUserId);

                    if (currentUserId <= 0)
                        return JsonConvert.SerializeObject(new { success = false, message = "Session expired. Please log in again." });

                    int result = obj.RejectExpense(ExpenseId, currentUserId, Reason.Trim());
                    return JsonConvert.SerializeObject(new { success = (result > 0), message = result > 0 ? "Expense rejected." : "Failed to reject expense." });
                }
                catch (Exception ex)
                {
                    return JsonConvert.SerializeObject(new { success = false, message = ex.Message });
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BulkApproveExpensesAjax(List<long> ExpenseIds, string Remarks = "")
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    if (ExpenseIds == null || ExpenseIds.Count == 0)
                        return JsonConvert.SerializeObject(new { success = false, message = "No expenses selected." });

                    int currentUserId = 0;
                    if (HttpContext.Current.Session["UserId"] != null)
                        int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out currentUserId);
                    else if (HttpContext.Current.Session["EmployeeId"] != null)
                        int.TryParse(HttpContext.Current.Session["EmployeeId"].ToString(), out currentUserId);

                    string idList = string.Join(",", ExpenseIds);
                    int count = obj.BulkApproveExpenses(idList, currentUserId, Remarks);
                    return JsonConvert.SerializeObject(new { success = true, count = count, message = $"{count} expense(s) approved successfully." });
                }
                catch (Exception ex)
                {
                    return JsonConvert.SerializeObject(new { success = false, message = ex.Message });
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BulkRejectExpensesAjax(List<long> ExpenseIds, string Reason)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    if (ExpenseIds == null || ExpenseIds.Count == 0)
                        return JsonConvert.SerializeObject(new { success = false, message = "No expenses selected." });

                    if (string.IsNullOrWhiteSpace(Reason))
                        return JsonConvert.SerializeObject(new { success = false, message = "Rejection reason is required." });

                    int currentUserId = 0;
                    if (HttpContext.Current.Session["UserId"] != null)
                        int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out currentUserId);
                    else if (HttpContext.Current.Session["EmployeeId"] != null)
                        int.TryParse(HttpContext.Current.Session["EmployeeId"].ToString(), out currentUserId);

                    string idList = string.Join(",", ExpenseIds);
                    int count = obj.BulkRejectExpenses(idList, currentUserId, Reason.Trim());
                    return JsonConvert.SerializeObject(new { success = true, count = count, message = $"{count} expense(s) rejected." });
                }
                catch (Exception ex)
                {
                    return JsonConvert.SerializeObject(new { success = false, message = ex.Message });
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetApproverDashboardStatsAjax()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    int currentUserId = 0;
                    int currentOrgId = 0;
                    if (HttpContext.Current.Session["UserId"] != null)
                        int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out currentUserId);
                    else if (HttpContext.Current.Session["EmployeeId"] != null)
                        int.TryParse(HttpContext.Current.Session["EmployeeId"].ToString(), out currentUserId);

                    if (HttpContext.Current.Session["OrgId"] != null)
                        int.TryParse(HttpContext.Current.Session["OrgId"].ToString(), out currentOrgId);

                    using (DataTable dt = obj.GetApproverDashboardStats(currentUserId, currentOrgId > 0 ? (int?)currentOrgId : null))
                    {
                        return JsonConvert.SerializeObject(dt);
                    }
                }
                catch (Exception ex)
                {
                    return JsonConvert.SerializeObject(new { error = true, message = ex.Message });
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetSubordinatesForFilterAjax()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    int currentUserId = 0;
                    int currentOrgId = 0;
                    if (HttpContext.Current.Session["UserId"] != null)
                        int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out currentUserId);
                    else if (HttpContext.Current.Session["EmployeeId"] != null)
                        int.TryParse(HttpContext.Current.Session["EmployeeId"].ToString(), out currentUserId);

                    if (HttpContext.Current.Session["OrgId"] != null)
                        int.TryParse(HttpContext.Current.Session["OrgId"].ToString(), out currentOrgId);

                    using (DataTable dt = obj.GetSubordinatesForApproval(currentUserId, currentOrgId > 0 ? (int?)currentOrgId : null))
                    {
                        return JsonConvert.SerializeObject(dt);
                    }
                }
                catch (Exception ex)
                {
                    return JsonConvert.SerializeObject(new { error = true, message = ex.Message });
                }
            }
        }

        #endregion
    }

    public class Expense
    {
        public int Id { get; set; }
        public string Date { get; set; }
        public int ExpenseId { get; set; }
        public int SubExpenseId { get; set; }
        public string File { get; set; }
        public string File2 { get; set; }
        public string Description { get; set; }
        public decimal Amount { get; set; }
        public int userId { get; set; }
        public decimal Rate { get; set; }
        public int Quantity { get; set; }
        public string BillNumber { get; set; }
        public bool IsPaid { get; set; }
        public string PaymentMode { get; set; }
    }
}
