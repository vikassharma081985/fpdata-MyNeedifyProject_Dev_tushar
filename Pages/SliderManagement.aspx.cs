using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class SliderManagement : System.Web.UI.Page
    {
        int tabIndex = -1;
        string ItemId = "";
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (Convert.ToString(Request["ItemId"]) != "" && Convert.ToString(Request["ItemId"]) != null)
                hdnItemId.Value = Convert.ToString(Request["ItemId"]);
            if (!IsPostBack)
            {
                BindData1();
            }
        }
        public void BindData1()
        {
            using (BusinessLogicLayer ObjIHC = new BusinessLogicLayer())
            {
                if (Convert.ToString(Request["ItemId"]) != "" && Convert.ToString(Request["ItemId"]) != null)

                    ObjIHC.ItemId = Convert.ToInt32(Request["ItemId"]);
                using (DataSet dsMain = ObjIHC.GetSliderItemEdit())
                {
                    if (dsMain.Tables.Count > tabIndex)
                    {
                        tabIndex++;
                        if (dsMain.Tables.Count > tabIndex)
                        {
                            using (DataTable dt = dsMain.Tables[tabIndex])
                            {
                                if (dt.Rows.Count > 0)
                                {
                                    ddlCategory.DataSource = dt;
                                    ddlCategory.DataTextField = "Category";
                                    ddlCategory.DataValueField = "CategoryId";
                                    ddlCategory.DataBind();
                                }
                            }
                        }
                        tabIndex++;
                        if (dsMain.Tables.Count > tabIndex)
                        {
                            using (DataTable dt = dsMain.Tables[tabIndex])
                            {
                                if (dt.Rows.Count > 0)
                                {
                                    ddlSubCatgeory.DataSource = dt;
                                    ddlSubCatgeory.DataTextField = "SubCategory";
                                    ddlSubCatgeory.DataValueField = "SubCategoryId";
                                    ddlSubCatgeory.DataBind();
                                }
                            }
                        }
                        tabIndex++;
                        if (dsMain.Tables.Count > tabIndex)
                        {
                            using (DataTable dt = dsMain.Tables[tabIndex])
                            {
                                if (dt.Rows.Count > 0)
                                {
                                    ddlSubSubCategory.DataSource = dt;
                                    ddlSubSubCategory.DataTextField = "SubSubCategory";
                                    ddlSubSubCategory.DataValueField = "SubSubCategoryId";
                                    ddlSubSubCategory.DataBind();
                                }
                            }
                        }
                        tabIndex++;
                        if (dsMain.Tables.Count > tabIndex)
                        {
                            using (DataTable dt = dsMain.Tables[tabIndex])
                            {
                                if (dt != null && dt.Rows.Count > 0)
                                {



                                }
                            }
                        }

                        tabIndex++;
                        if (dsMain.Tables.Count > tabIndex)
                        {

                        }
                        tabIndex++;
                        using (DataTable dt = dsMain.Tables[tabIndex])
                        {
                            if (dt.Rows.Count > 0)
                            {

                                txtItemName.Text = dt.Rows[0]["ItemName"].ToString();
                                ddlCategory.SelectedValue = dt.Rows[0]["CategoryId"].ToString();
                                ddlSubCatgeory.SelectedValue = dt.Rows[0]["SubCategoryId"].ToString();
                                ddlSubSubCategory.SelectedValue = dt.Rows[0]["SubSubCategoryId"].ToString();
                            }

                        }
                    }
                    tabIndex++;
                    if (dsMain.Tables.Count > tabIndex)
                    {
                        using (DataTable dt = dsMain.Tables[tabIndex])
                        {
                            if (dt != null && dt.Rows.Count > 0)
                            {
                                //rptImage.DataSource = dt;
                                //rptImage.DataBind();


                            }
                        }
                    }

                    tabIndex++;
                    if (dsMain.Tables.Count > tabIndex)
                    {
                        using (DataTable dt = dsMain.Tables[tabIndex])
                        {
                            if (dt != null && dt.Rows.Count > 0)
                            {
                                rptAttachment.DataSource = dt;
                                rptAttachment.DataBind();

                            }
                        }
                    }
                }
            }
        }
        //public void BindCategory()
        //{
        //    using (BusinessLogicLayer ObjIHC = new BusinessLogicLayer())
        //    {
        //        using (DataSet dsMain = ObjIHC.GetCategory())
        //        {

        //        }
        //    }
        //}
        protected void btnSubmitData_Click(object sender, EventArgs e)
        {
            using (BusinessLogicLayer objfp = new BusinessLogicLayer())
            {
                if (Convert.ToString(Request["ItemId"]) != "" && Convert.ToString(Request["ItemId"]) != null)
                {
                    objfp.ItemId = Convert.ToInt32(Request["ItemId"]);
                }
                else
                {
                    objfp.ItemId = 0;
                }
                objfp.ItemName = txtItemName.Text;

                if (hdnCategory.Value != "")
                    objfp.CategoryId = Convert.ToInt32(hdnCategory.Value.ToString());
                if (hdnSubCategory.Value != "")
                    objfp.SubCategoryId = Convert.ToInt32(hdnSubCategory.Value.ToString());
                if (hdnSubSubCategory.Value != "")
                    objfp.SubSubCategoryId = Convert.ToInt32(hdnSubSubCategory.Value.ToString());
                if (flUpload.HasFile)
                {
                    string sessionId = Session.SessionID;
                    string filename = Path.GetFileName(flUpload.PostedFile.FileName);
                    string location = Server.MapPath("../Images/Slider/Temp" + "\\" + filename);
                    flUpload.SaveAs(location);
                    objfp.ItemMultipleImage = filename;
                }
                //HttpPostedFile PostedFile = flUpload.PostedFile;
                //string fileName = Path.GetFileName(PostedFile.FileName);
                //string fileExtension = Path.GetExtension(fileName);
                //int FileSize = PostedFile.ContentLength;
                //Stream stream = PostedFile.InputStream;
                //BinaryReader binaryReader = new BinaryReader(stream);
                //byte[] bytes = binaryReader.ReadBytes((int)stream.Length);

                //objfp.ImageName = bytes.ToString();
                //objfp.ImageSize = FileSize;
                //objfp.ItemMultipleImage = hdnAttachmentXML.Value;
                using (DataTable dt = objfp.SaveSliderPage())
                {
                    if (dt.Rows.Count > 0)
                    {

                        string temppath = Request.PhysicalApplicationPath + "Images/Slider/Temp/" + (dt.Rows[0]["Path"]).ToString();
                        string perpath = Request.PhysicalApplicationPath + "Images/Slider/" + Convert.ToString(dt.Rows[0]["Id"]) + "_" + (dt.Rows[0]["Path"]).ToString();
                        if (File.Exists(temppath))
                        {
                            if (File.Exists(perpath))
                                File.Delete(perpath);
                            File.Move(temppath, perpath);

                        }

                    }
                }
                txtItemName.Text = "";
                txtDisplay.Text = "";
                Response.Redirect("https://myneedify.com//Pages/SliderManagement.aspx");
            }
        }

        [WebMethod(EnableSession = true)]
        public static string BindSubCategory(int CategoryId)
        {
            return BindAllCatgeory(CategoryId);
        }
        public static string BindAllCatgeory(int CategoryId)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.CategoryId = CategoryId;

                using (DataSet dsMain = objFp.GetSubCategory())
                {
                    using (DataTable dtSubcategory = dsMain.Tables[0])
                    {
                        if (dtSubcategory.Rows.Count > 0)
                        {
                            return Newtonsoft.Json.JsonConvert.SerializeObject(dtSubcategory);
                        }
                        else
                        {
                            return "";
                        }

                    }
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static string BindSubSubCategory(int SubCategoryId)
        {
            return BindAllSubCatgeory(SubCategoryId);
        }
        public static string BindAllSubCatgeory(int SubCategoryId)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.SubCategoryId = SubCategoryId;

                using (DataSet dsMain = objFp.GetSubSubCategory())
                {
                    using (DataTable dtSubSubcategory = dsMain.Tables[0])
                    {
                        if (dtSubSubcategory.Rows.Count > 0)
                        {
                            return Newtonsoft.Json.JsonConvert.SerializeObject(dtSubSubcategory);
                        }
                        else
                        {
                            return "";
                        }

                    }
                }
            }
        }


        [WebMethod(EnableSession = true)]
        public static int DeleteImage(int ImageId, int ItemId)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {

                objFp.ItemId = ItemId;
                // objFp.ItemId = Convert.ToInt32(HttpContext.Current.Request["ItemId"]);
                objFp.ImageId = ImageId;
                int Success = objFp.DeleteImage();
                if (Success == 1)
                {

                    return 1;
                }
                else
                {
                    return 0;
                }

            }
        }
    }
}