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

        try
        {
            if (callFor == "ItemImages")
            {
                ProcessItemImages(context);
                return;
            }
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                HttpPostedFile file = files[0];
                imgName = (file.FileName ?? "").Replace("^", "");

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

                if (callFor == "Logo")
                {
                    string uploadDir = context.Request.PhysicalApplicationPath + "Uploads\\Expense\\logo\\";
                    if (!Directory.Exists(uploadDir))
                        Directory.CreateDirectory(uploadDir);

                    string ext = System.IO.Path.GetExtension(imgName).ToLower();
                    if (string.IsNullOrEmpty(ext))
                        ext = GetExtensionFromContentType(file.ContentType);

                    if (string.IsNullOrEmpty(ext))
                    {
                        context.Response.StatusCode = 400;
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("Upload failed: selected file does not have an extension and the browser did not send a supported content type. File name received: " + imgName + "; Content type received: " + (file.ContentType ?? ""));
                        return;
                    }

                    string uniqueName = GetUniqueName(ext);
                    string savedPath = System.IO.Path.Combine(uploadDir, uniqueName);
                    if (System.IO.File.Exists(savedPath))
                        System.IO.File.Delete(savedPath);
                    file.SaveAs(savedPath);

                    context.Response.ContentType = "text/plain";
                    context.Response.Write(uniqueName + "|" + savedPath);
                    return;
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
                    if (string.IsNullOrEmpty(ext))
                        ext = GetExtensionFromContentType(file.ContentType);

                    if (string.IsNullOrEmpty(ext))
                    {
                        context.Response.StatusCode = 400;
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("Upload failed: selected file does not have an extension and the browser did not send a supported content type. File name received: " + imgName + "; Content type received: " + (file.ContentType ?? ""));
                        return;
                    }

                    string uniqueName = GetUniqueName(ext);
                    string savedPath = System.IO.Path.Combine(uploadDir, uniqueName);
                    if (System.IO.File.Exists(savedPath))
                        System.IO.File.Delete(savedPath);
                    file.SaveAs(savedPath);

                    // PDF -> IMAGE
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

                if (string.IsNullOrEmpty(Path))
                {
                    context.Response.StatusCode = 400;
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("Upload failed: invalid callFor value '" + (callFor ?? "") + "'.");
                    return;
                }

                file.SaveAs(Path);
                context.Response.ContentType = "text/plain";
                context.Response.Write(imgName + "|" + Path);

                //--------------------------
            }
            else
            {
                context.Response.StatusCode = 400;
                context.Response.ContentType = "text/plain";
                context.Response.Write("Upload failed: no file was received by the server.");
            }
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.ContentType = "text/plain";
            context.Response.Write("Upload failed on server: " + ex.Message);
        }
    }
    private void ProcessItemImages(HttpContext context)
    {
        int itemId;
        string action = context.Request["action"] ?? "List";
        if (!int.TryParse(context.Request["ItemId"], out itemId) || itemId <= 0 ||
            (action != "List" && action != "Add" && action != "Remove"))
            throw new InvalidOperationException("Invalid item image request.");
        if (action != "List" && context.Request.HttpMethod != "POST")
            throw new InvalidOperationException("Image changes require POST.");
        string savedPath = null;
        using (BusinessLogicLayer bll = new BusinessLogicLayer())
        {
            bll.ItemId = itemId;
            if (action == "Add")
            {
                if (context.Request.Files.Count != 1 || context.Request.Files[0].ContentLength == 0)
                    throw new InvalidOperationException("Select an image.");
                HttpPostedFile file = context.Request.Files[0];
                string ext = System.IO.Path.GetExtension(file.FileName).ToLowerInvariant();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif")
                    throw new InvalidOperationException("Only JPG, PNG and GIF images are allowed.");
                using (System.Drawing.Image image = System.Drawing.Image.FromStream(file.InputStream))
                {
                    if (!image.RawFormat.Equals(ImageFormat.Jpeg) && !image.RawFormat.Equals(ImageFormat.Png) && !image.RawFormat.Equals(ImageFormat.Gif))
                        throw new InvalidOperationException("Invalid image content.");
                }
                file.InputStream.Position = 0;
                bll.ImageName = itemId + "_" + Guid.NewGuid().ToString("N") + ext;
                string directory = context.Server.MapPath("~/Images/Items/");
                Directory.CreateDirectory(directory);
                savedPath = System.IO.Path.Combine(directory, bll.ImageName);
                file.SaveAs(savedPath);
            }
            else if (action == "Remove")
            {
                bll.ImageName = context.Request["ImageName"];
                if (string.IsNullOrEmpty(bll.ImageName)) throw new InvalidOperationException("Select an image to remove.");
            }
            try
            {
                using (DataTable images = bll.ManageItemImages(action))
                {
                    var result = new System.Collections.Generic.List<object>();
                    foreach (DataRow row in images.Rows)
                    {
                        string name = Convert.ToString(row["ImageName"]);
                        result.Add(new { ImageName = name, Url = VirtualPathUtility.ToAbsolute("~/Images/Items/") + Uri.EscapeDataString(name) });
                    }
                    context.Response.ContentType = "application/json";
                    context.Response.Write(new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(result));
                }
            }
            catch
            {
                if (savedPath != null && File.Exists(savedPath)) File.Delete(savedPath);
                throw;
            }
        }
    }

    private string GetUniqueName(string extension)
    {
        return DateTime.Now.ToString("yyyyMMddHHmmssfff")
               + "_" + Guid.NewGuid().ToString("N")
               + extension;
    }

    private string GetExtensionFromContentType(string contentType)
    {
        switch ((contentType ?? "").ToLower())
        {
            case "image/gif":
                return ".gif";
            case "image/jpeg":
            case "image/jpg":
                return ".jpg";
            case "image/png":
                return ".png";
            case "application/pdf":
                return ".pdf";
            default:
                return "";
        }
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
