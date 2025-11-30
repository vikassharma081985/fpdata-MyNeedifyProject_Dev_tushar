using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace WSBillingMaster.AjaxResponsePages
{
    /// <summary>
    /// Summary description for FileUploader
    /// </summary>
    public class FileUploader : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            try
            {
                string subPath = "Images/OrgImages";
                bool folderexists = Directory.Exists(subPath);
                if(!folderexists)
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/" + subPath));
                string dirFullPath = HttpContext.Current.Server.MapPath("~/" + subPath);
                string[] files;
                int numFiles;
                files = Directory.GetFiles(dirFullPath);
                numFiles = files.Length;
                numFiles = numFiles + 1;
                string str_image = "";
                foreach (string s in context.Request.Files)
                {
                    HttpPostedFile file = context.Request.Files[s];
                    string fileName = file.FileName;
                    string fileExtension = file.ContentType;
                    if (!string.IsNullOrEmpty(fileName))
                    {
                        fileExtension = Path.GetExtension(fileName);
                        str_image = fileName.Split('.')[0] + "_" + DateTime.Now.ToString("ddMMyyHHmmss") + fileExtension;
                        string pathtosave = HttpContext.Current.Server.MapPath("~/Images/OrgImages/") + str_image;
                        file.SaveAs(pathtosave);
                    }
                }
                context.Response.Write(str_image);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}