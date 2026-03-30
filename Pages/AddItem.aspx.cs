using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class AddItem : System.Web.UI.Page
    {
        int tabIndex = -1;
        string ItemId = "";
        DataTable dtSize = new DataTable();
        DataTable dtColor = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeId"] != null || Convert.ToInt32(Session["EmployeeId"]) > 0)
            {
                if (Convert.ToString(Request["ItemId"]) != "" && Convert.ToString(Request["ItemId"]) != null)
                {
                    hdnItemId.Value = Convert.ToString(Request["ItemId"]);
                    btnSubmitData.Text = "Update";
                }
                else
                {
                    btnSubmitData.Text = "Save";
                }


                if (!IsPostBack)
                {
                    int UserId = Convert.ToInt32(Session["EmployeeId"]);
                    int Role = Convert.ToInt32(Session["RoleId"]);
                    BindData1(UserId, Role);
                }
                //Session["UserId"] = "1";
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        public void BindData1(int userid, int role)
        {
            using (BusinessLogicLayer ObjIHC = new BusinessLogicLayer())
            {
                if (Convert.ToString(Request["ItemId"]) != "" && Convert.ToString(Request["ItemId"]) != null)

                    ObjIHC.ItemId = Convert.ToInt32(Request["ItemId"]);
                using (DataSet dsMain = ObjIHC.GetAdminItemEdit(userid, role))
                {
                    dtSize = dsMain.Tables[8];
                    dtColor = dsMain.Tables[9];
                    DataTable dtSupplier = new DataTable();
                    dtSupplier = dsMain.Tables[10];

                    if (dtSupplier.Rows.Count > 0)
                    {
                        if (Session["RoleId"].ToString() == "4")
                            ddlSupplier.DataSource = dtSupplier;
                        else
                            ddlSupplier.DataSource = dtSupplier;
                        ddlSupplier.DataTextField = "SupplierName";
                        ddlSupplier.DataValueField = "SupplierID";
                        ddlSupplier.DataBind();
                    }
                    ddlSupplier.Items.Insert(0, new ListItem("--Select Supplier--", "0"));

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
                                    ddlColor.DataSource = dtColor;
                                    ddlColor.DataTextField = "Color";
                                    ddlColor.DataValueField = "ColorId";

                                    ddlColor.DataBind();


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

                                    rptSizenStock.DataSource = dt;


                                    rptSizenStock.DataBind();

                                }
                            }
                        }
                        tabIndex++;
                        using (DataTable dt = dsMain.Tables[tabIndex])
                        {
                            if (dt.Rows.Count > 0)
                            {
                                ddlSupplier.SelectedValue = dt.Rows[0]["SupplierId"].ToString();
                                txtItemName.Text = dt.Rows[0]["ItemName"].ToString();
                                txtItemDescription.Text = Server.HtmlDecode(dt.Rows[0]["ItemDescription"].ToString());
                                 
                                txtAmount.Text = Convert.ToString(dt.Rows[0]["Amount"] == System.DBNull.Value ? 0 : Convert.ToInt32(dt.Rows[0]["Amount"]));


                                txtMRP.Text = Convert.ToString(dt.Rows[0]["ItemPrice"] == System.DBNull.Value ? 0 : Convert.ToInt32(dt.Rows[0]["ItemPrice"]));
                                ddlCategory.SelectedValue = dt.Rows[0]["CategoryId"].ToString();
                                ddlSubCatgeory.SelectedValue = dt.Rows[0]["SubCategoryId"].ToString();
                                //ddlColor.SelectedValue = dt.Rows[0]["ColorId"].ToString();
                                ddlSubSubCategory.SelectedValue = dt.Rows[0]["SubSubCategoryId"].ToString();
                                if (dt.Rows[0]["IsCoupanAppplicable"].ToString().ToLower() == "true")
                                    chkIscoupan.Checked = true;
                                else
                                    chkIscoupan.Checked = false;

                                if (dt.Rows[0]["Active"].ToString().ToLower() == "true")
                                    chkIsActive.Checked = true;
                                else
                                    chkIsActive.Checked = false;
                                // txtStock.Text = dt.Rows[0]["Stock"].ToString();
                                txtItemCode.Text = Convert.ToString(dt.Rows[0]["ItemId"] == System.DBNull.Value ? 0 : dt.Rows[0]["ItemId"]);
                                txtBrand.Text = Convert.ToString(dt.Rows[0]["Brand"] == System.DBNull.Value ? 0 : dt.Rows[0]["Brand"]);
                                txtModel.Text = Convert.ToString(dt.Rows[0]["Model"] == System.DBNull.Value ? 0 : dt.Rows[0]["Model"]);
                                txtDepartment.Text = Convert.ToString(dt.Rows[0]["Department"] == System.DBNull.Value ? 0 : dt.Rows[0]["Department"]);
                                txtCashback.Text = Convert.ToString(dt.Rows[0]["Cashback"] == System.DBNull.Value ? 0 : dt.Rows[0]["Cashback"]);
                                txtVendor.Text = Convert.ToString(dt.Rows[0]["Vendor"] == System.DBNull.Value ? 0 : dt.Rows[0]["Vendor"]);
                                //ddlCOD.SelectedValue = dt.Rows[0]["COD"].ToString(); Future Add .... 
                                txtVolume.Text = Convert.ToString(dt.Rows[0]["ItemVolume"] == System.DBNull.Value ? 0 : dt.Rows[0]["ItemVolume"]);
                                txtLength.Text = Convert.ToString(dt.Rows[0]["ItemLength"] == System.DBNull.Value ? 0 : dt.Rows[0]["ItemLength"]);
                                txtWidth.Text = Convert.ToString(dt.Rows[0]["ItemWidth"] == System.DBNull.Value ? 0 : dt.Rows[0]["ItemWidth"]);
                                txtHeight.Text = Convert.ToString(dt.Rows[0]["ItemHeight"] == System.DBNull.Value ? 0 : dt.Rows[0]["ItemHeight"]);
                                txtShippingWeight.Text = Convert.ToString(dt.Rows[0]["ShippingWeight"] == System.DBNull.Value ? 0 : dt.Rows[0]["ShippingWeight"]);
                                txtShippingPrice.Text = Convert.ToString(dt.Rows[0]["ShippingPrice"] == System.DBNull.Value ? 0 : dt.Rows[0]["ShippingPrice"]);
                                txtHSNCode.Text = Convert.ToString(dt.Rows[0]["HSNCode"] == System.DBNull.Value ? 0 : dt.Rows[0]["HSNCode"]);


                                // string Size = Convert.ToString(dt.Rows[0]["Size"]); Future add... 
                                //var array = Size.Split(',');
                                //for (int l = 0; l < chkSizeList.Items.Count; l++)
                                //{
                                //    for (int m = 0; m < array.Length; m++)
                                //    {
                                //        if (chkSizeList.Items[l].Value == array[m])
                                //        {
                                //            chkSizeList.Items[l].Selected = true;
                                //        }
                                //    }
                                //}
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

                    tabIndex++;
                    if (dsMain.Tables.Count > tabIndex)
                    {

                    }
                    tabIndex++;
                    if (dsMain.Tables.Count > tabIndex)
                    {

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
                //objfp.Stock = txtStock.Text;
                objfp.ItemDescription = Server.HtmlEncode(txtItemDescription.Text);
                if (hdnSupplier.Value != "")
                    objfp.SupplierId = Convert.ToInt32(hdnSupplier.Value.ToString());
                if (hdnCategory.Value != "")
                    objfp.CategoryId = Convert.ToInt32(hdnCategory.Value.ToString());
                if (hdnSubCategory.Value != "")
                    objfp.SubCategoryId = Convert.ToInt32(hdnSubCategory.Value.ToString());
                if (hdnSubSubCategory.Value != "")
                    objfp.SubSubCategoryId = Convert.ToInt32(hdnSubSubCategory.Value.ToString());
                objfp.Amount = Convert.ToInt32(txtAmount.Text.ToString());
                objfp.MRP = Convert.ToInt32(txtMRP.Text.ToString());

                if (chkIscoupan.Checked)
                    objfp.IsCoupanAvailable = 1;
                else
                    objfp.IsCoupanAvailable = 0;

                if (chkIsActive.Checked)
                    objfp.Active = 1;
                else
                    objfp.Active = 0;
                objfp.colorId = Convert.ToInt32(ddlColor.SelectedValue);

                objfp.SizeXml = hdnsize.Value;
                //objfp.colorId = Convert.ToInt32(ddlColor.SelectedValue);


                objfp.ProductId = txtItemCode.Text;
                objfp.Brand = txtBrand.Text;
                objfp.Modal = txtModel.Text;
                objfp.Department = txtDepartment.Text;
                objfp.Cashback = txtCashback.Text ?? "0";
                objfp.Vendor = txtVendor.Text;
                objfp.COD = ddlCOD.SelectedValue;
                objfp.ItemVolume = txtVolume.Text;
                objfp.ItemWidth = txtWidth.Text;
                objfp.ItemLength = txtLength.Text;
                objfp.ItemHeight = txtHeight.Text;
                objfp.ShippingPrice = txtShippingPrice.Text;
                objfp.ShippingWeight = txtShippingWeight.Text;
                objfp.HSNCode = txtHSNCode.Text;
                objfp.Stock = "1";
                //unable to get the stock value

                objfp.ItemPrice = Convert.ToInt32(txtMRP.Text);
                HttpPostedFile PostedFile = flUpload.PostedFile;
                string fileName = Path.GetFileName(PostedFile.FileName);
                string fileExtension = Path.GetExtension(fileName);
                int FileSize = PostedFile.ContentLength;
                Stream stream = PostedFile.InputStream;
                BinaryReader binaryReader = new BinaryReader(stream);
                byte[] bytes = binaryReader.ReadBytes((int)stream.Length);

                objfp.ImageName = bytes.ToString();
                objfp.ImageSize = FileSize;
                objfp.ItemMultipleImage = hdnAttachmentXML.Value;
                using (DataTable dt = objfp.SaveItemPage())
                {
                    using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
                    {
                        if (dt.Rows.Count > 0)
                        {
                            //string XML = "<Root>";
                            foreach (DataRow dr in dt.Rows)
                            {
                                string tempPath = Request.PhysicalApplicationPath + "Images/Items/Temp/" + Session.SessionID + "_" + (dr["Tempattachment"]).ToString();
                                string perPath = Request.PhysicalApplicationPath + "Images/Items/" + Convert.ToString(dr["ImageId"]) + "_" + (dr["Tempattachment"]).ToString();
                                if (File.Exists(tempPath))
                                {
                                    if (File.Exists(perPath))
                                        File.Delete(perPath);
                                    File.Move(tempPath, perPath);
                                }
                                //XML += "<Node>";
                                //string BarcodeImage = GenerateBarcode(dr["BillItemId"].ToString(), dr["Barcode"].ToString());
                                //XML += "<ItemId>" + dr["BillItemId"].ToString() + "</ItemId>";
                                //XML += "<Barcode>" + dr["Barcode"].ToString() + "</Barcode>";
                                //XML += "<BarcodeImage>" + BarcodeImage + "</BarcodeImage>";
                                //XML += "</Node>";
                            }
                            //XML += "</Root>";
                            //objBLL.XML = XML;
                            //objBLL.SaveBarcodeImage();
                        }
                    }
                }

            }
            // Response.Redirect("https://myneedify.com//Pages/AddItem.aspx");
            if (Convert.ToString(Request["ItemId"]) != "" && Convert.ToString(Request["ItemId"]) != null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Item Updated Successfully');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Item Added Successfully');window.location.href='http://trendzshopping.in//Pages/AddItem.aspx';", true);
            }
        }
        private string GenerateBarcode(string ItemId, string Barcode)
        {
            string barCode = Barcode;
            // System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            using (Bitmap bitMap = new Bitmap(barCode.Length * 40, 80))
            {
                using (Graphics graphics = Graphics.FromImage(bitMap))
                {
                    System.Drawing.Font oFont = new System.Drawing.Font("IDAutomationHC39M", 16);
                    PointF point = new PointF(2f, 2f);
                    SolidBrush blackBrush = new SolidBrush(System.Drawing.Color.Black);
                    SolidBrush whiteBrush = new SolidBrush(System.Drawing.Color.White);
                    graphics.FillRectangle(whiteBrush, 0, 0, bitMap.Width, bitMap.Height);
                    graphics.DrawString("*" + barCode + "*", oFont, blackBrush, point);
                }
                using (MemoryStream ms = new MemoryStream())
                {
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();

                    Convert.ToBase64String(byteImage);
                    string BarcodeImage = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                    return BarcodeImage;
                }
                //plBarCode.Controls.Add(imgBarCode);
            }
        }
        [WebMethod(EnableSession = true)]
        public static string BindCategory(int Suppplier)
        {
            return BindCatgeoryList(Suppplier);
        }
        public static string BindCatgeoryList(int Suppplier)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                using (DataSet dsMain = objFp.GetCategory(Suppplier))
                {
                    using (DataTable dtSubcategory = dsMain.Tables[1])
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

        protected void rptSizenStock_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HiddenField hdnSizeId = e.Item.FindControl("hdnSizeId") as HiddenField;
                HiddenField hdnColorId = e.Item.FindControl("hdnColorId") as HiddenField;
                DropDownList ddlColor = e.Item.FindControl("ddlColor") as DropDownList;
                DropDownList ddlSize = e.Item.FindControl("ddlSize") as DropDownList;

                ddlColor.DataSource = dtColor;
                ddlColor.DataTextField = "Color";
                ddlColor.DataValueField = "ColorId";
                ddlColor.DataBind();
                ddlColor.Items.Insert(0, new ListItem("--Color--", "0"));
                if (hdnColorId.Value != "")
                    ddlColor.Items.FindByValue(hdnColorId.Value).Selected = true;

                ddlSize.DataSource = dtSize;
                ddlSize.DataTextField = "Size";
                ddlSize.DataValueField = "SizeId";
                ddlSize.DataBind();
                ddlSize.Items.Insert(0, new ListItem("--Size--", "0"));
                if (hdnSizeId.Value != "")
                    ddlSize.Items.FindByValue(hdnSizeId.Value).Selected = true;

            }
        }
    }
}