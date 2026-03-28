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

namespace FaduPrice.Pages
{
    public partial class MyOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // Session["UserId"] = "1";

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
                using (DataSet ds = obj.BindMyOrders())
                {

                    using (DataTable dt = ds.Tables[0])
                    {
                        if (dt.Rows.Count > 0)
                        {
                            rptItems.DataSource = dt;
                            rptItems.DataBind();
                        }
                        else
                        {
                            rptItems.DataSource = null;
                            rptItems.DataBind();
                        }
                    }

                }

                // Bind Hired Data
                obj.IntUserId = Convert.ToInt32(UserId);
                using (DataTable dtHired = obj.GetHiringDetailsByUserId("ALL"))
                {
                    if (dtHired != null && dtHired.Rows.Count > 0)
                    {
                        rptHiringRequests.DataSource = dtHired;
                        rptHiringRequests.DataBind();
                    }
                    else
                    {
                        rptHiringRequests.DataSource = null;
                        rptHiringRequests.DataBind();
                    }
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string CancelOrder(string OrderItemId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.ItemId = Convert.ToInt32(OrderItemId);
                obj.CancelOrder();
                return "1";
            }
          
        }
    }
}