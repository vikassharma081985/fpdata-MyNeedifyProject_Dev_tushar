using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class AllTransactions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.FromDate = txtFromDate.Text;
                objBLL.ToDate = txtToDate.Text;

                using (DataTable dt = objBLL.GetPreviousTransactions())
                {
                    if (dt.Rows.Count > 0)
                    {
                        grdTransaction.DataSource = dt;
                        grdTransaction.DataBind();
                    }
                    else
                    {
                        grdTransaction.DataSource = null;
                        grdTransaction.DataBind();
                    }
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
    }
}