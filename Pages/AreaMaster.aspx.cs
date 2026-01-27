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
    public partial class AreaMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
                if (!IsPostBack)
                {
                    BindSatate();
                    txtAreaName.Text = "";
                    txtPincode.Text = "";
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
                using (DataTable dt = obj.GetCityMasterByStateID(StateID))
                {
                    ddlCityMaster.DataSource = dt;
                    ddlCityMaster.DataTextField = "city";
                    ddlCityMaster.DataValueField = "ID";
                    ddlCityMaster.DataBind();
                    ddlCityMaster.Items.Insert(0, new ListItem("Select City", ""));
                }
            }
        }
        //protected void BindArea(int CityID)
        //{
        //    using (BusinessLogicLayer obj = new BusinessLogicLayer())
        //    {
        //        using (DataTable dt = obj.GetAreaMasterByCityID(CityID))
        //        {
        //            ddlCityMaster.DataSource = dt;
        //            ddlStateMaster.DataTextField = "Area";
        //            ddlStateMaster.DataValueField = "ID";
        //            ddlCityMaster.DataBind();
        //            ddlStateMaster.Items.Insert(0, new ListItem("Select Area", ""));
        //        }
        //    }
        //}

        protected void BindArea(int CityID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetAllAreaMasterByCityID(CityID))
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
                    Results = obj.AreaMaster_CRUD(Convert.ToInt32(hdnAreaID.Value), Convert.ToInt32(ddlCityMaster.SelectedValue), txtAreaName.Text,Convert.ToInt32(txtPincode.Text), Convert.ToInt32(cblActive.Checked), "", "Update");
                    msg = "Update Sucessfully";
                }
                else
                {
                    Results = obj.AreaMaster_CRUD(0, Convert.ToInt32(ddlCityMaster.SelectedValue), txtAreaName.Text, Convert.ToInt32(txtPincode.Text), Convert.ToInt32(cblActive.Checked), "", "Add");
                    msg = "Save Sucessfully";
                }


                if (Results > 0)
                {
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = msg;
                    BindArea(Convert.ToInt32(ddlCityMaster.SelectedValue));
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
            var AreaID = (item.FindControl("hdnAreaID") as HiddenField);
            var CityID = (item.FindControl("hdnCityID") as HiddenField);
            var hdnStateID = (item.FindControl("hdnStateID") as HiddenField);
            var hdnAreaName = (item.FindControl("hdnAreaName") as HiddenField);
            var hdnpincode = (item.FindControl("hdnpincode") as HiddenField);
            var hdnisactive = (item.FindControl("hdnisactive") as HiddenField);
            cblActive.Checked = Convert.ToBoolean(hdnisactive.Value);

            txtAreaName.Text = hdnAreaName.Value;
            hdnAreaID.Value = AreaID.Value;
            ddlStateMaster.SelectedValue = hdnStateID.Value;
            txtPincode.Text = hdnpincode.Value;
            btnSave.Text = "Update";
        }

        protected void ddlStateMaster_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlStateMaster.SelectedIndex > 0)
            {
                BindCity(Convert.ToInt32(ddlStateMaster.SelectedValue));
            }

        }

        protected void ddlCityMaster_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCityMaster.SelectedIndex > 0)
            {
                BindArea(Convert.ToInt32(ddlCityMaster.SelectedValue));
                txtAreaName.Text = "";
                txtPincode.Text = "";
                lblmsg.Text = "";
            }
        }
    }
}