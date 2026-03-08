using System;
using System.Web.UI;
using System.Data;
using BLL;

namespace WSBillingMaster.Pages
{
    public partial class Hire : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null || Session["UserId"] == null)
            {
                Response.Redirect("/Front/Index.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["RegId"] != null)
                {
                    int regId = 0;
                    if (int.TryParse(Request.QueryString["RegId"], out regId))
                    {
                        hdnRegId.Value = regId.ToString();
                        LoadCandidateSummary(regId);
                        
                        // Set default joining date to tomorrow
                        txtHireDate.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        ShowError("Invalid Registration ID.");
                    }
                }
                else
                {
                    Response.Redirect("Job.aspx");
                }
            }
        }

        private void LoadCandidateSummary(int regId)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.RegId = regId;
                DataTable dt = objBLL.GetJobRegistrationForHire();
                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    ltCandidateName.Text = dr["FirstName"].ToString() + " " + dr["LastName"].ToString();
                    ltSkill.Text = dr["Skill"].ToString();
                    
                    string expType = dr["ExperienceType"].ToString();
                    if (expType.ToLower() == "fresher")
                    {
                        ltExperience.Text = "Fresher";
                    }
                    else
                    {
                        ltExperience.Text = dr["ExpDuration"].ToString() + " " + dr["ExpUnit"].ToString() + " (" + expType + ")";
                    }

                    ltLocation.Text = dr["CityName"].ToString() + ", " + dr["StateName"].ToString();
                    ltAmount.Text = dr["Amount"] != DBNull.Value ? Convert.ToDecimal(dr["Amount"]).ToString("N2") : "0.00";
                    
                    // Pre-fill salary offered with expected amount
                    txtSalaryOffered.Text = dr["Amount"] != DBNull.Value ? Convert.ToDecimal(dr["Amount"]).ToString("F2") : "";
                }
                else
                {
                    ShowError("Candidate details not found.");
                }
            }
        }

        protected void btnSaveHire_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtCompanyName.Text) || string.IsNullOrEmpty(txtContactPerson.Text) || string.IsNullOrEmpty(txtContactPhone.Text))
                {
                    ShowError("Please fill all mandatory fields.");
                    return;
                }

                using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                {
                    objBLL.RegId = Convert.ToInt32(hdnRegId.Value);
                    objBLL.CompanyName = txtCompanyName.Text.Trim();
                    objBLL.ContactPerson = txtContactPerson.Text.Trim();
                    objBLL.Mobile = txtContactPhone.Text.Trim();
                    objBLL.Amount = string.IsNullOrEmpty(txtSalaryOffered.Text) ? 0 : Convert.ToDecimal(txtSalaryOffered.Text);
                    objBLL.FromDate = txtHireDate.Text; // Reusing FromDate for HireDate
                    objBLL.Remarks = txtRemarks.Text.Trim();
                    objBLL.IntUserId = Convert.ToInt32(Session["UserId"]);

                    int result = objBLL.ManageHireDetail();

                    if (result > 0)
                    {
                        ShowAlert("Hiring confirmed successfully! Hire ID: " + result, "Job.aspx");
                    }
                    else
                    {
                        ShowError("Error confirming hire. Please try again.");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("An error occurred: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            lblStatus.Text = message;
            lblStatus.CssClass = "text-danger mt-2 d-block";
            // Also show a JS alert for better visibility
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message.Replace("'", "\\'") + "');", true);
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
