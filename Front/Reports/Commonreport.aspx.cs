using System;
using System.Data;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class Design_common_Commonreport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.IO.Stream oStream = null;
        try
        {


            ReportDocument obj1 = new ReportDocument();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("Col1");
            DataRow row = dt.NewRow();
            dt.Rows.Add(row);
            dt.Rows[0][0] = "TEst";

            ds.Tables.Add(dt);
            //ds.WriteXml("F:/MyXML.xml");
                //switch (ReportName)
                //{
                //    case "LabWorkSheetHisto":
                //        {
                           
                //            break;
                //        }
                    
                //}

                obj1.Load(Server.MapPath("~/Pages/Reports/Invoice.rpt"));
                obj1.SetDataSource(ds);


                //  System.IO.Stream oStream = null;
                byte[] byteArray = null;
                oStream = obj1.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                byteArray = new byte[oStream.Length];
                oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(byteArray);
                Response.Flush();
                Response.Close();
                obj1.Close();

                obj1.Dispose();

        }
        catch (Exception ex)
        {
            
        }
        finally
        {

            oStream.Close();
            oStream.Dispose();
        }


    }
}
