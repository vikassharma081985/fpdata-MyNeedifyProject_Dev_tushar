using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class VendorItemReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
                txtFormDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                txtToDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                if (!IsPostBack)
                {
                    BindData();
                }
            }
        }
        private void BindData()
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.UserId = Convert.ToString(Session["UserId"]);
                DataTable VendorReport = objFp.GetVendorItemReport();
                if (VendorReport != null && VendorReport.Rows.Count > 0)
                {
                    lblTotalCount.Text = VendorReport.Rows.Count.ToString();
                    int i = 0;
                    //tb_ItemList.Rows.Clear();
                    foreach (DataRow drVendor in VendorReport.Rows)
                    {
                        HtmlTableRow tblRow = new HtmlTableRow();
                        //HtmlTableCell tblCell = new HtmlTableCell();
                        i++;
                        StringBuilder html = new StringBuilder();
                        HtmlTableCell tblCell = new HtmlTableCell();
                        tblCell.InnerText = i.ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["ItemId"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["ItemName"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["ItemPrice"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Amount"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["IsActive"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Stock"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Pending"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Shippted"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["OutofDelivery"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Delivered"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Cancelled"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Medium"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Large"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["ExtraLarge"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["DoubleXL"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tb_ItemList.Rows.Add(tblRow);
                        tb_ItemList.Border = 1;

                    }
                }
            }

        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SearchData(string FromDate, string ToDate, string Status)
        {

            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.FromDate = Convert.ToDateTime(FromDate).ToString("yyyy-MM-dd");
                objFp.ToDate = Convert.ToDateTime(ToDate).ToString("yyyy-MM-dd"); ;
                objFp.Status = Status;
                DataTable POrderList = objFp.GetPendingOrderList();
                return Newtonsoft.Json.JsonConvert.SerializeObject(POrderList);
            }
        }        
    }
}