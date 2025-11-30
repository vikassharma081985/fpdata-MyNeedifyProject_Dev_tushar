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
    public partial class AddSubSubCategory : System.Web.UI.Page
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
                    BindCategory();
                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void BindCategory()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataSet ds = obj.GetCategory())
                {
                    ddlCategoryMaster.DataSource = ds.Tables[0];
                    ddlCategoryMaster.DataTextField = "Category";
                    ddlCategoryMaster.DataValueField = "CategoryId";
                    ddlCategoryMaster.DataBind();
                    ddlCategoryMaster.Items.Insert(0, new ListItem("Select Category", ""));
                }
            }
        }

        protected void BindSubCategory(int CategoryId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetSubCategoryByID(CategoryId))
                {
                    ddlSubCategoryMaster.DataSource = dt;
                    ddlSubCategoryMaster.DataTextField = "SubCategory";
                    ddlSubCategoryMaster.DataValueField = "SubCategoryId";
                    ddlSubCategoryMaster.DataBind();
                    ddlSubCategoryMaster.Items.Insert(0, new ListItem("Select SubCategory", ""));
                }
            }
        }

        protected void BindSubSubCategory(int SubCategoryId,int CategoryID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetSubSubCategoryByID(CategoryID, SubCategoryId))
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
                    Results = obj.SubSubCategory_master_CRUD(Convert.ToInt32(hdnSubCatID.Value), Convert.ToInt32(ddlSubCategoryMaster.SelectedValue), Convert.ToInt32(ddlCategoryMaster.SelectedValue), txtSubSubCategoryName.Text, Convert.ToInt32(cblActive.Checked), "", "Update");
                    msg = "Update Sucessfully";
                }
                else
                {
                    Results = obj.SubSubCategory_master_CRUD(0, Convert.ToInt32(ddlSubCategoryMaster.SelectedValue), Convert.ToInt32(ddlCategoryMaster.SelectedValue), txtSubSubCategoryName.Text, Convert.ToInt32(cblActive.Checked), "", "Add");
                    msg = "Save Sucessfully";
                }

                if (Results > 0)
                {
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = msg;
                    BindSubSubCategory(Convert.ToInt32(ddlSubCategoryMaster.SelectedValue), Convert.ToInt32(ddlCategoryMaster.SelectedValue));
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
            var hdnSubSubCategoryId = (item.FindControl("hdnSubSubCategoryId") as HiddenField);
            var hdnSubCategoryId = (item.FindControl("hdnSubCategoryId") as HiddenField);
            var hdnCategoryId = (item.FindControl("hdnCategoryId") as HiddenField);
            var hdnSubCategoryName = (item.FindControl("hdnSubSubCategoryName") as HiddenField);
            var hdnisactive = (item.FindControl("hdnisactive") as HiddenField);
            cblActive.Checked = Convert.ToBoolean(hdnisactive.Value);

            txtSubSubCategoryName.Text = hdnSubCategoryName.Value;
            hdnSubCatID.Value = hdnSubSubCategoryId.Value;
            ddlCategoryMaster.SelectedValue = hdnCategoryId.Value;
            ddlSubCategoryMaster.SelectedValue = hdnSubCategoryId.Value;
            btnSave.Text = "Update";
        }

        protected void ddlStateMaster_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCategoryMaster.SelectedIndex > 0)
            {
                BindSubCategory(Convert.ToInt32(ddlCategoryMaster.SelectedValue));
                txtSubSubCategoryName.Text = "";
                btnSave.Text = "Submit";
                lblmsg.Text = "";
            }

        }

        protected void ddlSubCategoryMaster_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCategoryMaster.SelectedIndex > 0)
            {
                BindSubSubCategory(Convert.ToInt32(ddlSubCategoryMaster.SelectedValue), Convert.ToInt32(ddlCategoryMaster.SelectedValue));
                txtSubSubCategoryName.Text = "";
                btnSave.Text = "Submit";
                lblmsg.Text = "";
            }
        }
    }
}