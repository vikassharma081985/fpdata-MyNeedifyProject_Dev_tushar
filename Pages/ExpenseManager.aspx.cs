using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;

namespace WSBillingMaster.Pages
{
    public partial class ExpenseManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
        public static string Save(List<Expense> data)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    obj.ExpenseDate =  Convert.ToDateTime(data[0].Date).ToString("yyyy-MM-dd");
                    obj.ExpenseId = data[0].ExpenseId;
                    //obj.ExpenseFile = data[0].File.Replace(@"C:\fakepath\","");
                    obj.ExpenseFile = data[0].File?.Split('|')?[0] ?? "";
                    obj.ExpenseDescription = data[0].Description;
                    obj.Amount = data[0].Amount;
					obj.Amount = data[0].Amount;
					string url = HttpContext.Current.Request.UrlReferrer.PathAndQuery.ToString();
					int idx = url.IndexOf('?');
					string query = idx >= 0 ? url.Substring(idx) : "";
					obj.FetchUserId = (HttpUtility.ParseQueryString(query).Get("UserId"));
					obj.OrgId = Convert.ToInt32(HttpUtility.ParseQueryString(query).Get("OrgId"));
					obj.EmpId = Convert.ToInt32(HttpUtility.ParseQueryString(query).Get("EmpId"));
                    

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
        public static string SearchExpense(string FromDate, string ToDate, int ExpenseId, string UserId=null)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                try
                {
                    if (FromDate != null && FromDate != "")
                        obj.FromDate = Convert.ToDateTime(FromDate).ToString("yyyy-MM-dd");
                    if (ToDate != null && ToDate != "")
                        obj.ToDate = Convert.ToDateTime(ToDate).ToString("yyyy-MM-dd");
                    obj.ExpenseId = ExpenseId;
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
    }

    public class Expense
    {
        public string Date { get; set; }
        public int ExpenseId { get; set; }
        public string File { get; set; }
        public string Description { get; set; }
        public int Amount { get; set; }



    }
}