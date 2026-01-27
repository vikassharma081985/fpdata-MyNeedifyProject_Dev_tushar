using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class ExportToExcel : System.Web.UI.Page
    {
        public override void VerifyRenderingInServerForm(Control control)
        {
            return;
        }
                
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
                string Period = "";
                string ReportName = Session["ReportName"].ToString();

                if (Session["Period"] != null)
                    Period = Session["Period"].ToString();
                else
                    Period = "";

                //lblHeader.Text = ReportName;
                //lblPeriod.Text = Period;
            }
        }
        public MemoryStream GetStream(XLWorkbook excelWorkbook)
        {
            MemoryStream fs = new MemoryStream();
            excelWorkbook.SaveAs(fs);
            fs.Position = 0;
            return fs;
        }
        protected void BindData()
        {
            // lblmsg.Text = "";
            try
            {
                DataTable dt = ((DataTable)Session["dtExport2Excel"]);
                dt.TableName = "data";

                var wb = new XLWorkbook();
                // Add a DataTable as a worksheet
                wb.Worksheets.Add(dt);
                byte[] package = ((MemoryStream)GetStream(wb)).ToArray();
                string attachment = "attachment; filename=" + Session["ReportName"].ToString() + ".xlsx";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.BinaryWrite(package);
                Response.End();
            }
            catch (Exception ex)
            {
                // lblmsg.Text = ex.Message;
            }
            finally
            {
                Session["dtExport2Excel"] = "";
                Session.Remove("dtExport2Excel");
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            //btnExport.Visible = false;
            //lblmsg.Visible = false;

            string ReportName = Session["ReportName"].ToString();

            Response.Clear();
            //   application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
            Response.AddHeader("content-disposition", "attachment;filename=" + ReportName + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";

            StringWriter StringWriter = new System.IO.StringWriter();
            HtmlTextWriter HtmlTextWriter = new HtmlTextWriter(StringWriter);
            this.RenderControl(HtmlTextWriter);
            //EmployeeGrid.RenderControl(HtmlTextWriter);
            Response.Write(StringWriter.ToString());
            Response.End();

            Session["dtExport2Excel"] = "";
            Session.Remove("dtExport2Excel");

            Session["ReportName"] = "";
            Session.Remove("ReportName");

            Session["Period"] = "";
            Session.Remove("Period");

            //btnExport.Visible = true;
            //lblmsg.Visible = true;
        }

    }
}