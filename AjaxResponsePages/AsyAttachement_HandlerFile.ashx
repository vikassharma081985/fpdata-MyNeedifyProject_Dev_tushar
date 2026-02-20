<%@ WebHandler Language="C#" Class="AsyAttachement_HandlerFile" %>

using System;
using System.Web;
using System.Web.SessionState;
using BLL;
using System.Data;
using PdfiumViewer;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
public class AsyAttachement_HandlerFile : IHttpHandler, IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        string imgName = null;
        string Path = null;
        string callFor = context.Request["callFor"];
        string PerPath = null;
        string ItemId = context.Request["ItemId"];

        if (context.Request.Files.Count > 0)
        {
            HttpFileCollection files = context.Request.Files;
            HttpPostedFile file = files[0];
            imgName = file.FileName.Replace("^", "");

            if (imgName.Contains("\\"))
            {
                string[] arr = imgName.Split('\\');
                imgName = arr[arr.Length - 1];
            }

            if (callFor == "Items")
            {
                Path = context.Request.PhysicalApplicationPath + "Images/Items/" + ItemId + "_" + imgName;
                PerPath = Path;
                if (System.IO.File.Exists(Path))
                    System.IO.File.Delete(Path);
                Path = PerPath;
                using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                {
                    objBLL.ItemId = Convert.ToInt32(ItemId);
                    objBLL.ImageName = ItemId + "_" + imgName;
                    objBLL.UpdateItemImage();
                }
            }
            if (callFor == "MoudLetter")
            {
                Path = context.Request.PhysicalApplicationPath + "Images/Items/Temp/" + context.Session.SessionID + "_" + imgName;
                PerPath = Path;
                if (System.IO.File.Exists(Path))
                    System.IO.File.Delete(Path);
                Path = PerPath;
            }
            if (callFor == "banner")
            {
                Path = context.Request.PhysicalApplicationPath + "Images/Slider/Temp/" + context.Session.SessionID + "_" + imgName;
                PerPath = Path;
                if (System.IO.File.Exists(Path))
                    System.IO.File.Delete(Path);
                Path = PerPath;
            }
            //if (callFor == "Expense")
            //{
            //    string ext = System.IO.Path.GetExtension(imgName);
            //    string uniqueName = System.DateTime.Now.ToString("yyyyMMddHHmmssfff") + "_" + Guid.NewGuid().ToString("N") + ext;
            //    imgName = uniqueName;
            //    Path = context.Request.PhysicalApplicationPath + "Uploads/Expense/" + imgName;
            //    PerPath = Path;
            //    if (System.IO.File.Exists(Path))
            //        System.IO.File.Delete(Path);
            //    Path = PerPath;

            //}

            if (callFor == "Expense")
            {
                string uploadDir = context.Request.PhysicalApplicationPath + "Uploads/Expense/";
                if (!Directory.Exists(uploadDir))
                    Directory.CreateDirectory(uploadDir);

                string ext = System.IO.Path.GetExtension(imgName).ToLower();
                string uniqueName = GetUniqueName(ext);
                string savedPath = System.IO.Path.Combine(uploadDir, uniqueName);
                if (System.IO.File.Exists(savedPath))
                    System.IO.File.Delete(savedPath);
                file.SaveAs(savedPath);

                // PDF → IMAGE
                if (ext == ".pdf")
                {
                    string imageName = ConvertPdfToImage(savedPath, uploadDir);
                    string imagePath = System.IO.Path.Combine(uploadDir, imageName);

                    // delete pdf
                    if (System.IO.File.Exists(savedPath))
                        System.IO.File.Delete(savedPath);

                    context.Response.ContentType = "text/plain";
                    context.Response.Write(imageName + "|" + imagePath);
                    return;
                }

                // Normal image
                context.Response.ContentType = "text/plain";
                context.Response.Write(uniqueName + "|" + savedPath);
                return;
            }


            file.SaveAs(Path);
            context.Response.ContentType = "text/plain";
            context.Response.Write(imgName + "|" + Path);

            //--------------------------

        }



    }
    private string GetUniqueName(string extension)
    {
        return DateTime.Now.ToString("yyyyMMddHHmmssfff")
               + "_" + Guid.NewGuid().ToString("N")
               + extension;
    }

    private string ConvertPdfToImage(string pdfPath, string outputFolder)
    {
        using (var document = PdfDocument.Load(pdfPath))
        {
            // Convert FIRST PAGE only
            using (var image = document.Render(0, 300, 300, true))
            {
                string imgName = Path.GetFileNameWithoutExtension(pdfPath) + ".png";
                string imgPath = Path.Combine(outputFolder, imgName);
                if (System.IO.File.Exists(imgPath))
                    System.IO.File.Delete(imgPath);
                image.Save(imgPath, ImageFormat.Png);
                return imgName;
            }
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