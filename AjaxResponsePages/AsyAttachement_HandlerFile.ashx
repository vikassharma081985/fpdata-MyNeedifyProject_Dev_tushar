<%@ WebHandler Language="C#" Class="AsyAttachement_HandlerFile" %>

using System;
using System.Web;
using System.Web.SessionState;
using BLL;
using System.Data;
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
            if (callFor == "Expense")
            {
                string ext = System.IO.Path.GetExtension(imgName);
                string uniqueName = System.DateTime.Now.ToString("yyyyMMddHHmmssfff") + "_" + Guid.NewGuid().ToString("N") + ext;
                imgName = uniqueName;
                Path = context.Request.PhysicalApplicationPath + "Uploads/Expense/" + imgName;
                PerPath = Path;
                if (System.IO.File.Exists(Path))
                    System.IO.File.Delete(Path);
                Path = PerPath;

            }


            file.SaveAs(Path);
            context.Response.ContentType = "text/plain";
            context.Response.Write(imgName + "|" + Path);

            //--------------------------

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