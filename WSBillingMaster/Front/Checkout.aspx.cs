using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FaduPrice.Pages
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
                BindData(Session["UserId"].ToString());
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }

        private void BindData(string UserId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = UserId;
                using (DataSet ds = obj.BindCart())
                {

                    using (DataTable dt = ds.Tables[1])
                    {
                        if (dt.Rows.Count > 0)
                        {
                            rptItems.DataSource = dt;
                            rptItems.DataBind();

                            int Total = 0;
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                int Sub=Convert.ToInt32(dt.Rows[i]["ItemQuantity"])*(Convert.ToInt32(dt.Rows[i]["ItemPrice"]));
                                Total = Total + Sub;
                            }
                            lblSubTotal.Text = Total.ToString();
                            lblTotal.Text = Total.ToString();

                        }
                        else
                        {
                            rptItems.DataSource = null;
                            rptItems.DataBind();
                        }
                    }

                }

            }
        }
    }
}