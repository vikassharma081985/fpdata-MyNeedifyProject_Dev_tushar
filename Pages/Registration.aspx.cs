//using System;
//using System.Data;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using WSBillingMaster.BAL;
//using BLL;

//namespace WSBillingMaster.Pages
//{

//    public partial class Registration : System.Web.UI.Page
//    {
//        JobBAL bll = new JobBAL();

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//                BindSkills();
//        }

//        private void BindSkills()
//        {
//            var dt = bll.GetSkills();
//            ddlSkills.DataSource = dt;
//            ddlSkills.DataTextField = "SkillName";
//            ddlSkills.DataValueField = "SkillID";
//            ddlSkills.DataBind();
//            ddlSkills.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Skill --", "0"));
//        }

//        protected void btnSubmit_Click(object sender, EventArgs e)
//        {
//            try
//            {
//                if (ddlSkills.SelectedValue == "0") { lblStatus.Text = "Please select skill"; return; }

//                var ent = new JobRegistrationEntity
//                {
//                    AadharNo = txtAadhar.Text.Trim(),
//                    SkillID = int.Parse(ddlSkills.SelectedValue),
//                    FirstName = txtFirstName.Text.Trim(),
//                    LastName = txtLastName.Text.Trim(),
//                    PhoneNo = txtPhone.Text.Trim(),
//                    LoginPassword = txtPassword.Text,
//                    Address = txtAddress.Text.Trim(),
//                    Consent = true // or from checkbox if present
//                };

//                int newId = bll.AddJobRegistration(ent);
//                if (newId > 0)
//                {
//                    lblStatus.CssClass = "text-success";
//                    lblStatus.Text = "Registered successfully. ID: " + newId;
//                    ClearForm();
//                }
//                else
//                {
//                    lblStatus.Text = "Error saving record.";
//                }
//            }
//            catch (Exception ex)
//            {
//                lblStatus.Text = ex.Message;
//            }
//        }

//        private void ClearForm()
//        {
//            txtAadhar.Text = txtFirstName.Text = txtLastName.Text = txtPhone.Text = txtPassword.Text = txtAddress.Text = "";
//            ddlSkills.SelectedIndex = 0;
//        }
//    }

//}




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
            }
        }

        private void BindSkills()
        {
            // Example: Replace this with actual DB call
            ddlSkills.Items.Clear();
            ddlSkills.Items.Add(new ListItem("-- Select Skill --", ""));
            ddlSkills.Items.Add(new ListItem("Plumber", "1"));
            ddlSkills.Items.Add(new ListItem("Electrician", "2"));
            ddlSkills.Items.Add(new ListItem("Carpenter", "3"));
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                lblStatus.Text = "";
                lblStatus.CssClass = "fw-bold d-block mb-2";

                // ===== Server-side Validation =====
                if (txtAadhar == null || txtFirstName == null || txtLoginPhone == null)
                {
                    ShowError("Form controls not loaded correctly.");
                    return;
                }

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

                // ===== File Upload Handling =====
                string uploadFolder = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(uploadFolder))
                    Directory.CreateDirectory(uploadFolder);

                string aadharFile = SaveFile(fuAadhar, uploadFolder);
                string photoFile = fuPhoto.HasFile ? SaveFile(fuPhoto, uploadFolder) : "";
                string eduFile = SaveFile(fuEducation, uploadFolder);

                // ===== Save Registration Data =====
                // Example: Here you can call your BLL/DB to save data
                // For now, just show success

                lblStatus.Text = "Registration submitted successfully!";
                lblStatus.CssClass = "text-success fw-bold";

                ClearForm();
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        private string SaveFile(FileUpload fu, string folder)
        {
            string fileName = DateTime.Now.Ticks + "_" + fu.FileName;
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
            //txtAadhar.Text =
            //txtFirstName.Text =
            //txtLastName.Text =
            //txtFatherName.Text =
            //txtBirthPlace.Text =
            //txtAddress.Text =
            //txtHeight.Text =
            //txtWeight.Text =
            //txtEmergencyPhone.Text =
            //txtEmergencyName.Text =
            //txtEmergencyRelation.Text =
            //txtLanguages.Text =
            ////txtExperience.Text =
            //txtAccountNumber.Text =
            //txtIFSC.Text =
            //txtBankName.Text =
            //txtLoginPhone.Text =
            //txtPassword.Text = "";

            //ddlSkills.SelectedIndex = 0;
            //ddlGender.SelectedIndex = 0;
            //ddlMarital.SelectedIndex = 0;
            //ddlDemand.SelectedIndex = 0;

            //rbOTP.Checked = true;
            //rbPassword.Checked = false;
        }
    }
}
