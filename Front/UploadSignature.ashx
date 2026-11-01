<%@ WebHandler Language="C#" Class="UploadSignature" %>

using System;
using System.IO;
using System.Web;
using System.Web.SessionState;
using BLL;

public class UploadSignature : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        try
        {
            if (context.Request.Files.Count == 0)
            {
                context.Response.Write("{\"success\":false,\"message\":\"No file received. Please select an image file to upload.\"}");
                return;
            }

            string userId = context.Request["userId"];
            if (string.IsNullOrEmpty(userId) || userId == "0")
            {
                if (context.Session != null && context.Session["UserId"] != null)
                {
                    userId = context.Session["UserId"].ToString();
                }
            }

            if (string.IsNullOrEmpty(userId) || userId == "0")
            {
                context.Response.Write("{\"success\":false,\"message\":\"Your session has expired. Please refresh the page and log in again.\"}");
                return;
            }

            HttpPostedFile file = context.Request.Files[0];
            if (file == null || file.ContentLength == 0)
            {
                context.Response.Write("{\"success\":false,\"message\":\"The selected file is empty. Please choose a valid image.\"}");
                return;
            }

            string extension = Path.GetExtension(file.FileName).ToLower();
            if (extension != ".png" && extension != ".jpg" && extension != ".jpeg")
            {
                context.Response.Write("{\"success\":false,\"message\":\"Invalid file format (" + extension + "). Only PNG, JPG, and JPEG files are allowed.\"}");
                return;
            }

            if (file.ContentLength > 4 * 1024 * 1024)
            {
                context.Response.Write("{\"success\":false,\"message\":\"File is too large (" + Math.Round((double)file.ContentLength / (1024 * 1024), 2) + "MB). Maximum allowed size is 4MB.\"}");
                return;
            }

            string folderPath = context.Server.MapPath("~/Uploads/Signatures/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string newFileName = "SIGN_" + Guid.NewGuid().ToString() + extension;
            string fullPath = Path.Combine(folderPath, newFileName);
            file.SaveAs(fullPath);

            // Update database
            try
            {
                using (BusinessLogicLayer obj = new BusinessLogicLayer())
                {
                    obj.UserId = userId;
                    obj.Signature = newFileName;
                    obj.UpdateUserSignature();
                }
            }
            catch (Exception dbEx)
            {
                string dbMsg = dbEx.Message.Replace("\"", "'").Replace("\r", "").Replace("\n", " ");
                context.Response.Write("{\"success\":false,\"message\":\"Signature image saved to server, but database update failed: " + dbMsg + ". Please verify database schema and Proc_UpdateUserSignature.\"}");
                return;
            }

            string json = "{\"success\":true,\"message\":\"Signature uploaded successfully!\",\"fileName\":\"" + newFileName + "\",\"imageUrl\":\"../Uploads/Signatures/" + newFileName + "\"}";
            context.Response.Write(json);
        }
        catch (Exception ex)
        {
            string safeMsg = ex.Message.Replace("\"", "'").Replace("\r", "").Replace("\n", " ");
            context.Response.Write("{\"success\":false,\"message\":\"Error uploading signature: " + safeMsg + "\"}");
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
