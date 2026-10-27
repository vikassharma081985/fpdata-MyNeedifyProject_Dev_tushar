using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using DAL;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace BLL
{
    public class BusinessLogicLayer : IDisposable
    {
        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
        public void Dispose(bool disposable)
        {
            //GC.SuppressFinalize(this);
        }



        #region "Properties"

        public int ItemPrice { get; set; }
        public string ImageName { get; set; }
        public int ImageSize { get; set; }
        public int LoggedInUser { get; set; }
        public int SelectedUser { get; set; }
        public string Message { get; set; }
        public string Name { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string Password { get; set; }
        public string UserId { get; set; }
        //public int FetchUserId { get; set; }
        public string UserName { get; set; }

        public int Quantity { get; set; }
        public int SizeId { get; set; }
        public string Search { get; set; }
        public string SizeSearch { get; set; }
        public string ColorSearch { get; set; }
        public string Building { get; set; }
        public string Locality { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Pincode { get; set; }

        //--------------------------
        public int PageSize { get; set; }
        public int PageIndex { get; set; }
        public int CategoryId { get; set; }
        public int SubCategoryId { get; set; }
        public int SubSubCategoryId { get; set; }
        public string ItemName { get; set; }
        public string ItemDescription { get; set; }
        public decimal Amount { get; set; }
        public decimal Rate { get; set; }
        public Int32 Id { get; set; }
        public int MRP { get; set; }

        public int IsCoupanAvailable { get; set; }
        public int colorId { get; set; }
        public int ItemId { get; set; }
        public int ImageId { get; set; }
        public string SizeXml { get; set; }
        public string ItemMultipleImage { get; set; }
        public string Stock { get; set; }
        public int Active { get; set; }
        public int ContactId { get; set; }

        public string OrderId { get; set; }
        public string Status { get; set; }

        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string courier { get; set; }
        public string Remarks { get; set; }
        public string ProductId { get; set; }
        public string Brand { get; set; }
        public string Modal { get; set; }

        public string Department { get; set; }
        public string Cashback { get; set; }
        public string Vendor { get; set; }
        public string COD { get; set; }
        public string ItemVolume { get; set; }
        public string ItemLength { get; set; }
        public string ItemWidth { get; set; }
        public string ItemHeight { get; set; }
        public string ShippingWeight { get; set; }
        public string ShippingPrice { get; set; }
        public string HSNCode { get; set; }
        public string GST { get; set; }
        public string XML { get; set; }
        public string Barcode { get; set; }


        public string Gender { get; set; }
        public string Age { get; set; }
        public string Title { get; set; }
        public string LName { get; set; }


        public string Total { get; set; }
        public string Discount { get; set; }
        public string Tax { get; set; }
        public string NetAmount { get; set; }
        public string PaymentMode { get; set; }
        public string TransactionId { get; set; }
        public int SalesManId { get; set; }

        public string DiscountName { get; set; }
        public float DiscountPer { get; set; }
        public Int32 IsActive { get; set; }
        public Int32 DiscountId { get; set; }
        public string Keyword { get; set; }

        //public Int32 type { get; set; }

        private int subMenuCounter = 0;
        public string PriceOrder { get; set; }
        public string Ip { get; set; }
        //public Int32 SellerId { get; set; }
        //public int OrgId { get; set;  }
        public float SettlementAmt { get; set; }

        public int RegId { get; set; }
        public string CompanyName { get; set; }
        public string ContactPerson { get; set; }
        public string AadharNumber { get; set; }
        public string Skill { get; set; }
        public string FatherName { get; set; }
        public string BirthPlace { get; set; }
        public string ExperienceType { get; set; }
        public string ResumePath { get; set; }
        public int IntUserId { get; set; }

        public string EmergencyPhone { get; set; }
        public string EmergencyName { get; set; }
        public string EmergencyRelation { get; set; }

        public string SchoolUniversity { get; set; }
        public string Qualification { get; set; }
        public string EducationPath { get; set; }

        public string AccountNumber { get; set; }
        public string IFSC { get; set; }
        public string BankName { get; set; }

        public string AadharPath { get; set; }
        public string PhotoPath { get; set; }

        public string ExpDuration { get; set; }
        public string ExpUnit { get; set; }

        public string Height { get; set; }
        public string Weight { get; set; }
        public string Languages { get; set; }
        public string MaritalStatus { get; set; }
        public string ExpectedDemand { get; set; }
        public string FullAddress { get; set; }
        public string StateName { get; set; }
        public string CityName { get; set; }
        public string LocationName { get; set; }
        public string Landmark { get; set; }
        public string PincodeVal { get; set; }
        public int HireId { get; set; }
        public string Input { get; set; }

        public int ManageDiscount()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_ManageDiscount";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@DiscountId", DiscountId);
                    sqlCommand.Parameters.AddWithValue("@DiscountName", DiscountName);
                    sqlCommand.Parameters.AddWithValue("@DiscountPer", DiscountPer);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    sqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));
                    sqlCommand.Parameters.AddWithValue("@AddedBy", Convert.ToInt32(HttpContext.Current.Session["UserId"]));
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public int RemoveDiscount()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_RemoveDiscount";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@DiscountId", DiscountId);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public DataTable BindDiscountData()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_BindDiscountData";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataSet GetStockInHand()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetStockInHand";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    // sqlCommand.Parameters.AddWithValue("@InvoiceNumber", TransactionId);
                    return objDAL.GetDataSet(sqlCommand);
                }
            }
        }
        public DataTable BindDiscount()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_BindDiscount";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }


        public string SaveBill()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SaveBill";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Title", Title);
                    sqlCommand.Parameters.AddWithValue("@LName", LName);
                    sqlCommand.Parameters.AddWithValue("@Email", Email);
                    sqlCommand.Parameters.AddWithValue("@Name", Name);
                    sqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    sqlCommand.Parameters.AddWithValue("@Gender", Gender);
                    sqlCommand.Parameters.AddWithValue("@Age", Age);
                    sqlCommand.Parameters.AddWithValue("@Total", Total);
                    sqlCommand.Parameters.AddWithValue("@Discount", Discount);
                    sqlCommand.Parameters.AddWithValue("@Tax", Tax);
                    sqlCommand.Parameters.AddWithValue("@NetAmount", NetAmount);
                    sqlCommand.Parameters.AddWithValue("@PaymentMode", PaymentMode);
                    sqlCommand.Parameters.AddWithValue("@XML", XML);
                    sqlCommand.Parameters.AddWithValue("@AddedBy", UserId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));

                    return objDAL.GetDataTable(sqlCommand).Rows[0][0].ToString();

                }
            }
        }

        public string SaveBillManual()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SaveBillManual";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Title", Title);
                    sqlCommand.Parameters.AddWithValue("@LName", LName);
                    sqlCommand.Parameters.AddWithValue("@Email", Email);
                    sqlCommand.Parameters.AddWithValue("@Name", Name);
                    sqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    sqlCommand.Parameters.AddWithValue("@Gender", Gender);
                    sqlCommand.Parameters.AddWithValue("@Age", Age);
                    sqlCommand.Parameters.AddWithValue("@Total", Total);
                    sqlCommand.Parameters.AddWithValue("@Discount", Discount);
                    sqlCommand.Parameters.AddWithValue("@Tax", Tax);
                    sqlCommand.Parameters.AddWithValue("@NetAmount", NetAmount);
                    sqlCommand.Parameters.AddWithValue("@PaymentMode", PaymentMode);
                    sqlCommand.Parameters.AddWithValue("@XML", XML);
                    sqlCommand.Parameters.AddWithValue("@AddedBy", UserId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));
                    sqlCommand.Parameters.AddWithValue("@SalesManId", SalesManId);

                    return objDAL.GetDataTable(sqlCommand).Rows[0][0].ToString();

                }
            }
        }

        /*public string SaveReceipt()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer)
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    return objDAL.GetDataTable(cmd).Rows[0][0].ToString();
                }
            }
        }*/

        public int SaveTransactionDetail()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SaveTransactionDetail";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@XML", XML);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public DataTable GetInvoice()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetInvoice";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@TransactionId", TransactionId);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable SearchCustomer()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SearchCustomer";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
        public DataTable GetPreviousTransactions()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetPreviousTransactions";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    sqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    sqlCommand.Parameters.AddWithValue("@Keyword", Keyword);
                    sqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"].ToString()));

                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataSet GetdataList()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetdataList";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("", "");
                    return objDAL.GetDataSet(sqlCommand);

                }
            }
        }

        public int SaveImage()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SaveImage";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@ImageName", ImageName);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }

        public DataTable GetMessages()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetMessages";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@LoggedInUser", LoggedInUser);
                    sqlCommand.Parameters.AddWithValue("@SelectedUser", SelectedUser);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
        public int SendMessage()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SendMessage";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@LoggedInUser", LoggedInUser);
                    sqlCommand.Parameters.AddWithValue("@SelectedUser", SelectedUser);
                    sqlCommand.Parameters.AddWithValue("@Message", Message);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }

        public DataTable GetLoginDetails()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetLoginDetails";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserName", UserName);
                    dbSqlCommand.Parameters.AddWithValue("@Password", Password);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);
                }
            }
        }
        public DataTable GetUserDetailsByEmailOrPhone()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetUserDetailsByEmailOrPhone";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;

                    dbSqlCommand.Parameters.AddWithValue("@Input", Input);

                    return objDALCIILibrary.GetDataTable(dbSqlCommand);
                }
            }
        }

        public DataSet GetLoginFrontDetails()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetLoginFrontDetails";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserName", UserName);
                    dbSqlCommand.Parameters.AddWithValue("@Password", Password);
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);
                }
            }
        }

        public DataTable SaveSignUp()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_SaveSignUp";
                    dbSqlCommand.Parameters.AddWithValue("@FirstName", FirstName);
                    dbSqlCommand.Parameters.AddWithValue("@LastName", LastName);
                    dbSqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    dbSqlCommand.Parameters.AddWithValue("@EmailId", Email);
                    dbSqlCommand.Parameters.AddWithValue("@Password", Password);

                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable SetPassword()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_ResetUserPassword";
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    dbSqlCommand.Parameters.AddWithValue("@Password", Password);

                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataSet GetUserIdByEmail(string email)
        {

            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_GetUserIdByEmail";
                    dbSqlCommand.Parameters.AddWithValue("@Email", Email);

                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public DataTable saveOTP()
        {

            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_SavePasswordResetOtp";
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    dbSqlCommand.Parameters.AddWithValue("@Otp", Password);

                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public bool verifyOTP()
        {

            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    SqlParameter[] inputParams = new SqlParameter[]
                    {
                        new SqlParameter("@UserId", UserId),
                        new SqlParameter("@Otp", Password)
                    };
                    //dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    //dbSqlCommand.CommandText = "Proc_VerifyPasswordResetOtp";
                    //dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    //dbSqlCommand.Parameters.AddWithValue("@Otp", Password);
                    //SqlParameter isValidParam = new SqlParameter("@IsValid", SqlDbType.Bit)
                    //{
                    //    Direction = ParameterDirection.Output
                    //};
                    //dbSqlCommand.Parameters.Add(isValidParam);
                    return objDALCIILibrary.ExecuteProcedureWithOutput("Proc_VerifyPasswordResetOtp", inputParams, "@IsValid");
                    //return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }


        //------Homepage data fetch-----------

        public DataSet GetHomePageData()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetHomePageData";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public DataTable CheckDelivery()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_CheckDelivery";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@Pincode", Pincode);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        //-----------Item Description Data-------------
        public DataSet GetItemDescriptionData()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetItemDescriptionData";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        //-----------Item Description Data-------------
        public string AddToCart()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_AddToCart";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    dbSqlCommand.Parameters.AddWithValue("@SizeId", SizeId);
                    dbSqlCommand.Parameters.AddWithValue("@Quantity", Quantity);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand).Rows[0]["CartItem"].ToString();

                }
            }
        }

        public DataSet BindCart()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_BindCart";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public DataTable GetUserAddress()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "GetUserAddress";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataTable GetUserAddressV1()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "GetUserAddressv1";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserId", IntUserId);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public long AddNewAddress()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_AddNewAddress";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserId", IntUserId);
                    dbSqlCommand.Parameters.AddWithValue("@Name", Name);
                    dbSqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    dbSqlCommand.Parameters.AddWithValue("@Building", Building);
                    dbSqlCommand.Parameters.AddWithValue("@Locality", Locality);
                    dbSqlCommand.Parameters.AddWithValue("@City", City);
                    dbSqlCommand.Parameters.AddWithValue("@State", State);
                    dbSqlCommand.Parameters.AddWithValue("@Pincode", Pincode);

                    using (DataTable dt = objDALCIILibrary.GetDataTable(dbSqlCommand))
                    {
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            return Convert.ToInt64(dt.Rows[0][0]);
                        }
                    }
                }
            }

            return 0;
        }

        public int UpdateAddress()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "UPDATE tblUserContactDetails SET Name = @Name, Mobile = @Mobile, Building = @Building, Locality = @Locality, City = @City, State = @State, Pincode = @Pincode WHERE ContactId = @ContactId AND UserId = @UserId";
                    sqlCommand.CommandType = CommandType.Text;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Name", Name);
                    sqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    sqlCommand.Parameters.AddWithValue("@Building", Building);
                    sqlCommand.Parameters.AddWithValue("@Locality", Locality);
                    sqlCommand.Parameters.AddWithValue("@City", City);
                    sqlCommand.Parameters.AddWithValue("@State", State);
                    sqlCommand.Parameters.AddWithValue("@Pincode", Pincode);
                    sqlCommand.Parameters.AddWithValue("@ContactId", ContactId);
                    sqlCommand.Parameters.AddWithValue("@UserId", IntUserId);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }



        public DataSet BindMyOrders()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_BindMyOrders";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public int CancelOrder()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_CancelOrder";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@OrderItemId", ItemId);
                    return objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);

                }
            }
        }
        public int RemoveCartItem()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_DeleteCartItem";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@CartId", ItemId);
                    return objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);

                }
            }
        }


        public DataSet GetMyAccountData()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetMyAccountData";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserID", UserId);
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);
                }
            }
        }

        public int UpdateUserData()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_UpdateUserData";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    dbSqlCommand.Parameters.AddWithValue("@FirstName", FirstName);
                    dbSqlCommand.Parameters.AddWithValue("@LastName", LastName);
                    dbSqlCommand.Parameters.AddWithValue("@Email", Email);
                    dbSqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    return objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);

                }
            }
        }
        public int DeleteSlider()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_DeleteSlider";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@Id", ItemId);

                    return objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);

                }
            }
        }


        //
        //-------Brij Work---------------

        public DataTable SaveItemPage()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_SaveItemPage";
                    dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    dbSqlCommand.Parameters.AddWithValue("@ItemName", ItemName);
                    dbSqlCommand.Parameters.AddWithValue("@ItemDescription", ItemDescription);
                    dbSqlCommand.Parameters.AddWithValue("@CategoryId", CategoryId);
                    dbSqlCommand.Parameters.AddWithValue("@SubCategoryId", SubCategoryId);
                    dbSqlCommand.Parameters.AddWithValue("@SubSubCategoryId", SubSubCategoryId);
                    dbSqlCommand.Parameters.AddWithValue("@colorId", colorId);
                    dbSqlCommand.Parameters.AddWithValue("@SizeXml", SizeXml);
                    dbSqlCommand.Parameters.AddWithValue("@Amount", Amount);
                    dbSqlCommand.Parameters.AddWithValue("@MRP", MRP);

                    dbSqlCommand.Parameters.AddWithValue("@ItemMultipleImage", ItemMultipleImage);
                    dbSqlCommand.Parameters.AddWithValue("@IsCoupanAvailable", IsCoupanAvailable);
                    dbSqlCommand.Parameters.AddWithValue("@Active", Active);

                    dbSqlCommand.Parameters.AddWithValue("@ProductId", ProductId);
                    dbSqlCommand.Parameters.AddWithValue("@Brand", Brand);
                    dbSqlCommand.Parameters.AddWithValue("@Modal", Modal);
                    dbSqlCommand.Parameters.AddWithValue("@Department", Department);
                    dbSqlCommand.Parameters.AddWithValue("@Cashback", Cashback);
                    dbSqlCommand.Parameters.AddWithValue("@Vendor", Vendor);
                    dbSqlCommand.Parameters.AddWithValue("@COD", COD);
                    dbSqlCommand.Parameters.AddWithValue("@ItemVolume", ItemVolume.Trim() == ""? 0:Convert.ToInt32(ItemVolume));
                    dbSqlCommand.Parameters.AddWithValue("@ItemWidth", ItemWidth.Trim() == "" ? 0 : Convert.ToInt32(ItemWidth));
                    dbSqlCommand.Parameters.AddWithValue("@ItemLength", ItemLength.Trim() == "" ? 0 : Convert.ToInt32(ItemLength));
                    dbSqlCommand.Parameters.AddWithValue("@ItemHeight", ItemHeight.Trim() == "" ? 0 : Convert.ToInt32(ItemHeight));
                    dbSqlCommand.Parameters.AddWithValue("@ShippingPrice", ShippingPrice.Trim() == "" ? 0 : Convert.ToInt32(ShippingPrice));
                    dbSqlCommand.Parameters.AddWithValue("@ShippingWeight", ShippingWeight.Trim() == "" ? 0 : Convert.ToInt32(ShippingWeight));
                    dbSqlCommand.Parameters.AddWithValue("@HSNCode", HSNCode);
                    dbSqlCommand.Parameters.AddWithValue("@GST", GST);
                    dbSqlCommand.Parameters.AddWithValue("@SupplierId", SupplierId);
                    dbSqlCommand.Parameters.AddWithValue("@CreatedBy", Convert.ToInt32(HttpContext.Current.Session["UserId"]));
                    dbSqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));

                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataSet GetCategory()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetCategory";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }
        public DataSet GetSubCategory()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetSubCategory";
                    dbSqlCommand.Parameters.AddWithValue("@CategoryId", CategoryId);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }
        public DataSet GetSubSubCategory()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetSubSubCategory";
                    dbSqlCommand.Parameters.AddWithValue("@SubCategoryId", SubCategoryId);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public DataSet GetBannerList()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetBannerList";
                    dbSqlCommand.Parameters.AddWithValue("@PageIndex", PageIndex);
                    dbSqlCommand.Parameters.AddWithValue("@PageSize", PageSize);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);
                }
            }
        }

        public DataSet GetAdminList(int userid, int role)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetAdminItemList";
                    dbSqlCommand.Parameters.AddWithValue("@PageIndex", PageIndex);
                    dbSqlCommand.Parameters.AddWithValue("@PageSize", PageSize);
                    dbSqlCommand.Parameters.AddWithValue("@userid", userid);
                    dbSqlCommand.Parameters.AddWithValue("@role", role);
                    //dbSqlCommand.Parameters.AddWithValue("@SearchText", Search);

                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);
                }
            }
        }
        public DataSet GetAdminItemSearch(int CategoryId, int SubCategoryId, int SubSubCategoryId)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDAL = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "GET_ITEMSFORONLINE";
                    if (CategoryId > 0)
                    {
                        dbSqlCommand.Parameters.AddWithValue("@CategoryId", CategoryId);
                    }
                    if (SubCategoryId > 0)
                    {
                        dbSqlCommand.Parameters.AddWithValue("@SubCategoryId", SubCategoryId);
                    }
                    if (SubSubCategoryId > 0)
                    {
                        dbSqlCommand.Parameters.AddWithValue("@SubSubCategoryId", SubSubCategoryId);
                    }
                    dbSqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDAL.GetDataSet(dbSqlCommand);
                }
            }
        }

        public DataSet GetAdminItemEdit(int userid, int role, int CategoryId, int SubCategoryId, int SubSubCategoryId)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetAdminItemEdit";
                    dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    dbSqlCommand.Parameters.AddWithValue("@userid", userid);
                    dbSqlCommand.Parameters.AddWithValue("@role", role);
                    dbSqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));
                    if (CategoryId != 0)
                    {
                        dbSqlCommand.Parameters.AddWithValue("@CategoryId", CategoryId);
                    }
                    if (SubCategoryId != 0)
                    {
                        dbSqlCommand.Parameters.AddWithValue("@SubCategoryId", SubCategoryId);
                    }
                    if (SubSubCategoryId != 0)
                    {
                        dbSqlCommand.Parameters.AddWithValue("@SubSubCategoryId", SubSubCategoryId);
                    }
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public int DeleteImage()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_DeleteImage";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    sqlCommand.Parameters.AddWithValue("@ImageId", ImageId);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }

        public int DeleteItem()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_DeleteItem";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }

        public int ChangePassword()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_ChangePassword";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@UserID", UserId);
                    sqlCommand.Parameters.AddWithValue("@Password", Password);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }
        public int InsertWishlist()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_InsertWishlist";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@UserID", UserId);
                    sqlCommand.Parameters.AddWithValue("@ItemId", ItemId);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }



        public DataTable SaveSliderManagementPage()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_SaveSliderManagementPage";
                    dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    dbSqlCommand.Parameters.AddWithValue("@ItemName", ItemName);
                    dbSqlCommand.Parameters.AddWithValue("@ItemDescription", ItemDescription);
                    dbSqlCommand.Parameters.AddWithValue("@ItemMultipleImage", ItemMultipleImage);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataTable GetOrderDetails()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_GetOrderDetails";
                    dbSqlCommand.Parameters.AddWithValue("@OrderItemId", OrderId);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataTable GetWishlistItems()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_GetWishlistItems";
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataTable SaveSliderPage()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.CommandText = "Proc_SaveSliderPage";
                    dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    dbSqlCommand.Parameters.AddWithValue("@ItemName", ItemName);
                    dbSqlCommand.Parameters.AddWithValue("@ItemDescription", ItemDescription);
                    dbSqlCommand.Parameters.AddWithValue("@CategoryId", CategoryId);
                    dbSqlCommand.Parameters.AddWithValue("@SubCategoryId", SubCategoryId);
                    dbSqlCommand.Parameters.AddWithValue("@SubSubCategoryId", SubSubCategoryId);
                    dbSqlCommand.Parameters.AddWithValue("@ItemMultipleImage", ItemMultipleImage);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataSet GetSliderItemEdit()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetSliderItemEdit";
                    dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public DataTable GetPendingOrderList()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetPendingOrderList";
                    dbSqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    dbSqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    dbSqlCommand.Parameters.AddWithValue("@Status", Status);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }


        public DataSet BindSearchData()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_BindSearchData";
                    dbSqlCommand.Parameters.AddWithValue("@SubSubCategory", SubSubCategoryId);
                    dbSqlCommand.Parameters.AddWithValue("@SearchText", Search);
                    dbSqlCommand.Parameters.AddWithValue("@SizeId", SizeSearch);
                    dbSqlCommand.Parameters.AddWithValue("@ColorId", ColorSearch);
                    dbSqlCommand.Parameters.AddWithValue("@Price", Amount);

                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public DataTable PlaceOrder()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_PlaceOrder";
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    dbSqlCommand.Parameters.AddWithValue("@Name", Name);
                    dbSqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    dbSqlCommand.Parameters.AddWithValue("@Building", Building);
                    dbSqlCommand.Parameters.AddWithValue("@Locality", Locality);
                    dbSqlCommand.Parameters.AddWithValue("@City", City);
                    dbSqlCommand.Parameters.AddWithValue("@State", State);
                    dbSqlCommand.Parameters.AddWithValue("@Pincode", Pincode);
                    dbSqlCommand.Parameters.AddWithValue("@Amount", Amount);

                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable BindCategory()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_BindCategory";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable BindCategoryWithSeller(int sellerid)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_BindCategoryWithSeller";
                    sqlCommand.Parameters.AddWithValue("@sellerid", sellerid);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public int SavePendingOrderList()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SavePendingOrderList";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@courier", courier);
                    sqlCommand.Parameters.AddWithValue("@Status", Status);
                    sqlCommand.Parameters.AddWithValue("@Remarks", Remarks);
                    sqlCommand.Parameters.AddWithValue("@OrderId", OrderId);
                    sqlCommand.Parameters.AddWithValue("@ItemId", ItemId);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }



        //---------------------------------------------------------------
        public DataTable ImportItems()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_ImportItems";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@XML", XML);
                    sqlCommand.Parameters.AddWithValue("@IP", Ip);
                    sqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    sqlCommand.Parameters.AddWithValue("@SellerId", SellerId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));
                    using (DataSet ds = objDAL.GetDataSet(sqlCommand))
                    {
                        return ds.Tables[0];
                    }

                }
            }
        }

        public string GetVisitorsIPAddresss()
        {
            string VisitorsIPAddr = string.Empty;
            if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            {
                VisitorsIPAddr = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            }
            else if (HttpContext.Current.Request.UserHostAddress.Length != 0)
            {
                VisitorsIPAddr = HttpContext.Current.Request.UserHostAddress;
            }
            return VisitorsIPAddr;
        }

        public int SaveBarcodeImage()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SaveBarcodeImage";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@XML", XML);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }

        public int UpdateItemImage()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_UpdateItemImage";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    sqlCommand.Parameters.AddWithValue("@ImageName", ImageName);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);

                }
            }
        }



        public DataTable GetManagedItemImages(string itemIdsXml)
        {
            using (DataAccessLayer dal = new DataAccessLayer())
            using (SqlCommand cmd = new SqlCommand(@"
                DECLARE @Ids XML = @ItemIds;
                SELECT images.ItemId, images.ImageName, MIN(images.ImageOrder) AS ImageOrder
                FROM (
                    SELECT i.ItemId, i.ItemImage AS ImageName, CAST(0 AS BIGINT) AS ImageOrder
                    FROM dbo.tblItem i
                    INNER JOIN @Ids.nodes('/items/item') ids(n) ON i.ItemId = ids.n.value('@id', 'bigint')
                    WHERE NULLIF(i.ItemImage, '') IS NOT NULL
                    UNION ALL
                    SELECT x.ItemId, x.ImageName, x.ItemImageId AS ImageOrder
                    FROM dbo.tblItemImage x
                    INNER JOIN @Ids.nodes('/items/item') ids(n) ON x.ItemId = ids.n.value('@id', 'bigint')
                ) images
                GROUP BY images.ItemId, images.ImageName
                ORDER BY images.ItemId, ImageOrder"))
            {
                cmd.CommandTimeout = 30;
                cmd.Parameters.Add("@ItemIds", SqlDbType.Xml).Value = itemIdsXml;
                DataTable images = dal.GetDataTable(cmd);
                if (images == null) throw new InvalidOperationException("Unable to load item images. Check database setup.");
                return images;
            }
        }

        public DataTable ManageItemImages(string action)
        {
            using (DataAccessLayer dal = new DataAccessLayer())
            using (SqlCommand cmd = new SqlCommand("Proc_ManageItemImages"))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ItemId", ItemId);
                cmd.Parameters.AddWithValue("@Action", action);
                cmd.Parameters.AddWithValue("@ImageName", (object)ImageName ?? DBNull.Value);
                DataTable images = dal.GetDataTable(cmd);
                if (images == null) throw new InvalidOperationException("Unable to manage item images. Check database setup.");
                return images;
            }
        }

        public DataTable GetManageItemData(int type)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetManageItemData";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@type", type);
                    sqlCommand.Parameters.AddWithValue("@Keyword", Keyword);
                    sqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    sqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable GetManageItemDataPhysicalStock()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetManageItemData";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@type", 1);
                    sqlCommand.Parameters.AddWithValue("@Keyword", Keyword);
                    sqlCommand.Parameters.AddWithValue("@FromDate", System.DateTime.Now.ToString("yyyy-MM-dd"));
                    sqlCommand.Parameters.AddWithValue("@ToDate", System.DateTime.Now.ToString("yyyy-MM-dd"));
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        //public DataTable GetManageItemDataPhy()
        //{
        //    using (DataAccessLayer objDAL = new DataAccessLayer())
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand())
        //        {
        //            sqlCommand.CommandText = "Proc_GetManageItemDataPhy";
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            sqlCommand.CommandTimeout = 100;
        //            //sqlCommand.Parameters.AddWithValue("@type", type);
        //            sqlCommand.Parameters.AddWithValue("@Keyword", Keyword);
        //            //sqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
        //            //sqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
        //            return objDAL.GetDataTable(sqlCommand);
        //        }
        //    }
        //}

        public DataTable GetItemDetail()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetItemDetail";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Barcode", Barcode);

                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable GetItemDetailByItemName(string ItemName, int OrgId, int CategoryId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetItemDetailByItemName";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Barcode", ItemName);
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);
                    sqlCommand.Parameters.AddWithValue("@CategoryId", CategoryId);

                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable ItemSearch()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_ItemSearch";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Keyword", Keyword);

                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }






        public string SendEmail(string To, string Message, string Bcc, string CC, string Subject)
        {

            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("relay-hosting.secureserver.net");
                mail.From = new MailAddress("no-reply@faduprice.in");
                mail.To.Add(To);
                if (CC != "")
                    mail.CC.Add(CC);
                if (Bcc != "")
                    mail.Bcc.Add(Bcc);
                mail.Subject = Subject;
                mail.Body = Message;
                mail.IsBodyHtml = true;
                // System.Net.Mail.Attachment attachment;
                // attachment = new System.Net.Mail.Attachment(@"C:\Attachment.txt");
                //mail.Attachments.Add(attachment);

                SmtpServer.Port = 25;
                SmtpServer.UseDefaultCredentials = true;    ///Set it to false, or remove this line
                SmtpServer.Credentials = new System.Net.NetworkCredential("", "");
                SmtpServer.EnableSsl = false;
                SmtpServer.Send(mail);
                return "1";

            }
            catch (Exception exception)
            {
                return exception.Message;
            }

        }
        public int EditItemName()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "EditItemName";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@ItemName", ItemName);
                    sqlCommand.Parameters.AddWithValue("@ItemId", ItemId);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public DataTable GetPreviousTransactionsDayWise()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetPreviousTransactionsDayWise";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    sqlCommand.Parameters.AddWithValue("@ToDate", ToDate);

                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
        //public DataTable ItemSearch()
        //        {
        //            using (DataAccessLayer objDAL = new DataAccessLayer())
        //            {
        //                using (SqlCommand sqlCommand = new SqlCommand())
        //                {
        //                    sqlCommand.CommandText = "Proc_ItemSearch";
        //                    sqlCommand.CommandType = CommandType.StoredProcedure;
        //                    sqlCommand.CommandTimeout = 100;
        //                    sqlCommand.Parameters.AddWithValue("@Keyword", Keyword);

        //                    return objDAL.GetDataTable(sqlCommand);
        //                }
        //            }
        //        }

        public DataTable SearchInvoice()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SearchInvoice";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@InvoiceNumber", TransactionId);

                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public int Refund()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_Refund";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@TransactionDetailId", TransactionId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));    //2026-01-11 by HEMANT
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }


        //-------------------Business logic layer----------

        //---------------------Expense ----------------


        public string ExpenseDate { get; set; }
        public int ExpenseId { get; set; }
        public string ExpenseFile { get; set; }
        public string ExpenseFile2 { get; set; }
        public string ExpenseDescription { get; set; }

        public DataTable GetProfitLoss()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetProfitLoss";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    sqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    sqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));    //2026-01-11 by HEMANT
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }


        public DataTable BindExpenseMaster()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_BindExpenseMaster";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    // sqlCommand.Parameters.AddWithValue("@InvoiceNumber", TransactionId);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable BindExpenseSubCategoryByCategoryId(int CategoryId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "usp_GetExpenseSubMasterByExpenseId";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@ExpenseMasterId", CategoryId);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        //Expense
        public int OrgId { get; set; }
        public int EmpId { get; set; }
        public int ExpenseStatus { get; set; }
        public string FetchUserId { get; set; }
        public string ExpenseDataStatus { get; set; }
        public string BillNumber { get; set; }
        public bool IsPaid { get; set; }
        public int SaveExpense()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SaveExpense";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@ExpenseDate", ExpenseDate);
                    sqlCommand.Parameters.AddWithValue("@ExpenseId", ExpenseId);
                    sqlCommand.Parameters.AddWithValue("@SubExpenseId", SubCategoryId);
                    sqlCommand.Parameters.AddWithValue("@File", ExpenseFile);
                    sqlCommand.Parameters.AddWithValue("@File2", ExpenseFile2);
                    sqlCommand.Parameters.AddWithValue("@Description", ExpenseDescription);
                    sqlCommand.Parameters.AddWithValue("@Amount", Amount);
                    sqlCommand.Parameters.AddWithValue("@UserId", FetchUserId);
                    sqlCommand.Parameters.AddWithValue("@EmpId", EmpId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);
                    sqlCommand.Parameters.AddWithValue("@Rate", Rate);
                    sqlCommand.Parameters.AddWithValue("@Quantity", Quantity);
                    sqlCommand.Parameters.AddWithValue("@BillNumber", string.IsNullOrEmpty(BillNumber) ? (object)DBNull.Value : BillNumber);
                    sqlCommand.Parameters.AddWithValue("@IsPaid", IsPaid);
                    sqlCommand.Parameters.AddWithValue("@PaymentMode", string.IsNullOrEmpty(PaymentMode) ? (object)DBNull.Value : PaymentMode);
                    //sqlCommand.Parameters.AddWithValue("@Action", ExpenseStatus);


                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public DataTable SearchExpense()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SearchExpense";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    sqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    sqlCommand.Parameters.AddWithValue("@ExpenseId", ExpenseId);
                    sqlCommand.Parameters.AddWithValue("@UserId", FetchUserId);
                    sqlCommand.Parameters.AddWithValue("@EmpId", EmpId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);
                    sqlCommand.Parameters.AddWithValue("@ExpenseDataStatus", ExpenseDataStatus);
                    sqlCommand.Parameters.AddWithValue("@Action", ExpenseStatus);


                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
        public DataTable ReimbursementHistoryData(string LoggedInUSerID)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_ReimbursementHistoryData";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@UserId", Convert.ToInt32(LoggedInUSerID));
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }


        public int UpdateExpense()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_UpdateExpense";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;

                    // Required for UPDATE
                    sqlCommand.Parameters.AddWithValue("@ID", Id); // Make sure you have public int ID { get; set; } in BLL

                    sqlCommand.Parameters.AddWithValue("@ExpenseDate", ExpenseDate ?? (object)DBNull.Value);
                    sqlCommand.Parameters.AddWithValue("@ExpenseId", ExpenseId);
                    sqlCommand.Parameters.AddWithValue("@SubExpenseId", SubCategoryId);
                    sqlCommand.Parameters.AddWithValue("@File", string.IsNullOrEmpty(ExpenseFile) ? (object)DBNull.Value : ExpenseFile);
                    sqlCommand.Parameters.AddWithValue("@File2", string.IsNullOrEmpty(ExpenseFile2) ? (object)DBNull.Value : ExpenseFile2);
                    sqlCommand.Parameters.AddWithValue("@Description", string.IsNullOrEmpty(ExpenseDescription) ? (object)DBNull.Value : ExpenseDescription);
                    sqlCommand.Parameters.AddWithValue("@Amount", Amount);
                    sqlCommand.Parameters.AddWithValue("@Rate", Rate);
                    sqlCommand.Parameters.AddWithValue("@Quantity", Quantity);
                    sqlCommand.Parameters.AddWithValue("@UserId", FetchUserId);
                    // EmpId and OrgId usually don't change during edit, but included for completeness
                    sqlCommand.Parameters.AddWithValue("@EmpId", EmpId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);
                    sqlCommand.Parameters.AddWithValue("@BillNumber", string.IsNullOrEmpty(BillNumber) ? (object)DBNull.Value : BillNumber);
                    sqlCommand.Parameters.AddWithValue("@IsPaid", IsPaid);
                    sqlCommand.Parameters.AddWithValue("@PaymentMode", string.IsNullOrEmpty(PaymentMode) ? (object)DBNull.Value : PaymentMode);

                    // Use your existing GetDataTable method
                    DataTable dt = objDAL.GetDataTable(sqlCommand);

                    // Check if any row was returned
                    if (dt.Rows.Count > 0)
                    {
                        return Convert.ToInt32(dt.Rows[0]["Id"]);
                    }

                    return 0; // No record updated
                }
            }
        }
        #endregion






        //public DataTable GetManageItemData(int type)
        //{
        //    throw new NotImplementedException();
        //}

        #region "Sandeep Kumar vendor report"

        public int SupplierId { get; set; }

        public DataTable GETSUPPLIERLIST(string SupplierName)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_GET_SUPPLIERLIST";
                    if (!string.IsNullOrEmpty(SupplierName))
                        dbSqlCommand.Parameters.AddWithValue("@SupplierName", SupplierName);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataTable GetVendorItemReport()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_REPORT_VENDOR_ITEM";
                    dbSqlCommand.Parameters.AddWithValue("@Vendor", Vendor);
                    //dbSqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    //dbSqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    //dbSqlCommand.Parameters.AddWithValue("@Status", Status);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataSet GetSupplierData(int SupId)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_BINDSupplierData";
                    dbSqlCommand.Parameters.AddWithValue("@SupplierID", SupId);
                    //dbSqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    //dbSqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    //dbSqlCommand.Parameters.AddWithValue("@Status", Status);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public DataTable SaveSupplierData(Supplier objSup)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_INSERTUPDATE_SupplierData";
                    dbSqlCommand.Parameters.AddWithValue("@SupplierID", objSup.SupplierID);
                    dbSqlCommand.Parameters.AddWithValue("@SupplierName", objSup.SupplierName);
                    dbSqlCommand.Parameters.AddWithValue("@SupplierCode", objSup.SupplierCode);
                    dbSqlCommand.Parameters.AddWithValue("@SupplierType", objSup.SupplierType);
                    dbSqlCommand.Parameters.AddWithValue("@SupplierCategory", objSup.SupplierCategory);
                    dbSqlCommand.Parameters.AddWithValue("@HouseNo", objSup.HouseNo);
                    dbSqlCommand.Parameters.AddWithValue("@Street", objSup.Street);
                    dbSqlCommand.Parameters.AddWithValue("@Country", objSup.Country);
                    dbSqlCommand.Parameters.AddWithValue("@State", objSup.State);
                    dbSqlCommand.Parameters.AddWithValue("@PinCode", objSup.PinCode);
                    dbSqlCommand.Parameters.AddWithValue("@Landline", objSup.Landline);
                    dbSqlCommand.Parameters.AddWithValue("@FaxNo", objSup.FaxNo);
                    dbSqlCommand.Parameters.AddWithValue("@EmailId", objSup.EmailId);
                    dbSqlCommand.Parameters.AddWithValue("@Website", objSup.Website);
                    dbSqlCommand.Parameters.AddWithValue("@PrimaryContactPerson", objSup.PrimaryContactPerson);
                    dbSqlCommand.Parameters.AddWithValue("@PrimaryContactPersonDesignation", objSup.PrimaryContactPersonDesignation);
                    dbSqlCommand.Parameters.AddWithValue("@PrimaryContactPersonMobileNo", objSup.PrimaryContactPersonMobileNo);
                    dbSqlCommand.Parameters.AddWithValue("@PrimaryContactPersonEmailId", objSup.PrimaryContactPersonEmailId);
                    dbSqlCommand.Parameters.AddWithValue("@SecondaryContactPerson", objSup.SecondaryContactPerson);
                    dbSqlCommand.Parameters.AddWithValue("@SecondaryContactPersonDesignation", objSup.SecondaryContactPersonDesignation);
                    dbSqlCommand.Parameters.AddWithValue("@SecondaryContactPersonMobileNo", objSup.SecondaryContactPersonMobileNo);
                    dbSqlCommand.Parameters.AddWithValue("@SecondaryContactPersonEmailId", objSup.SecondaryContactPersonEmailId);
                    dbSqlCommand.Parameters.AddWithValue("@CINNo", objSup.CINNo);
                    dbSqlCommand.Parameters.AddWithValue("@PFRegistartionNo", objSup.PFRegistartionNo);
                    dbSqlCommand.Parameters.AddWithValue("@NameonPANCard", objSup.NameonPANCard);
                    dbSqlCommand.Parameters.AddWithValue("@PANCardNo", objSup.PANCardNo);
                    dbSqlCommand.Parameters.AddWithValue("@ROCNo", objSup.ROCNo);
                    dbSqlCommand.Parameters.AddWithValue("@ESIRegistrationNo", objSup.ESIRegistrationNo);
                    dbSqlCommand.Parameters.AddWithValue("@ISOCertificationNo", objSup.ISOCertificationNo);
                    dbSqlCommand.Parameters.AddWithValue("@ISOValidUpto", objSup.ISOValidUpto);
                    dbSqlCommand.Parameters.AddWithValue("@PollutioncontrolBoardCertificationNo", objSup.PollutioncontrolBoardCertificationNo);
                    dbSqlCommand.Parameters.AddWithValue("@PollutionValidUpto", objSup.PollutionValidUpto);
                    dbSqlCommand.Parameters.AddWithValue("@Bank1", objSup.Bank1);
                    dbSqlCommand.Parameters.AddWithValue("@Bank1Branch", objSup.Bank1Branch);
                    dbSqlCommand.Parameters.AddWithValue("@Bank1AccountsNo", objSup.Bank1AccountsNo);
                    dbSqlCommand.Parameters.AddWithValue("@Bank1IFSCCode", objSup.Bank1IFSCCode);
                    dbSqlCommand.Parameters.AddWithValue("@Bank1Address1", objSup.Bank1Address1);
                    dbSqlCommand.Parameters.AddWithValue("@Bank1Address2", objSup.Bank1Address2);
                    dbSqlCommand.Parameters.AddWithValue("@Bank1City", objSup.Bank1City);
                    dbSqlCommand.Parameters.AddWithValue("@Bank1State", objSup.Bank1State);
                    dbSqlCommand.Parameters.AddWithValue("@Bank2", objSup.Bank2);
                    dbSqlCommand.Parameters.AddWithValue("@Bank2Branch", objSup.Bank2Branch);
                    dbSqlCommand.Parameters.AddWithValue("@Bank2AccountsNo", objSup.Bank2AccountsNo);
                    dbSqlCommand.Parameters.AddWithValue("@Bank2IFSCCode", objSup.Bank2IFSCCode);
                    dbSqlCommand.Parameters.AddWithValue("@Bank2Address1", objSup.Bank2Address1);
                    dbSqlCommand.Parameters.AddWithValue("@Bank2Address2", objSup.Bank2Address2);
                    dbSqlCommand.Parameters.AddWithValue("@Bank2City", objSup.Bank2City);
                    dbSqlCommand.Parameters.AddWithValue("@Bank2State", objSup.Bank2State);
                    dbSqlCommand.Parameters.AddWithValue("@PaymentTerms", objSup.PaymentTerms);
                    dbSqlCommand.Parameters.AddWithValue("@Taxes", objSup.Taxes);
                    dbSqlCommand.Parameters.AddWithValue("@DeliveryTerms", objSup.DeliveryTerms);
                    dbSqlCommand.Parameters.AddWithValue("@VendorToNotes", objSup.VendorToNotes);
                    dbSqlCommand.Parameters.AddWithValue("@CreditLimit", objSup.CreditLimit);
                    dbSqlCommand.Parameters.AddWithValue("@IsActive", objSup.IsActive);
                    dbSqlCommand.Parameters.AddWithValue("@CreaterID", objSup.CreaterID);
                    dbSqlCommand.Parameters.AddWithValue("@UpdatedBy", objSup.UpdatedBy);
                    dbSqlCommand.Parameters.AddWithValue("@CheckedBy", objSup.CheckedBy);
                    dbSqlCommand.Parameters.AddWithValue("@ApprovedBy", objSup.ApprovedBy);
                    dbSqlCommand.Parameters.AddWithValue("@LoginPassword", objSup.LoginPassword);
                    dbSqlCommand.Parameters.AddWithValue("@IsLoginRequired", objSup.IsLoginRequired);
                    dbSqlCommand.Parameters.AddWithValue("@LoginUserName", objSup.LoginUserName);
                    dbSqlCommand.Parameters.AddWithValue("@IsAutoRejectPO", objSup.IsAutoRejectPO);

                    dbSqlCommand.Parameters.AddWithValue("@FinancialDetails", objSup.FinancialDetails);
                    dbSqlCommand.Parameters.AddWithValue("@GstDetails", objSup.GstDetails);
                    dbSqlCommand.Parameters.AddWithValue("@ItemCategory", objSup.ItemCategory);
                    dbSqlCommand.Parameters.AddWithValue("@ItemSubCategory", objSup.ItemSubCategory);

                    //dbSqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    //dbSqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    //dbSqlCommand.Parameters.AddWithValue("@Status", Status);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataSet GetCategory(int supplierid)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetCategoryBySupplierId";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@supplierid", supplierid);
                    return objDALCIILibrary.GetDataSet(dbSqlCommand);

                }
            }
        }

        public DataTable GetSupplierListData(int UserId, int Role)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_GetSupplierListData";
                    dbSqlCommand.Parameters.AddWithValue("@UserId", UserId);
                    dbSqlCommand.Parameters.AddWithValue("@Role", Role);
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));    //2026-01-11 by HEMANT
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);
                }
            }
        }
        #endregion

        #region MenuData
        public string GetMenuData()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetMenus";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return MenuBindData(objDALCIILibrary.GetDataTable(dbSqlCommand));
                }
            }
        }
        public string MenuBindData(DataTable MenuData)
        {
            subMenuCounter = 0;
            IList<ClsMenu> lstClsMenu = new List<ClsMenu>();
            StringBuilder htmlbuilder = new StringBuilder();

            for (int i = 0; i < MenuData.Rows.Count; i++)
            {
                ClsMenu Menu = new ClsMenu();
                Menu.CategoryID = Convert.ToInt32(MenuData.Rows[i]["CategoryId"]);
                Menu.Category = MenuData.Rows[i]["Category"].ToString();
                Menu.SubCategory = MenuData.Rows[i]["SubCategory"].ToString();
                Menu.SubSubCategory = MenuData.Rows[i]["SubSubCategory"].ToString();
                Menu.SubSubCategoryId = MenuData.Rows[i]["SubSubCategoryId"].ToString();
                lstClsMenu.Add(Menu);
            }

            htmlbuilder.Append("<ul class='nav navbar-nav'>");
            var CategoryList = lstClsMenu.Select(s => new { CategoryID = s.CategoryID, Category = s.Category }).Distinct().ToList();
            foreach (var mainmenu in CategoryList)
            {
                var SubCategoryList = lstClsMenu.Where(w => w.Category == mainmenu.Category.ToString() && w.SubCategory != "").Select(s => new { SubCategory = s.SubCategory }).Distinct().ToList();


                if (SubCategoryList.Count > 0)
                {
                    subMenuCounter++;
                    if (SubCategoryList.Count >= subMenuCounter)
                    {
                        htmlbuilder.Append("<li class='dropdown mega-dropdown'>");
                        htmlbuilder.Append("<a href='../Front/Search.aspx?Search=" + mainmenu.Category.ToString() + "' class='navbar-brand dropdown-toggle' style='padding:15px;' data-toggle='dropdown'>" + mainmenu.Category.ToString() + " <span class='caret'></span></a>	");
                        htmlbuilder.Append("<ul class='dropdown-menu mega-dropdown-menu'>");
                    }
                    else
                    {
                        htmlbuilder.Append("<li class='dropdown normal-dropdown'>");
                        htmlbuilder.Append("<a href='../Front/Search.aspx?Search=" + mainmenu.Category.ToString() + "' class='navbar-brand dropdown-toggle' style='padding:15px;' data-toggle='dropdown'>" + mainmenu.Category.ToString() + " <span class='caret'></span></a>	");
                        htmlbuilder.Append("<ul class='dropdown-menu' role='menu'>");
                    }

                    foreach (var subcategory in SubCategoryList)
                    {
                        if (SubCategoryList.Count >= subMenuCounter)
                        {
                            htmlbuilder.Append("<li class='col-sm-3' style='width:auto;'>");
                        }
                        else
                        {
                            htmlbuilder.Append("<li style='width:auto;'>");
                        }
                        htmlbuilder.Append("<ul>");
                        htmlbuilder.Append("<li class='dropdown-header'>" + subcategory.SubCategory.ToString() + "</li>");
                        foreach (var subsubcategory in lstClsMenu.Where(w => w.SubCategory == subcategory.SubCategory.ToString() && w.SubSubCategory != "" && w.CategoryID == mainmenu.CategoryID).Distinct().ToList())
                        {
                            htmlbuilder.Append("<li><a href='../Front/Search.aspx?SubSubCategory=" + subsubcategory.SubSubCategoryId.ToString() + "'>" + subsubcategory.SubSubCategory.ToString() + "</a></li>");
                        }
                        htmlbuilder.Append("</ul>");
                        htmlbuilder.Append("</li>");
                    }
                    htmlbuilder.Append("</ul>");
                }
                else
                {
                    htmlbuilder.Append("<li class='dropdown mega-dropdown'>");
                    htmlbuilder.Append("<a href='../Front/Search.aspx?Search=" + mainmenu.Category.ToString() + "' class='navbar-brand dropdown-toggle' style='padding:15px;' data-toggle='dropdown'>" + mainmenu.Category.ToString() + " <span class='caret'></span></a>	");
                }
                htmlbuilder.Append("</li>");
            }
            htmlbuilder.Append("</ul>");
            return htmlbuilder.ToString();
        }

        #endregion

        #region Raju 

        public DataTable GetStateMaster()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "GetStateMaster_SP";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        #endregion
        public DataTable GetCityMasterByStateID(int stateID)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "GetCityMasterByStateID_SP";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@stateID", stateID);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable GetAllCityMasterByStateID(int stateID)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "GetAllCityMasterByStateID_SP";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@stateID", stateID);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable GetAreaMasterByCityID(int CityID)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "sp_GetAreaMasterByCityId";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@CityID", CityID);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable GetAllAreaMasterByCityID(int CityID)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "GetAllAreaMasterByCityID_SP";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@CityID", CityID);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataTable GetAllCategoryMaster()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_AllGetCategory";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataTable GetSubCategoryByID(int CategoryID)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetSubCategoryByID";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@CategoryID", CategoryID);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable GetSubSubCategoryByID(int CategoryID, int SubCategoryID)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetSubSubCategoryByID";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@CategoryID", CategoryID);
                    dbSqlCommand.Parameters.AddWithValue("@SubCategoryID", SubCategoryID);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }

        public DataTable GetMenuMaster()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_ADMINMENULIST";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable GetADMINROLE()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_ADMINROLE";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable GetBINDROLEWISEMENU(int RoleID)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_BINDROLEWISEMENU";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@RoleID", RoleID);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }
        public DataTable GetDashboardROLEWISEMENU(int RoleID)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "PROC_BINDDASHBOARDMENU";
                    dbSqlCommand.CommandType = CommandType.StoredProcedure;
                    dbSqlCommand.Parameters.AddWithValue("@RoleID", RoleID);
                    return objDALCIILibrary.GetDataTable(dbSqlCommand);

                }
            }
        }


        public int StateMaster_CRUD(int id, string state, int IsActive, string CreatedBy, string Action)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "State_master_CRUD";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@id", id);
                    sqlCommand.Parameters.AddWithValue("@state", state);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                    sqlCommand.Parameters.AddWithValue("@Action", Action);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }
        public int CityMaster_CRUD(int id, int stateID, string CityName, int IsActive, string CreatedBy, string Action)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "City_master_CRUD";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@id", id);
                    sqlCommand.Parameters.AddWithValue("@stateID", stateID);
                    sqlCommand.Parameters.AddWithValue("@CityName", CityName);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                    sqlCommand.Parameters.AddWithValue("@Action", Action);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }
        public int AreaMaster_CRUD(int id, int CityID, string AreaName, int pincode, int IsActive, string CreatedBy, string Action)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Area_master_CRUD";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@id", id);
                    sqlCommand.Parameters.AddWithValue("@CityID", CityID);
                    sqlCommand.Parameters.AddWithValue("@AreaName", AreaName);
                    sqlCommand.Parameters.AddWithValue("@pincode", pincode);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                    sqlCommand.Parameters.AddWithValue("@Action", Action);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public int Category_master_CRUD(int CategoryId, string CategoryName, int IsActive, string CreatedBy, string Action)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Category_master_CRUD";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@CategoryId", CategoryId);
                    sqlCommand.Parameters.AddWithValue("@CategoryName", CategoryName);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", Convert.ToInt32(HttpContext.Current.Session["UserId"]));
                    sqlCommand.Parameters.AddWithValue("@Action", Action);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public int SubCategory_master_CRUD(int id, int CategoryID, string SubCategoryName, int IsActive, string CreatedBy, string Action)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    //sqlCommand.CommandText = "proc_AddSettlementAmount";
                    sqlCommand.CommandText = "SubCategory_master_CRUD";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@SubCategoryID", id);
                    sqlCommand.Parameters.AddWithValue("@CategoryID", CategoryID);
                    //sqlCommand.Parameters.AddWithValue("@CustomerId", CustomerId);
                    sqlCommand.Parameters.AddWithValue("@SubCategoryName", SubCategoryName);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", Convert.ToInt32(HttpContext.Current.Session["UserId"]));
                    sqlCommand.Parameters.AddWithValue("@Action", Action);
                    //sqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    //sqlCommand.Parameters.AddWithValue("@Name", FirstName);
                    //sqlCommand.Parameters.AddWithValue("@TransactionId", TransactionId);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }
        public int SubSubCategory_master_CRUD(int id, int SubCategoryID, int CategoryID, string SubSubCategoryName, int IsActive, string CreatedBy, string Action)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "SubSubCategory_master_CRUD";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@SubSubCategoryID", id);
                    sqlCommand.Parameters.AddWithValue("@SubCategoryID", SubCategoryID);
                    sqlCommand.Parameters.AddWithValue("@CategoryID", CategoryID);
                    sqlCommand.Parameters.AddWithValue("@SubSubCategoryName", SubSubCategoryName);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", Convert.ToInt32(HttpContext.Current.Session["UserId"]));
                    sqlCommand.Parameters.AddWithValue("@Action", Action);
                    //sqlCommand.Parameters.AddWithValue("@SettlementAmount", SettlementAmt);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        //add menu
        public int Menu_master_CRUD(int MenuId, string MenuName, string MenuUrl, int IsActive, string CreatedBy, string Action)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_INSERTUPDATEADMINMENU";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@MenuId", MenuId);
                    sqlCommand.Parameters.AddWithValue("@MenuName", MenuName);
                    sqlCommand.Parameters.AddWithValue("@MenuUrl", MenuUrl);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    //sqlCommand.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                    // sqlCommand.Parameters.AddWithValue("@Action", Action);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }
        //add Role
        public int Role_master_CRUD(int RoleId, string Role, int IsActive, string CreatedBy, string Action)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_INSERTUPDATEROLE";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@RoleId", RoleId);
                    sqlCommand.Parameters.AddWithValue("@Role", Role);
                    sqlCommand.Parameters.AddWithValue("@IsActive", IsActive);
                    //sqlCommand.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                    // sqlCommand.Parameters.AddWithValue("@Action", Action);

                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }
        #region Get Due Amount Details
        public DataTable GetDueAmountDetails()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetDueAmount";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@FromDate", FromDate);
                    sqlCommand.Parameters.AddWithValue("@ToDate", ToDate);
                    sqlCommand.Parameters.AddWithValue("@Keyword", Keyword);
                    sqlCommand.Parameters.AddWithValue("@OrgId", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
        #endregion

        #region Add Settlement Amount with Remarks
        public Int32 CustomerId { get; set; }
        public string AddSettlementAmount()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "proc_AddSettlementAmount";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@CustomerId", CustomerId);
                    sqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    sqlCommand.Parameters.AddWithValue("@Name", FirstName);
                    sqlCommand.Parameters.AddWithValue("@TransactionId", TransactionId);
                    sqlCommand.Parameters.AddWithValue("@SettlementAmount", SettlementAmt);
                    sqlCommand.Parameters.AddWithValue("@PaymentModeId", Convert.ToInt32(PaymentMode));
                    sqlCommand.Parameters.AddWithValue("@Remarks", Remarks);
                    sqlCommand.Parameters.AddWithValue("@EntryBy", UserId);

                    return objDAL.GetDataTable(sqlCommand).Rows[0][0].ToString();

                }
            }
        }
        #endregion
        #region Bind Caregory
        public DataTable BindWSCategory()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_WS_BindCategory";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Action", 1);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
        #endregion
        public DataTable FetchTransactionDetail()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetSettlement_Hemant";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@TransactionId", TransactionId);

                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }



        //add/update menu
        #region Insert update rolewise menu
        public int INSERTUPDATEROLEWISEMENU(int RoleId, int MenuID, bool IsChecked)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_INSERTUPDATEROLEWISEMENU";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@RoleId", RoleId);
                    sqlCommand.Parameters.AddWithValue("@MenuID", MenuID);
                    sqlCommand.Parameters.AddWithValue("@IsChecked", IsChecked);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        #endregion

        #region Organization Master properties
        public int SellerId { get; set; }
        public string SellerName { get; set; }
        public string BrandName { get; set; }
        public string DisplayName { get; set; }
        public string SellerAddress { get; set; }
        public string Logo { get; set; }
        public int BusinessId { get; set; }
        public string LandLineNumber { get; set; }
        public string Website { get; set; }
        public int CreatedBy { get; set; }
        public string OrgProfileImage { get; set; }
        public bool OrgStatus { get; set; }
        public string Latitude { get; set; } = "0";
        public string Longitude { get; set; } = "0";
        #endregion

        #region Organization Master BLL - Insert
        public int AddOrganizationMasterDetails()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_OrganizationMaster";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@SellerName", SellerName);
                    sqlCommand.Parameters.AddWithValue("@LastName", LastName);
                    sqlCommand.Parameters.AddWithValue("@BrandName", BrandName);
                    sqlCommand.Parameters.AddWithValue("@DisplayName", DisplayName);
                    sqlCommand.Parameters.AddWithValue("@GST", GST);
                    sqlCommand.Parameters.AddWithValue("@SellerAddress", SellerAddress);
                    sqlCommand.Parameters.AddWithValue("@Logo", "");
                    sqlCommand.Parameters.AddWithValue("@BusinessId", BusinessId);
                    sqlCommand.Parameters.AddWithValue("@MobileNumber", Mobile);
                    sqlCommand.Parameters.AddWithValue("@LandlineNumber", LandLineNumber);
                    sqlCommand.Parameters.AddWithValue("@EmailId", Email);
                    sqlCommand.Parameters.AddWithValue("@Website", Website);
                    sqlCommand.Parameters.AddWithValue("@Password", Password);
                    sqlCommand.Parameters.AddWithValue("@IsActive", true);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", UserId);
                    sqlCommand.Parameters.AddWithValue("@Username", UserName);
                    sqlCommand.Parameters.AddWithValue("@ProfileImage", OrgProfileImage);
                    sqlCommand.Parameters.AddWithValue("@Latitude", Latitude);
                    sqlCommand.Parameters.AddWithValue("@Longitude", Longitude);
                    sqlCommand.Parameters.AddWithValue("@State", State);
                    sqlCommand.Parameters.AddWithValue("@City", City);
                    sqlCommand.Parameters.AddWithValue("@Locality", Locality);
                    sqlCommand.Parameters.AddWithValue("@Pincode", Pincode);
                    sqlCommand.Parameters.AddWithValue("@Action", 1);
                    sqlCommand.Parameters.AddWithValue("@ReturnId", SqlDbType.Int);
                    sqlCommand.Parameters["@ReturnId"].Direction = ParameterDirection.Output;

                    //return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                    return Convert.ToInt32(objDAL.GetDataTable(sqlCommand).Rows[0][0]);
                }
            }
        }
        #endregion

        #region Bind Organization Master details
        public DataTable BindOrganizationMasterDetails()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_OrganizationMaster";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Id", Convert.ToInt32(HttpContext.Current.Session["OrgId"]));
                    sqlCommand.Parameters.AddWithValue("@Action", 2);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
        #endregion

        #region Update Organization Details
        public int UpdateOrganizationMasterDetails()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_OrganizationMaster";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Id", SellerId);
                    sqlCommand.Parameters.AddWithValue("@SellerName", SellerName);
                    sqlCommand.Parameters.AddWithValue("@LastName", LastName);
                    sqlCommand.Parameters.AddWithValue("@BrandName", BrandName);
                    sqlCommand.Parameters.AddWithValue("@DisplayName", DisplayName);
                    sqlCommand.Parameters.AddWithValue("@GST", GST);
                    sqlCommand.Parameters.AddWithValue("@SellerAddress", SellerAddress);
                    sqlCommand.Parameters.AddWithValue("@Logo", "");
                    sqlCommand.Parameters.AddWithValue("@BusinessId", BusinessId);
                    sqlCommand.Parameters.AddWithValue("@MobileNumber", Mobile);
                    sqlCommand.Parameters.AddWithValue("@LandlineNumber", LandLineNumber);
                    sqlCommand.Parameters.AddWithValue("@EmailId", Email);
                    sqlCommand.Parameters.AddWithValue("@Website", Website);
                    sqlCommand.Parameters.AddWithValue("@Password", Password);
                    sqlCommand.Parameters.AddWithValue("@modifiedBy", UserId);
                    sqlCommand.Parameters.AddWithValue("@ProfileImage", OrgProfileImage);
                    sqlCommand.Parameters.AddWithValue("@Latitude", Latitude);
                    sqlCommand.Parameters.AddWithValue("@Longitude", Longitude);
                    sqlCommand.Parameters.AddWithValue("@State", State);
                    sqlCommand.Parameters.AddWithValue("@City", City);
                    sqlCommand.Parameters.AddWithValue("@Locality", Locality);
                    sqlCommand.Parameters.AddWithValue("@Pincode", Pincode);
                    sqlCommand.Parameters.AddWithValue("@Action", 3);
                    sqlCommand.Parameters.AddWithValue("@ReturnId", SqlDbType.Int);
                    sqlCommand.Parameters["@ReturnId"].Direction = ParameterDirection.Output;

                    //return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                    return Convert.ToInt32(objDAL.GetDataTable(sqlCommand).Rows[0][0]);
                }
            }
        }
        #endregion

        #region Delete Organization Details
        public int DeleteOrganizationMasterDetails()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_OrganizationMaster";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Id", SellerId);
                    sqlCommand.Parameters.AddWithValue("@IsActive", OrgStatus);
                    sqlCommand.Parameters.AddWithValue("@Action", 4);
                    sqlCommand.Parameters.AddWithValue("@ReturnId", SqlDbType.Int);
                    sqlCommand.Parameters["@ReturnId"].Direction = ParameterDirection.Output;

                    //return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                    return Convert.ToInt32(objDAL.GetDataTable(sqlCommand).Rows[0][0]);
                }
            }
        }
        #endregion

        /*#region Bind Caregory
        public DataTable BindWSCategory()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_WS_BindCategory";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Action", 1);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }*/

        #region "Job Registration"
        public int ManageRegistration()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_ManageRegistration";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@RegId", RegId);
                    sqlCommand.Parameters.AddWithValue("@AadharNumber", AadharNumber);
                    sqlCommand.Parameters.AddWithValue("@Skill", Skill);
                    sqlCommand.Parameters.AddWithValue("@FirstName", FirstName);
                    sqlCommand.Parameters.AddWithValue("@LastName", LastName);
                    sqlCommand.Parameters.AddWithValue("@FatherName", FatherName);
                    sqlCommand.Parameters.AddWithValue("@PhoneNumber", Mobile);
                    sqlCommand.Parameters.AddWithValue("@Gender", Gender);
                    sqlCommand.Parameters.AddWithValue("@BirthPlace", BirthPlace);
                    sqlCommand.Parameters.AddWithValue("@Age", int.TryParse(Age, out var age) ? age : 0);
                    sqlCommand.Parameters.AddWithValue("@ExperienceType", ExperienceType);
                    sqlCommand.Parameters.AddWithValue("@ResumePath", ResumePath);
                    sqlCommand.Parameters.AddWithValue("@UserId", IntUserId);

                    sqlCommand.Parameters.AddWithValue("@EmergencyPhone", EmergencyPhone);
                    sqlCommand.Parameters.AddWithValue("@EmergencyName", EmergencyName);
                    sqlCommand.Parameters.AddWithValue("@EmergencyRelation", EmergencyRelation);

                    sqlCommand.Parameters.AddWithValue("@SchoolUniversity", SchoolUniversity);
                    sqlCommand.Parameters.AddWithValue("@Qualification", Qualification);
                    sqlCommand.Parameters.AddWithValue("@EducationPath", EducationPath);

                    sqlCommand.Parameters.AddWithValue("@AccountNumber", AccountNumber);
                    sqlCommand.Parameters.AddWithValue("@IFSC", IFSC);
                    sqlCommand.Parameters.AddWithValue("@BankName", BankName);

                    sqlCommand.Parameters.AddWithValue("@AadharPath", AadharPath);
                    sqlCommand.Parameters.AddWithValue("@PhotoPath", PhotoPath);

                    sqlCommand.Parameters.AddWithValue("@ExpDuration", ExpDuration);
                    sqlCommand.Parameters.AddWithValue("@ExpUnit", ExpUnit);
                    sqlCommand.Parameters.AddWithValue("@Amount", Amount);

                    sqlCommand.Parameters.AddWithValue("@Height", Height);
                    sqlCommand.Parameters.AddWithValue("@Weight", Weight);
                    sqlCommand.Parameters.AddWithValue("@Languages", Languages);
                    sqlCommand.Parameters.AddWithValue("@MaritalStatus", MaritalStatus);
                    sqlCommand.Parameters.AddWithValue("@ExpectedDemand", ExpectedDemand);
                    sqlCommand.Parameters.AddWithValue("@FullAddress", FullAddress);
                    sqlCommand.Parameters.AddWithValue("@StateName", StateName);
                    sqlCommand.Parameters.AddWithValue("@CityName", CityName);
                    sqlCommand.Parameters.AddWithValue("@LocationName", LocationName);
                    sqlCommand.Parameters.AddWithValue("@Landmark", Landmark);
                    sqlCommand.Parameters.AddWithValue("@Pincode", PincodeVal);

                    DataTable dt = objDAL.GetDataTable(sqlCommand);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        return Convert.ToInt32(dt.Rows[0][0]);
                    }
                    return 0;
                }
            }
        }

        public DataTable GetRegistrationList()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_GetRegistrationList";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable GetRegistrationById()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_GetRegistrationById";
                    sqlCommand.Parameters.AddWithValue("@RegId", RegId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public int DeleteRegistration()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_DeleteRegistration";
                    sqlCommand.Parameters.AddWithValue("@RegId", RegId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public DataTable GetJobRegistrations(string skill, string location, string experience)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_SearchJobRegistrations";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Skill", string.IsNullOrEmpty(skill) ? (object)DBNull.Value : skill);
                    sqlCommand.Parameters.AddWithValue("@Location", string.IsNullOrEmpty(location) ? (object)DBNull.Value : location);
                    sqlCommand.Parameters.AddWithValue("@Experience", string.IsNullOrEmpty(experience) ? (object)DBNull.Value : experience);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable GetHiredRegIdsByUser()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "SELECT DISTINCT RegId FROM tblHire WHERE CreatedBy = @UserId";
                    sqlCommand.CommandType = CommandType.Text;
                    sqlCommand.Parameters.AddWithValue("@UserId", IntUserId);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable GetJobRegistrationForHire()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_GetJobRegistrationForHire";
                    sqlCommand.Parameters.AddWithValue("@RegId", RegId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public int ManageHireDetail()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_SaveHireDetail";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@RegId", RegId);
                    sqlCommand.Parameters.AddWithValue("@CompanyName", CompanyName);
                    sqlCommand.Parameters.AddWithValue("@ContactPerson", ContactPerson);
                    sqlCommand.Parameters.AddWithValue("@ContactPhone", Mobile);
                    sqlCommand.Parameters.AddWithValue("@SalaryOffered", Amount);
                    sqlCommand.Parameters.AddWithValue("@HireDate", string.IsNullOrEmpty(FromDate) ? (object)DateTime.Now : FromDate);
                    sqlCommand.Parameters.AddWithValue("@Remarks", Remarks);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", IntUserId);

                    DataTable dt = objDAL.GetDataTable(sqlCommand);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        return Convert.ToInt32(dt.Rows[0][0]);
                    }
                    return 0;
                }
            }
        }
        public DataTable GetHiringDetailsByUserId(string Status = "")
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_GETHIRINGDETAILSBYUSERID";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@UserId", IntUserId); // Need to check if there is UserId int. 
                    sqlCommand.Parameters.AddWithValue("@Status", Status); // Need to check if there is UserId int. 
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable GetHiringDetailsByHireId()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "SELECT h.*, jr.FirstName, jr.LastName FROM tblHire h INNER JOIN tblJobRegistration jr ON h.RegId = jr.RegId WHERE h.HireId = @HireId";
                    sqlCommand.CommandType = CommandType.Text;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@HireId", HireId);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public int UpdateHireStatus()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "UPDATE tblHire SET Status = @Status WHERE HireId = @HireId";
                    sqlCommand.CommandType = CommandType.Text;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@Status", Status);
                    sqlCommand.Parameters.AddWithValue("@HireId", HireId);
                    return objDAL.ExecuteNonQuery_RetInt(sqlCommand);
                }
            }
        }

        public DataTable GetSellerLogoBySellerId(int OrgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "proc_GETSellerLogoBySellerId";
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }

        public DataTable GetEmployeeByOrgId(int OrgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_GETEMPLOYEEBYORGID";
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
        public DataTable GetOrganizationCategory(int orgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_GetOrganizationCategory";
                    sqlCommand.Parameters.AddWithValue("@OrgId", orgId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    return objDAL.GetDataTable(sqlCommand);

                }
            }
        }

        #endregion


        #region Team Hierarchy Management
        public bool IsSuperAdminRole(int roleId)
        {
            try
            {
                using (DataAccessLayer objDAL = new DataAccessLayer())
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "SELECT RoleId, Role FROM tblRole WHERE RoleId = @RoleId";
                        cmd.Parameters.AddWithValue("@RoleId", roleId);
                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            string role = dt.Rows[0]["Role"].ToString().Trim();
                            return role.IndexOf("Super", StringComparison.OrdinalIgnoreCase) >= 0
                                || role.Equals("Super Admin", StringComparison.OrdinalIgnoreCase)
                                || role.Equals("SuperAdmin", StringComparison.OrdinalIgnoreCase)
                                || (role.Equals("Admin", StringComparison.OrdinalIgnoreCase) && roleId == 1);
                        }
                    }
                }
            }
            catch
            {
                if (roleId == 1) return true;
            }
            return false;
        }

        public bool IsAdminRole(int roleId)
        {
            try
            {
                using (DataAccessLayer objDAL = new DataAccessLayer())
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "SELECT RoleId, Role FROM tblRole WHERE RoleId = @RoleId";
                        cmd.Parameters.AddWithValue("@RoleId", roleId);
                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            string role = dt.Rows[0]["Role"].ToString().Trim();
                            return role.IndexOf("Admin", StringComparison.OrdinalIgnoreCase) >= 0;
                        }
                    }
                }
            }
            catch
            {
                if (roleId == 1 || roleId == 2) return true;
            }
            return false;
        }

        public bool CanManageHierarchy(int roleId)
        {
            return IsSuperAdminRole(roleId) || IsAdminRole(roleId);
        }

        public bool CheckUserHasSubordinates(int userId)
        {
            try
            {
                using (DataAccessLayer objDAL = new DataAccessLayer())
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "SELECT TOP 1 1 FROM tblUser WHERE ManagerId = @UserId";
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        DataTable dt = objDAL.GetDataTable(cmd);
                        return (dt != null && dt.Rows.Count > 0);
                    }
                }
            }
            catch { return false; }
        }

        public DataTable GetTeamHierarchy(int? orgId, int? roleId, string search)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_GET_TEAM_HIERARCHY";
                        cmd.CommandType = CommandType.StoredProcedure;
                        if (orgId.HasValue && orgId.Value > 0)
                            cmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            cmd.Parameters.AddWithValue("@OrgId", DBNull.Value);

                        if (roleId.HasValue && roleId.Value > 0)
                            cmd.Parameters.AddWithValue("@RoleId", roleId.Value);
                        else
                            cmd.Parameters.AddWithValue("@RoleId", DBNull.Value);

                        if (!string.IsNullOrWhiteSpace(search))
                            cmd.Parameters.AddWithValue("@Search", search.Trim());
                        else
                            cmd.Parameters.AddWithValue("@Search", DBNull.Value);

                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null) return dt;
                    }
                    catch
                    {
                        // Fallback to inline query if stored procedure has not been executed yet
                    }

                    using (SqlCommand fallbackCmd = new SqlCommand())
                    {
                        fallbackCmd.CommandType = CommandType.Text;
                        fallbackCmd.CommandText = @"
                            WITH UserHierarchyCTE AS (
                                SELECT 
                                    u.UserId,
                                    u.UserName,
                                    u.FirstName,
                                    u.LastName,
                                    ISNULL(NULLIF(LTRIM(RTRIM(ISNULL(u.FirstName,'') + ' ' + ISNULL(u.LastName,''))),''), u.UserName) AS FullName,
                                    u.Email,
                                    u.Mobile,
                                    u.EmployeeId,
                                    u.RoleId,
                                    u.OrgId,
                                    u.IsActive,
                                    u.JoinedOn,
                                    u.ManagerId,
                                    CAST(NULL AS NVARCHAR(250)) AS ManagerName,
                                    1 AS HierarchyLevel,
                                    CAST('/' + RIGHT('0000000000' + CAST(u.UserId AS VARCHAR(10)), 10) + '/' AS VARCHAR(MAX)) AS HierarchyPath,
                                    CAST(ISNULL(NULLIF(LTRIM(RTRIM(ISNULL(u.FirstName,'') + ' ' + ISNULL(u.LastName,''))),''), u.UserName) AS NVARCHAR(MAX)) AS HierarchyBreadcrumb
                                FROM tblUser u
                                WHERE (u.ManagerId IS NULL OR u.ManagerId = 0 OR u.ManagerId = u.UserId
                                       OR u.ManagerId NOT IN (SELECT UserId FROM tblUser))
                                  AND (@OrgId IS NULL OR u.OrgId = @OrgId)

                                UNION ALL

                                SELECT 
                                    u.UserId,
                                    u.UserName,
                                    u.FirstName,
                                    u.LastName,
                                    CAST(ISNULL(NULLIF(LTRIM(RTRIM(ISNULL(u.FirstName,'') + ' ' + ISNULL(u.LastName,''))),''), u.UserName) AS NVARCHAR(250)) AS FullName,
                                    u.Email,
                                    u.Mobile,
                                    u.EmployeeId,
                                    u.RoleId,
                                    u.OrgId,
                                    u.IsActive,
                                    u.JoinedOn,
                                    u.ManagerId,
                                    CAST(cte.FullName AS NVARCHAR(250)) AS ManagerName,
                                    cte.HierarchyLevel + 1 AS HierarchyLevel,
                                    CAST(cte.HierarchyPath + RIGHT('0000000000' + CAST(u.UserId AS VARCHAR(10)), 10) + '/' AS VARCHAR(MAX)) AS HierarchyPath,
                                    CAST(cte.HierarchyBreadcrumb + ' > ' + ISNULL(NULLIF(LTRIM(RTRIM(ISNULL(u.FirstName,'') + ' ' + ISNULL(u.LastName,''))),''), u.UserName) AS VARCHAR(MAX)) AS HierarchyBreadcrumb
                                FROM tblUser u
                                INNER JOIN UserHierarchyCTE cte ON u.ManagerId = cte.UserId
                                WHERE cte.HierarchyPath NOT LIKE '%/' + RIGHT('0000000000' + CAST(u.UserId AS VARCHAR(10)), 10) + '/%'
                                  AND (@OrgId IS NULL OR u.OrgId = @OrgId)
                            )
                            SELECT 
                                h.UserId,
                                h.UserName,
                                h.FirstName,
                                h.LastName,
                                h.FullName,
                                h.Email,
                                h.Mobile,
                                h.EmployeeId,
                                h.RoleId,
                                ISNULL(r.[Role], 'Employee') AS RoleName,
                                h.OrgId,
                                h.IsActive,
                                h.JoinedOn,
                                h.ManagerId,
                                ISNULL(h.ManagerName, 'None (Top Level / Root)') AS ManagerName,
                                h.HierarchyLevel,
                                h.HierarchyPath,
                                h.HierarchyBreadcrumb,
                                (SELECT COUNT(1) FROM tblUser sub WHERE sub.ManagerId = h.UserId) AS DirectReportsCount
                            FROM UserHierarchyCTE h
                            LEFT JOIN tblRole r ON h.RoleId = r.RoleId
                            WHERE (@RoleId IS NULL OR h.RoleId = @RoleId)
                              AND (
                                  @Search IS NULL 
                                  OR h.FullName LIKE '%' + @Search + '%' 
                                  OR h.UserName LIKE '%' + @Search + '%' 
                                  OR h.Email LIKE '%' + @Search + '%' 
                                  OR h.Mobile LIKE '%' + @Search + '%'
                                  OR CAST(h.EmployeeId AS VARCHAR(50)) LIKE '%' + @Search + '%'
                                  OR r.[Role] LIKE '%' + @Search + '%'
                              )
                            ORDER BY h.HierarchyPath;
                        ";

                        if (orgId.HasValue && orgId.Value > 0)
                            fallbackCmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            fallbackCmd.Parameters.AddWithValue("@OrgId", DBNull.Value);

                        if (roleId.HasValue && roleId.Value > 0)
                            fallbackCmd.Parameters.AddWithValue("@RoleId", roleId.Value);
                        else
                            fallbackCmd.Parameters.AddWithValue("@RoleId", DBNull.Value);

                        if (!string.IsNullOrWhiteSpace(search))
                            fallbackCmd.Parameters.AddWithValue("@Search", search.Trim());
                        else
                            fallbackCmd.Parameters.AddWithValue("@Search", DBNull.Value);

                        return objDAL.GetDataTable(fallbackCmd);
                    }
                }
            }
        }

        public bool UpdateUserManager(int userId, int? managerId, int updatedBy, out string message)
        {
            message = string.Empty;
            if (userId <= 0)
            {
                message = "Invalid User ID.";
                return false;
            }

            if (managerId.HasValue && managerId.Value > 0 && managerId.Value == userId)
            {
                message = "A user cannot report to themselves.";
                return false;
            }

            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "PROC_UPDATE_USER_MANAGER";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@ManagerId", (object)managerId ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@UpdatedBy", updatedBy > 0 ? (object)updatedBy : DBNull.Value);

                        SqlParameter pStatus = new SqlParameter("@Status", SqlDbType.Bit) { Direction = ParameterDirection.Output };
                        SqlParameter pMessage = new SqlParameter("@Message", SqlDbType.VarChar, 250) { Direction = ParameterDirection.Output };
                        cmd.Parameters.Add(pStatus);
                        cmd.Parameters.Add(pMessage);

                        objDAL.ExecuteNonQuery_RetInt(cmd);

                        bool status = pStatus.Value != DBNull.Value && Convert.ToBoolean(pStatus.Value);
                        message = pMessage.Value != DBNull.Value ? pMessage.Value.ToString() : (status ? "Manager updated successfully." : "Failed to update manager.");
                        return status;
                    }
                }
                catch
                {
                    // Fallback direct execution
                    try
                    {
                        if (managerId.HasValue && managerId.Value > 0)
                        {
                            // Circular check
                            using (SqlCommand checkCmd = new SqlCommand())
                            {
                                checkCmd.CommandType = CommandType.Text;
                                checkCmd.CommandText = @"
                                    WITH AncestorCTE AS (
                                        SELECT UserId, ManagerId FROM tblUser WHERE UserId = @ManagerId
                                        UNION ALL
                                        SELECT u.UserId, u.ManagerId FROM tblUser u
                                        INNER JOIN AncestorCTE a ON u.UserId = a.ManagerId
                                        WHERE a.ManagerId IS NOT NULL AND a.ManagerId > 0 AND a.ManagerId <> a.UserId
                                    )
                                    SELECT COUNT(1) FROM AncestorCTE WHERE UserId = @UserId;
                                ";
                                checkCmd.Parameters.AddWithValue("@ManagerId", managerId.Value);
                                checkCmd.Parameters.AddWithValue("@UserId", userId);
                                DataTable dtCheck = objDAL.GetDataTable(checkCmd);
                                if (dtCheck != null && dtCheck.Rows.Count > 0 && Convert.ToInt32(dtCheck.Rows[0][0]) > 0)
                                {
                                    message = "Circular hierarchy detected: cannot assign a subordinate as manager.";
                                    return false;
                                }
                            }
                        }

                        using (SqlCommand updateCmd = new SqlCommand())
                        {
                            updateCmd.CommandType = CommandType.Text;
                            updateCmd.CommandText = @"
                                UPDATE tblUser
                                SET ManagerId = @ManagerId
                                WHERE UserId = @UserId;
                            ";
                            updateCmd.Parameters.AddWithValue("@UserId", userId);
                            if (managerId.HasValue && managerId.Value > 0)
                                updateCmd.Parameters.AddWithValue("@ManagerId", managerId.Value);
                            else
                                updateCmd.Parameters.AddWithValue("@ManagerId", DBNull.Value);

                            int rows = objDAL.ExecuteNonQuery_RetInt(updateCmd);
                            if (rows > 0)
                            {
                                message = "Reporting manager updated successfully.";
                                return true;
                            }
                            else
                            {
                                message = "User not found or no changes made.";
                                return false;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        message = "Error updating manager: " + ex.Message;
                        return false;
                    }
                }
            }
        }

        public DataTable GetPotentialManagers(int userId, int? orgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_GET_POTENTIAL_MANAGERS";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        if (orgId.HasValue && orgId.Value > 0)
                            cmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            cmd.Parameters.AddWithValue("@OrgId", DBNull.Value);

                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null) return dt;
                    }
                    catch
                    {
                        // Fallback
                    }

                    using (SqlCommand fallbackCmd = new SqlCommand())
                    {
                        fallbackCmd.CommandType = CommandType.Text;
                        fallbackCmd.CommandText = @"
                            WITH SubordinateCTE AS (
                                SELECT UserId FROM tblUser WHERE ManagerId = @UserId
                                UNION ALL
                                SELECT u.UserId FROM tblUser u
                                INNER JOIN SubordinateCTE s ON u.ManagerId = s.UserId
                                WHERE u.ManagerId IS NOT NULL AND u.ManagerId > 0 AND u.ManagerId <> u.UserId
                            )
                            SELECT 
                                u.UserId,
                                ISNULL(NULLIF(LTRIM(RTRIM(ISNULL(u.FirstName,'') + ' ' + ISNULL(u.LastName,''))),''), u.UserName) AS FullName,
                                u.UserName,
                                u.EmployeeId,
                                ISNULL(r.[Role], 'No Role') AS RoleName,
                                u.Email,
                                u.Mobile,
                                u.IsActive
                            FROM tblUser u
                            LEFT JOIN tblRole r ON u.RoleId = r.RoleId
                            WHERE u.UserId <> @UserId
                              AND u.UserId NOT IN (SELECT UserId FROM SubordinateCTE)
                              AND (@OrgId IS NULL OR u.OrgId = @OrgId)
                            ORDER BY FullName ASC;
                        ";
                        fallbackCmd.Parameters.AddWithValue("@UserId", userId);
                        if (orgId.HasValue && orgId.Value > 0)
                            fallbackCmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            fallbackCmd.Parameters.AddWithValue("@OrgId", DBNull.Value);

                        return objDAL.GetDataTable(fallbackCmd);
                    }
                }
            }
        }

        public bool BulkReassignSubordinates(int oldManagerId, int? newManagerId, int updatedBy, out string message)
        {
            message = string.Empty;
            if (oldManagerId <= 0)
            {
                message = "Invalid source manager.";
                return false;
            }

            if (newManagerId.HasValue && newManagerId.Value == oldManagerId)
            {
                message = "Source manager and destination manager cannot be the same.";
                return false;
            }

            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "PROC_BULK_REASSIGN_SUBORDINATES";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@OldManagerId", oldManagerId);
                        cmd.Parameters.AddWithValue("@NewManagerId", (object)newManagerId ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@UpdatedBy", updatedBy > 0 ? (object)updatedBy : DBNull.Value);

                        SqlParameter pStatus = new SqlParameter("@Status", SqlDbType.Bit) { Direction = ParameterDirection.Output };
                        SqlParameter pMessage = new SqlParameter("@Message", SqlDbType.VarChar, 250) { Direction = ParameterDirection.Output };
                        cmd.Parameters.Add(pStatus);
                        cmd.Parameters.Add(pMessage);

                        objDAL.ExecuteNonQuery_RetInt(cmd);

                        bool status = pStatus.Value != DBNull.Value && Convert.ToBoolean(pStatus.Value);
                        message = pMessage.Value != DBNull.Value ? pMessage.Value.ToString() : (status ? "Reassigned successfully." : "Failed to reassign.");
                        return status;
                    }
                }
                catch
                {
                    // Fallback
                    try
                    {
                        using (SqlCommand updateCmd = new SqlCommand())
                        {
                            updateCmd.CommandType = CommandType.Text;
                            updateCmd.CommandText = @"
                                UPDATE tblUser
                                SET ManagerId = @NewManagerId
                                WHERE ManagerId = @OldManagerId;
                            ";
                            updateCmd.Parameters.AddWithValue("@OldManagerId", oldManagerId);
                            if (newManagerId.HasValue && newManagerId.Value > 0)
                                updateCmd.Parameters.AddWithValue("@NewManagerId", newManagerId.Value);
                            else
                                updateCmd.Parameters.AddWithValue("@NewManagerId", DBNull.Value);

                            int rows = objDAL.ExecuteNonQuery_RetInt(updateCmd);
                            message = "Successfully reassigned " + rows + " team member(s).";
                            return true;
                        }
                    }
                    catch (Exception ex)
                    {
                        message = "Error during bulk reassign: " + ex.Message;
                        return false;
                    }
                }
            }
        }

        public DataTable GetAllRolesForHierarchy()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT RoleId, Role FROM tblRole ORDER BY Role ASC";
                    return objDAL.GetDataTable(cmd);
                }
            }
        }

        public DataTable GetTeamHierarchyStats(int? orgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_GET_TEAM_HIERARCHY_STATS";
                        cmd.CommandType = CommandType.StoredProcedure;
                        if (orgId.HasValue && orgId.Value > 0)
                            cmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            cmd.Parameters.AddWithValue("@OrgId", DBNull.Value);

                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null) return dt;
                    }
                    catch
                    {
                        // Fallback
                    }

                    using (SqlCommand fallbackCmd = new SqlCommand())
                    {
                        fallbackCmd.CommandType = CommandType.Text;
                        fallbackCmd.CommandText = @"
                            SELECT 
                                (SELECT COUNT(1) FROM tblUser WHERE (@OrgId IS NULL OR OrgId = @OrgId)) AS TotalUsers,
                                (SELECT COUNT(1) FROM tblUser WHERE (ManagerId IS NULL OR ManagerId = 0) AND (@OrgId IS NULL OR OrgId = @OrgId)) AS TopLevelUsers,
                                (SELECT COUNT(DISTINCT ManagerId) FROM tblUser WHERE ManagerId IS NOT NULL AND ManagerId > 0 AND (@OrgId IS NULL OR OrgId = @OrgId)) AS TotalManagersWithReports,
                                1 AS MaxHierarchyDepth;
                        ";
                        if (orgId.HasValue && orgId.Value > 0)
                            fallbackCmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            fallbackCmd.Parameters.AddWithValue("@OrgId", DBNull.Value);

                        return objDAL.GetDataTable(fallbackCmd);
                    }
                }
            }
        }
        public DataTable GetOrganizationsList()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = @"
                        IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'tblOrganizationMaster')
                        BEGIN
                            SELECT 
                                SellerId AS OrgId, 
                                ISNULL(NULLIF(LTRIM(RTRIM(BrandName)), ''), ISNULL(NULLIF(LTRIM(RTRIM(SellerName)), ''), 'Organization #' + CAST(SellerId AS VARCHAR))) AS OrgName
                            FROM tblOrganizationMaster
                            ORDER BY OrgName ASC;
                        END
                        ELSE
                        BEGIN
                            SELECT DISTINCT 
                                OrgId, 
                                'Organization #' + CAST(OrgId AS VARCHAR) AS OrgName
                            FROM tblUser 
                            WHERE OrgId IS NOT NULL AND OrgId > 0
                            ORDER BY OrgId ASC;
                        END
                    ";
                    return objDAL.GetDataTable(cmd);
                }
            }
        }

        public DataTable GetEmployeesByOrg(int orgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = @"
                        SELECT 
                            u.UserId,
                            ISNULL(NULLIF(LTRIM(RTRIM(ISNULL(u.FirstName,'') + ' ' + ISNULL(u.LastName,''))),''), u.UserName) AS FullName,
                            u.UserName,
                            u.EmployeeId,
                            u.ManagerId,
                            ISNULL(r.Role, 'Employee') AS RoleName
                        FROM tblUser u
                        LEFT JOIN tblRole r ON u.RoleId = r.RoleId
                        WHERE u.OrgId = @OrgId
                        ORDER BY FullName ASC;
                    ";
                    cmd.Parameters.AddWithValue("@OrgId", orgId);
                    return objDAL.GetDataTable(cmd);
                }
            }
        }

        #region Expense Approval Process
        public DataTable GetExpensesForApproval(int approverUserId, int? orgId, string approvalStatus, string fromDate, string toDate, int? subordinateUserId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_GET_EXPENSES_FOR_APPROVAL";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        if (orgId.HasValue && orgId.Value > 0)
                            cmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            cmd.Parameters.AddWithValue("@OrgId", DBNull.Value);

                        if (!string.IsNullOrEmpty(approvalStatus))
                            cmd.Parameters.AddWithValue("@ApprovalStatus", approvalStatus);
                        else
                            cmd.Parameters.AddWithValue("@ApprovalStatus", "Pending");

                        if (!string.IsNullOrEmpty(fromDate))
                            cmd.Parameters.AddWithValue("@FromDate", Convert.ToDateTime(fromDate).ToString("yyyy-MM-dd"));
                        else
                            cmd.Parameters.AddWithValue("@FromDate", DBNull.Value);

                        if (!string.IsNullOrEmpty(toDate))
                            cmd.Parameters.AddWithValue("@ToDate", Convert.ToDateTime(toDate).ToString("yyyy-MM-dd"));
                        else
                            cmd.Parameters.AddWithValue("@ToDate", DBNull.Value);

                        if (subordinateUserId.HasValue && subordinateUserId.Value > 0)
                            cmd.Parameters.AddWithValue("@SubordinateUserId", subordinateUserId.Value);
                        else
                            cmd.Parameters.AddWithValue("@SubordinateUserId", DBNull.Value);

                        return objDAL.GetDataTable(cmd);
                    }
                    catch
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = @"
                            ;WITH SubordinatesCTE AS (
                                SELECT u.UserId, u.ManagerId, CAST(1 AS INT) AS [Level]
                                FROM tblUser u WHERE u.ManagerId = @ApproverUserId
                                UNION ALL
                                SELECT u.UserId, u.ManagerId, CAST(sub.[Level] + 1 AS INT) AS [Level]
                                FROM tblUser u INNER JOIN SubordinatesCTE sub ON u.ManagerId = sub.UserId
                            )
                            SELECT 
                                e.ID,
                                CONVERT(VARCHAR, e.dtEntry, 106) AS EntryDate,
                                CONVERT(VARCHAR, e.ExpenseDate, 106) AS ExpenseDate,
                                e.ExpenseDate AS RawExpenseDate,
                                ISNULL(e.Amount, 0) AS Amount,
                                ISNULL(e.Rate, 0) AS Rate,
                                ISNULL(e.Quantity, 0) AS Quantity,
                                ISNULL(e.Description, '') AS [Description],
                                ISNULL(em.Expense, '') AS Category,
                                ISNULL(esm.ExpenseSubMaster, '') AS SubCategory,
                                ISNULL(e.ExpenseFile, '') AS ExpenseFile,
                                ISNULL(e.ExpenseFile2, '') AS ExpenseFile2,
                                ISNULL(e.BillNumber, '') AS BillNumber,
                                ISNULL(e.PaymentMode, '') AS PaymentMode,
                                ISNULL(e.IsPaid, 0) AS IsPaid,
                                ISNULL(e.[Status], '') AS ReimbursementStatus,
                                ISNULL(e.ApprovalStatus, 'Pending') AS ApprovalStatus,
                                e.ApprovedBy,
                                CONVERT(VARCHAR, e.ApprovedOn, 106) AS ApprovedOn,
                                ISNULL(e.RejectionReason, '') AS RejectionReason,
                                ISNULL(e.ApproverRemarks, '') AS ApproverRemarks,
                                e.UserId AS SubmitterUserId,
                                CAST(ISNULL(subUser.FirstName, '') + CASE WHEN subUser.LastName IS NULL OR subUser.LastName = '' THEN '' ELSE ' ' + subUser.LastName END AS NVARCHAR(250)) AS SubmitterName,
                                ISNULL(subUser.EmployeeId, '') AS SubmitterEmployeeId,
                                ISNULL(subUser.Email, '') AS SubmitterEmail,
                                ISNULL(rSub.[Role], 'Employee') AS SubmitterRole,
                                CAST(ISNULL(appUser.FirstName, '') + CASE WHEN appUser.LastName IS NULL OR appUser.LastName = '' THEN '' ELSE ' ' + appUser.LastName END AS NVARCHAR(250)) AS ApproverName,
                                ISNULL(tree.[Level], 1) AS HierarchyLevel,
                                e.OrgId
                            FROM tblExpense e
                            INNER JOIN tblExpenseMaster em ON em.ExpenseId = e.ExpenseId
                            LEFT JOIN tblExpenseSubMaster esm ON esm.Id = e.SubExpenseId
                            LEFT JOIN tblUser subUser ON subUser.UserId = e.UserId
                            LEFT JOIN tblRole rSub ON rSub.RoleId = subUser.RoleId
                            LEFT JOIN tblUser appUser ON appUser.UserId = e.ApprovedBy
                            LEFT JOIN SubordinatesCTE tree ON tree.UserId = e.UserId
                            WHERE e.UserId <> @ApproverUserId
                              AND (tree.UserId IS NOT NULL OR @ApproverUserId IN (SELECT u2.UserId FROM tblUser u2 WHERE u2.RoleId IN (SELECT RoleId FROM tblRole WHERE [Role] LIKE '%Admin%')))
                              AND (@ApprovalStatus = 'All' OR ISNULL(e.ApprovalStatus, 'Pending') = @ApprovalStatus)
                            ORDER BY CASE WHEN ISNULL(e.ApprovalStatus, 'Pending') = 'Pending' THEN 0 ELSE 1 END, e.ExpenseDate DESC, e.ID DESC;
                        ";
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        cmd.Parameters.AddWithValue("@ApprovalStatus", string.IsNullOrEmpty(approvalStatus) ? "Pending" : approvalStatus);
                        return objDAL.GetDataTable(cmd);
                    }
                }
            }
        }

        public int ApproveExpense(long expenseId, int approverUserId, string remarks)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_APPROVE_EXPENSE";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 100;
                        cmd.Parameters.AddWithValue("@ExpenseId", expenseId);
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        cmd.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            return Convert.ToInt32(dt.Rows[0]["Result"]);
                        }
                        return 1;
                    }
                    catch
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = @"
                            UPDATE tblExpense
                            SET ApprovalStatus = 'Approved',
                                ApprovedBy = @ApproverUserId,
                                ApprovedOn = GETDATE(),
                                RejectionReason = NULL,
                                ApproverRemarks = @Remarks
                            WHERE ID = @ExpenseId AND UserId <> @ApproverUserId;
                        ";
                        cmd.Parameters.AddWithValue("@ExpenseId", expenseId);
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        cmd.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
                        return objDAL.ExecuteNonQuery_RetInt(cmd);
                    }
                }
            }
        }

        public int RejectExpense(long expenseId, int approverUserId, string reason)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_REJECT_EXPENSE";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 100;
                        cmd.Parameters.AddWithValue("@ExpenseId", expenseId);
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        cmd.Parameters.AddWithValue("@RejectionReason", reason);
                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            return Convert.ToInt32(dt.Rows[0]["Result"]);
                        }
                        return 1;
                    }
                    catch
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = @"
                            UPDATE tblExpense
                            SET ApprovalStatus = 'Rejected',
                                ApprovedBy = @ApproverUserId,
                                ApprovedOn = GETDATE(),
                                RejectionReason = @RejectionReason,
                                ApproverRemarks = NULL
                            WHERE ID = @ExpenseId AND UserId <> @ApproverUserId;
                        ";
                        cmd.Parameters.AddWithValue("@ExpenseId", expenseId);
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        cmd.Parameters.AddWithValue("@RejectionReason", reason);
                        return objDAL.ExecuteNonQuery_RetInt(cmd);
                    }
                }
            }
        }

        public int BulkApproveExpenses(string expenseIds, int approverUserId, string remarks)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_BULK_APPROVE_EXPENSES";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.Parameters.AddWithValue("@ExpenseIds", expenseIds);
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        cmd.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            return Convert.ToInt32(dt.Rows[0]["ApprovedCount"]);
                        }
                        return 1;
                    }
                    catch
                    {
                        var ids = expenseIds.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                        int count = 0;
                        foreach (var idStr in ids)
                        {
                            long id;
                            if (long.TryParse(idStr.Trim(), out id))
                            {
                                count += ApproveExpense(id, approverUserId, remarks);
                            }
                        }
                        return count;
                    }
                }
            }
        }

        public int BulkRejectExpenses(string expenseIds, int approverUserId, string reason)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_BULK_REJECT_EXPENSES";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.Parameters.AddWithValue("@ExpenseIds", expenseIds);
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        cmd.Parameters.AddWithValue("@RejectionReason", reason);
                        DataTable dt = objDAL.GetDataTable(cmd);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            return Convert.ToInt32(dt.Rows[0]["RejectedCount"]);
                        }
                        return 1;
                    }
                    catch
                    {
                        var ids = expenseIds.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                        int count = 0;
                        foreach (var idStr in ids)
                        {
                            long id;
                            if (long.TryParse(idStr.Trim(), out id))
                            {
                                count += RejectExpense(id, approverUserId, reason);
                            }
                        }
                        return count;
                    }
                }
            }
        }

        public DataTable GetApproverDashboardStats(int approverUserId, int? orgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_GET_APPROVER_DASHBOARD_STATS";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 100;
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        if (orgId.HasValue && orgId.Value > 0)
                            cmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            cmd.Parameters.AddWithValue("@OrgId", DBNull.Value);
                        return objDAL.GetDataTable(cmd);
                    }
                    catch
                    {
                        return new DataTable();
                    }
                }
            }
        }

        public DataTable GetSubordinatesForApproval(int approverUserId, int? orgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        cmd.CommandText = "PROC_GET_SUBORDINATES_FOR_APPROVAL";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 100;
                        cmd.Parameters.AddWithValue("@ApproverUserId", approverUserId);
                        if (orgId.HasValue && orgId.Value > 0)
                            cmd.Parameters.AddWithValue("@OrgId", orgId.Value);
                        else
                            cmd.Parameters.AddWithValue("@OrgId", DBNull.Value);
                        return objDAL.GetDataTable(cmd);
                    }
                    catch
                    {
                        return new DataTable();
                    }
                }
            }
        }
        #endregion
        #endregion
    }


    public class ClsMenu
    {
        public int CategoryID { get; set; }
        public string Category { get; set; }
        public string SubCategory { get; set; }
        public string SubSubCategory { get; set; }
        public string SubSubCategoryId { get; set; }
    }

    public class JobRegistrationEntity
    {

        public int JobRegID { get; set; }
        public string AadharNo { get; set; }
        public string AadharFilePath { get; set; }
        public int SkillID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string FatherName { get; set; }
        public string Gender { get; set; }
        public string BirthPlace { get; set; }
        public string MaritalStatus { get; set; }
        public string PhotoPath { get; set; }
        public string Address { get; set; }
        public string Height { get; set; }
        public string Weight { get; set; }
        public string EmergencyContactNo { get; set; }
        public string EmergencyContactName { get; set; }
        public string EmergencyRelationship { get; set; }
        public string LanguagesKnown { get; set; }
        public string ExperienceDescription { get; set; }
        public string EducationDocPath { get; set; }
        public string BankAccountNo { get; set; }
        public string IFSCCode { get; set; }
        public string BankName { get; set; }
        public string PhoneNo { get; set; }
        public string LoginType { get; set; }
        public string LoginPassword { get; set; }
        public string ExpectedDemandType { get; set; }
        public bool Consent { get; set; }
        public DataTable GetEmployeeByOrgId(int OrgId)
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_GETEMPLOYEEBYORGID";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);
                    return objDAL.GetDataTable(sqlCommand);
                }
            }
        }
    }
}
