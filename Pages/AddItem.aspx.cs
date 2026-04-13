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
        private bool HasSelectedItems()
        {
            foreach (RepeaterItem item in rptItems.Items)
            {
                CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                    return true;
            }
            return false;
        }

        protected void rptItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Dropdown and variant binding removed for simplified flat layout
        }

        private void BindItems()
        {
            using (BusinessLogicLayer ObjIHC = new BusinessLogicLayer())
            {
                using (DataSet dsSearch = ObjIHC.GetAdminItemSearch(Convert.ToInt32(ddlCategory.SelectedValue == "" ? "0" : ddlCategory.SelectedValue), Convert.ToInt32(ddlSubCatgeory.SelectedValue == "" ? "0" : ddlSubCatgeory.SelectedValue), Convert.ToInt32(ddlSubSubCategory.SelectedValue == "" ? "0" : ddlSubSubCategory.SelectedValue)))
                {
                    DataTable dt = dsSearch.Tables[0];
                    if (dt.Rows.Count == 0)
                    {
                        // Create an empty row if no data found
                        dt.Rows.Add(dt.NewRow());
                    }
                    rptItems.DataSource = dt;
                    rptItems.DataBind();
                }
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
            ddlSubCatgeory.Items.Clear();
            ddlSubSubCategory.Items.Clear();

            if (categoryId > 0)
            {
                string json = BindAllCatgeory(categoryId);
                if (!string.IsNullOrEmpty(json))
                {
                    DataTable dt = Newtonsoft.Json.JsonConvert.DeserializeObject<DataTable>(json);
                    ddlSubCatgeory.DataSource = dt;
                    ddlSubCatgeory.DataTextField = "SubCategory";
                    ddlSubCatgeory.DataValueField = "SubCategoryId";
                    ddlSubCatgeory.DataBind();
                }
            }
            ddlSubCatgeory.Items.Insert(0, new ListItem("---Select---", "0"));
            ddlSubSubCategory.Items.Insert(0, new ListItem("---Select---", "0"));
            BindItems();
        }

        protected void ddlSubCatgeory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int subCategoryId = Convert.ToInt32(ddlSubCatgeory.SelectedValue);
            ddlSubSubCategory.Items.Clear();

            if (subCategoryId > 0)
            {
                string json = BindAllSubCatgeory(subCategoryId);
                if (!string.IsNullOrEmpty(json))
                {
                    DataTable dt = Newtonsoft.Json.JsonConvert.DeserializeObject<DataTable>(json);
                    ddlSubSubCategory.DataSource = dt;
                    ddlSubSubCategory.DataTextField = "SubSubCategory";
                    ddlSubSubCategory.DataValueField = "SubSubCategoryId";
                    ddlSubSubCategory.DataBind();
                }
            }
            ddlSubSubCategory.Items.Insert(0, new ListItem("---Select---", "0"));
            BindItems();
        }

        protected void ddlSubSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindItems();
        }

        int tabIndex = -1;
        string ItemId = "";
        DataTable dtSize = new DataTable();
        DataTable dtColor = new DataTable();
        DataTable dtSizenStock = new DataTable();

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

                // Always fetch static data so it's available for ItemDataBound on postbacks
                FetchStaticData();

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

        private void FetchStaticData()
        {
            using (BusinessLogicLayer ObjIHC = new BusinessLogicLayer())
            {
                int UserId = Convert.ToInt32(Session["EmployeeId"]);
                int Role = Convert.ToInt32(Session["RoleId"]);
                using (DataSet dsMain = ObjIHC.GetAdminItemEdit(UserId, Role, 0, 0, 0))
                {
                    dtSize = dsMain.Tables[8];
                    dtColor = dsMain.Tables[9];
                }
            }
        }

        public void BindData1(int userid, int role)
        {
            using (BusinessLogicLayer ObjIHC = new BusinessLogicLayer())
            {
                if (Convert.ToString(Request["ItemId"]) != "" && Convert.ToString(Request["ItemId"]) != null)

                    ObjIHC.ItemId = Convert.ToInt32(Request["ItemId"]);
                using (DataSet dsMain = ObjIHC.GetAdminItemEdit(userid, role, 0, 0, 0))
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
                                    // Logic for color binding moved to rptItems_ItemDataBound
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
                                    dtSizenStock = dt;
                                    // rptSizenStock binding moved to rptItems_ItemDataBound
                                }
                            }
                        }
                        BindItems();
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
                                //rptAttachment.DataSource = dt;
                                //rptAttachment.DataBind();

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
                // Validation First
                foreach (RepeaterItem item in rptItems.Items)
                {
                    CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect");
                    if (chkSelect != null && chkSelect.Checked)
                    {
                        string itemName = ((TextBox)item.FindControl("txtItemName")).Text;
                        string amountStr = ((TextBox)item.FindControl("txtAmount")).Text;
                        FileUpload fuItemImage = (FileUpload)item.FindControl("fuItemImage");
                        HiddenField hdnExistingImageRow = (HiddenField)item.FindControl("hdnExistingImage");

                        if (string.IsNullOrWhiteSpace(itemName))
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Item Name is mandatory for selected items.');", true);
                            return;
                        }

                        decimal amount = 0;
                        if (!decimal.TryParse(amountStr, out amount) || amount <= 1)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Amount must be greater than 1 for selected items.');", true);
                            return;
                        }

                        if (!fuItemImage.HasFile && string.IsNullOrEmpty(hdnExistingImageRow.Value))
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Item Image is mandatory for selected items.');", true);
                            return;
                        }
                    }
                }

                // Processing
                foreach (RepeaterItem item in rptItems.Items)
                {
                    CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect");
                    if (chkSelect != null && chkSelect.Checked)
                    {
                        HiddenField hdnItemIdRow = (HiddenField)item.FindControl("hdnItemId");
                        objfp.ItemId = Convert.ToInt32(string.IsNullOrEmpty(hdnItemIdRow.Value) ? "0" : hdnItemIdRow.Value);
                        objfp.ItemName = ((TextBox)item.FindControl("txtItemName")).Text;
                        
                        string txtAmountVal = ((TextBox)item.FindControl("txtAmount")).Text;
                        objfp.Amount = Convert.ToDecimal(string.IsNullOrWhiteSpace(txtAmountVal) ? "0" : txtAmountVal);
                        
                        string txtMRPVal = ((TextBox)item.FindControl("txtMRP")).Text;
                        objfp.MRP = (int)(string.IsNullOrWhiteSpace(txtMRPVal) ? 0 : Convert.ToDecimal(txtMRPVal));
                        
                        objfp.ProductId = ((TextBox)item.FindControl("txtItemCode")).Text;
                        objfp.Brand = ((TextBox)item.FindControl("txtBrand")).Text;
                        objfp.Modal = ((TextBox)item.FindControl("txtModel")).Text;
                        objfp.Department = ((TextBox)item.FindControl("txtDepartment")).Text;
                        
                        string txtCashbackVal = ((TextBox)item.FindControl("txtCashback")).Text;
                        objfp.Cashback = string.IsNullOrWhiteSpace(txtCashbackVal) ? "0" : txtCashbackVal;
                        
                        objfp.Vendor = ((TextBox)item.FindControl("txtVendor")).Text;
                        objfp.ItemVolume = ((TextBox)item.FindControl("txtVolume")).Text;
                        objfp.ItemWidth = ((TextBox)item.FindControl("txtWidth")).Text;
                        objfp.ItemLength = ((TextBox)item.FindControl("txtLength")).Text;
                        objfp.ItemHeight = ((TextBox)item.FindControl("txtHeight")).Text;
                        objfp.ShippingPrice = ((TextBox)item.FindControl("txtShippingPrice")).Text;
                        objfp.ShippingWeight = ((TextBox)item.FindControl("txtShippingWeight")).Text;
                        objfp.HSNCode = ((TextBox)item.FindControl("txtHSNCode")).Text;
                        
                        objfp.colorId = 0; 

                        // Build SizeXml in <data><rows> format
                        string batchNo = ((TextBox)item.FindControl("txtBatchNo")).Text;
                        string size = ((TextBox)item.FindControl("txtSize")).Text;
                        string color1 = ((TextBox)item.FindControl("txtColor")).Text;
                        string stock = ((TextBox)item.FindControl("txtStock")).Text;
                        
                        string sizeXml = "<data><rows>";
                        sizeXml += "<BatchNo>" + batchNo + "</BatchNo>";
                        // BLL/SP expects bigint for SizeId, if sending text might fail unless handled in SP
                        sizeXml += "<SizeId>" + (string.IsNullOrWhiteSpace(size) ? "0" : size) + "</SizeId>";
                        sizeXml += "<ColorId>" + color1 + "</ColorId>";
                        sizeXml += "<Stock>" + (string.IsNullOrWhiteSpace(stock) ? "0" : stock) + "</Stock>";
                        sizeXml += "</rows></data>";
                        objfp.SizeXml = sizeXml;

                        // Image logic and XML
                        FileUpload fuItemImage = (FileUpload)item.FindControl("fuItemImage");
                        HiddenField hdnExistingImageRow = (HiddenField)item.FindControl("hdnExistingImage");
                        string finalImage = hdnExistingImageRow.Value;

                        if (fuItemImage != null && fuItemImage.HasFile)
                        {
                            string fileNameRow = Path.GetFileName(fuItemImage.FileName);
                            string path = Server.MapPath("~/Images/Items/");
                            fuItemImage.SaveAs(path + objfp.ItemId + "_" + fileNameRow);
                            finalImage = objfp.ItemId + "_" + fileNameRow;
                        }

                        // Build ItemMultipleImage XML in <data><rows> format
                        string imgXml = "<data><rows>";
                        imgXml += "<Attachment>" + finalImage + "</Attachment>";
                        imgXml += "<Title>" + finalImage + "</Title>";
                        imgXml += "<Tempattachment>" + finalImage + "</Tempattachment>";
                        imgXml += "</rows></data>";
                        objfp.ItemMultipleImage = imgXml;
                        objfp.ImageName = finalImage;

                        // Global/Static fields
                        if (!string.IsNullOrEmpty(hdnSupplier.Value))
                            objfp.SupplierId = Convert.ToInt32(hdnSupplier.Value);
                        if (!string.IsNullOrEmpty(hdnCategory.Value))
                            objfp.CategoryId = Convert.ToInt32(hdnCategory.Value);
                        if (!string.IsNullOrEmpty(hdnSubCategory.Value))
                            objfp.SubCategoryId = Convert.ToInt32(hdnSubCategory.Value);
                        if (!string.IsNullOrEmpty(hdnSubSubCategory.Value))
                            objfp.SubSubCategoryId = Convert.ToInt32(hdnSubSubCategory.Value);

                        objfp.Stock = string.IsNullOrWhiteSpace(stock) ? "0" : stock;
                        objfp.ItemPrice = (int)objfp.Amount;
                        objfp.Active = 1;
                        objfp.IsCoupanAvailable = 0;
                        objfp.COD = "No";
                        objfp.ImageSize = 0;

                        objfp.SaveItemPage();
                    }
                }
            }
            
            string redirectScript = "alert('Processing Complete');window.location.href=window.location.href;";
            ScriptManager.RegisterStartupScript(this, GetType(), "redirect", redirectScript, true);
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

                if (ddlColor != null && dtColor != null)
                {
                    ddlColor.DataSource = dtColor;
                    ddlColor.DataTextField = "Color";
                    ddlColor.DataValueField = "ColorId";
                    ddlColor.DataBind();
                    ddlColor.Items.Insert(0, new ListItem("--Color--", "0"));
                    if (hdnColorId != null && !string.IsNullOrEmpty(hdnColorId.Value))
                    {
                        var item = ddlColor.Items.FindByValue(hdnColorId.Value);
                        if (item != null) item.Selected = true;
                    }
                }

                if (ddlSize != null && dtSize != null)
                {
                    ddlSize.DataSource = dtSize;
                    ddlSize.DataTextField = "Size";
                    ddlSize.DataValueField = "SizeId";
                    ddlSize.DataBind();
                    ddlSize.Items.Insert(0, new ListItem("--Size--", "0"));
                    if (hdnSizeId != null && !string.IsNullOrEmpty(hdnSizeId.Value))
                    {
                        var item = ddlSize.Items.FindByValue(hdnSizeId.Value);
                        if (item != null) item.Selected = true;
                    }
                }
            }
        }
    }
}