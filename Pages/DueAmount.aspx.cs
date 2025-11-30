using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster
{
    public partial class DueAmount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                BindDueAmountData();
        }
        public void BindDueAmountData()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.FromDate = txtFromDate.Text;
                objBLL.ToDate = txtToDate.Text;
                objBLL.Keyword = txtKeyword.Text.Trim();

                using (DataTable dt = objBLL.GetDueAmountDetails())
                {
                    if (dt.Rows.Count > 0)
                    {
                        grdDueAmount.DataSource = dt;
                        grdDueAmount.DataBind();
                    }
                    else
                    {
                        grdDueAmount.DataSource = null;
                        grdDueAmount.DataBind();
                    }
                }
            }
        }
        protected void btnSearchData_Click(object sender, EventArgs e)
        {
            BindDueAmountData();
        }
    }
}