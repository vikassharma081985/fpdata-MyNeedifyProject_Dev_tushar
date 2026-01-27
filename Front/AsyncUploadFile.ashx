<%@ WebHandler Language="C#" Class="AsyncUploadFile" %>

using System;
using System.Web;
using System.Web.SessionState;
public class AsyncUploadFile : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        string imgName = null;
        string path = context.Request["path"];
        if (context.Request.Files.Count > 0)
        {
            HttpFileCollection files = context.Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFile file = files[i];
                //imgName = new System.Text.RegularExpressions.Regex("([!@#$%^&*;:_,/'{\\|}()\\-+=~`\\[\\] ]|(?:[.](?![a-z0-9]+$)))", System.Text.RegularExpressions.RegexOptions.IgnoreCase).Replace(file.FileName, String.Empty);
                imgName = file.FileName;
                path = context.Server.MapPath("~/" + path + "/"  + imgName);
                file.SaveAs(path);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(imgName);
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
