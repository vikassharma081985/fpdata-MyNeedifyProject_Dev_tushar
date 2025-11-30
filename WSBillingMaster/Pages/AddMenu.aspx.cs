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
    public partial class AddMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
                if (!IsPostBack)
                {
                    btnSave.Text = "Submit";
                    lblmsg.Text = "";
                    BindMenu();
                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void BindMenu()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetMenuMaster())
                {
                    rptData.DataSource = dt;
                    rptData.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int Results = 0; string msg = "";
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                if (btnSave.Text == "Update")
                {
                    Results = obj.Menu_master_CRUD(Convert.ToInt32(hdnMenuID.Value), txtMenuName.Text.Trim(), txtMenuUrl.Text.Trim(), Convert.ToInt32(cblActive.Checked), "", "Update");
                    msg = "Update Sucessfully";
                }
                else
                {
                    Results = obj.Menu_master_CRUD(0, txtMenuName.Text.Trim(), txtMenuUrl.Text.Trim(), Convert.ToInt32(cblActive.Checked), "", "Add");
                    msg = "Save Sucessfully";
                }

                if (Results > 0)
                {
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = msg;
                    BindMenu();
                    btnSave.Text = "Submit";
                }
                else
                {
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                    lblmsg.Text = "not Sucessfully";
                }
            }
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            RepeaterItem item = (sender as LinkButton).Parent as RepeaterItem;
            var hdnMenuId = (item.FindControl("hdnMenuId") as HiddenField);
            var hdnMenuName = (item.FindControl("hdnMenuName") as HiddenField);
            var hdnMenuUrl = (item.FindControl("hdnMenuUrl") as HiddenField);
            var hdnisactive = (item.FindControl("hdnisactive") as HiddenField);
            cblActive.Checked = Convert.ToBoolean(hdnisactive.Value);

            txtMenuName.Text = hdnMenuName.Value;
            hdnMenuID.Value = hdnMenuId.Value;
            txtMenuUrl.Text = hdnMenuUrl.Value;
            btnSave.Text = "Update";
        }


    }
}
