using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using System.Text.RegularExpressions;
using System;
using BLL;

namespace WSBillingMaster.Pages
{
    public partial class BillReceipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["TransactionId"] != null)
            {
                string TransactionId = Request["TransactionId"].ToString();
                using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                {
                    objBLL.TransactionId = TransactionId;
                    using (DataTable dtReceipt = objBLL.GetInvoice())
                    {
                        if (dtReceipt.Rows.Count > 0)
                        {
                            using (DataSet ds = new DataSet())
                            {
                                System.IO.Stream oStream = null;
                                ds.Tables.Add(dtReceipt.Copy());
                              //  ds.WriteXmlSchema(@"H:\\BillReceipt.xml");
                                ReportDocument obj1 = new ReportDocument();
                                obj1.Load(Server.MapPath("~/Reports/BillReceipt.rpt"));
                                obj1.SetDataSource(ds);
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
                        }
                    }

                }
            }
        }
    }
}