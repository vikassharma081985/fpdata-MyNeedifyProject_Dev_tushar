using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using System.Data;

namespace WSBillingMaster.Pages
{
    public partial class Billing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                BindDiscount();
            }
        }

        private void BindDiscount()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                using (DataTable dt = objBLL.BindDiscountData())
                {
                    if (dt.Rows.Count > 0)
                    {
                        ddldiscount.DataSource = dt;
                        ddldiscount.DataTextField = "DiscountName";
                        ddldiscount.DataValueField = "DiscountPer";
                        ddldiscount.DataBind();
                    }
                    ddldiscount.Items.Insert(0, new ListItem("Select","0"));
                    ddldiscount.Items.Insert(1, new ListItem("Other", "-1"));

                }
            }
        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SearchData(string Barcode)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.Barcode = Barcode;
                using (DataTable dt = objBLL.GetItemDetail())
                {
                    return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SaveBill(string Title,string LName,string Email,string Mobile, string Name, string Gender, string Age, string GrandTotal, string Discount, string Tax, string NetAmount, string PaymentMode, string LtDetail)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                try
                {
                    objBLL.Title = Title;
                    objBLL.LName = LName;
                    objBLL.Email = Email;
                    objBLL.Name = Name;
                    objBLL.Mobile = Mobile;
                    objBLL.Gender = Gender;
                    objBLL.Age = Age;
                    objBLL.Total = GrandTotal;
                    objBLL.Discount = Discount;
                    objBLL.Tax = Tax;
                    objBLL.NetAmount = NetAmount;
                    objBLL.PaymentMode = PaymentMode;
                    objBLL.XML = LtDetail;
                    objBLL.UserId = HttpContext.Current.Session["UserId"].ToString();
                    string TransactionId = objBLL.SaveBill();
                    return TransactionId;
                }
                catch
                {

                    return "0";
                }
            }
        }

        
              [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SearchCustomer(string Mobile)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.Mobile = Mobile;
                using (DataTable dt = objBLL.SearchCustomer())
                {
                    return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                }
            }
        }
    }


}

