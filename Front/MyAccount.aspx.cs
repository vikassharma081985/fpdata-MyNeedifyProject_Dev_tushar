using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FaduPrice.Pages
{
    public partial class MyAccount : System.Web.UI.Page
    {
        static string userId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Session["UserId"] = "1";
                if (Session["UserId"] != null)
                {
                    BindData();
                    hdnUserId.Value = Session["UserId"].ToString();
                    userId = hdnUserId.Value;
                }
                else
                {
                    Response.Redirect("https://myneedify.com//Front/Index.aspx");
                }
            }
        }

        private void BindData()
        {
            int tabIndex = -1;
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.UserId = Session["UserId"].ToString();

                using (DataSet dsMain = objFp.GetMyAccountData())
                {
                    tabIndex++;
                    using (DataTable dt = dsMain.Tables[tabIndex])
                    {
                        if (dt.Rows.Count > 0)
                        {
                            txtFirstName.Text = dt.Rows[0]["FirstName"].ToString();
                            txtLastName.Text = dt.Rows[0]["LastName"].ToString();
                            txtMobile.Text = dt.Rows[0]["Mobile"].ToString();
                            txtEmail.Text = dt.Rows[0]["Email"].ToString();
                            hdnPassword.Value = dt.Rows[0]["Password"].ToString();
                            lblUserName.Text = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
                            lblEmail.Text = dt.Rows[0]["Email"].ToString();

                            // Load Signature (from Proc_GetMyAccountData or fallback to Proc_GetUserSignature)
                            string userSignature = string.Empty;
                            if (dt.Columns.Contains("Signature") && dt.Rows[0]["Signature"] != DBNull.Value)
                            {
                                userSignature = dt.Rows[0]["Signature"].ToString().Trim();
                            }

                            if (string.IsNullOrEmpty(userSignature))
                            {
                                try
                                {
                                    using (DataTable dtSig = objFp.GetUserSignature())
                                    {
                                        if (dtSig != null && dtSig.Rows.Count > 0 && dtSig.Columns.Contains("Signature") && dtSig.Rows[0]["Signature"] != DBNull.Value)
                                        {
                                            userSignature = dtSig.Rows[0]["Signature"].ToString().Trim();
                                        }
                                    }
                                }
                                catch
                                {
                                    // In case Proc_GetUserSignature is not yet created in DB
                                }
                            }

                            if (!string.IsNullOrEmpty(userSignature))
                            {
                                imgCurrentSignature.ImageUrl = "~/Uploads/Signatures/" + userSignature;
                                hdnSignature.Value = userSignature;
                                divViewSignature.Style["display"] = "block";
                                divUploadSignature.Style["display"] = "none";
                            }
                            else
                            {
                                imgCurrentSignature.ImageUrl = string.Empty;
                                hdnSignature.Value = string.Empty;
                                divViewSignature.Style["display"] = "none";
                                divUploadSignature.Style["display"] = "block";
                            }
                        }

                    }

                    tabIndex++;
                    //commentedby Raju 
                    using (DataTable dt = dsMain.Tables[tabIndex])
                    {
                        if (dt.Rows.Count > 0)
                        {
                            rptUserAddresss.DataSource = dt;
                            rptUserAddresss.DataBind();
                        }
                    }
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string UpdateUserData(string FirstName,string LastName,string Mobile,string Email,string UserId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = userId;
                obj.FirstName = FirstName;
                obj.LastName = LastName;
                obj.Email = Email;
                obj.Mobile = Mobile;
                int rowsEffected = obj.UpdateUserData();
                return rowsEffected.ToString();
            }
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string ChangePassword(string Password, string UserId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = UserId;
                obj.Password = Password;
                int rowsEffected = obj.ChangePassword();
                return rowsEffected.ToString();
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object UploadSignature(string base64Image, string fileName, string userId)
        {
            try
            {
                if (string.IsNullOrEmpty(base64Image))
                {
                    return new { success = false, message = "Please select an image file to upload." };
                }

                string currentUserId = !string.IsNullOrEmpty(userId) && userId != "0" ? userId : MyAccount.userId;
                if (string.IsNullOrEmpty(currentUserId) || currentUserId == "0")
                {
                    if (HttpContext.Current.Session != null && HttpContext.Current.Session["UserId"] != null)
                    {
                        currentUserId = HttpContext.Current.Session["UserId"].ToString();
                    }
                }

                if (string.IsNullOrEmpty(currentUserId) || currentUserId == "0")
                {
                    return new { success = false, message = "User session expired. Please log in again." };
                }

                string extension = ".png";
                string rawBase64 = base64Image;

                if (rawBase64.Contains(","))
                {
                    string header = rawBase64.Substring(0, rawBase64.IndexOf(","));
                    rawBase64 = rawBase64.Substring(rawBase64.IndexOf(",") + 1);

                    if (header.IndexOf("jpeg", StringComparison.OrdinalIgnoreCase) >= 0 ||
                        header.IndexOf("jpg", StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        extension = ".jpg";
                    }
                    else if (header.IndexOf("png", StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        extension = ".png";
                    }
                }
                else if (!string.IsNullOrEmpty(fileName))
                {
                    string ext = Path.GetExtension(fileName).ToLower();
                    if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
                    {
                        extension = ext;
                    }
                }

                byte[] imageBytes = Convert.FromBase64String(rawBase64);

                string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/Signatures/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string newFileName = "SIGN_" + Guid.NewGuid().ToString() + extension;
                string fullPath = Path.Combine(folderPath, newFileName);
                File.WriteAllBytes(fullPath, imageBytes);

                // Update database
                using (BusinessLogicLayer obj = new BusinessLogicLayer())
                {
                    obj.UserId = currentUserId;
                    obj.Signature = newFileName;
                    obj.UpdateUserSignature();
                }

                return new
                {
                    success = true,
                    message = "Signature uploaded successfully!",
                    fileName = newFileName,
                    imageUrl = "../Uploads/Signatures/" + newFileName
                };
            }
            catch (Exception ex)
            {
                return new
                {
                    success = false,
                    message = "Error uploading signature: " + ex.Message
                };
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object RemoveSignature(string userId)
        {
            try
            {
                string currentUserId = !string.IsNullOrEmpty(userId) && userId != "0" ? userId : MyAccount.userId;
                if (string.IsNullOrEmpty(currentUserId) || currentUserId == "0")
                {
                    if (HttpContext.Current.Session != null && HttpContext.Current.Session["UserId"] != null)
                    {
                        currentUserId = HttpContext.Current.Session["UserId"].ToString();
                    }
                }

                if (string.IsNullOrEmpty(currentUserId) || currentUserId == "0")
                {
                    return new { success = false, message = "User session expired. Please log in again." };
                }

                using (BusinessLogicLayer obj = new BusinessLogicLayer())
                {
                    obj.UserId = currentUserId;
                    obj.Signature = null;
                    obj.UpdateUserSignature();
                }

                return new
                {
                    success = true,
                    message = "Signature removed successfully."
                };
            }
            catch (Exception ex)
            {
                return new
                {
                    success = false,
                    message = "Error removing signature: " + ex.Message
                };
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object GetUserSignature(string userId)
        {
            try
            {
                string currentUserId = !string.IsNullOrEmpty(userId) && userId != "0" ? userId : MyAccount.userId;
                if (string.IsNullOrEmpty(currentUserId) || currentUserId == "0")
                {
                    if (HttpContext.Current.Session != null && HttpContext.Current.Session["UserId"] != null)
                    {
                        currentUserId = HttpContext.Current.Session["UserId"].ToString();
                    }
                }

                if (string.IsNullOrEmpty(currentUserId) || currentUserId == "0")
                {
                    return new { success = false, message = "Invalid user." };
                }

                using (BusinessLogicLayer obj = new BusinessLogicLayer())
                {
                    obj.UserId = currentUserId;
                    using (DataTable dt = obj.GetUserSignature())
                    {
                        if (dt != null && dt.Rows.Count > 0 && dt.Columns.Contains("Signature"))
                        {
                            string sig = dt.Rows[0]["Signature"] != DBNull.Value ? dt.Rows[0]["Signature"].ToString().Trim() : "";
                            if (!string.IsNullOrEmpty(sig))
                            {
                                return new { success = true, hasSignature = true, fileName = sig, imageUrl = "../Uploads/Signatures/" + sig };
                            }
                        }
                    }
                }

                return new { success = true, hasSignature = false, message = "No signature found." };
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }
    }
}
