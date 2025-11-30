using BLL;
using DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class PhysicalVerification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Search(string Barcode)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.Keyword = Barcode.Trim();
                using (DataTable dt = objBLL.GetManageItemDataPhysicalStock())
                {
                    return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string PostStock(int ItemId, int NewStock, int PreviousStock)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("UPDATE tblItemStock SET Stock=@Stock WHERE ItemId=@ItemId");
                using (SqlCommand dbSqlCommand = new SqlCommand())
                {
                    using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                    {
                        dbSqlCommand.CommandText = sb.ToString();
                        dbSqlCommand.CommandType = CommandType.Text;
                        dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                        dbSqlCommand.Parameters.AddWithValue("@Stock", NewStock);
                        objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);

                    }
                }

                sb = new StringBuilder();
                sb.Append("INSERT INTO tblStockPostHistory(ItemId,PreviousStock,NewStock) values(@ItemId,@PreviousStock,@NewStock)");
                using (SqlCommand dbSqlCommand = new SqlCommand())
                {
                    using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                    {
                        dbSqlCommand.CommandText = sb.ToString();
                        dbSqlCommand.CommandType = CommandType.Text;
                        dbSqlCommand.Parameters.AddWithValue("@ItemId", ItemId);
                        dbSqlCommand.Parameters.AddWithValue("@PreviousStock", PreviousStock);
                        dbSqlCommand.Parameters.AddWithValue("@NewStock", NewStock);
                        objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);

                    }
                }
                return "1";
            }
            catch
            {
                return "0";
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Export(List<PVData> data)
        {
            using (DataTable dt = new DataTable())
            {
                dt.Columns.Add("SNo");
                dt.Columns.Add("ItemName");
                dt.Columns.Add("Barcode");
                dt.Columns.Add("TotalAsSystem");
                dt.Columns.Add("StockAsSystem");
                dt.Columns.Add("TotalAsPhysicallyVerified");
                dt.Columns.Add("StockAsPhysicallyVerified");
                int ctr = 1;
                foreach (var v in data)
                {
                    DataRow dr = dt.NewRow();
                    dr["SNo"] = ctr;
                    dr["ItemName"] = v.ItemName;
                    dr["Barcode"] = v.Barcode;
                    dr["TotalAsSystem"] = v.TotalAsSystem;
                    dr["StockAsSystem"] = v.StockAsSystem;
                    dr["TotalAsPhysicallyVerified"] = v.TotalAsPhysicallyVerified;
                    dr["StockAsPhysicallyVerified"] = v.StockAsPhysicallyVerified;
                    ctr++;
                    dt.Rows.Add(dr);
                }
                HttpContext.Current.Session["ReportName"] = "PhysicalVerification_data";
                HttpContext.Current.Session["dtExport2Excel"] = dt;


                return "1";
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SaveAsDraft(List<PVData> data)
        {
            
            try
            {

                using (SqlCommand dbSqlCommand = new SqlCommand())
                    {
                        using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                        {
                            dbSqlCommand.CommandText = "TRUNCATE TABLE tblPhysicalVerificationDraft";
                            dbSqlCommand.CommandType = CommandType.Text;
                            objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);
                        }
                    }


                foreach (var v in data)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("INSERT INTO tblPhysicalVerificationDraft(ItemID,ItemName,Barcode,ImagePath,TotalAsSystem,StockAsSystem,TotalAsPhysicallyVerified,StockAsPhysicallyVerified) ");
                    sb.Append(" values(@ItemID,@ItemName,@Barcode,@ImagePath,@TotalAsSystem,@StockAsSystem,@TotalAsPhysicallyVerified,@StockAsPhysicallyVerified)");
                    using (SqlCommand dbSqlCommand = new SqlCommand())
                    {
                        using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                        {
                            dbSqlCommand.CommandText = sb.ToString();
                            dbSqlCommand.CommandType = CommandType.Text;
                            dbSqlCommand.Parameters.AddWithValue("@ItemID", v.ItemId);
                            dbSqlCommand.Parameters.AddWithValue("@ItemName", v.ItemName);
                            dbSqlCommand.Parameters.AddWithValue("@Barcode", v.Barcode);
                            dbSqlCommand.Parameters.AddWithValue("@ImagePath", v.ItemImage);
                            dbSqlCommand.Parameters.AddWithValue("@TotalAsSystem", v.TotalAsSystem);
                            dbSqlCommand.Parameters.AddWithValue("@StockAsSystem", v.StockAsSystem);
                            dbSqlCommand.Parameters.AddWithValue("@TotalAsPhysicallyVerified", v.TotalAsPhysicallyVerified);
                            dbSqlCommand.Parameters.AddWithValue("@StockAsPhysicallyVerified", v.StockAsPhysicallyVerified);
                            objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);

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

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindDraftData()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT ItemID,ItemName,Barcode,ImagePath,TotalAsSystem,StockAsSystem,TotalAsPhysicallyVerified,StockAsPhysicallyVerified,CONVERT(VARCHAR,dtEntry,106) dtEntry FROM tblPhysicalVerificationDraft");
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = sb.ToString();
                    dbSqlCommand.CommandType = CommandType.Text;
                    using (DataTable dt = objDALCIILibrary.GetDataTable(dbSqlCommand))
                    {
                        return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    }

                }
            }

        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string DiscardDraft()
        {
            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = "TRUNCATE TABLE tblPhysicalVerificationDraft";
                    dbSqlCommand.CommandType = CommandType.Text;
                    objDALCIILibrary.ExecuteNonQuery_RetInt(dbSqlCommand);
                }
            }
            return "1";

        }


        //

        public class PVData
        {
            public int ItemId { get; set; }
            public string ItemName { get; set; }
            public string Barcode { get; set; }
            public string TotalAsSystem { get; set; }
            public string StockAsSystem { get; set; }
            public string ItemImage { get; set; }
            public string TotalAsPhysicallyVerified { get; set; }
            public string StockAsPhysicallyVerified { get; set; }
        }

    }





}