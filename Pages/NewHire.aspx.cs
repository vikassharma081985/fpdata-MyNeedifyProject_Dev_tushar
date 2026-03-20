using System;
using System.Data;
using System.Web.UI;
using BLL;

namespace WSBillingMaster.Pages
{
    public partial class NewHire : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindHireDetails();
            }
        }

        private void BindHireDetails()
        {
            if (Request.QueryString["HireId"] != null)
            {
                int hireId = Convert.ToInt32(Request.QueryString["HireId"]);
                using (BusinessLogicLayer objBll = new BusinessLogicLayer())
                {
                    objBll.HireId = hireId;
                    using (DataTable dt = objBll.GetHiringDetailsByHireId())
                    {
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            litCompany.Text = row["CompanyName"] != DBNull.Value ? row["CompanyName"].ToString() : "N/A";
                            litContactPerson.Text = row["ContactPerson"] != DBNull.Value ? row["ContactPerson"].ToString() : "N/A";
                            litPhone.Text = row["ContactPhone"] != DBNull.Value ? row["ContactPhone"].ToString() : "N/A";
                            litRemarks.Text = row["Remarks"] != DBNull.Value ? row["Remarks"].ToString() : "N/A";
                            
                            litDate.Text = row["HireDate"] != DBNull.Value ? Convert.ToDateTime(row["HireDate"]).ToString("dd-MMM-yyyy") : "N/A";
                            litSalary.Text = row["SalaryOffered"] != DBNull.Value ? row["SalaryOffered"].ToString() : "0";
                            litTime.Text = row["TimeSlot"] != DBNull.Value ? row["TimeSlot"].ToString() : "N/A";
                            litStatus.Text = row["Status"] != DBNull.Value ? row["Status"].ToString() : "Pending";
                            
                            if (litStatus.Text.Equals("Accepted", StringComparison.OrdinalIgnoreCase) || 
                                litStatus.Text.Equals("Rejected", StringComparison.OrdinalIgnoreCase))
                            {
                                btnAccept.Visible = false;
                                btnReject.Visible = false;
                            }
                        }
                    }
                }
            }
        }

        protected void btnAccept_Click(object sender, EventArgs e)
        {
            UpdateStatus("Accepted");
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            UpdateStatus("Rejected");
        }

        private void UpdateStatus(string status)
        {
            if (Request.QueryString["HireId"] != null)
            {
                int hireId = Convert.ToInt32(Request.QueryString["HireId"]);
                using (BusinessLogicLayer objBll = new BusinessLogicLayer())
                {
                    objBll.HireId = hireId;
                    objBll.Status = status;
                    objBll.UpdateHireStatus();
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Request has been " + status + " successfully.'); window.location.href='../Front/index.aspx';", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid Request ID.');", true);
            }
        }
    }
}
