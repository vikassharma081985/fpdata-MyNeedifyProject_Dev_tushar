using System;
using System.IO;

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
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select Skill --", ""));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Plumber", "Plumber"));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Electrician", "Electrician"));
            ddlSkills.Items.Add(new System.Web.UI.WebControls.ListItem("Carpenter", "Carpenter"));
        }

        private void LoadRegistrationData(int regId)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
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

                string uploadPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(uploadPath))
                    Directory.CreateDirectory(uploadPath);

                SaveFile(fuAadhar, uploadPath);
                SaveFile(fuEducation, uploadPath);

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("RegistrationList.aspx");
    }

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
                return dr[columnName].ToString();
            }
            return "";
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
            ShowAlert(message);
            lblStatus.Text = message;
            lblStatus.CssClass = "text-danger fw-bold";
        }
    }
}