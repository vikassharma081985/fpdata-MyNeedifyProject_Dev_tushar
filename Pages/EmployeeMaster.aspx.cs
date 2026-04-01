using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using DAL;

namespace WSBillingMaster.Pages
{
    public partial class EmployeeMaster : System.Web.UI.Page
    {
        private static int OrgId = 0;
        private static int EmployeeId = 0;
        protected string EmployeeListHtml = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["OrgId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                OrgId = Convert.ToInt32(Session["OrgId"]);
                EmployeeId = Convert.ToInt32(Session["EmployeeId"]);
            }
            BindRole();
            BindEmployeeList();
        }

        private void BindRole()
        {
            using (DataAccessLayer objDAL = new DataAccessLayer())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT RoleId,Role FROM tblROle";

                using (DataTable dt = objDAL.GetDataTable(cmd))
                {
                    ddlRole.DataSource = dt;
                    ddlRole.DataTextField = "Role";
                    ddlRole.DataValueField = "RoleId";
                    ddlRole.DataBind();
                    ddlRole.Items.Insert(0, new ListItem("--Select--", "0"));
                }
            }
        }

        private void BindEmployeeList()
        {
            using (BusinessLogicLayer objBal = new BusinessLogicLayer())
            {
                DataTable dt = objBal.GetEmployeeByOrgId(OrgId);
                if (dt != null && dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    foreach (DataRow dr in dt.Rows)
                    {
                        sb.Append("<tr>");
                        sb.Append("<td>" + dr["EmployeeName"].ToString() + "</td>");
                        sb.Append("<td>" + dr["Mobile"].ToString() + "</td>");
                        sb.Append("<td>" + dr["UserName"].ToString() + "</td>");
                        sb.Append("<td>" + dr["Role"].ToString() + "</td>");
                        sb.Append("<td>" + dr["Password"].ToString() + "</td>");
                        sb.Append("</tr>");
                    }
                    EmployeeListHtml = sb.ToString();
                }
            }
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Save(string Name, string Mobile, string Email, string RoleID, string Password)
        {

            try
            {
                string passEncryp = PasswordHelper.HashPasswordSHA256(Password);
                StringBuilder sb = new StringBuilder();
                DataAccessLayer objDAL = new DataAccessLayer();

                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SaveEmployee";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@EmployeeName", Name);
                    sqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    sqlCommand.Parameters.AddWithValue("@Email", Email);
                    sqlCommand.Parameters.AddWithValue("@Password", passEncryp);
                    sqlCommand.Parameters.AddWithValue("@RoleId", RoleID);
                    sqlCommand.Parameters.AddWithValue("@AddedBy", EmployeeId);
                    sqlCommand.Parameters.AddWithValue("@OrgId", OrgId);

                    if (objDAL.ExecuteNonQuery_RetInt(sqlCommand) > 0)
                    {
                        return "1";
                    }
                    else
                    {
                        return "1";
                    }
                }
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }

    }
}