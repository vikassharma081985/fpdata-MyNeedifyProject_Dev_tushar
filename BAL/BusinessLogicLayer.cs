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
                    dbSqlCommand.Parameters.AddWithValue("@ItemVolume", ItemVolume);
                    dbSqlCommand.Parameters.AddWithValue("@ItemWidth", ItemWidth);
                    dbSqlCommand.Parameters.AddWithValue("@ItemLength", ItemLength);
                    dbSqlCommand.Parameters.AddWithValue("@ItemHeight", ItemHeight);
                    dbSqlCommand.Parameters.AddWithValue("@ShippingPrice", ShippingPrice);
                    dbSqlCommand.Parameters.AddWithValue("@ShippingWeight", ShippingWeight);
                    dbSqlCommand.Parameters.AddWithValue("@HSNCode", HSNCode);
                    dbSqlCommand.Parameters.AddWithValue("@GST", GST);
                    dbSqlCommand.Parameters.AddWithValue("@SupplierId", SupplierId);

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
        public DataSet GetAdminItemEdit(int userid, int role)
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "Proc_GetAdminItemEdit";
                    dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                    dbSqlCommand.Parameters.AddWithValue("@userid", userid);
                    dbSqlCommand.Parameters.AddWithValue("@role", role);
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
                    sqlCommand.Parameters.AddWithValue("@Description", ExpenseDescription);
                    sqlCommand.Parameters.AddWithValue("@Amount", Amount);
                    sqlCommand.Parameters.AddWithValue("@UserId", FetchUserId);
                    sqlCommand.Parameters.AddWithValue("@EmpId", EmpId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);
                    sqlCommand.Parameters.AddWithValue("@Rate", Rate);
                    sqlCommand.Parameters.AddWithValue("@Quantity", Quantity);
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
                    sqlCommand.Parameters.AddWithValue("@Description", string.IsNullOrEmpty(ExpenseDescription) ? (object)DBNull.Value : ExpenseDescription);
                    sqlCommand.Parameters.AddWithValue("@Amount", Amount);
                    sqlCommand.Parameters.AddWithValue("@Rate", Rate);
                    sqlCommand.Parameters.AddWithValue("@Quantity", Quantity);
                    sqlCommand.Parameters.AddWithValue("@UserId", FetchUserId);
                    // EmpId and OrgId usually don't change during edit, but included for completeness
                    sqlCommand.Parameters.AddWithValue("@EmpId", EmpId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);

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
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", CreatedBy);
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
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", CreatedBy);
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
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", CreatedBy);
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
        public DataTable GetHiringDetailsByUserId()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "PROC_GETHIRINGDETAILSBYUSERID";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@UserId", IntUserId); // Need to check if there is UserId int. 
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
    }
}
