using System;
using System.IO;

namespace WSBillingMaster.Pages
{
    public partial class Registrationtusharmain : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSkills();
            }
        }

        private void BindSkills()
        {
            ddlSkills.Items.Clear();
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select Skill --", ""));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Plumber", "Plumber"));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Electrician", "Electrician"));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Carpenter", "Carpenter"));
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtAadhar.Text) || txtAadhar.Text.Trim().Length != 12)
                {
                    ShowError("Enter valid 12-digit Aadhaar.");
                    return;
                }

                if (!fuAadhar.HasFile || !fuEducation.HasFile)
                {
                    ShowError("Upload required documents.");
                    return;
                }

                string uploadPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(uploadPath))
                    Directory.CreateDirectory(uploadPath);

                SaveFile(fuAadhar, uploadPath);
                SaveFile(fuEducation, uploadPath);

                lblStatus.Text = "Registration submitted successfully!";
                lblStatus.CssClass = "text-success fw-bold";

                lblViewAadhar.Text = txtAadhar.Text;
                lblViewName.Text = txtFirstName.Text + " " + txtLastName.Text;
                lblViewPhone.Text = txtLoginPhone.Text;
                lblViewGender.Text = ddlGender.SelectedValue;
                lblViewBirthPlace.Text = txtBirthPlace.Text;
                lblViewMarital.Text = ddlMarital.SelectedValue;
                lblViewHeight.Text = txtHeight.Text + " cm";
                lblViewWeight.Text = txtWeight.Text + " kg";
                lblViewEmergencyPhone.Text = txtEmergencyPhone.Text;

                pnlMyDetails.Visible = true;
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        protected void btnEditDetails_Click(object sender, EventArgs e)
        {
            txtAadhar.Text = lblViewAadhar.Text;

            string[] nameParts = lblViewName.Text.Split(' ');
            if (nameParts.Length > 0) txtFirstName.Text = nameParts[0];
            if (nameParts.Length > 1) txtLastName.Text = nameParts[1];

            txtLoginPhone.Text = lblViewPhone.Text;
            ddlGender.SelectedValue = lblViewGender.Text;
            txtBirthPlace.Text = lblViewBirthPlace.Text;
            ddlMarital.SelectedValue = lblViewMarital.Text;

            txtHeight.Text = lblViewHeight.Text.Replace(" cm", "");
            txtWeight.Text = lblViewWeight.Text.Replace(" kg", "");
            txtEmergencyPhone.Text = lblViewEmergencyPhone.Text;

            pnlMyDetails.Visible = false;
        }

        private void SaveFile(System.Web.UI.WebControls.FileUpload fu, string folder)
        {
            string fileName = DateTime.Now.Ticks + "_" + Path.GetFileName(fu.FileName);
            fu.SaveAs(Path.Combine(folder, fileName));
        }

        private void ShowError(string message)
        {
            lblStatus.Text = message;
            lblStatus.CssClass = "text-danger fw-bold";
        }
    }
}