using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class PendingOrderList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtFormDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
            txtToDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
            BindData();
        }

        private void BindData()
        {

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
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static int SaveData(List<SaveData> Data)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                foreach (var item in Data)
                {
                    objFp.Status = item.Status;
                    objFp.courier = item.Courier;
                    objFp.Remarks = item.Remarks;
                    objFp.OrderId = item.OrderId;
                    objFp.ItemId = item.ItemId;
                    int result = objFp.SavePendingOrderList();

                }
            }
            return 1;
        }
    }

    public class SaveData
    {
        public string Status { get; set; }
        public string Courier { get; set; }
        public string Remarks { get; set; }
        public string OrderId { get; set; }
        public int ItemId { get; set; }
    }
}