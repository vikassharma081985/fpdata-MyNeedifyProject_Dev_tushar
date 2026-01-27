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
    public partial class AddRole : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
                if (!IsPostBack)
                {
                    btnSave.Text = "Submit";
                    lblmsg.Text = "";
                    BindRole();
                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void BindRole()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetADMINROLE())
                {
                    rptData.DataSource = dt;
                    rptData.DataBind();
                    
                }
            }
        }

        protected void BindRoleWiseMenu(int RoleID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetBINDROLEWISEMENU(RoleID))
                {
                    rptMenu.DataSource = dt;
                    rptMenu.DataBind();
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
                    Results = obj.Role_master_CRUD(Convert.ToInt32(hdnMenuID.Value), txtrole.Text.Trim(),  Convert.ToInt32(cblActive.Checked), "", "Update");
                    msg = "Update Sucessfully";
                }
                else
                {
                    Results = obj.Role_master_CRUD(0, txtrole.Text.Trim(),  Convert.ToInt32(cblActive.Checked), "", "Add");
                    msg = "Save Sucessfully";
                }

                if (Results > 0)
                {
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = msg;
                    BindRole();
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
            var hdnRoleId = (item.FindControl("hdnRoleId") as HiddenField);
            var hdnRole = (item.FindControl("hdnRole") as HiddenField);
            var hdnisactive = (item.FindControl("hdnisactive") as HiddenField);
            cblActive.Checked = Convert.ToBoolean(hdnisactive.Value);

            txtrole.Text = hdnRole.Value;
            hdnMenuID.Value = hdnRoleId.Value;            
            btnSave.Text = "Update";
        }

        protected void lnkMenu_Click(object sender, EventArgs e)
        {
            RepeaterItem item = (sender as LinkButton).Parent as RepeaterItem;
            var hdnRoleId = (item.FindControl("hdnRoleId") as HiddenField);
            hdnRoleID.Value = hdnRoleId.Value;
            BindRoleWiseMenu(Convert.ToInt32(hdnRoleId.Value));

            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup();", true);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)

        {            
            foreach (RepeaterItem item in rptMenu.Items)
            {
                CheckBox IsChecked = item.FindControl("chkRow") as CheckBox;
                HiddenField hdnMenuID = item.FindControl("hdnMenuId") as HiddenField;
                int MenuID = Convert.ToInt32(hdnMenuID.Value);
                int RoleID= Convert.ToInt32( hdnRoleID.Value);
                
                using (BusinessLogicLayer obj = new BusinessLogicLayer())
                {
                  var s=  obj.INSERTUPDATEROLEWISEMENU(RoleID, MenuID, IsChecked.Checked);
                }
                
            }
        }
    }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       