using System;
using System.IO;
using System.Data;
using BLL;
using System.Web;

namespace WSBillingMaster.Pages
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null || Session["UserId"] == null)
            {
                Session.Clear();
                Session.Abandon();

                Response.Clear();
                Response.Write(@"
                    <script type='text/javascript'>
                        alert('Please login first to use this tool.');
                        window.location.href='/Front/Index.aspx';
                    </script>
                ");

                HttpContext.Current.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                string userName = Session["UserName"].ToString();
                string userId = Session["UserId"].ToString();
                hdnUserId.Value = userId;

                BindSkills();
                if (Request.QueryString["RegId"] != null)
                {
                    int regId = 0;
                    if (int.TryParse(Request.QueryString["RegId"], out regId))
                    {
                        LoadRegistrationData(regId);
                    }
                }
            }
        }

        private void BindSkills()
        {
            ddlSkills.Items.Clear();
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Select your skill", ""));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Plumber", "Plumber"));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Electrician", "Electrician"));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Carpenter", "Carpenter"));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Painter", "Painter"));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Mason", "Mason"));
        }

        private void LoadRegistrationData(int regId)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.RegId = regId;
                DataTable dt = objBLL.GetRegistrationById();
                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    txtAadhar.Text = GetSafeString(dr, "AadharNumber");
                    SafeSetSelectedValue(ddlSkills, GetSafeString(dr, "Skill"));
                    txtFirstName.Text = GetSafeString(dr, "FirstName");
                    txtLastName.Text = GetSafeString(dr, "LastName");
                    txtFatherName.Text = GetSafeString(dr, "FatherName");
                    txtLoginPhone.Text = GetSafeString(dr, "PhoneNumber");
                    SafeSetSelectedValue(ddlGender, GetSafeString(dr, "Gender"));
                    txtBirthPlace.Text = GetSafeString(dr, "BirthPlace");
                    txtAge.Text = GetSafeString(dr, "Age");
                    SafeSetSelectedValue(ddlExperienceType, GetSafeString(dr, "ExperienceType"));
                    txtExpDuration.Text = GetSafeString(dr, "ExpDuration");
                    SafeSetSelectedValue(ddlExpUnit, GetSafeString(dr, "ExpUnit"));
                    txtAmount.Text = GetSafeString(dr, "Amount");

                    txtHeight.Text = GetSafeString(dr, "Height");
                    txtWeight.Text = GetSafeString(dr, "Weight");
                    txtLanguages.Text = GetSafeString(dr, "Languages");
                    SafeSetSelectedValue(ddlMarital, GetSafeString(dr, "MaritalStatus"));
                    SafeSetSelectedValue(ddlDemand, GetSafeString(dr, "ExpectedDemand"));

                    txtFullAddress.Text = GetSafeString(dr, "FullAddress");
                    txtState.Text = GetSafeString(dr, "StateName");
                    txtCity.Text = GetSafeString(dr, "CityName");
                    txtLocation.Text = GetSafeString(dr, "LocationName");
                    txtLandmark.Text = GetSafeString(dr, "Landmark");
                    txtPincode.Text = GetSafeString(dr, "Pincode");

                    txtEmergencyPhone.Text = GetSafeString(dr, "EmergencyPhone");
                    txtEmergencyName.Text = GetSafeString(dr, "EmergencyName");
                    txtEmergencyRelation.Text = GetSafeString(dr, "EmergencyRelation");

                    txtSchoolUniversity.Text = GetSafeString(dr, "SchoolUniversity");
                    SafeSetSelectedValue(ddlQualification, GetSafeString(dr, "Qualification"));

                    txtAccountNumber.Text = GetSafeString(dr, "AccountNumber");
                    txtIFSC.Text = GetSafeString(dr, "IFSC");
                    txtBankName.Text = GetSafeString(dr, "BankName");

                    // Show file links and remove buttons
                    string resPath = GetSafeString(dr, "ResumePath");
                    string aadPath = GetSafeString(dr, "AadharPath");
                    string phoPath = GetSafeString(dr, "PhotoPath");
                    string eduPath = GetSafeString(dr, "EducationPath");

                    SetFileUI(resPath, hlResume, btnRemoveResume);
                    SetFileUI(aadPath, hlAadhar, btnRemoveAadhar);
                    SetFileUI(phoPath, hlPhoto, btnRemovePhoto);
                    SetFileUI(eduPath, hlEducation, btnRemoveEducation);

                    ViewState["OldResumePath"] = resPath;
                    ViewState["OldAadharPath"] = aadPath;
                    ViewState["OldPhotoPath"] = phoPath;
                    ViewState["OldEducationPath"] = eduPath;

                    btnSubmit.Text = "Update Registration";
                    ViewState["RegId"] = regId;
                }
            }
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

                string resumePath = "", aadharPath = "", photoPath = "", educationPath = "";

                if (fuResume.HasFile) resumePath = SaveFile(fuResume, "~/Uploads/Resumes/");
                if (fuAadhar.HasFile) aadharPath = SaveFile(fuAadhar, "~/Uploads/Aadhar/");
                if (fuPhoto.HasFile) photoPath = SaveFile(fuPhoto, "~/Uploads/Photos/");
                if (fuEducation.HasFile) educationPath = SaveFile(fuEducation, "~/Uploads/Education/");

                if (ViewState["RegId"] == null && !fuResume.HasFile)
                {
                    ShowError("Please upload your resume.");
                    return;
                }

                if (!chkConsent.Checked)
                {
                    ShowError("Please give your consent to submit.");
                    return;
                }

                using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                {
                    objBLL.RegId = ViewState["RegId"] != null ? Convert.ToInt32(ViewState["RegId"]) : 0;
                    objBLL.AadharNumber = txtAadhar.Text.Trim();
                    objBLL.Skill = ddlSkills.SelectedValue;
                    objBLL.FirstName = txtFirstName.Text.Trim();
                    objBLL.LastName = txtLastName.Text.Trim();
                    objBLL.FatherName = txtFatherName.Text.Trim();
                    objBLL.Mobile = txtLoginPhone.Text.Trim();
                    objBLL.Gender = ddlGender.SelectedValue;
                    objBLL.BirthPlace = txtBirthPlace.Text.Trim();
                    objBLL.Age = txtAge.Text.Trim();
                    objBLL.ExperienceType = ddlExperienceType.SelectedValue;
                    objBLL.ExpDuration = txtExpDuration.Text.Trim();
                    objBLL.ExpUnit = ddlExpUnit.SelectedValue;
                    objBLL.Amount = string.IsNullOrEmpty(txtAmount.Text) ? 0 : Convert.ToDecimal(txtAmount.Text);

                    objBLL.Height = txtHeight.Text.Trim();
                    objBLL.Weight = txtWeight.Text.Trim();
                    objBLL.Languages = txtLanguages.Text.Trim();
                    objBLL.MaritalStatus = ddlMarital.SelectedValue;
                    objBLL.ExpectedDemand = ddlDemand.SelectedValue;

                    objBLL.FullAddress = txtFullAddress.Text.Trim();
                    objBLL.StateName = txtState.Text.Trim();
                    objBLL.CityName = txtCity.Text.Trim();
                    objBLL.LocationName = txtLocation.Text.Trim();
                    objBLL.Landmark = txtLandmark.Text.Trim();
                    objBLL.PincodeVal = txtPincode.Text.Trim();

                    objBLL.EmergencyPhone = txtEmergencyPhone.Text.Trim();
                    objBLL.EmergencyName = txtEmergencyName.Text.Trim();
                    objBLL.EmergencyRelation = txtEmergencyRelation.Text.Trim();

                    objBLL.SchoolUniversity = txtSchoolUniversity.Text.Trim();
                    objBLL.Qualification = ddlQualification.SelectedValue;

                    objBLL.AccountNumber = txtAccountNumber.Text.Trim();
                    objBLL.IFSC = txtIFSC.Text.Trim();
                    objBLL.BankName = txtBankName.Text.Trim();

                    if (fuResume.HasFile) objBLL.ResumePath = resumePath;
                    else if (ViewState["RegId"] != null)
                    {
                        if (hlResume.Visible) objBLL.ResumePath = ViewState["OldResumePath"]?.ToString() ?? "";
                        else objBLL.ResumePath = "";
                    }

                    if (fuAadhar.HasFile) objBLL.AadharPath = aadharPath;
                    else if (ViewState["RegId"] != null)
                    {
                        if (hlAadhar.Visible) objBLL.AadharPath = ViewState["OldAadharPath"]?.ToString() ?? "";
                        else objBLL.AadharPath = "";
                    }

                    if (fuPhoto.HasFile) objBLL.PhotoPath = photoPath;
                    else if (ViewState["RegId"] != null)
                    {
                        if (hlPhoto.Visible) objBLL.PhotoPath = ViewState["OldPhotoPath"]?.ToString() ?? "";
                        else objBLL.PhotoPath = "";
                    }

                    if (fuEducation.HasFile) objBLL.EducationPath = educationPath;
                    else if (ViewState["RegId"] != null)
                    {
                        if (hlEducation.Visible) objBLL.EducationPath = ViewState["OldEducationPath"]?.ToString() ?? "";
                        else objBLL.EducationPath = "";
                    }

                    objBLL.IntUserId = !string.IsNullOrEmpty(hdnUserId.Value) ? Convert.ToInt32(hdnUserId.Value) : 0;

                    int result = objBLL.ManageRegistration();

                if (result > 0)
                {
                    string msg = ViewState["RegId"] == null ? "Registration submitted successfully! Your Job Registration ID is: " + result : "Registration updated successfully!";
                    ShowAlert(msg, "RegistrationList.aspx");
                    ClearForm();
                }
                    else if (result == -1)
                    {
                        ShowError("Aadhar Number already exists!");
                    }
                    else
                    {
                        ShowError("Error saving registration.");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

    private void ClearForm()
    {
        txtAadhar.Text = "";
        txtFirstName.Text = "";
        txtLastName.Text = "";
        txtFatherName.Text = "";
        txtLoginPhone.Text = "";
        txtBirthPlace.Text = "";
        txtAge.Text = "";
        txtExpDuration.Text = "";
        txtAmount.Text = "";
        txtHeight.Text = "";
        txtWeight.Text = "";
        txtLanguages.Text = "";
        txtFullAddress.Text = "";
        txtState.Text = "";
        txtCity.Text = "";
        txtLocation.Text = "";
        txtLandmark.Text = "";
        txtPincode.Text = "";
        txtEmergencyPhone.Text = "";
        txtEmergencyName.Text = "";
        txtEmergencyRelation.Text = "";
        txtSchoolUniversity.Text = "";
        txtAccountNumber.Text = "";
        txtIFSC.Text = "";
        txtBankName.Text = "";
        ddlSkills.SelectedIndex = 0;
        ddlGender.SelectedIndex = 0;
        ddlMarital.SelectedIndex = 0;
        ddlDemand.SelectedIndex = 0;
        ddlExperienceType.SelectedIndex = 0;
        ddlQualification.SelectedIndex = 0;
        ddlExpUnit.SelectedIndex = 0;
        chkConsent.Checked = false;

        hlResume.Visible = hlAadhar.Visible = hlPhoto.Visible = hlEducation.Visible = false;
        btnRemoveResume.Visible = btnRemoveAadhar.Visible = btnRemovePhoto.Visible = btnRemoveEducation.Visible = false;

        btnSubmit.Text = "Submit Registration";
        ViewState["RegId"] = null;
        ViewState["OldResumePath"] = null;
        ViewState["OldAadharPath"] = null;
        ViewState["OldPhotoPath"] = null;
        ViewState["OldEducationPath"] = null;
    }

    private void SetFileUI(string path, System.Web.UI.WebControls.HyperLink hl, System.Web.UI.WebControls.LinkButton btn)
    {
        if (!string.IsNullOrEmpty(path))
        {
            hl.NavigateUrl = ResolveUrl(path);
            hl.Visible = true;
            btn.Visible = true;
        }
        else
        {
            hl.Visible = false;
            btn.Visible = false;
        }
    }

    protected void btnRemoveFile_Click(object sender, EventArgs e)
    {
        if (ViewState["RegId"] != null)
        {
            string column = ((System.Web.UI.WebControls.LinkButton)sender).CommandArgument;
            int regId = Convert.ToInt32(ViewState["RegId"]);

            // This is a simple logic to clear path in DB via a potential BLL method or direct execution
            // For now, we update the UI and we will update DB during next save/update
            ((System.Web.UI.WebControls.LinkButton)sender).Visible = false;
            if (column == "ResumePath") hlResume.Visible = false;
            if (column == "AadharPath") hlAadhar.Visible = false;
            if (column == "PhotoPath") hlPhoto.Visible = false;
            if (column == "EducationPath") hlEducation.Visible = false;

            lblStatus.Text = "File marked for removal. Please click update to confirm.";
            lblStatus.CssClass = "text-warning fw-bold";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("RegistrationList.aspx");
    }

        private string SaveFile(System.Web.UI.WebControls.FileUpload fu, string virtualFolder)
        {
            string physicalPath = Server.MapPath(virtualFolder);
            if (!Directory.Exists(physicalPath))
                Directory.CreateDirectory(physicalPath);

            string fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + "_" + Path.GetFileName(fu.FileName);
            string fullPath = Path.Combine(physicalPath, fileName);
            fu.SaveAs(fullPath);
            return virtualFolder + fileName;
        }

        private string GetSafeString(DataRow dr, string columnName)
        {
            if (dr.Table.Columns.Contains(columnName) && dr[columnName] != DBNull.Value)
            {
                return dr[columnName].ToString();
            }
            return "";
        }

        private void SafeSetSelectedValue(System.Web.UI.WebControls.DropDownList ddl, string value)
        {
            if (ddl.Items.FindByValue(value) != null)
            {
                ddl.SelectedValue = value;
            }
            else
            {
                ddl.SelectedIndex = 0;
            }
        }

        private void ShowError(string message)
        {
            ShowAlert(message);
            lblStatus.Text = message;
            lblStatus.CssClass = "text-danger fw-bold";
        }

        private void ShowAlert(string message, string redirectTo = null)
        {
            string script = "alert('" + message.Replace("'", "\\'") + "');";
            if (!string.IsNullOrEmpty(redirectTo))
            {
                script += "window.location.href='" + redirectTo + "';";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }
    }
}
