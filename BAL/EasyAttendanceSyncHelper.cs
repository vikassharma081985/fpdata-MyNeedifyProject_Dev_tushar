using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;
using DAL;

namespace WSBillingMaster.BAL
{
    public static class EasyAttendanceSyncHelper
    {
        private static string BaseUrl
        {
            get
            {
                var url = ConfigurationManager.AppSettings["EasyAttendanceBaseUrl"] ?? "https://aqua-dunlin-182687.hostingersite.com/api/v1";
                return url.TrimEnd('/');
            }
        }

        private static string InternalSecret
        {
            get
            {
                return ConfigurationManager.AppSettings["EasyAttendanceInternalSecret"] ?? "10e7d80a7182eda5c0107d19bf168c9c57e63c4b39d4b03c5715c94dbdae3baf";
            }
        }

        public static string ProvisionCompany(int sellerId, string sellerName, string brandName, string email, string mobile, string password)
        {
            if (sellerId <= 0) return null;

            try
            {
                string companyName = !string.IsNullOrWhiteSpace(brandName) ? brandName : sellerName;
                if (string.IsNullOrWhiteSpace(companyName)) companyName = "Organization-" + sellerId;

                var payload = new
                {
                    name = companyName,
                    slug = GenerateSlug(companyName, sellerId),
                    ownerName = !string.IsNullOrWhiteSpace(sellerName) ? sellerName : companyName,
                    ownerEmail = !string.IsNullOrWhiteSpace(email) ? email : "seller" + sellerId + "@example.com",
                    ownerPhone = mobile ?? "",
                    initialPassword = !string.IsNullOrWhiteSpace(password) ? password : "Password123",
                    timezone = "Asia/Kolkata"
                };

                var serializer = new JavaScriptSerializer();
                string jsonPayload = serializer.Serialize(payload);

                string responseJson = SendPostRequest(BaseUrl + "/internal/provision-company", jsonPayload);
                if (string.IsNullOrWhiteSpace(responseJson)) return null;

                dynamic result = serializer.Deserialize<dynamic>(responseJson);
                if (result != null && result["success"] == true && result["data"] != null)
                {
                    string companyId = result["data"]["companyId"]?.ToString();
                    if (!string.IsNullOrWhiteSpace(companyId))
                    {
                        SaveCompanyIdToDb(sellerId, companyId);
                        return companyId;
                    }
                }
            }
            catch (Exception ex)
            {
                // Non-blocking: log or ignore
                System.Diagnostics.Trace.WriteLine("EasyAttendance ProvisionCompany failed: " + ex.Message);
            }

            return null;
        }

