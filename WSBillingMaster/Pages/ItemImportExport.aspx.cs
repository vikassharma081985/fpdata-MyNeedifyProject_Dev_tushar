using ClosedXML.Excel;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;

namespace WSBillingMaster.Pages
{
    public partial class ItemImportExport : System.Web.UI.Page
    {
        bool IsValid = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                int UserId = Convert.ToInt32(Session["EmployeeId"]);
                int Role = Convert.ToInt32(Session["RoleId"]);
                BindData(UserId, Role);
            }
        }

        protected void BindData(int UserId, int Role)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {                
                using (DataTable dt = objBLL.GetSupplierListData(UserId, Role))
                {
                    if(dt!=null && dt.Rows.Count>0)
                    {
                        ddlSeller.DataSource = dt;
                        ddlSeller.DataTextField = "SupplierName";
                        ddlSeller.DataValueField = "SupplierID";
                        ddlSeller.DataBind();
                    }
                }
            }
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetTemplate()
        {
            using (DataTable dt = new DataTable())
            {
                dt.Columns.Add("ItemName");
                dt.Columns.Add("Category");
                dt.Columns.Add("SubCategory");
                dt.Columns.Add("SubSubCategory");
                dt.Columns.Add("BatchNo");
                dt.Columns.Add("Size");
                //dt.Columns.Add("Color");
                dt.Columns.Add("Cost");
                dt.Columns.Add("GST");
                dt.Columns.Add("Freight");
                dt.Columns.Add("Misc");
                dt.Columns.Add("ProfitMargin");
                dt.Columns.Add("MRP");
                //dt.Columns.Add("Stock");
                dt.Columns.Add("ExpireOn");
                dt.Columns.Add("Remarks");

                DataRow dr = dt.NewRow();
                dt.Rows.Add(dr);

                dt.Rows[0][0] = "";
                dt.Rows[0][1] = "";
                dt.Rows[0][2] = "";
                dt.Rows[0][3] = "";
                dt.Rows[0][4] = "";
                dt.Rows[0][5] = "";
                dt.Rows[0][6] = "";
                dt.Rows[0][7] = "";
                dt.Rows[0][8] = "";
                dt.Rows[0][9] = "";
                dt.Rows[0][10] = "";
                dt.Rows[0][11] = "";
                dt.Rows[0][12] = "";
                dt.Rows[0][13] = "";
                //dt.Rows[0][14] = "";
                //dt.Rows[0][15] = "";

                HttpContext.Current.Session["dtExport2Excel"] = dt;
                HttpContext.Current.Session["ReportName"] = "ItemList" + DateTime.Now.ToString();
                //  HttpContext.Current.Response.Redirect("ExportToExcel.aspx");
            }
            return "";
        }


        protected void btnupload_Click(object sender, EventArgs e)
        {

            if (fpUpload.HasFile)
            {
                string FileExtension = Path.GetExtension(fpUpload.PostedFile.FileName);

                if (FileExtension.ToLower() != ".xlsx" && FileExtension.ToLower() != ".xls")
                {

                    return;
                }
            }
            else
            {

                return;

            }

            string FileName = "";
            string Mypath = "";

            FileName = Path.GetFileName(fpUpload.FileName);
            Mypath = Server.MapPath("~/Uploads/" + FileName);

            if (File.Exists(Mypath))
                File.Delete(Mypath);

            fpUpload.SaveAs(Mypath);



            DataTable dt = CreateDataTableHeader(Mypath);
            DataTable dtc = Getdata(Mypath, dt);
            if (dtc.Rows.Count > 0)
            {

                IsValid = true;
                grd.DataSource = dtc;
                grd.DataBind();

                if (IsValid)
                {
                    btnSave.Style["cursor"] = "pointer";
                    btnSave.Enabled = true;
                    divContent.Visible = true;
                }

            }
            else
            {
                grd.DataSource = null;
                grd.DataBind();
                divContent.Visible = false;

            }

            if (File.Exists(Mypath))
                File.Delete(Mypath);
        }

        // Create DataTable
        public DataTable Getdata(string pFilePath, DataTable dt)
        {
            try
            {
                var wb = new XLWorkbook(pFilePath);
                IXLWorksheet ws;

                ws = wb.Worksheet("data");


                StringBuilder sb = new StringBuilder();


                foreach (IXLRow r in ws.Rows())
                {

                    DataRow tempRow = dt.NewRow();
                    bool IsValid = true;
                    for (int i = 1; i <= dt.Columns.Count; i++)
                    {
                        if (r.Cell(i).Value.ToString().Trim() != "")
                        {
                            tempRow[i - 1] = r.Cell(i).Value.ToString();
                        }
                        if (r.Cell(1).Value.ToString().Trim() == "")
                        {
                            IsValid = false;
                        }
                    }
                    if (IsValid)
                        dt.Rows.Add(tempRow);

                }


                dt.Rows.RemoveAt(0);

            }
            catch (Exception ex)
            {
                // lblMsg.Text = ex.Message.ToString();
            }

            ViewState["mydata"] = dt;
            return dt;
        }

        // Create Header
        public static DataTable CreateDataTableHeader(string fileName)
        {
            DataTable dataTable = new DataTable();
            using (SpreadsheetDocument spreadSheetDocument = SpreadsheetDocument.Open(fileName, false))
            {
                WorkbookPart workbookPart = spreadSheetDocument.WorkbookPart;
                IEnumerable<Sheet> sheets = spreadSheetDocument.WorkbookPart.Workbook.GetFirstChild<Sheets>().Elements<Sheet>();
                string relationshipId = sheets.First().Id.Value;
                WorksheetPart worksheetPart = (WorksheetPart)spreadSheetDocument.WorkbookPart.GetPartById(relationshipId);
                Worksheet workSheet = worksheetPart.Worksheet;
                SheetData sheetData = workSheet.GetFirstChild<SheetData>();
                IEnumerable<Row> rows = sheetData.Descendants<Row>();
                try
                {
                    foreach (Cell cell in rows.ElementAt(0))
                    {
                        dataTable.Columns.Add(GetCellValue(spreadSheetDocument, cell));
                    }
                }
                catch
                {
                }

            }


            return dataTable;
        }

        private static string GetCellValue(SpreadsheetDocument document, Cell cell)
        {
            SharedStringTablePart stringTablePart = document.WorkbookPart.SharedStringTablePart;
            string value = cell.CellValue.InnerXml;

            if (cell.DataType != null && cell.DataType.Value == CellValues.SharedString)
            {
                return stringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText;
            }
            else
            {
                return value;
            }
        }

        protected void grd_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.XML = hdnXML.Value;
                objBLL.Ip = objBLL.GetVisitorsIPAddresss();
                objBLL.UserId = Convert.ToString(Session["EmployeeId"]);
                objBLL.SellerId = Convert.ToInt32(hdnSellerId.Value);
                using (DataTable dt = objBLL.ImportItems())
                {
                    int RowsInserted = dt.Rows.Count;
                    if (RowsInserted > 0)
                    {
                        string XML = "<Root>";
                        foreach (DataRow dr in dt.Rows)
                        {
                            XML += "<Node>";
                            string BarcodeImage = GenerateBarcode(dr["ItemId"].ToString(), dr["Barcode"].ToString());
                            XML += "<ItemId>" + dr["ItemId"].ToString() + "</ItemId>";
                            XML += "<Barcode>" + dr["Barcode"].ToString() + "</Barcode>";
                            XML += "<BarcodeImage>" + BarcodeImage + "</BarcodeImage>";
                            XML += "</Node>";

                        }
                        XML += "</Root>";
                        objBLL.XML = XML;
                        objBLL.SaveBarcodeImage();

                        ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Items Imported Successfully !');", true);
                        hdnXML.Value = "";
                        grd.DataSource = null;
                        grd.DataBind();
                        divContent.Visible = false;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Some Error Occured, Please try again later !');", true);
                    }
                }
            }
        }

        private string GenerateBarcode(string ItemId, string Barcode)
        {
            string barCode = Barcode;
            // System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            using (Bitmap bitMap = new Bitmap(barCode.Length * 40, 80))
            {
                using (Graphics graphics = Graphics.FromImage(bitMap))
                {
                    System.Drawing.Font oFont = new System.Drawing.Font("IDAutomationHC39M", 16);
                    PointF point = new PointF(2f, 2f);
                    SolidBrush blackBrush = new SolidBrush(System.Drawing.Color.Black);
                    SolidBrush whiteBrush = new SolidBrush(System.Drawing.Color.White);
                    graphics.FillRectangle(whiteBrush, 0, 0, bitMap.Width, bitMap.Height);
                    graphics.DrawString("*" + barCode + "*", oFont, blackBrush, point);
                }
                using (MemoryStream ms = new MemoryStream())
                {
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();

                    Convert.ToBase64String(byteImage);
                    string BarcodeImage = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                    return BarcodeImage;
                }
                //plBarCode.Controls.Add(imgBarCode);
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindCategory(int sellerid)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                using (DataTable dt = objBLL.BindCategoryWithSeller(sellerid))
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    return rtrn;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindSubCategory(int CategoryId)
        {
            string rtrn = "";
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.CategoryId = CategoryId;
                using (DataSet dt = objBLL.GetSubCategory())
                {
                    if (dt != null && dt.Tables.Count > 0)
                    {
                        if (dt.Tables[0] != null && dt.Tables[0].Rows.Count > 0)
                        {
                            rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt.Tables[0]);
                        }
                    }                    
                }
                return rtrn;
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string BindSubSubCategory(int SubCategoryId)
        {
            string rtrn = "";
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.SubCategoryId = SubCategoryId;
                using (DataSet dt = objBLL.GetSubSubCategory())
                {
                    if (dt != null && dt.Tables.Count > 0)
                    {
                        if (dt.Tables[0] != null && dt.Tables[0].Rows.Count > 0)
                        {
                            rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt.Tables[0]);
                        }
                    }
                }
                return rtrn;
            }
        }
    }
}