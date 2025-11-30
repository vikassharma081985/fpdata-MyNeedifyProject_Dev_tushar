using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WSBillingMaster.BAL;
using BLL;

namespace WSBillingMaster.Pages
{
    
    public partial class Registration : System.Web.UI.Page
    {
        JobBAL bll = new JobBAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindSkills();
        }

        private void BindSkills()
        {
            var dt = bll.GetSkills();
            ddlSkills.DataSource = dt;
            ddlSkills.DataTextField = "SkillName";
            ddlSkills.DataValueField = "SkillID";
            ddlSkills.DataBind();
            ddlSkills.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Skill --", "0"));
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlSkills.SelectedValue == "0") { lblStatus.Text = "Please select skill"; return; }

                var ent = new JobRegistrationEntity
                {
                    AadharNo = txtAadhar.Text.Trim(),
                    SkillID = int.Parse(ddlSkills.SelectedValue),
                    FirstName = txtFirstName.Text.Trim(),
                    LastName = txtLastName.Text.Trim(),
                    PhoneNo = txtPhone.Text.Trim(),
                    LoginPassword = txtPassword.Text,
                    Address = txtAddress.Text.Trim(),
                    Consent = true // or from checkbox if present
                };

                int newId = bll.AddJobRegistration(ent);
                if (newId > 0)
                {
                    lblStatus.CssClass = "text-success";
                    lblStatus.Text = "Registered successfully. ID: " + newId;
                    ClearForm();
                }
                else
                {
                    lblStatus.Text = "Error saving record.";
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = ex.Message;
            }
        }

        private void ClearForm()
        {
            txtAadhar.Text = txtFirstName.Text = txtLastName.Text = txtPhone.Text = txtPassword.Text = txtAddress.Text = "";
            ddlSkills.SelectedIndex = 0;
        }
    }

}