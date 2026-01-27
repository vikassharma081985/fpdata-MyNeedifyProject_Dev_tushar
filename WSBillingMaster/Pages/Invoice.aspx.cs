using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HiQPdf;
using System.Text;
using BLL;
using System.Data;

namespace WSBillingMaster.Pages
{
    public partial class Invoice : System.Web.UI.Page
    {
        int MarginLeft = 20;
        int MarginRight = 30;
        int PageWidth = 550;
        int BrowserWidth = 800;
        //Header Property
        float HeaderHeight = 0;//207
        int XHeader = 0;//20
        int YHeader = 0;//80
        int HeaderBrowserWidth = 800;
        float FooterHeight = 0;//95
        int XFooter = 20;
        PdfLayoutInfo html1LayoutInfo;
        PdfDocument document = new PdfDocument();
        protected void Page_Load(object sender, EventArgs e)
        {
       
            if (Request["OrderItemId"] != null)
            {

                using (BusinessLogicLayer obj = new BusinessLogicLayer())
                {
                    obj.OrderId = Request["OrderItemId"].ToString();
                    using (DataTable dt = obj.GetOrderDetails())
                    {
                        if (dt.Rows.Count > 0)
                        {
                            //SetDepFilePath();
                            
                            document.SerialNumber = "g8vq0tPn‐5c/q4fHi‐8fq7rbOj‐sqO3o7uy‐t6Owsq2y‐sa26urq6";
                            StringBuilder sb = new StringBuilder();
                            sb.Append(" <style>    .invoice-box {        max-width: 800px;        margin: auto;        padding: 30px;        border: 1px solid #eee;        box-shadow: 0 0 10px rgba(0, 0, 0, .15);        font-size: 16px;        line-height: 24px;        font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;        color: #555;    }        .invoice-box table {        width: 100%;        line-height: inherit;        text-align: left;    }        .invoice-box table td {        padding: 5px;        vertical-align: top;    }        .invoice-box table tr td:nth-child(2) {        text-align: right;    }        .invoice-box table tr.top table td {        padding-bottom: 20px;    }        .invoice-box table tr.top table td.title {        font-size: 45px;        line-height: 45px;        color: #333;    }        .invoice-box table tr.information table td {        padding-bottom: 40px;    }        .invoice-box table tr.heading td {        background: #eee;        border-bottom: 1px solid #ddd;        font-weight: bold;   }        .invoice-box table tr.details td {        padding-bottom: 20px;    }        .invoice-box table tr.item td{        border-bottom: 1px solid #eee;    }        .invoice-box table tr.item.last td {        border-bottom: none;    }        .invoice-box table tr.total td:nth-child(2) {        border-top: 2px solid #eee;        font-weight: bold;    }        @media only screen and (max-width: 600px) {        .invoice-box table tr.top table td {            width: 100%;            display: block;            text-align: center;        }                .invoice-box table tr.information table td {            width: 100%;            display: block;            text-align: center;        }    }        /** RTL **/    .rtl {        direction: rtl;        font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;    }        .rtl table {        text-align: right;    }        .rtl table tr td:nth-child(2) {        text-align: left;    }    </style>");
                            sb.Append("<div style='width:98%;padding:15px;background-color:#f1f1f1;color:#000;text-align:center;margin-bottom:15px;margin-top:15px;font-size:24px;font-weight:bold'> Invoice    </div> ");
                            sb.Append("<div class='invoice-box'>");
                            sb.Append("<table cellpadding='0' cellspacing='0'> <tr class='top'> <td colspan='2'><table>  <tr>      <td class='title'>         </td> ");
                             //<img src='../Images/System/logo_1.png' style='width:200px;'>
                            sb.Append("<td> Order # : " + dt.Rows[0]["OrderId"].ToString() + "</br> Invoice #: " + dt.Rows[0]["OrderItemId"].ToString() + "<br>  ");
                            sb.Append("Ordered On : " + dt.Rows[0]["OrderedOn"].ToString() + " <br>  ");
                            sb.Append("Invoice Date : " + dt.Rows[0]["InvoiceDate"].ToString() + " <br>  ");
                            sb.Append(" </td>  </tr> </table></td> </tr>  <tr class='information'> <td colspan='2'> <table>  <tr> <td> ");
                            sb.Append(dt.Rows[0]["Name"].ToString() + "<br>");
                            sb.Append(dt.Rows[0]["Address1"].ToString() + "<br>");
                            sb.Append(dt.Rows[0]["City"].ToString() + "<br>");
                            sb.Append(dt.Rows[0]["State"].ToString() + "<br>");
                            sb.Append(dt.Rows[0]["Mobile"].ToString() + "<br>");
                             sb.Append("  </td> ");
                            sb.Append("<td> </td>  </tr>  </table>  </td> </tr>");
                            // sb.Append("<tr class='heading'>     <td>         Payment Method     </td>          <td>         Check #     </td> </tr>  <tr class='details'>     <td>         Check     </td>          <td>         1000     </td> </tr> ");
                            sb.Append("<tr class='heading'>     <td>         Item     </td>          <td>         Price     </td> </tr> ");
                            sb.Append("<tr class='item'>   ");
                            sb.Append("<td>    " + dt.Rows[0]["ItemName"].ToString() + "    </td>  ");
                            sb.Append("<td>       ₹  " + dt.Rows[0]["ItemPrice"].ToString() + "  </td> </tr> ");
                            sb.Append("<tr class='item'>     <td>         Shipping Charges     </td>          <td> ₹ " + dt.Rows[0]["ShippingPrice"].ToString() + "     </td> </tr> ");
                            //sb.Append("<tr class='item last'>     <td>         Domain name (1 year)     </td>          <td>         $10.00     </td> </tr>");
                            sb.Append("<tr class='total'>     <td></td> <td>  Total: ₹ " + dt.Rows[0]["TotalAmount"].ToString() + "     </td> ");
                            sb.Append("</tr> </table>    </div>");
                            AddContent(sb.ToString());
                            byte[] pdfBuffer = document.WriteToMemory();
                            HttpContext.Current.Response.AddHeader("Content-Type", "application/pdf");
                            HttpContext.Current.Response.BinaryWrite(pdfBuffer);

                            HttpContext.Current.Response.End();

                            document.Close();
                        }
                    }
                }
            }
        }
        private void AddContent(string Content)
        {
            html1LayoutInfo = null;
            PdfDocument tempDocument = new PdfDocument();
            PdfPage page1 = document.AddPage(PdfPageSize.A4, PdfDocumentMargins.Empty);
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
            page1.CreateFooterCanvas(FooterHeight);
            page1.CreateHeaderCanvas(HeaderHeight);
        }
    }
}