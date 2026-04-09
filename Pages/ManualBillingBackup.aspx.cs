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
using System.Data.SqlClient;
using DAL;

namespace WSBillingMaster.Pages
{
    public partial class ManualBillingBackup : System.Web.UI.Page
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
                    ddldiscount.Items.Insert(0, new ListItem("Select", "0"));
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
        public static string SaveBill(string Title, string LName, string Email, string Mobile, string Name, string Gender, string Age, string GrandTotal, string Discount, string Tax, string NetAmount, string PaymentMode, string PaidAmount, string LtDetail)
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
                    objBLL.UserId = "1";
                    string TransactionId = objBLL.SaveBill();

                    return TransactionId;
                }
                catch (Exception e)
                {

                    return e.Message.ToString();
                }
            }
        }



        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string MarkDueEntry(string TransactionId, string Mobile, string Name, string GrandTotal, string PaidAmount)
        {
            if (TransactionId != "")
            {
                //-------------------Update Paid Amount : 20-02-2020 ------------------

                int DueAmount = 0;
                if (PaidAmount == "")
                    PaidAmount = "0";
                if (Convert.ToInt32(GrandTotal) > Convert.ToInt32(PaidAmount))
                {
                    DueAmount = Convert.ToInt32(GrandTotal) - Convert.ToInt32(PaidAmount);
                }
                else
                {
                    PaidAmount = GrandTotal;
                }
                string CustomerId = "0";
                StringBuilder sb = new StringBuilder();
                sb.Append("UPDATE tblTransaction SET PaidAmount=@PaidAmount,DueAmount=@DueAmount WHERE TransactionId=@TransactionId;");
                using (SqlCommand dbSqlCommand = new SqlCommand())
                {
                    using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                    {
                        dbSqlCommand.CommandText = sb.ToString();
                        dbSqlCommand.CommandType = CommandType.Text;
                        dbSqlCommand.Parameters.AddWithValue("@PaidAmount", PaidAmount);
                        dbSqlCommand.Parameters.AddWithValue("@DueAmount", DueAmount);
                        dbSqlCommand.Parameters.AddWithValue("@TransactionId", TransactionId);

                        objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);
                    }
                }
                if (DueAmount > 0)
                {
                    sb = new StringBuilder();
                    sb.Append("Select CustomerId from tblTransaction where TransactionId=@TransactionId");
                    using (SqlCommand dbSqlCommand = new SqlCommand())
                    {
                        using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                        {
                            dbSqlCommand.CommandText = sb.ToString();
                            dbSqlCommand.CommandType = CommandType.Text;
                            dbSqlCommand.Parameters.AddWithValue("@TransactionId", TransactionId);
                            using (DataTable dtCustomer = objDALCIILibrary.GetDataTable(dbSqlCommand))
                            {
                                if (dtCustomer.Rows.Count > 0)
                                {
                                    CustomerId = dtCustomer.Rows[0][0].ToString();
                                }
                            }
                        }
                    }


                    sb = new StringBuilder();
                    sb.Append(@"INSERT INTO tblSettlement(TransactionId,Mobile,Name,CustomerId,Amount) VALUES(@TransactionId,@Mobile,@Name,@CustomerId,@Amount)");
                    using (SqlCommand dbSqlCommand = new SqlCommand())
                    {
                        using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                        {
                            dbSqlCommand.CommandText = sb.ToString();
                            dbSqlCommand.CommandType = CommandType.Text;
                            dbSqlCommand.Parameters.AddWithValue("@TransactionId", TransactionId);
                            dbSqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                            dbSqlCommand.Parameters.AddWithValue("@Name", Name);
                            dbSqlCommand.Parameters.AddWithValue("@CustomerId", CustomerId);
                            dbSqlCommand.Parameters.AddWithValue("@Amount", DueAmount * -1);
                            objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);
                        }
                    }

                }
            }

            return "";
            //---------------------------------------------------------

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



        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string CheckPromoAvailable(string Mobile)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(@"SELECT top 1 PromoGroup+' Promocode to get flat '+CONVERT(VARCHAR,CashbackAmount)+' off on purchase of min '+CONVERT(VARCHAR,MinTransactionRequired)+
                        ' Available on your number' FROM tblPromoCode WHERE AssignedMobile='" + Mobile + "' AND IsValid='1' AND validTill >= GETDATE(); ");
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
                            string rtrn = dt.Rows[0][0].ToString();
                            return rtrn;
                        }
                        else
                        {
                            return "";
                        }
                    }

                }
            }
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string CheckPromo(string Promocode, string TotalAmount)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(@"Select top 1 cashbackAmount,MinTransactionRequired from tblPromoCode WHERE Promocode='" + Promocode + "' AND isValid=1  ");
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
                            string rtrn = dt.Rows[0][0].ToString() + "#" + dt.Rows[0][1].ToString();
                            return rtrn;
                        }
                        else
                        {
                            return "";
                        }
                    }

                }
            }
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SavePromoUsed(string Promocode, string Mobile)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(@"UPDATE tblPromoCode SET UsedBymobile='" + Mobile + "',IsValid='0' WHERE Promocode='" + Promocode + "' ");
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = sb.ToString();
                    dbSqlCommand.CommandType = CommandType.Text;
                    objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);
                    return "1";

                }
            }
        }
    }


}

