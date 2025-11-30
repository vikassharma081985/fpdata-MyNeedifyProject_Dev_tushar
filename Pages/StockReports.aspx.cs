using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
//using ClosedXML.Excel;
using System.Web.Services;
using System.Data.SqlClient;
using DAL;
using System.Text;
using ClosedXML.Excel;

namespace WSBillingMaster.Pages
{
    public partial class StockReports : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack == false)
            {
                txtFromDate.Text = DateTime.Today.AddDays(-1).ToString("yyyy-MM-dd 00:00:00");
                txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd 23:59:59");
            }
            //BindData();

        }
        private void BindChart(DataTable dt)
        {
            string JsonData = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
            string Script = "GetSalesSummary('" + JsonData + "');";
            ScriptManager.RegisterStartupScript(this, GetType(), "", Script, true);
        }
        private void BindReports()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                StringBuilder sb = new StringBuilder();
                sb.Append(@"select TI.ItemName,tip.Cost,ti.AddedOn ,(select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId) Stock,(tip.Cost*((select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId))) as [totalstockvalue]   
                            from tblItem TI  
                            inner join tblItemPrice TIP on ti.ItemId=tip.ItemId                              
                            WHERE (ISNULL('" + txtFromDate.Text + "','')='' OR CONVERT(Date,ti.AddedOn) >= '" + txtFromDate.Text + "'  ");
                sb.Append("   AND (ISNULL('" + txtToDate.Text + "','')='' OR CONVERT(DATE,ti.AddedOn) <= '" + txtToDate.Text + "')");
                sb.Append("   AND ItemName ='" + rblType.SelectedValue + "' ");

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sb.ToString();



                using (DataTable dt = objDAL.GetDataTable(cmd))
                {
                    if (dt.Rows.Count > 0)
                    {

                    }
                }
            }
        }
        //if (!IsPostBack)
        //{

        //    BindData();
        //}
        [WebMethod]
        public static string GetTotalStockValues(string FromDate, string ToDate, string Type)
        {

            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                StringBuilder sb = new StringBuilder();
                sb.Append(@"select TI.ItemName,tip.Cost,ti.AddedOn ,(select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId) Stock,(tip.Cost*((select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId))) as [totalstockvalue]   
                            from tblItem TI  
                            inner join tblItemPrice TIP on ti.ItemId=tip.ItemId                                 
                            WHERE (ISNULL('" + FromDate + "','')='' OR CONVERT(Date,ti.AddedOn) >= '" + FromDate + "'  ");
                sb.Append("   AND (ISNULL('" + ToDate + "','')='' OR CONVERT(DATE,ti.AddedOn) <= '" + ToDate + "'))");
                //  sb.Append("   AND ItemName ='"+ddlReport.SelectedValue+"' ");

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sb.ToString();

                using (DataTable dt = objDAL.GetDataTable(cmd))
                {
                    if (Type == "Search")
                    {
                        string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                        return rtrn;

                    }
                    else
                    {
                        HttpContext.Current.Session["dtExport2Excel"] = dt;
                        HttpContext.Current.Session["ReportName"] = "ItemList" + DateTime.Now.ToString();
                        return "Export";
                    }

                }

            }
        }

        
             [WebMethod]
        public static string GetExportData(string FromDate, string ToDate,string Type)
        {

            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                StringBuilder sb = new StringBuilder();
                if (Type == "1")
                {

                    sb.Append(@"select TI.ItemName,tip.Cost,ti.AddedOn ,(select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId) Stock,(tip.Cost*((select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId))) as [totalstockvalue]   
                            from tblItem TI  
                            inner join tblItemPrice TIP on ti.ItemId=tip.ItemId  
                            INNER JOIN tblItemStock IST ON TI.ItemId=IST.ItemId     
                            WHERE (ISNULL('" + FromDate + "','')='' OR CONVERT(Date,ti.AddedOn) >= '" + FromDate + "'  ");
                    sb.Append("   AND (ISNULL('" + ToDate + "','')='' OR CONVERT(DATE,ti.AddedOn) <= '" + ToDate + "'))");
                }
                else if (Type == "2")
                {
                    sb.Append(@"Select  CAT.CategoryId,CAT.Category,IT.ItemId,IT.ItemName,(select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId) Stock,pr.Price,((select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId) *pr.Price) as [Total Stock Value]
                        from tblItem IT  
                        
                        INNER JOIN tblCategory CAT ON IT.CategoryId=CAT.CategoryId  
                        INNER JOIN tblItemPrice PR ON PR.ItemId=IT.ItemId  
                        ORDER BY CAT.Category;");
                }
                else if (Type == "3")
                {
                    sb.Append(@"SELECT ROW_NUMBER() OVER(Order By TRN.TransactionOn DESC) as SNo, 'RC0000'+CONVERT(VARCHAR,TRN.TransactionId) as InvoiceNumber, CONVERT(VARCHAR,TRN.TransactionOn,106) TransactionOn,    
CM.CustomerName+'/'+CM.Gender+'/'+CONVERT(VARCHAR,CM.Age)+' YRS' AS Customer,CM.Mobile,TRN.NetAmount As Amount,TRN.Tax,TRN.Discount,    
TRN.TotalAmount as GrandTotal,CASE WHEN TRN.PaymentModeId=1 THEN 'CASH' ELSE 'DEBIT/CREDIT CARD' END as PaymentMode,ti.ItemId,ti.ItemName,ti.Barcode,tip.cost as BasePrice
,(tip.Gst + tip.Freight+ tip.Misc) as [Other Tax],tip.ProfitMargin, trn.Discount, (trn.TotalAmount - trn.Discount - tip.cost - (tip.Gst + tip.Freight+ tip.Misc)) as [Actual Profit]
 , (trn.TotalAmount - trn.Discount - tip.cost) as [profit with tax]
 from tblTransaction TRN    
INNER JOIN tblCustomer CM ON TRN.CustomerId=CM.CustomerId  
inner join tblTransactionDetail TRD on TRD.TransactionId = TRN.TransactionId
inner join  tblItem ti ON ti.ItemId = trd.ItemId
INNER JOIN  tblItemPrice tip ON ti.ItemId = tip.ItemId
 where TRN.transactionOn>='" + FromDate + "' and TRN.transactionOn <= '" + ToDate + "'");
                    
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sb.ToString();

                using (DataTable dt = objDAL.GetDataTable(cmd))
                {
                   
                        HttpContext.Current.Session["dtExport2Excel"] = dt;
                        HttpContext.Current.Session["ReportName"] = "ItemList" + DateTime.Now.ToString();
                        return "Export";
                }

            }
        }

        [WebMethod]
//             public static string GetTotalStockValues1(string FromDate, string ToDate, string ReportName, string Type)
//        {
           
//            using (DataAccessLayer objDAL = new DataAccessLayer())
//            {
//                StringBuilder sb = new StringBuilder();
//                if (Type == "1")
//                {
                    
//                    sb.Append(@"select TI.ItemName,tip.Cost,ti.AddedOn ,ist.Stock,(tip.Cost*ist.Stock) as [totalstockvalue]  
//                            from tblItem TI  
//                            inner join tblItemPrice TIP on ti.ItemId=tip.ItemId  
//                            INNER JOIN tblItemStock IST ON TI.ItemId=IST.ItemId     
//                            WHERE (ISNULL('" + FromDate + "','')='' OR CONVERT(Date,ti.AddedOn) >= '" + FromDate + "'  ");
//                    sb.Append("   AND (ISNULL('" + ToDate + "','')='' OR CONVERT(DATE,ti.AddedOn) <= '" + ToDate + "'))");
//                }
//                else if (Type == "2")
//                {
//                    sb.Append(@"Select  CAT.CategoryId,CAT.Category,IT.ItemId,IT.ItemName,IST.Stock,pr.Price,(IST.Stock *pr.Price) as [Total Stock Value]
//                        from tblItem IT  
//                        INNER JOIN tblItemStock IST ON IT.ItemId=IST.ItemId  
//                        INNER JOIN tblCategory CAT ON IT.CategoryId=CAT.CategoryId  
//                        INNER JOIN tblItemPrice PR ON PR.ItemId=IT.ItemId  
//                        ORDER BY CAT.Category;");
//                }
                        
//                //sb.Append("   AND ItemName ='"+rblType.SelectedValue+"' ");

//                SqlCommand cmd = new SqlCommand();
//                cmd.CommandType = CommandType.Text;
//                cmd.CommandText = sb.ToString();
//                DataTable dt = objDAL.GetDataTable(cmd);
//                HttpContext.Current.Session["dtExport2Excel"] = dt;
//                HttpContext.Current.Session["ReportName"] = ReportName + DateTime.Now.ToString();
//                return "1";
//            }
//        }

        //protected void ExportExcel(object sender, EventArgs e)
        //{
        //    //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        //    //using (SqlConnection con = new SqlConnection(constr))
        //    //{
        //    //    using (SqlCommand cmd = new SqlCommand("SELECT * FROM "))
        //    //    {
        //    using (SqlDataAdapter sda = new SqlDataAdapter())
        //    {
        //        //cmd.Connection = con;
        //        //sda.SelectCommand = cmd;

        //        using (DataAccessLayer objDAL = new DataAccessLayer())
        //        {
        //            string Date = "2019-09-01";
        //            string TODATE = "2019-11-30";

        //                using (SqlCommand sqlCommand = new SqlCommand())
        //                {
        //                    sqlCommand.CommandText = "Proc_GetTotalStockValues";
        //                    sqlCommand.CommandType = CommandType.StoredProcedure;
        //                    sqlCommand.CommandTimeout = 100;
        //                    sqlCommand.Parameters.AddWithValue("@FromDate", Date);
        //                    sqlCommand.Parameters.AddWithValue("@ToDate", TODATE);
        //                    //sqlCommand.Parameters.AddWithValue("@Keyword", Keyword);


        //                    DataTable dt = objDAL.GetDataTable(sqlCommand);
        //                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
        //                    //return rtrn;



        //                    sda.Fill(dt);
        //                    using (XLWorkbook wb = new XLWorkbook())
        //                    {
        //                        wb.Worksheets.Add(dt, "Customers");

        //                        Response.Clear();
        //                        Response.Buffer = true;
        //                        Response.Charset = "";
        //                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        //                        Response.AddHeader("content-disposition", "attachment;filename=SqlExport.xlsx");
        //                        using (MemoryStream MyMemoryStream = new MemoryStream())
        //                        {
        //                            wb.SaveAs(MyMemoryStream);
        //                            MyMemoryStream.WriteTo(Response.OutputStream);
        //                            Response.Flush();
        //                            Response.End();
        //                        }


        //                }
        //            }
        //        }
        //    }
        //}

        //protected void Button1_Click(object sender, EventArgs e)
        //{

        //}
//        protected void btnExport_Click(object sender, EventArgs e)
//        {
//            using (DataAccessLayer objDAL = new DataAccessLayer())
//            {
//                StringBuilder sb = new StringBuilder();
//                sb.Append(@"select TI.ItemName,tip.Cost,ti.AddedOn ,ist.Stock,(tip.Cost*ist.Stock) as [totalstockvalue]  
//                            from tblItem TI  
//                            inner join tblItemPrice TIP on ti.ItemId=tip.ItemId  
//                            INNER JOIN tblItemStock IST ON TI.ItemId=IST.ItemId  
// 
//                            WHERE CONVERT(Date,ti.AddedOn) >= '"+ Convert.ToDateTime(txtFromDate.Text).ToString("yyyy-MM-dd")+" 00:00:00'  ");
//                sb.Append("   AND  CONVERT(DATE,ti.AddedOn) <= '" + Convert.ToDateTime(txtToDate.Text).ToString("yyyy-MM-dd") + " 23:59:59'");

//                //sb.Append("   AND ItemName ='"+rblType.SelectedValue+"' ");

//                SqlCommand cmd = new SqlCommand();
//                cmd.CommandType = CommandType.Text;
//                cmd.CommandText = sb.ToString();
//                DataTable dt = objDAL.GetDataTable(cmd);
//                HttpContext.Current.Session["dtExport2Excel"] = dt;
//                HttpContext.Current.Session["ReportName"] = "Export" + DateTime.Now.ToString();
                
//            }

//        }
        

        protected void btnsearch_Click(object sender, EventArgs e)
        {

            StringBuilder sb = new StringBuilder();

            if (rblType.SelectedValue == "1")
            {
                sb.Append(@"select TI.ItemName,tip.Cost,ti.AddedOn ,(select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId) Stock,(tip.Cost*(select SUM(Stock) from tblItemAvailableSize where ItemId = TI.ItemId group by ItemId)) as [total stock value]
                            from tblItem TI
                            inner join tblItemPrice TIP on ti.ItemId=tip.ItemId
                            
                            where ti.AddedOn >='" + Convert.ToDateTime(txtFromDate.Text).ToString("yyyy-MM-dd")+" 00:00:00' and ti.AddedOn <='"+Convert.ToDateTime(txtToDate.Text).ToString("yyyy-MM-dd")+" 23:59:59';");

                sb.Append(@" select sum((tip.Cost))*(select SUM(Stock) from tblItemAvailableSize) as [TotalStockValue]
                            from tblItem TI
                            inner join tblItemPrice TIP on ti.ItemId=tip.ItemId
                            
                            where ti.AddedOn >='" + Convert.ToDateTime(txtFromDate.Text).ToString("yyyy-MM-dd") + " 00:00:00' and ti.AddedOn <='" + Convert.ToDateTime(txtToDate.Text).ToString("yyyy-MM-dd") + " 23:59:59'");
            }
            else if (rblType.SelectedValue == "2")
            {

                sb.Append(@"Select  CAT.CategoryId,CAT.Category,IT.ItemId,IT.ItemName,(select SUM(Stock) from tblItemAvailableSize where ItemId = IT.ItemId group by ItemId) Stock,pr.Price,
((select SUM(Stock) from tblItemAvailableSize where ItemId = IT.ItemId group by ItemId) *pr.Price) as [Total Stock Value]
                        from tblItem IT  
                        
                        INNER JOIN tblCategory CAT ON IT.CategoryId=CAT.CategoryId  
                        INNER JOIN tblItemPrice PR ON PR.ItemId=IT.ItemId  
                        ORDER BY CAT.Category;");
                sb.Append(@" Select  (select SUM(Stock) from tblItemAvailableSize) *sum(pr.Price) as [TotalStockValue]
                        from tblItem IT  
                        
                        INNER JOIN tblCategory CAT ON IT.CategoryId=CAT.CategoryId  
                        INNER JOIN tblItemPrice PR ON PR.ItemId=IT.ItemId ");
            }
            else if (rblType.SelectedValue == "3")
            {
                sb.Append(@"SELECT ROW_NUMBER() OVER(Order By TRN.TransactionOn DESC) as SNo, 'RC0000'+CONVERT(VARCHAR,TRN.TransactionId) as InvoiceNumber, CONVERT(VARCHAR,TRN.TransactionOn,106) TransactionOn,    
CM.CustomerName+'/'+CM.Gender+'/'+CONVERT(VARCHAR,CM.Age)+' YRS' AS Customer,CM.Mobile,TRN.NetAmount As Amount,TRN.Tax,TRN.Discount,    
TRN.TotalAmount as GrandTotal,CASE WHEN TRN.PaymentModeId=1 THEN 'CASH' ELSE 'DEBIT/CREDIT CARD' END as PaymentMode,ti.ItemId,ti.ItemName,ti.Barcode,tip.cost as BasePrice
,(tip.Gst + tip.Freight+ tip.Misc) as [Other Tax],tip.ProfitMargin, trn.Discount, (trn.TotalAmount - trn.Discount - tip.cost - (tip.Gst + tip.Freight+ tip.Misc)) as [Actual Profit]
 , (trn.TotalAmount - trn.Discount - tip.cost) as [profit with tax]
 from tblTransaction TRN    
INNER JOIN tblCustomer CM ON TRN.CustomerId=CM.CustomerId  
inner join tblTransactionDetail TRD on TRD.TransactionId = TRN.TransactionId
inner join  tblItem ti ON ti.ItemId = trd.ItemId
INNER JOIN  tblItemPrice tip ON ti.ItemId = tip.ItemId
 where TRN.transactionOn>='" + Convert.ToDateTime(txtFromDate.Text).ToString("yyyy-MM-dd") + " 00:00:00' and TRN.transactionOn <='" + Convert.ToDateTime(txtToDate.Text).ToString("yyyy-MM-dd") + " 23:59:59'");
                sb.Append(@" Select  (select SUM(Stock) from tblItemAvailableSize) *sum(pr.Price) as [TotalStockValue]
                        from tblItem IT  
                        
                        INNER JOIN tblCategory CAT ON IT.CategoryId=CAT.CategoryId  
                        INNER JOIN tblItemPrice PR ON PR.ItemId=IT.ItemId ");
            }

            using (SqlCommand dbSqlCommand = new SqlCommand())
            {
                using (DataAccessLayer objDALCIILibrary = new DataAccessLayer())
                {
                    dbSqlCommand.CommandText = sb.ToString();
                    dbSqlCommand.CommandType = CommandType.Text;

                    using (DataSet dt = objDALCIILibrary.GetDataSet(dbSqlCommand))
                    {
                        if (dt.Tables[0].Rows.Count > 0)
                        {
                            grdData.DataSource = dt.Tables[0];
                            grdData.DataBind();
                            lblAmount.Text = dt.Tables[1].Rows[0]["TotalStockValue"].ToString();
                        }
                        else
                        {
                            grdData.DataSource = null;
                            grdData.DataBind();
                            lblAmount.Text = "0";
                        }
                    }

                }
            }
        }
    }
}




