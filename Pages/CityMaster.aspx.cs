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
    public partial class CityMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
                if (!IsPostBack)
                {
                    btnSave.Text = "Submit";
                    lblmsg.Text = "";
                    BindSatate();
                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void BindSatate()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetStateMaster())
                {
                    ddlStateMaster.DataSource = dt;
                    ddlStateMaster.DataTextField = "state";
                    ddlStateMaster.DataValueField = "ID";
                    ddlStateMaster.DataBind();
                    ddlStateMaster.Items.Insert(0, new ListItem("Select State", ""));
                }
            }
        }

        protected void BindCity(int StateID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetAllCityMasterByStateID(StateID))
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
                    Results = obj.CityMaster_CRUD(Convert.ToInt32(hdnCityID.Value), Convert.ToInt32(ddlStateMaster.SelectedValue), txtCityName.Text, Convert.ToInt32(cblActive.Checked), "", "Update");
                    msg = "Update Sucessfully";
                }
                else
                {
                    Results = obj.CityMaster_CRUD(0, Convert.ToInt32(ddlStateMaster.SelectedValue), txtCityName.Text, Convert.ToInt32( cblActive.Checked), "", "Add");
                    msg = "Save Sucessfully";
                }

                if (Results > 0)
                {
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = msg;
                    BindCity(Convert.ToInt32(ddlStateMaster.SelectedValue));
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
            var CityID = (item.FindControl("hdnCityID") as HiddenField);
            var hdnStateID = (item.FindControl("hdnStateID") as HiddenField);
            var hdnCityName = (item.FindControl("hdnCityName") as HiddenField);
            var hdnisactive = (item.FindControl("hdnisactive") as HiddenField);
            //cblActive.Checked = Convert.ToBoolean(Convert.ToInt32(hdnisactive.Value));
            cblActive.Checked = Convert.ToBoolean(hdnisactive.Value);

            txtCityName.Text = hdnCityName.Value;
            hdnCityID.Value = CityID.Value;
            ddlStateMaster.SelectedValue = hdnStateID.Value;
            btnSave.Text = "Update";
        }

        protected void ddlStateMaster_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlStateMaster.SelectedValue != "0")
            {
                BindCity(Convert.ToInt32(ddlStateMaster.SelectedValue));
                txtCityName.Text = "";
                btnSave.Text = "Submit";
                lblmsg.Text = "";
            }

        }
    }
}