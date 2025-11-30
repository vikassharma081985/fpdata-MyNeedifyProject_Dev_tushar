using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class SupplierList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
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
                DataTable VendorReport = objFp.GETSUPPLIERLIST(txtSupplierName.Text);
                if (VendorReport != null && VendorReport.Rows.Count > 0)
                {
                    lblTotalCount.Text = VendorReport.Rows.Count.ToString();
                    int i = 0;
                    foreach (DataRow drVendor in VendorReport.Rows)
                    {
                        HtmlTableRow tblRow = new HtmlTableRow();
                        i++;

                        HtmlTableCell tblCell = new HtmlTableCell();
                        tblCell.InnerText = i.ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["SupplierName"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["SupplierCode"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Landline"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["EmailId"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["PANCardNo"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["Status"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerText = drVendor["CreateDate"].ToString();
                        tblRow.Controls.Add(tblCell);

                        tblCell = new HtmlTableCell();
                        tblCell.InnerHtml = "<input type='hidden' id='hdnSupplierId' value='" + drVendor["SupplierID"].ToString() + "' /><a href='http://trendzshopping.in//Pages/AddSupplier.aspx?SupId=" + Convert.ToInt32(drVendor["SupplierID"]) + "'>Edit</a>";
                        tblRow.Controls.Add(tblCell);

                        tb_ItemList.Rows.Add(tblRow);
                        tb_ItemList.Border = 1;

                    }
                }
            }

        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SearchData(string SupplierName)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                DataTable VendorReport = objFp.GETSUPPLIERLIST(SupplierName);
                return Newtonsoft.Json.JsonConvert.SerializeObject(VendorReport);
                //bindTable(VendorReport);
            }
        }

        public void bindTable(DataTable dt)
        {
            lblTotalCount.Text = dt.Rows.Count.ToString();
            int i = 0;
            foreach (DataRow drVendor in dt.Rows)
            {
                HtmlTableRow tblRow = new HtmlTableRow();
                i++;

                HtmlTableCell tblCell = new HtmlTableCell();
                tblCell.InnerText = i.ToString();
                tblRow.Controls.Add(tblCell);

                tblCell = new HtmlTableCell();
                tblCell.InnerText = drVendor["SupplierName"].ToString();
                tblRow.Controls.Add(tblCell);

                tblCell = new HtmlTableCell();
                tblCell.InnerText = drVendor["SupplierCode"].ToString();
                tblRow.Controls.Add(tblCell);

                tblCell = new HtmlTableCell();
                tblCell.InnerText = drVendor["Landline"].ToString();
                tblRow.Controls.Add(tblCell);

                tblCell = new HtmlTableCell();
                tblCell.InnerText = drVendor["EmailId"].ToString();
                tblRow.Controls.Add(tblCell);

                tblCell = new HtmlTableCell();
                tblCell.InnerText = drVendor["PANCardNo"].ToString();
                tblRow.Controls.Add(tblCell);

                tblCell = new HtmlTableCell();
                tblCell.InnerText = drVendor["Status"].ToString();
                tblRow.Controls.Add(tblCell);

                tblCell = new HtmlTableCell();
                tblCell.InnerText = drVendor["CreateDate"].ToString();
                tblRow.Controls.Add(tblCell);

                tblCell = new HtmlTableCell();
                tblCell.InnerHtml = "<input type='hidden' id='hdnSupplierId' value='" + drVendor["SupplierID"].ToString() + "' /><a href='http://trendzshopping.in//Pages/AddSupplier.aspx?SupId=" + Convert.ToInt32(drVendor["SupplierID"]) + "'>Edit</a>";
                tblRow.Controls.Add(tblCell);

                tb_ItemList.Rows.Add(tblRow);
                tb_ItemList.Border = 1;

            }
        }

        //[WebMethod(EnableSession = true)]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        //public static int SaveData(List<SaveData> Data)
        //{

        //    using (BusinessLogicLayer objFp = new BusinessLogicLayer())
        //    {
        //        foreach (var item in Data)
        //        {
        //            objFp.Status = item.Status;
        //            objFp.courier = item.Courier;
        //            objFp.Remarks = item.Remarks;
        //            objFp.OrderId = item.OrderId;
        //            objFp.ItemId = item.ItemId;
        //            int result = objFp.SavePendingOrderList();

        //        }
        //    }
        //    return 1;
        //}
    }
}