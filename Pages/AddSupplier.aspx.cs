using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class AddSupplier : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Convert.ToString(Request["SupId"]) != "" && Convert.ToString(Request["SupId"]) != null)
            {
                hdnSupplierId.Value = Convert.ToString(Request["SupId"]);
                btnSave.Text = "Update";
            }
            else
            {
                btnSave.Text = "Save";
            }

            if (!IsPostBack)
            {
                BindPageLoadData();
            }
            Session["UserId"] = "1";
        }

        public void BindPageLoadData()
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.UserId = Convert.ToString(Session["UserId"]);
                DataSet SupplierData = objFp.GetSupplierData(Convert.ToInt32(hdnSupplierId.Value));
                if (SupplierData != null && SupplierData.Tables.Count > 0)
                {
                    if (SupplierData.Tables[0] != null && SupplierData.Tables[0].Rows.Count > 0)
                    {
                        ddlSupplierCategory.DataSource = SupplierData.Tables[0];
                        ddlSupplierCategory.DataTextField = "Suppliercategory";
                        ddlSupplierCategory.DataValueField = "SuppliercategoryId";
                        ddlSupplierCategory.DataBind();
                    }
                    ddlSupplierCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));

                    if (SupplierData.Tables[1] != null && SupplierData.Tables[1].Rows.Count > 0)
                    {
                        ddlSupplierType.DataSource = SupplierData.Tables[1];
                        ddlSupplierType.DataTextField = "Name";
                        ddlSupplierType.DataValueField = "id";
                        ddlSupplierType.DataBind();
                    }
                    ddlSupplierType.Items.Insert(0, new ListItem("--Select Supplier Type--", "0"));

                    if (SupplierData.Tables[2] != null && SupplierData.Tables[2].Rows.Count > 0)
                    {
                        ddlCountry.DataSource = SupplierData.Tables[2];
                        ddlCountry.DataTextField = "Country";
                        ddlCountry.DataValueField = "CountryId";
                        ddlCountry.DataBind();
                    }
                    ddlCountry.Items.Insert(0, new ListItem("--Select Country--", "0"));

                    if (SupplierData.Tables[3] != null && SupplierData.Tables[3].Rows.Count > 0)
                    {
                        ddlState.DataSource = SupplierData.Tables[3];
                        ddlState.DataTextField = "StateName";
                        ddlState.DataValueField = "StateID";
                        ddlState.DataBind();
                    }
                    ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
                    if (SupplierData.Tables[3] != null && SupplierData.Tables[3].Rows.Count > 0)
                    {
                        ddlGStState.DataSource = SupplierData.Tables[3];
                        ddlGStState.DataTextField = "StateName";
                        ddlGStState.DataValueField = "StateID";
                        ddlGStState.DataBind();
                    }
                    ddlGStState.Items.Insert(0, new ListItem("--Select State--", "0"));

                    if (SupplierData.Tables[7] != null && SupplierData.Tables[7].Rows.Count > 0)
                    {
                        ddlItemCategory.DataSource = SupplierData.Tables[7];
                        ddlItemCategory.DataTextField = "Category";
                        ddlItemCategory.DataValueField = "CategoryId";
                        ddlItemCategory.DataBind();
                    }
                    ddlItemCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));
                    ddlItemSubCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));

                    if (SupplierData.Tables[4] != null && SupplierData.Tables[4].Rows.Count > 0)
                    {
                        //SupplierData.Tables[4].Rows[0][""]
                        txtSupplierName.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["SupplierName"]);
                        txtSupplierCode.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["SupplierCode"]);
                        ddlSupplierType.Items.FindByValue(Convert.ToString(SupplierData.Tables[4].Rows[0]["SupplierType"])).Selected = true;
                        ddlSupplierCategory.Items.FindByValue(Convert.ToString(SupplierData.Tables[4].Rows[0]["SupplierCategory"])).Selected = true;
                        txtHouseOfficeNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["HouseNo"]);
                        txtStreetBuildingLocality.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Street"]);
                        ddlCountry.Items.FindByValue(Convert.ToString(SupplierData.Tables[4].Rows[0]["Country"])).Selected = true;
                        ddlState.Items.FindByValue(Convert.ToString(SupplierData.Tables[4].Rows[0]["State"])).Selected = true;
                        txtPinCode.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PinCode"]);
                        txtLandline.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Landline"]);
                        txtFaxNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["FaxNo"]);
                        txtEmailid.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["EmailId"]);
                        txtWebSite.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Website"]);
                        txtPrimaryContactPerson.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PrimaryContactPerson"]);
                        txtPrimaryDestination.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PrimaryContactPersonDesignation"]);
                        txtPrimaryMobile.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PrimaryContactPersonMobileNo"]);
                        txtPrimaryEmail.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PrimaryContactPersonEmailId"]);
                        txtSecondaryContactPerson.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["SecondaryContactPerson"]);
                        txtsecondaryDestination.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["SecondaryContactPersonDesignation"]);
                        txtSecondaryMobile.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["SecondaryContactPersonMobileNo"]);
                        txtSecondaryEmail.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["SecondaryContactPersonEmailId"]);
                        txtTANno.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["CINNo"]);
                        txtPFRegistrationNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PFRegistartionNo"]);
                        txtNameOnPAN.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["NameonPANCard"]);
                        txtPANNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PANCardNo"]);
                        txtROCNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["ROCNo"]);
                        txtESIRegistrationNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["ESIRegistrationNo"]);
                        txtISOCertificateNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["ISOCertificationNo"]);
                        txtISOValidUpTo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["ISOValidUpto"]);
                        txtPollutionCB.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PollutioncontrolBoardCertificationNo"]);
                        txtPollutionValidUpTo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PollutionValidUpto"]);
                        txtBank1.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank1"]);
                        txtBankBranch.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank1Branch"]);
                        txtBankAccNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank1AccountsNo"]);
                        txtBank2RtgsIfsc.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank1IFSCCode"]);
                        txtAddress1bank.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank1Address1"]);
                        txtAddress2bank.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank1Address2"]);
                        txtCitybank.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank1City"]);
                        txtStateBank.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank1State"]);
                        txtBanker2.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank2"]);
                        txtBank2Branch.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank2Branch"]);
                        txtBank2BankaccNo.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank2AccountsNo"]);
                        txtBank2RtgsIfsc.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank2IFSCCode"]);
                        txtBank2Address1.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank2Address1"]);
                        txtBank2Address2.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank2Address2"]);
                        txtBank2City.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank2City"]);
                        txtBank2State.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Bank2State"]);
                        txtPaymentTerms.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["PaymentTerms"]);
                        txtTaxes.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["Taxes"]);
                        txtDeliveryTerms.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["DeliveryTerms"]);
                        txtVendorToNote.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["VendorToNotes"]);
                        txtCreditLimit.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["CreditLimit"]);
                        if (Convert.ToBoolean(SupplierData.Tables[4].Rows[0]["IsActive"]))
                            chkActive.Checked = true;
                        else
                            chkActive.Checked = false;

                        if (Convert.ToBoolean(SupplierData.Tables[4].Rows[0]["IsLoginRequired"]))
                            chkIsLoginRequired.Checked = true;
                        else
                            chkIsLoginRequired.Checked = false;
                        if (Convert.ToBoolean(SupplierData.Tables[4].Rows[0]["IsAutoRejectPO"]))
                            chkAutoClosePO.Checked = true;
                        else
                            chkAutoClosePO.Checked = false;


                        //if (chkActive.Checked)
                        //    IsActive = true;
                        //else
                        //    IsActive = false;                        
                        txtSellerPassword.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["LoginPassword"]);
                        //if (chkIsLoginRequired.Checked)
                        //    IsLoginRequired = true;
                        //else
                        //    IsLoginRequired = false;
                        txtSellerUserName.Text = Convert.ToString(SupplierData.Tables[4].Rows[0]["LoginUserName"]);
                        if (DBNull.Value == SupplierData.Tables[4].Rows[0]["ItemCategory"])
                        {
                            ddlItemCategory.Items.FindByValue("0").Selected = true;
                        }
                        else
                        {
                            ddlItemCategory.Items.FindByValue(Convert.ToString(SupplierData.Tables[4].Rows[0]["ItemCategory"])).Selected = true;
                        }
                        #region "sub category"
                        if (DBNull.Value == SupplierData.Tables[4].Rows[0]["ItemCategory"] || Convert.ToString(SupplierData.Tables[4].Rows[0]["ItemCategory"]) == "0")
                        {

                        }
                        else
                        {
                            if (ddlItemSubCategory.SelectedValue != "0")
                            {
                                ddlItemSubCategory.ClearSelection();
                                ddlItemSubCategory.Items.FindByValue("0").Selected = true;
                            }
                            using (BusinessLogicLayer objbu = new BusinessLogicLayer())
                            {
                                objbu.CategoryId = Convert.ToInt32(Convert.ToString(SupplierData.Tables[4].Rows[0]["ItemCategory"]));
                                DataSet dsSubCat = objbu.GetSubCategory();
                                if (dsSubCat.Tables[0] != null && dsSubCat.Tables[0].Rows.Count > 0)
                                {
                                    ddlItemSubCategory.DataSource = dsSubCat.Tables[0];
                                    ddlItemSubCategory.DataTextField = "SubCategory";
                                    ddlItemSubCategory.DataValueField = "SubCategoryId";
                                    ddlItemSubCategory.DataBind();
                                    ddlItemSubCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));
                                }
                            }
                            ddlItemSubCategory.Items.FindByValue(Convert.ToString(SupplierData.Tables[4].Rows[0]["ItemSubCategory"])).Selected = true;
                        }
                        #endregion

                        //if (chkAutoClosePO.Checked)
                        //    IsAutoRejectPO = true;
                        //else
                        //    IsAutoRejectPO = false;
                        //hdnAddAnnualTurnover.Value = Convert.ToString(SupplierData.Tables[4].Rows[0]["FinancialDetails"]);
                        //hdnGstDetails.Value = Convert.ToString(SupplierData.Tables[4].Rows[0]["GstDetails"]);
                    }

                    if (SupplierData.Tables[5] != null && SupplierData.Tables[5].Rows.Count > 0)
                    {
                        string finyear = "";
                        string annualturnover = "";
                        foreach (DataRow dr in SupplierData.Tables[5].Rows)
                        {
                            finyear += dr["FinancialYear"].ToString() + "@";
                            annualturnover += dr["AnnualTurnover"].ToString() + "@";
                        }
                        finyear = finyear.TrimEnd('@');
                        annualturnover = annualturnover.TrimEnd('@');
                        ClientScript.RegisterStartupScript(GetType(), "startup1", "<script>financedata('" + finyear + "', '" + annualturnover + "');</script>");
                    }
                    if (SupplierData.Tables[6] != null && SupplierData.Tables[6].Rows.Count > 0)
                    {
                        string Supplier = "";
                        string StateId = "";
                        string State = "";
                        string GST_No = "";
                        string Address = "";
                        foreach (DataRow dr in SupplierData.Tables[6].Rows)
                        {
                            Supplier += Convert.ToString(dr["supplierID"]) + "@";
                            StateId += Convert.ToString(dr["StateID"]) + "@";
                            State += Convert.ToString(dr["State"]) + "@";
                            GST_No += Convert.ToString(dr["GST_No"]) + "@";
                            Address += Convert.ToString(dr["Address"]) + "@";
                        }
                        Supplier = Supplier.TrimEnd('@');
                        StateId = StateId.TrimEnd('@');
                        State = State.TrimEnd('@');
                        GST_No = GST_No.TrimEnd('@');
                        Address = Address.TrimEnd('@');
                        ClientScript.RegisterStartupScript(GetType(), "startup2", "<script>gstdata('" + Supplier + "', '" + StateId + "', '" + State + "', '" + GST_No + "', '" + Address + "');</script>");
                    }
                }
            }
        }

        public void SaveSupplierData()
        {
            using (Supplier objSupplier = new Supplier())
            {
                if (Convert.ToInt32(hdnSupplierId.Value) > 0)
                    objSupplier.SupplierID = Convert.ToInt32(hdnSupplierId.Value);
                else
                    objSupplier.SupplierID = 0;
                objSupplier.SupplierName = txtSupplierName.Text;
                //objSupplier.SupplierNameAHLL = "";
                objSupplier.SupplierCode = txtSupplierCode.Text;
                objSupplier.SupplierType = ddlSupplierType.SelectedValue;
                objSupplier.SupplierCategory = ddlSupplierCategory.SelectedValue;
                //objSupplier.OrganizationType = ;
                objSupplier.HouseNo = txtHouseOfficeNo.Text;
                objSupplier.Street = txtStreetBuildingLocality.Text;
                objSupplier.Country = ddlCountry.SelectedValue;
                objSupplier.State = ddlState.SelectedValue;
                objSupplier.PinCode = txtPinCode.Text;
                objSupplier.Landline = txtLandline.Text;
                objSupplier.FaxNo = txtFaxNo.Text;
                objSupplier.EmailId = txtEmailid.Text;
                objSupplier.Website = txtWebSite.Text;
                objSupplier.PrimaryContactPerson = txtPrimaryContactPerson.Text;
                objSupplier.PrimaryContactPersonDesignation = txtPrimaryDestination.Text;
                objSupplier.PrimaryContactPersonMobileNo = txtPrimaryMobile.Text;
                objSupplier.PrimaryContactPersonEmailId = txtPrimaryEmail.Text;
                objSupplier.SecondaryContactPerson = txtSecondaryContactPerson.Text;
                objSupplier.SecondaryContactPersonDesignation = txtsecondaryDestination.Text;
                objSupplier.SecondaryContactPersonMobileNo = txtSecondaryMobile.Text;
                objSupplier.SecondaryContactPersonEmailId = txtSecondaryEmail.Text;
                objSupplier.CINNo = txtTANno.Text;
                objSupplier.PFRegistartionNo = txtPFRegistrationNo.Text;
                objSupplier.NameonPANCard = txtNameOnPAN.Text;
                objSupplier.PANCardNo = txtPANNo.Text;
                objSupplier.ROCNo = txtROCNo.Text;
                objSupplier.ESIRegistrationNo = txtESIRegistrationNo.Text;
                objSupplier.ISOCertificationNo = txtISOCertificateNo.Text;
                objSupplier.ISOValidUpto = txtISOValidUpTo.Text;
                objSupplier.PollutioncontrolBoardCertificationNo = txtPollutionCB.Text;
                objSupplier.PollutionValidUpto = txtPollutionValidUpTo.Text;
                objSupplier.Bank1 = txtBank1.Text;
                objSupplier.Bank1Branch = txtBankBranch.Text;
                objSupplier.Bank1AccountsNo = txtBankAccNo.Text;
                objSupplier.Bank1IFSCCode = txtBank2RtgsIfsc.Text;
                objSupplier.Bank1Address1 = txtAddress1bank.Text;
                objSupplier.Bank1Address2 = txtAddress2bank.Text;
                objSupplier.Bank1City = txtCitybank.Text;
                objSupplier.Bank1State = txtStateBank.Text;
                objSupplier.Bank2 = txtBanker2.Text;
                objSupplier.Bank2Branch = txtBank2Branch.Text;
                objSupplier.Bank2AccountsNo = txtBank2BankaccNo.Text;
                objSupplier.Bank2IFSCCode = txtBank2RtgsIfsc.Text;
                objSupplier.Bank2Address1 = txtBank2Address1.Text;
                objSupplier.Bank2Address2 = txtBank2Address2.Text;
                objSupplier.Bank2City = txtBank2City.Text;
                objSupplier.Bank2State = txtBank2State.Text;
                objSupplier.PaymentTerms = txtPaymentTerms.Text;
                objSupplier.Taxes = txtTaxes.Text;
                objSupplier.DeliveryTerms = txtDeliveryTerms.Text;
                objSupplier.VendorToNotes = txtVendorToNote.Text;
                objSupplier.CreditLimit = txtCreditLimit.Text;
                if (chkActive.Checked)
                    objSupplier.IsActive = true;
                else
                    objSupplier.IsActive = false;
                //objSupplier.CreaterDateTime = ;
                objSupplier.CreaterID = Convert.ToInt32(Session["UserId"]);
                //objSupplier.UpdateDate = "";
                objSupplier.UpdatedBy = Convert.ToInt32(Session["UserId"]);
                //objSupplier.CheckedDate = "";
                objSupplier.CheckedBy = Convert.ToInt32(Session["UserId"]);
                //objSupplier.ApprovedDate = "";
                objSupplier.ApprovedBy = Convert.ToInt32(Session["UserId"]);
                //objSupplier.ApprovalStatus = "";

                objSupplier.LoginPassword = txtSellerPassword.Text;
                if (chkIsLoginRequired.Checked)
                    objSupplier.IsLoginRequired = true;
                else
                    objSupplier.IsLoginRequired = false;
                objSupplier.LoginUserName = txtSellerUserName.Text;
                if (chkAutoClosePO.Checked)
                    objSupplier.IsAutoRejectPO = true;
                else
                    objSupplier.IsAutoRejectPO = false;

                objSupplier.FinancialDetails = hdnAddAnnualTurnover.Value;
                objSupplier.GstDetails = hdnGstDetails.Value;
                objSupplier.ItemCategory = Convert.ToInt32(ddlItemCategory.SelectedValue);
                objSupplier.ItemSubCategory = Convert.ToInt32(ddlItemSubCategory.SelectedValue);
                //objSupplier.AutoRejectPOAfterDays = ;
                //objSupplier.IsMSMERegistration = "";
                //objSupplier.MSMERegistrationNo = "";
                //objSupplier.MSMERegistrationValidDate = "";
                BusinessLogicLayer objB = new BusinessLogicLayer();
                DataTable dt = objB.SaveSupplierData(objSupplier);
                if (dt != null && dt.Rows.Count > 0)
                {
                    ClientScript.RegisterStartupScript(GetType(), "startup3", "<script>alert('Data saved successfully.');</script>");
                    //Response.Redirect("SupplierList.aspx");
                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), "startup4", "<script>alert('Data not saved successfully.');</script>");
                }

            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveSupplierData();
        }

        protected void ddlItemCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlItemSubCategory.SelectedValue != "0")
            {
                ddlItemSubCategory.ClearSelection();
                ddlItemSubCategory.Items.FindByValue("0").Selected = true;
            }
            using (BusinessLogicLayer objbu = new BusinessLogicLayer())
            {
                objbu.CategoryId = Convert.ToInt32(ddlItemCategory.SelectedValue);
                DataSet dsSubCat = objbu.GetSubCategory();
                if (dsSubCat.Tables[0] != null && dsSubCat.Tables[0].Rows.Count > 0)
                {
                    ddlItemSubCategory.DataSource = dsSubCat.Tables[0];
                    ddlItemSubCategory.DataTextField = "SubCategory";
                    ddlItemSubCategory.DataValueField = "SubCategoryId";
                    ddlItemSubCategory.DataBind();
                    ddlItemSubCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));
                }
            }
        }
    }
}