        public static string ProvisionEmployee(int orgId, long userId, string employeeName, string mobile, string email, string roleId, string rawPassword)
        {
            if (orgId <= 0 || userId <= 0) return null;

            try
            {
                string companyId = GetCompanyIdFromDb(orgId);
                if (string.IsNullOrWhiteSpace(companyId))
                {
                    // Auto-provision company if not yet provisioned
                    companyId = AutoProvisionCompanyFromDb(orgId);
                }

                if (string.IsNullOrWhiteSpace(companyId)) return null;

                string role = "Employee";
                if (roleId == "3") role = "Manager";
                else if (roleId == "2" || roleId == "1") role = "Admin";

                var payload = new
                {
                    companyId = companyId,
                    code = userId.ToString(),
                    name = !string.IsNullOrWhiteSpace(employeeName) ? employeeName : "Employee-" + userId,
                    email = !string.IsNullOrWhiteSpace(email) ? email : "emp" + userId + "@example.com",
                    phone = mobile ?? "",
                    role = role,
                    initialPassword = !string.IsNullOrWhiteSpace(rawPassword) ? rawPassword : "Password123",
                    department = "General"
                };

                var serializer = new JavaScriptSerializer();
                string jsonPayload = serializer.Serialize(payload);

                string responseJson = SendPostRequest(BaseUrl + "/internal/provision-employee", jsonPayload);
                if (string.IsNullOrWhiteSpace(responseJson)) return null;

                dynamic result = serializer.Deserialize<dynamic>(responseJson);
                if (result != null && result["success"] == true && result["data"] != null)
                {
                    string employeeId = result["data"]["employeeId"]?.ToString();
                    if (!string.IsNullOrWhiteSpace(employeeId))
                    {
                        SaveEmployeeIdToDb(userId, employeeId, companyId);
                        return employeeId;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine("EasyAttendance ProvisionEmployee failed: " + ex.Message);
            }

            return null;
        }

        private static string SendPostRequest(string url, string jsonBody)
        {
            try
            {
                var request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "POST";
                request.ContentType = "application/json; charset=utf-8";
                request.Timeout = 10000; // 10 seconds
                request.Headers.Add("X-Internal-Secret", InternalSecret);

                byte[] data = Encoding.UTF8.GetBytes(jsonBody);
                request.ContentLength = data.Length;

                using (var stream = request.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }

                using (var response = (HttpWebResponse)request.GetResponse())
                using (var reader = new StreamReader(response.GetResponseStream()))
                {
                    return reader.ReadToEnd();
                }
            }
            catch (WebException webEx)
            {
                if (webEx.Response != null)
                {
                    using (var reader = new StreamReader(webEx.Response.GetResponseStream()))
                    {
                        string errBody = reader.ReadToEnd();
                        System.Diagnostics.Trace.WriteLine("EasyAttendance API Error: " + errBody);
                    }
                }
                return null;
            }
        }

        private static string GenerateSlug(string name, int id)
        {
            var sb = new StringBuilder();
            foreach (char c in name.ToLowerInvariant())
            {
                if ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9'))
                    sb.Append(c);
                else if (c == ' ' || c == '-' || c == '_')
                    sb.Append('-');
            }
            string clean = sb.ToString().Trim('-');
            if (clean.Length > 60) clean = clean.Substring(0, 60);
            return clean + "-" + id;
        }

        private static string GetCompanyIdFromDb(int orgId)
        {
            using (var dal = new DataAccessLayer())
            using (var cmd = new SqlCommand("SELECT TOP 1 EasyAttendanceCompanyId FROM tblOrganizationMaster WITH (NOLOCK) WHERE SellerId = @SellerId"))
            {
                cmd.Parameters.AddWithValue("@SellerId", orgId);
                var val = dal.ExecuteScalar(cmd);
                return val != null && val != DBNull.Value ? val.ToString() : null;
            }
        }

        private static string AutoProvisionCompanyFromDb(int orgId)
        {
            using (var dal = new DataAccessLayer())
            using (var cmd = new SqlCommand("SELECT TOP 1 SellerId, SellerName, BrandName, EmailId, MobileNumber FROM tblOrganizationMaster WITH (NOLOCK) WHERE SellerId = @SellerId"))
            {
                cmd.Parameters.AddWithValue("@SellerId", orgId);
                using (var dt = dal.GetDataTable(cmd))
                {
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        var row = dt.Rows[0];
                        return ProvisionCompany(
                            orgId,
                            row["SellerName"]?.ToString(),
                            row["BrandName"]?.ToString(),
                            row["EmailId"]?.ToString(),
                            row["MobileNumber"]?.ToString(),
                            "Password123"
                        );
                    }
                }
            }
            return null;
        }

        private static void SaveCompanyIdToDb(int sellerId, string companyId)
        {
            using (var dal = new DataAccessLayer())
            using (var cmd = new SqlCommand("UPDATE tblOrganizationMaster SET EasyAttendanceCompanyId = @CompanyId WHERE SellerId = @SellerId"))
            {
                cmd.Parameters.AddWithValue("@CompanyId", companyId);
                cmd.Parameters.AddWithValue("@SellerId", sellerId);
                dal.ExecuteNonQuery_RetInt(cmd);
            }
        }

        private static void SaveEmployeeIdToDb(long userId, string employeeId, string companyId)
        {
            using (var dal = new DataAccessLayer())
            using (var cmd = new SqlCommand("UPDATE tblUser SET EasyAttendanceUserId = @EmployeeId, EasyAttendanceCompanyId = @CompanyId WHERE UserId = @UserId"))
            {
                cmd.Parameters.AddWithValue("@EmployeeId", employeeId);
                cmd.Parameters.AddWithValue("@CompanyId", companyId ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@UserId", userId);
                dal.ExecuteNonQuery_RetInt(cmd);
            }
        }
    }
}
