using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;

namespace WSBillingMaster.Pages
{
    public partial class EmployeeMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindRole();
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


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Save(string Name, string Mobile, string Email, string RoleID, string Password)
        {

            try
            {
                StringBuilder sb = new StringBuilder();
                DataAccessLayer objDAL = new DataAccessLayer();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT COUNT(1) FROM tbllogin WHERE UserName ='" + Email + "'";
               
                int IsExists = Convert.ToInt32(objDAL.GetDataTable(cmd).Rows[0][0]);
                if (IsExists > 0)
                {
                    return "-1";
                }


                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    sqlCommand.CommandText = "Proc_SaveEmployee";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = 100;
                    sqlCommand.Parameters.AddWithValue("@EmployeeName", Name);
                    sqlCommand.Parameters.AddWithValue("@Mobile", Mobile);
                    sqlCommand.Parameters.AddWithValue("@Email", Email);
                    sqlCommand.Parameters.AddWithValue("@Password", Password);
                    sqlCommand.Parameters.AddWithValue("@RoleId", RoleID);

                    if (objDAL.ExecuteNonQuery_RetInt(sqlCommand) > 0)
                    {
                        return "1";
                    }
                    else {
                        return "0";
                    
                    }

                }
               
            }
            catch
            {
                return "0";
            }

        }

    }
}