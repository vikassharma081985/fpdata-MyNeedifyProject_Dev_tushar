<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="AddOrganization.aspx.cs" Inherits="WSBillingMaster.Pages.AddOrganization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="//cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        .OrganizationHeader {
            border: 1px solid #ccc;
            margin-top: 0.5%;
            text-align: center;
            font-weight: bold;
            padding: 15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="OrganizationHeader">
            Add Organization
        </div>
        <div style="padding-top: 1em;"></div>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Seller Name</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtFirstName" class="form-control" placeholder="Enter Your First name" tabindex="1" autocomplete="off" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" id="txtLastName" class="form-control" placeholder="Enter Your Last name" tabindex="2" autocomplete="off" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Brand Name</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtBrandName" class="form-control" placeholder="Enter Organization Brand name" tabindex="3" autocomplete="off" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Display Name</label><span style="color: saddlebrown; font-size: xx-small;">(*display same as brand name by default)</span>
                            <input type="text" id="txtDisplayName" class="form-control" placeholder="Enter Organization display name" tabindex="4" autocomplete="off" />

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>GST Number</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtGST" class="form-control text-uppercase" placeholder="Enter Your GST name" tabindex="5" autocomplete="off" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Seller Address</label>
                            <input type="text" id="txtSelleraddress" class="form-control" placeholder="Enter Your Address" tabindex="6" autocomplete="off" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Select Category</label>&nbsp;<span style="color: red;">*</span>
                            <select id="ddlCategory" class="form-control" tabindex="7"></select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Mobile Number</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtMobile" class="form-control" placeholder="Enter Your Mobile number" tabindex="8" maxlength="10" autocomplete="off" />
                            <span>
                                <input type="radio" name="rdo" id="chkmobile" /></span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Landline number</label>
                            <input type="text" id="txtLandline" class="form-control" placeholder="Enter Your Landline number" tabindex="9" autocomplete="off" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Email Id</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtEmailid" class="form-control" tabindex="10" placeholder="noreply@yourdomain.com" autocomplete="off" />
                            <span>
                                <input type="radio" name="rdo" id="chkemail" /></span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Website</label>
                            <input type="text" id="txtwebsite" class="form-control" placeholder="www.yourdomain.com" tabindex="11" autocomplete="off" />
                        </div>
                    </div>
                </div>
                <!-- Added Latitude and Longitude Fields -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Latitude</label>
                            <input type="text" id="txtLatitude" class="form-control" placeholder="Enter Latitude" tabindex="12" autocomplete="off" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Longitude</label>
                            <input type="text" id="txtLongitude" class="form-control" placeholder="Enter Longitude" tabindex="13" autocomplete="off" />
                        </div>
                    </div>

                    <div class="col-md-3">
    <div class="form-group">
        <label>State</label>
        <input type="text" id="txtstate" class="form-control" placeholder="Enter State" tabindex="13" autocomplete="off" />
    </div>
</div>


                                        <div class="col-md-3">
    <div class="form-group">
        <label>City</label>
        <input type="text" id="txtcity" class="form-control" placeholder="Enter City" tabindex="13" autocomplete="off" />
    </div>
</div>


                                                            <div class="col-md-3">
    <div class="form-group">
        <label>Location</label>
        <input type="text" id="txtloc" class="form-control" placeholder="Enter Location" tabindex="13" autocomplete="off" />
    </div>
</div>


                                                            <div class="col-md-3">
    <div class="form-group">
        <label>Pincode</label>
        <input type="text" id="txtpincode" class="form-control" placeholder="Enter Pincode" tabindex="13" autocomplete="off" />
    </div>
</div>


                </div>
                <!-- End Added Fields -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Password</label>&nbsp;<span style="color: red;">*</span>
                            <input type="password" id="txtpassword" class="form-control" placeholder="Enter Your Password" tabindex="14" autocomplete="off" maxlength="15" />
                            <span toggle="#password-field" class="fa fa-fw fa-eye field_icon toggle-password"></span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Confirm Password</label>&nbsp;<span style="color: red;">*</span>
                            <input type="password" id="txtconfirmpassword" class="form-control" placeholder="Confirm your password" tabindex="15" autocomplete="off" maxlength="15" />
                            <span toggle="#confpassword-field" class="fa fa-fw fa-eye field_icon toggle-cfpassword"></span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Upload Image</label><span style="color: red;">(.jpg, .jpeg, .png) </span>
                            <input type="file" id="flUpload" class="form-control" onchange="sendFile(this);" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <img id="myuploadImg" alt="View Image" style="width: 180px;" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <button type="button" class="btn btn-primary" id="btnSaveDetails">Save</button>
                        <input type="hidden" id="hdnSellerId" value="" />
                        <!-- <button type="button" class="btn btn-secondary" id="btnclosepopup">Close</button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="//cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="../Js/Custom/AddOrganization.js"></script>
</asp:Content>
