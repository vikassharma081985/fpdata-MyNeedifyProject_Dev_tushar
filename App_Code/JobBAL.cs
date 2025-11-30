using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL;
using WSBillingMaster.DAL;
using BLL;

namespace WSBillingMaster.BAL
{
    public class JobBAL
    {
        private readonly JobDAL dal = new JobDAL();

        public DataTable GetSkills() { return dal.GetSkills(); }

        public int AddJobRegistration(JobRegistrationEntity ent)
        {
            // example business rule: phone required and unique
            if (string.IsNullOrWhiteSpace(ent.PhoneNo))
                throw new ArgumentException("Phone number required.");

            // Could add uniqueness check here via DAL if desired

            // Hash password if provided (simple SHA256 shown earlier)
            if (!string.IsNullOrEmpty(ent.LoginPassword))
            {
                //ent.LoginPassword = HashHelper.ComputeSha256Hash(ent.LoginPassword);
            }

            return dal.InsertJobRegistration(ent);
        }

        /*public DataTable SearchJobs(int? skillId, string keyword) => dal.SearchJobRegistrations(skillId, keyword);

        public DataTable GetUserImages(int userId, DateTime? from, DateTime? to) => dal.GetUserImages(userId, from, to);

        public DataTable GetUserDetails(int userId) => dal.GetUserDetails(userId);*/
    }
}
