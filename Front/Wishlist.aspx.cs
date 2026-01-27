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
    public partial class Wishlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               // Session["UserId"] = "1";
                if (Session["UserId"] != null)
                {
                    BindData();
                   // hdnUserId.Value = Session["UserId"].ToString();
                }
                else
                {
                    Response.Redirect("http://trendzshopping.in//Front/Index.aspx");
                }
            }
        }

        private void BindData()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = Session["UserId"].ToString();
                using (DataTable dt = obj.GetWishlistItems())
                {
                    if (dt.Rows.Count > 0)
                    {

                        rptMenCollection.DataSource = dt;
                        rptMenCollection.DataBind();
                        divMenCollNoRecord.Visible = false;
                    }
                    else {
                        divMenCollNoRecord.Visible = true;
                    }
                }
            }
        }
    }
}