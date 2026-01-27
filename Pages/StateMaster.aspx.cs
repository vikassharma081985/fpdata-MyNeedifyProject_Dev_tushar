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
    public partial class StateMaster : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
                if (!IsPostBack)
                {
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
                    Results = obj.StateMaster_CRUD(Convert.ToInt32(hdnSateID.Value), txtStateName.Text, Convert.ToInt32(cblActive.Checked), "", "Update");
                    msg = "Update Sucessfully";
                }
                else
                {
                    Results = obj.StateMaster_CRUD(0, txtStateName.Text, Convert.ToInt32(cblActive.Checked), "", "Add");
                    msg = "Save Sucessfully";
                }

                if (Results > 0)
                {
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = msg;
                    BindSatate();
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
            var ID = (item.FindControl("hdnID") as HiddenField);
            var hdnSate = (item.FindControl("hdnSate") as HiddenField);
            var hdnisactive = (item.FindControl("hdnisactive") as HiddenField);
            //cblActive.Checked = Convert.ToBoolean(Convert.ToInt32(hdnisactive.Value));
            cblActive.Checked = Convert.ToBoolean(hdnisactive.Value);

            txtStateName.Text = hdnSate.Value;
            hdnSateID.Value = ID.Value;
            btnSave.Text = "Update";
        }
    }
}