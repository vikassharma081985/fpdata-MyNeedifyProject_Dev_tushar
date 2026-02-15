using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSkills();
                LoadUserData();   // NEW
            }
        }

        private void BindSkills()
        {
            ddlSkills.Items.Clear();
            ddlSkills.Items.Add(new ListItem("-- Select Skill --", ""));
            ddlSkills.Items.Add(new ListItem("Plumber", "1"));
            ddlSkills.Items.Add(new ListItem("Electrician", "2"));
            ddlSkills.Items.Add(new ListItem("Carpenter", "3"));

            // Also bind edit dropdown if exists
            if (ddlEditSkills != null)
            {
                ddlEditSkills.Items.Clear();
                ddlEditSkills.Items.Add(new ListItem("-- Select Skill --", ""));
                ddlEditSkills.Items.Add(new ListItem("Plumber", "1"));
                ddlEditSkills.Items.Add(new ListItem("Electrician", "2"));
                ddlEditSkills.Items.Add(new ListItem("Carpenter", "3"));
            }
        }

        // =========================
        // LOAD USER DATA (DEMO)
        // Replace with DB Fetch
        // =========================
        private void LoadUserData()
        {
            // Example demo data
            txtFirstName.Text = "Rahul";
            txtLastName.Text = "Sharma";
            txtLoginPhone.Text = "9876543210";
            ddlSkills.SelectedValue = "2";

            // Load into edit panel
            if (txtEditFirstName != null)
            {
                txtEditFirstName.Text = txtFirstName.Text;
                txtEditLastName.Text = txtLastName.Text;
                txtEditPhone.Text = txtLoginPhone.Text;
                ddlEditSkills.SelectedValue = ddlSkills.SelectedValue;
            }
        }

        // =========================
        // MAIN SUBMIT (Registration)
        // =========================
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                lblStatus.Text = "";
                lblStatus.CssClass = "fw-bold d-block mb-2";

                // ===== Validation =====
                if (txtAadhar.Text.Trim().Length != 12)
                {
                    ShowError("Enter a valid 12-digit Aadhaar number.");
                    return;
                }

                if (ddlSkills.SelectedValue == "")
                {
                    ShowError("Please select a skill.");
                    return;
                }

                if (txtFirstName.Text.Trim() == "" || txtLastName.Text.Trim() == "")
                {
                    ShowError("Enter First and Last Name.");
                    return;
                }

                if (txtLoginPhone.Text.Trim().Length != 10)
                {
                    ShowError("Enter 10-digit Phone Number.");
                    return;
                }

                if (!fuAadhar.HasFile)
                {
                    ShowError("Please upload Aadhaar document.");
                    return;
                }

                if (!fuEducation.HasFile)
                {
                    ShowError("Please upload Educational Certificate.");
                    return;
                }

                // ===== File Upload =====
                string uploadFolder = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(uploadFolder))
                    Directory.CreateDirectory(uploadFolder);

                string aadharFile = SaveFile(fuAadhar, uploadFolder);
                string photoFile = fuPhoto.HasFile ? SaveFile(fuPhoto, uploadFolder) : "";
                string eduFile = SaveFile(fuEducation, uploadFolder);

                // TODO: Save to Database Here

                lblStatus.Text = "Registration submitted successfully!";
                lblStatus.CssClass = "text-success fw-bold";

                ClearForm();
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        // =========================
        // EDIT PANEL UPDATE
        // =========================
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                // Update main form fields
                txtFirstName.Text = txtEditFirstName.Text;
                txtLastName.Text = txtEditLastName.Text;
                txtLoginPhone.Text = txtEditPhone.Text;
                ddlSkills.SelectedValue = ddlEditSkills.SelectedValue;

                // TODO: Update database here

                lblStatus.Text = "Details updated successfully!";
                lblStatus.CssClass = "text-success fw-bold";
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        private string SaveFile(FileUpload fu, string folder)
        {
            string fileName = DateTime.Now.Ticks + "_" + Path.GetFileName(fu.FileName);
            string fullPath = Path.Combine(folder, fileName);
            fu.SaveAs(fullPath);
            return fileName;
        }

        private void ShowError(string message)
        {
            lblStatus.Text = message;
            lblStatus.CssClass = "text-danger fw-bold";
        }

        private void ClearForm()
        {
            txtAadhar.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtLoginPhone.Text = "";
            ddlSkills.SelectedIndex = 0;
        }
    }
}
