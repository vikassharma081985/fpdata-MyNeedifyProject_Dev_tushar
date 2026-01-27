<%@ WebHandler Language="C#" Class="DownloadPdfProxy" %>

using System;
using System.Web;
using System.Net;
using System.Configuration;
using System.Threading.Tasks;
using System.IO;

public class DownloadPdfProxy : HttpTaskAsyncHandler
{
    public override async Task ProcessRequestAsync(HttpContext context)
    {
        string fileName = context.Request.QueryString["fileName"];

        if (string.IsNullOrEmpty(fileName))
        {
            context.Response.StatusCode = 400;
            context.Response.Write("File name is required.");
            return;
        }

        // Get API base URL
        string apiBaseUrl = ConfigurationManager.AppSettings["ApiBaseUrl"];

        // Fallback for safety
        if (string.IsNullOrEmpty(apiBaseUrl))
        {
            apiBaseUrl = "http://198.38.88.185:8081/api";
        }

        // Remove trailing slash
        apiBaseUrl = apiBaseUrl.TrimEnd('/');

        string targetUrl = apiBaseUrl
            + "/Download/DownloadPdf?fileName="
            + HttpUtility.UrlEncode(fileName);

        using (WebClient client = new WebClient())
        {
            try
            {
                byte[] fileBytes = await client.DownloadDataTaskAsync(new Uri(targetUrl));

                context.Response.Clear();
                context.Response.ContentType = "application/pdf";
                context.Response.AddHeader(
                    "Content-Disposition",
                    "inline; filename=" + fileName
                );
                context.Response.BinaryWrite(fileBytes);
                context.Response.End();
            }
            catch (WebException ex)
            {
                context.Response.StatusCode = 500;
                string message = ex.Message;

                if (ex.Response != null)
                {
                    HttpWebResponse httpResponse = ex.Response as HttpWebResponse;
                    if (httpResponse != null)
                    {
                        context.Response.StatusCode = (int)httpResponse.StatusCode;
                    }

                    Stream responseStream = ex.Response.GetResponseStream();
                    if (responseStream != null)
                    {
                        using (StreamReader reader = new StreamReader(responseStream))
                        {
                            message += " - " + reader.ReadToEnd();
                        }
                    }
                }

                context.Response.Write("Error downloading file: " + message);
            }
            catch (Exception ex)
            {
                context.Response.StatusCode = 500;
                context.Response.Write("Error: " + ex.Message);
            }
        }
    }

    public override bool IsReusable
    {
        get { return false; }
    }
}

//    public override bool IsReusable
//    {
//        get
//        {
//            return false;
//        }
//    }
//}
