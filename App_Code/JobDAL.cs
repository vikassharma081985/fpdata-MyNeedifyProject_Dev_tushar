using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BLL;

namespace WSBillingMaster.DAL
{
    public class JobDAL
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["WsBilling"].ConnectionString;

        public DataTable GetSkills()
        {
            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("USP_GetSkills", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        public int InsertJobRegistration(JobRegistrationEntity ent)
        {
            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("USP_InsertJobRegistration", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@AadharNo", (object)ent.AadharNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@AadharFilePath", (object)ent.AadharFilePath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@SkillID", ent.SkillID);
                cmd.Parameters.AddWithValue("@FirstName", ent.FirstName);
                cmd.Parameters.AddWithValue("@LastName", (object)ent.LastName ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@FatherName", (object)ent.FatherName ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Gender", (object)ent.Gender ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@BirthPlace", (object)ent.BirthPlace ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MaritalStatus", (object)ent.MaritalStatus ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhotoPath", (object)ent.PhotoPath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Address", (object)ent.Address ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Height", (object)ent.Height ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Weight", (object)ent.Weight ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@EmergencyContactNo", (object)ent.EmergencyContactNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@EmergencyContactName", (object)ent.EmergencyContactName ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@EmergencyRelationship", (object)ent.EmergencyRelationship ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@LanguagesKnown", (object)ent.LanguagesKnown ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@ExperienceDescription", (object)ent.ExperienceDescription ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@EducationDocPath", (object)ent.EducationDocPath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@BankAccountNo", (object)ent.BankAccountNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@IFSCCode", (object)ent.IFSCCode ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@BankName", (object)ent.BankName ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhoneNo", ent.PhoneNo);
                cmd.Parameters.AddWithValue("@LoginType", (object)ent.LoginType ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@LoginPassword", (object)ent.LoginPassword ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@ExpectedDemandType", (object)ent.ExpectedDemandType ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Consent", ent.Consent);

                con.Open();
                try
                {
                    object o = cmd.ExecuteScalar(); // returns NewJobRegID
                    return Convert.ToInt32(o.ToString());

                }
                catch(Exception ex)
                {
                    Console.Write(ex);
                    return 0;
                }


                con.Close();
                //(o != null && int.TryParse(o.ToString(), out int id)) ? id : 0;
            }
        }

        public DataTable SearchJobRegistrations(int? skillID, string keyword)
        {
            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("USP_SearchJobRegistrations", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SkillID", skillID.HasValue ? (object)skillID.Value : DBNull.Value);
                cmd.Parameters.AddWithValue("@Keyword", string.IsNullOrWhiteSpace(keyword) ? (object)DBNull.Value : keyword);
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        public DataTable GetUserImages(int userId, DateTime? from, DateTime? to)
        {
            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("USP_GetUserImages", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@FromDate", from.HasValue ? (object)from.Value : DBNull.Value);
                cmd.Parameters.AddWithValue("@ToDate", to.HasValue ? (object)to.Value : DBNull.Value);
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        public DataTable GetUserDetails(int userId)
        {
            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("USP_GetUserDetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", userId);
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }
    }
}
