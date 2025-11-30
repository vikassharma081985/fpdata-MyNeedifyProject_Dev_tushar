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
    public partial class StockInHand : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetStockInHand()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {

                using (DataSet ds = objBLL.GetStockInHand())
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
                    return rtrn;
                }
            }


        }
    }
}