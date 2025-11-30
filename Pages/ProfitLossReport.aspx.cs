using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class ProfitLossReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.ToString("01-MMM-yyyy");
                txtToDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                BindData();

            }

        }

        private void BindData()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.FromDate = txtFromDate.Text;
                objBLL.ToDate = txtToDate.Text;

                using (DataTable dt = objBLL.GetProfitLoss())
                {
                    if (dt.Rows.Count > 0)
                    {
                        grdTransaction.DataSource = dt;
                        grdTransaction.DataBind();
                        BindChart(dt);
                    }
                    else
                    {
                        grdTransaction.DataSource = null;
                        grdTransaction.DataBind();
                    }
                }
            }
        }

        private void BindChart(DataTable dt)
        {
            string JsonData = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
            string Script = "GetSalesSummary('" + JsonData + "');";
            ScriptManager.RegisterStartupScript(this, GetType(), "", Script, true);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string drawChart(string FromDate, string ToDate)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.FromDate = FromDate;
                objBLL.ToDate = ToDate;

                using (DataTable dt = objBLL.GetProfitLoss())
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    return rtrn;
                }
            }


        }
    }
}