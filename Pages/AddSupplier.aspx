<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="AddSupplier.aspx.cs" Inherits="WSBillingMaster.Pages.AddSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Jscript/AddSupplier.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="max-width: 1170px; margin: 0 auto; margin-top: 8%; background-color: #fff; padding: 30px; min-height: 1300px;">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-right: 0px; padding-left: 0px;">
                <%--<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6" style="font-size: 20px; font-family: Arial; color: #000; font-weight: bold; padding-left: 0px;">Add Saller</div>--%>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="background-color: aqua;">
            Supplier Details
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Supplier Name <font color="red">*</font>
                <asp:HiddenField ID="hdnSupplierId" Value="0" runat="server" />
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtSupplierName" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Supplier Code <font color="red">*</font>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtSupplierCode" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Supplier Type
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <div style="width: 100%; float: left;">
                    <div style="width: 50%; float: left;">
                        <asp:DropDownList ID="ddlSupplierType" CssClass="BoxText" runat="server"></asp:DropDownList>
                    </div>
                    <div style="width: 50%; float: left; text-align: right">
                        <asp:CheckBox ID="chkActive" runat="server" Text="Active" Checked="true" />
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace" style="display: none;">
                Supplier Category
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace" style="display: none;">
                <asp:DropDownList ID="ddlSupplierCategory" CssClass="BoxText" runat="server"></asp:DropDownList>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                        Item Category
                    </div>
                    <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                        <asp:DropDownList ID="ddlItemCategory" CssClass="BoxText" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlItemCategory_SelectedIndexChanged"></asp:DropDownList>

                    </div>
                    <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace" style="display: none;">
                        Item Sub-Category
                    </div>
                    <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace" style="display: none;">
                        <asp:DropDownList ID="ddlItemSubCategory" CssClass="BoxText" runat="server"></asp:DropDownList>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlItemCategory" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace" style="display: none;">
                Organization Type
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace" style="display: none;">
                <asp:DropDownList ID="txtOrganizationType" CssClass="BoxText" runat="server"></asp:DropDownList>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                House No./Office No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtHouseOfficeNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Street/Building/Locality
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtStreetBuildingLocality" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Country
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="BoxText"></asp:DropDownList>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                State
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:DropDownList ID="ddlState" CssClass="BoxText" runat="server"></asp:DropDownList>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                PinCode
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPinCode" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Landline
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtLandline" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Fax No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtFaxNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Email Id
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtEmailid" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                WebSite
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtWebSite" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="background-color: aqua;">
            Concern Person Details
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Primary Contact Person
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPrimaryContactPerson" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Destination
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPrimaryDestination" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Mobile
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPrimaryMobile" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Email
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPrimaryEmail" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Secondary Contact Person
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtSecondaryContactPerson" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Destination
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtsecondaryDestination" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Mobile
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtSecondaryMobile" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Email
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtSecondaryEmail" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="background-color: aqua;">
            Statutory/MSME/PAN Registration Information
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                TAN No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtTANno" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                PF Registration No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPFRegistrationNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Name On PAN Card
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtNameOnPAN" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                PAN Card No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPANNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                ROC No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtROCNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                ESI Registration No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtESIRegistrationNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                ISO Certificate No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtISOCertificateNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Valid UpTo
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtISOValidUpTo" CssClass="form-control datepicker" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Pollution control Board certification No
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPollutionCB" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Valid UpTo
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPollutionValidUpTo" CssClass="form-control datepicker" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                MSME Registration
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:CheckBox ID="chkIsMSMEreg" runat="server" Checked="true" />
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Valid UpTo
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtMSMEValidUpTo" CssClass="form-control datepicker" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="background-color: aqua;">
            Bank Details
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Bank 1
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBank1" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Branch
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBankBranch" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Bank Account No 
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBankAccNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                RTGS/IFSC Code
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtRtgsIfsc" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Address
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtAddress1bank" placeholder="Address 1" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtAddress2bank" placeholder="Address 2" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtCitybank" CssClass="BoxText" placeholder="City" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtStateBank" CssClass="BoxText" placeholder="State" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Banker 2
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBanker2" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Branch
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBank2Branch" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Bank Account No 
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBank2BankaccNo" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                RTGS/IFSC Code
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBank2RtgsIfsc" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Address
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBank2Address1" placeholder="Address 1" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBank2Address2" placeholder="Address 2" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBank2City" CssClass="BoxText" placeholder="City" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtBank2State" CssClass="BoxText" placeholder="State" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
        </div>

        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="background-color: aqua;">
            Financial Details
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-6 col-sm-6 col-lg-6 TopSpace">
                <div style="width: 100%; float: left;">
                    <div style="width: 15%; float: left;">
                        <asp:DropDownList runat="server" ID="ddlFiancialYear">
                            <asp:ListItem>2015</asp:ListItem>
                            <asp:ListItem>2016</asp:ListItem>
                            <asp:ListItem>2017</asp:ListItem>
                            <asp:ListItem>2018</asp:ListItem>
                            <asp:ListItem>2019</asp:ListItem>
                            <asp:ListItem>2020</asp:ListItem>
                            <asp:ListItem>2021</asp:ListItem>
                            <asp:ListItem>2022</asp:ListItem>
                            <asp:ListItem>2023</asp:ListItem>
                            <asp:ListItem>2024</asp:ListItem>
                            <asp:ListItem>2025</asp:ListItem>
                            <asp:ListItem>2026</asp:ListItem>
                            <asp:ListItem>2027</asp:ListItem>
                            <asp:ListItem>2028</asp:ListItem>
                            <asp:ListItem>2029</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div style="width: 60%; float: left;">
                        <asp:TextBox ID="txtAnnualTurnover" CssClass="BoxText" placeholder="Annual Turnover in Lacks" runat="server"></asp:TextBox>
                        <asp:HiddenField ID="hdnAddAnnualTurnover" Value="" runat="server" />
                    </div>
                    <div style="width: 20%; float: right;">
                        <asp:Button ID="btnAnnualTurnoverAdd" runat="server" Text="Add" OnClientClick="return AddAnnualTurnover()" />
                    </div>
                </div>

            </div>
            <div class="col-xs-12 col-md-6 col-sm-6 col-lg-6 TopSpace">
                <table border="1" id="tblAnnualTurnover">
                    <thead>
                        <th style="padding: 10px 10px 10px 10px;">Sr No</th>
                        <th style="padding: 10px 10px 10px 10px;">Financial Year</th>
                        <th style="padding: 10px 10px 10px 10px;">Annual Turnover in Lacks</th>
                        <th style="padding: 10px 10px 10px 10px;">Remove</th>
                    </thead>
                </table>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="background-color: aqua;">
            GST Details
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-6 col-sm-6 col-lg-6 TopSpace">
                <div style="width: 100%; float: left;">
                    <div style="width: 15%; float: left;">
                        <asp:DropDownList runat="server" ID="ddlGStState" CssClass="BoxText">
                        </asp:DropDownList>
                        <asp:HiddenField ID="hdnGstDetails" Value="" runat="server" />
                    </div>
                    <div style="width: 50%; float: left;">
                        <asp:TextBox ID="txtGstAddress" CssClass="BoxText" placeholder="Address" runat="server"></asp:TextBox>
                    </div>
                    <div style="width: 25%; float: left;">
                        <asp:TextBox ID="txtGstNumber" CssClass="BoxText" placeholder="GST No" runat="server"></asp:TextBox>
                    </div>
                    <div style="width: 10%; float: left;">
                        <asp:Button ID="btnAddGst" runat="server" Text="Add" OnClientClick="return AddGstDetails()" />
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-md-6 col-sm-6 col-lg-6 TopSpace">
                <table border="1" id="tblGstDetails">
                    <thead>
                        <th style="padding: 10px 10px 10px 10px;">Sr No</th>
                        <th style="padding: 10px 10px 10px 10px;">State</th>
                        <th style="padding: 10px 10px 10px 10px;">Address</th>
                        <th style="padding: 10px 10px 10px 10px;">GSTIN No</th>
                        <th style="padding: 10px 10px 10px 10px;">Remove</th>
                    </thead>
                </table>
            </div>
        </div>

        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="background-color: aqua;">
            Term & Condition
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Payment Terms
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtPaymentTerms" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Taxes
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtTaxes" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Delivery Terms
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtDeliveryTerms" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Vendor To Notes
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtVendorToNote" CssClass="BoxText" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Credit Limit
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <asp:TextBox ID="txtCreditLimit" CssClass="BoxText" placeholder="Months" runat="server"></asp:TextBox>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
        </div>

        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="background-color: aqua;">
            Login and Auto PO Close Detail
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Is Login Required
                <asp:CheckBox ID="chkIsLoginRequired" runat="server" Checked="true" />
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <div style="width: 100%; float: left;">
                    <div style="width: 50%; float: left;">
                        User Name
                    </div>
                    <div style="width: 50%; float: left;">
                        <asp:TextBox ID="txtSellerUserName" CssClass="BoxText" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <div style="width: 100%; float: left;">
                    <div style="width: 50%; float: left;">
                        Password
                    </div>
                    <div style="width: 50%; float: left;">
                        <asp:TextBox ID="txtSellerPassword" TextMode="Password" CssClass="BoxText" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <div style="width: 100%; float: left;">
                    <div style="width: 50%; float: left;">
                        Confirm Password:
                    </div>
                    <div style="width: 50%; float: left;">
                        <asp:TextBox ID="txtsellerConfirmPassword" TextMode="Password" CssClass="BoxText" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                Auto Close PO
                <asp:CheckBox ID="chkAutoClosePO" runat="server" Checked="true" />
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                <div style="width: 100%; float: left;">
                    <div style="width: 50%; float: left;">Close PO After (In Days)</div>
                    <div style="width: 50%; float: left;">
                        <asp:TextBox ID="txtClosePoAfter" CssClass="BoxText" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
            <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
            </div>
        </div>

        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row TopSpace" style="margin-bottom: 100px;">
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="return ValidateSave();" OnClick="btnSave_Click" />
        </div>
    </div>
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".datepicker").datepicker(
                { dateFormat: 'dd-M-yy' }
            );
        });
    </script>
</asp:Content>
