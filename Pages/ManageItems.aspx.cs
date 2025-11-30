using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;

namespace WSBillingMaster.Pages
{
    public partial class ManageItems : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.ToString("yyyy-MM-dd 00:00:00");
                txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd 23:59:59");
                
            }
        }

        private void BindData(int type)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.Keyword = txtSearch.Text.Trim();
                objBLL.FromDate = txtFromDate.Text;
                objBLL.ToDate = txtToDate.Text;
                using (DataTable dt = objBLL.GetManageItemData(type))
                {
                    if (dt.Rows.Count > 0)
                    {
                        rptItems.DataSource = dt;
                        rptItems.DataBind();
                    }
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtSearch.Text == "")
            {
                rptItems.DataSource = null;
                rptItems.DataBind();
                //string message = "Please entre the text which you want to search?";
                //ClientScript.RegisterOnSubmitStatement(this.GetType(), "confirm", "return confirm('" + message + "');");
            }
            else
            {
                BindData(1);
            }
            
        }
        protected void btnSearch2_Click(object sender, EventArgs e)

        {

            BindData(2);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string EditItemName(int ItemId,string ItemName)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.ItemName = ItemName;
                objBLL.ItemId = ItemId;
                return objBLL.EditItemName().ToString();
                
            }
        }
    }
}