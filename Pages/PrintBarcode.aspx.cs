using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using HiQPdf;
using System.Drawing;
using System.IO;
using System.Net;
using Barcode;
using CrystalDecisions.CrystalReports.Engine;
namespace WSBillingMaster.Pages
{
    public partial class PrintBarcode : System.Web.UI.Page
    {
        PdfDocument document;
        PdfDocument tempDocument;
        PdfLayoutInfo html1LayoutInfo;
        DataTable dtObs;
        DataTable dtSettlement;
        DataTable dtRefund;

        //Page Property

        int MarginLeft = 3;
        int MarginRight = 50;
        int PageWidth = 300;
        int BrowserWidth = 400;

        //Header Property
        float HeaderHeight = 10;//207
        int XHeader = 1;//20
        int YHeader = 1;//80
        int HeaderBrowserWidth = 1200;

        // BackGround Property
        bool HeaderImage = true;
        bool FooterImage = false;
        bool BackGroundImage = false;
        string HeaderImg = "";

        //Footer Property 80
        float FooterHeight = 10;
        int XFooter = 5;

        DataRow drcurrent;

        string id = "";
        string name = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            string PaperSize = string.Empty;
            try
            {
                string Barcode = Request["Barcode"].ToString();
                int Copies = Convert.ToInt32(Request["Copies"].ToString());
                int size = Convert.ToInt32(Request["Size"].ToString());

                if (size == 1)
                {
                    BindCrystalBarcode(Copies, Barcode);
                }
                else
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("Barcode");

                    for (int i = 0; i < Copies; i++)
                    {
                        DataRow dr = dt.NewRow();
                        dr["Barcode"] = Barcode;
                        dt.Rows.Add(dr);
                    }

                    //----------------HiQPDF Work Starts here---------------
                    document = new PdfDocument();
                    tempDocument = new PdfDocument();
                    document.SerialNumber = "g8vq0tPn‐5c/q4fHi‐8fq7rbOj‐sqO3o7uy‐t6Owsq2y‐sa26urq6";
                    BindData(dt);
                }
            }
            catch
            {

            }
        }

        private void BindCrystalBarcode(int Copies, string Barcode)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Barcode");
            dt.Columns.Add("ItemName");
            dt.Columns.Add("MRP");
            dt.Columns.Add("ProfitMargin");

            DataColumn dcBarcodeImage = new DataColumn("BarcodeImage");
            dcBarcodeImage.DataType = System.Type.GetType("System.Byte[]");
            dt.Columns.Add(dcBarcodeImage);

            string barcode = new GenerateBarcode().Save(Barcode).Trim();
            string x = barcode.Replace("data:image/png;base64,", "");
            byte[] imageBytes = Convert.FromBase64String(x);

            string ItemName = Request["ItemName"].ToString();
            string MRP = Request["MRP"].ToString();
            string ProfitMargin = Request["ProfitMargin"].ToString();

            for (int i = 0; i < Copies; i++)
            {
                DataRow dr = dt.NewRow();
                dr["Barcode"] = Barcode;
                dr["ItemName"] = ItemName;
                dr["MRP"] = MRP;
                dr["ProfitMargin"] = ProfitMargin;
                dr["BarcodeImage"] = imageBytes;
                dt.Rows.Add(dr);
            }

            using (DataSet ds = new DataSet())
            {
                dt.TableName = "dtBarcode";
                ds.Tables.Add(dt.Copy());
                 //ds.WriteXmlSchema("f:/Barcode.xml");
                ReportDocument rpt = new ReportDocument();
                rpt.Load(Server.MapPath(@"~\Reports\PrintBarcode.rpt"));
                rpt.SetDataSource(ds);
                System.IO.Stream oStream = null;
                byte[] byteArray = null;
                using (oStream = rpt.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat))
                {
                    byteArray = new byte[oStream.Length];
                    oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(byteArray);
                    Response.Flush();
                    Response.Close();

                    oStream.Close();
                    oStream.Dispose();

                }
            }
            
           
        }

        public void BindData(DataTable dt)
        {

            try
            {
                StringBuilder sb = new StringBuilder();

                sb = new StringBuilder();
                if (dt.Rows.Count > 0)
                {
                    sb.Append("<div style='width:100%;color:#000;font-size:16px;'>");
                    sb.Append("</div>");
                    sb.Append("<div style='width:100%;'>");
                    foreach (DataRow dw in dt.Rows)
                    {
                        sb.Append("<div style='width:50%;float:left;margin-top:15px;border:0px solid #000;margin-left:0%;margin-bottom:30px;'>");
                        sb.Append("     <div style='width:100%;float:left;text-align:center;paddingleft:10px;padding-right:10px;'>");
                        sb.Append("     <img style='width:90%;height:50px;' src='" + new GenerateBarcode().Save(dw["Barcode"].ToString()).Trim() + "'/>  ");
                        sb.Append("     </div> ");
                        sb.Append("     <div style='width:100%;float:left;text-align:center;paddingleft:10px;padding-right:10px;font-weight:bold;'>");
                        sb.Append("     " + dw["Barcode"].ToString() + " ");
                        sb.Append("     </div> ");
                        sb.Append(" </div> ");
                    }
                    sb.Append("</div>");
                    AddContent(sb.ToString());
                    SetFooter(tempDocument.Pages[tempDocument.Pages.Count - 1]);
                    mergeDocument();
                    byte[] pdfBuffer = document.WriteToMemory();
                    HttpContext.Current.Response.AddHeader("Content-Type", "application/pdf");
                    HttpContext.Current.Response.BinaryWrite(pdfBuffer);
                    HttpContext.Current.Response.End();
                }
                //}
            }
            catch (Exception ex)
            {
               
            }
            finally
            {

            }
        }
        private void AddContent(string Content)
        {

            PdfPageSize AP1 = new PdfPageSize(1200, 300);
            PdfPage page1 = tempDocument.AddPage(AP1, PdfDocumentMargins.Empty);

            PdfHtml html1 = new PdfHtml();
            html1 = new PdfHtml(MarginLeft, ((html1LayoutInfo == null) ? 0 : html1LayoutInfo.LastPageRectangle.Height), PageWidth, Content, null);
            html1.PageCreatingEvent += new PdfPageCreatingDelegate(htmlToPdfConverter_PageCreatingEvent);

            html1.FontEmbedding = false;
            html1.BrowserWidth = BrowserWidth;

            html1.ImagesCutAllowed = false;
            html1LayoutInfo = page1.Layout(html1);
        }
        void htmlToPdfConverter_PageCreatingEvent(PdfPageCreatingParams eventParams)
        {
            PdfPage page1 = eventParams.PdfPage;
            //set background iamge in pdf report.
            if (BackGroundImage == true)
            {
                HeaderImg = "";// "App_Images/WatermarkReceipt.png";
                page1.Layout(getPDFBackGround(HeaderImg));
            }
            // SetHeader(page1);
            page1.CreateFooterCanvas(FooterHeight);
            // SetFooter(page1);
        }
        private void SetHeader(PdfPage page)
        {
            page.CreateHeaderCanvas(HeaderHeight);
            PdfHtml headerHtml = new PdfHtml(XHeader - 80, YHeader - 40, PageWidth, MakeHeader(), null);
            //   page.Header.Layout(getPDFImageforbarcode(15, 140, drcurrent["LedgerTransactionNo"].ToString()));
            headerHtml.FitDestWidth = true;
            headerHtml.FontEmbedding = false;
            headerHtml.BrowserWidth = HeaderBrowserWidth;
            page.Header.Layout(headerHtml);
            // string path = "../../App_Images/brcodelogo/vaccutainer-logo-red.jpg";
            if (HeaderImage)
            {
                //   page.Header.Layout(getPDFImageHeader(path));
            }
            //-----------------

        }
        private PdfImage getPDFImageHeader(string SignImg)
        {
            PdfImage transparentResizedPdfImage = new PdfImage(10, 3, 150, Server.MapPath(SignImg));

            transparentResizedPdfImage.PreserveAspectRatio = true;
            //transparentResizedPdfImage.AlphaBlending = true;

            return transparentResizedPdfImage;
            //imageLayoutInfo = page1.Layout(transparentResizedPdfImage);
        }
        private void SetFooter(PdfPage page)
        {
            if (page.Footer != null)
            {
                if (FooterImage)
                {
                    page.Footer.Layout(getPDFImageFooter(drcurrent["FooterImage"].ToString()));
                }

            }
        }
        private PdfImage getPDFImageforbarcode(float X, float Y, string labno)
        {
            string image = "";

            image = new GenerateBarcode().Save(labno).Trim();

            PdfImage transparentResizedPdfImage = new PdfImage(X, Y, Base64StringToImage(image));

            transparentResizedPdfImage.PreserveAspectRatio = true;



            return transparentResizedPdfImage;

        }
        public System.Drawing.Image Base64StringToImage(string base64String)
        {
            byte[] imageBytes = Convert.FromBase64String(base64String.Replace("data:image/png;base64,", ""));
            MemoryStream memStream = new MemoryStream(imageBytes, 0, imageBytes.Length);

            memStream.Write(imageBytes, 0, imageBytes.Length);
            System.Drawing.Image image = System.Drawing.Image.FromStream(memStream);
            Bitmap newImage = new Bitmap(240, 30);
            using (Graphics graphics = Graphics.FromImage(newImage))
                graphics.DrawImage(image, 0, 0, 240, 30);
            return newImage;
        }

        private PdfImage getPDFBackGround(string SignImg)
        {
            PdfImage transparentResizedPdfImage = new PdfImage(225, 110, 200, Server.MapPath("~/" + SignImg));

            transparentResizedPdfImage.PreserveAspectRatio = true;
            //transparentResizedPdfImage.AlphaBlending = true;

            return transparentResizedPdfImage;
            //imageLayoutInfo = page1.Layout(transparentResizedPdfImage);
        }

        private PdfImage getPDFImageFooter(string SignImg)
        {
            PdfImage transparentResizedPdfImage = new PdfImage(20, 0, Server.MapPath(SignImg));

            transparentResizedPdfImage.PreserveAspectRatio = true;
            //transparentResizedPdfImage.AlphaBlending = true;

            return transparentResizedPdfImage;
            //imageLayoutInfo = page1.Layout(transparentResizedPdfImage);
        }
        private string MakeHeader()
        {

            StringBuilder Header = new StringBuilder();
            Header.Append("<div style='width:1000px;'>");

            Header.Append("<table style='width:1000px;border-collapse:collapse;font-family:Times New Roman;font-size:15px;'");
            Header.Append("<tr>");
            Header.Append("<td><span style='font-size:16px !important;'></span>");
            Header.Append("</td>");
            Header.Append("</tr>");

            Header.Append("</table>");


            return Header.ToString();
        }

        private void mergeDocument()
        {
            int pageno = 1;
            foreach (PdfPage p in tempDocument.Pages)
            {


                PdfHtml linehtml = new PdfHtml(XFooter, -4, "<div style='width:1140px;border-top:3px solid black;'></div>", null);

                System.Drawing.Font pageNumberingFont =
              new System.Drawing.Font(new System.Drawing.FontFamily("Times New Roman"), 8, System.Drawing.GraphicsUnit.Point);
                PdfText pageNumberingText = new PdfText(PageWidth - 20, FooterHeight - 40, String.Format(" Page {0} of {1}", pageno, tempDocument.Pages.Count), pageNumberingFont);
                pageNumberingText.ForeColor = System.Drawing.Color.Black;

                PdfText printdatetime = new PdfText(PageWidth - 520, FooterHeight - 40, DateTime.Now.ToString("dd-MMM-yyyy hh:mm tt"), pageNumberingFont);
                printdatetime.ForeColor = System.Drawing.Color.Black;

                if (p.Footer == null)
                {
                    p.CreateFooterCanvas(FooterHeight);

                }
                //  p.Footer.Layout(linehtml);
                //p.Footer.Layout(pageNumberingText);
                //  p.Footer.Layout(printdatetime);
                document.Pages.AddPage(p);
                pageno++;
            }

            tempDocument = new PdfDocument();
        }
    }
}