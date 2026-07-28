<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="FaduPrice.Pages.MyAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="/resources/demos/style.css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <script src="../Js/jquery-ui.js"></script>

    <script>
        $(function () {
            $("#accordion").accordion();
        });
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var file = document.getElementById("<%= fuSignature.ClientID %>");

            file.onchange = function () {
                if (this.files.length > 0) {
                    document.getElementById("lblFileName").innerHTML =
                        this.files[0].name;
                }
            };
        });
    </script>

    <style>
        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
            border: 1px solid #F6861F;
            background: #F6861F;
            font-weight: normal;
            color: #ffffff;
            padding: 5px !important;
            font-size: 16px !important;
            font-family: raleway;
            /*height: 28px !important;*/
        }


        .MyClass {
            font-family: raleway;
            color: #999;
            padding: 20px !important;
            width: 100%;
            height: auto !important;
        }

        label {
            display: inline-block;
            max-width: 100%;
            margin-bottom: 5px;
            margin-left: 5px;
            /* font-size: 17px; */
            font-weight: 500 !important;
        }

        .Section {
            text-align: left;
            color: #999;
            font-size: 16px;
            margin-left: 0px !important;
            margin-right: 0px !important;
        }

        .ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button {
            font-family: Arial !important;
            font-size: 13px !important;
        }

        .form-control {
            display: block;
            width: 100%;
            height: 30px !important;
            padding: 6px 12px;
            font-size: 10px;
            line-height: 1.24;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #dddfe2;
            border-radius: 2px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
            -webkit-transition: border-color ease-in-out 0.15s,box-shadow ease-in-out 0.15s;
            -o-transition: border-color ease-in-out 0.15s,box-shadow ease-in-out 0.15s;
            transition: border-color ease-in-out 0.15s,box-shadow ease-in-out 0.15s;
        }

    </style>


<style>
.address-wrapper {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

.address-card {
    width: 320px;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 15px;
    background: #fff;
    position: relative;
    transition: 0.3s;
}

.address-card:hover {
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
}

.default-badge {
    position: absolute;
    top: 10px;
    right: 10px;
    background: #e7f3ff;
    color: #007185;
    font-size: 12px;
    padding: 3px 8px;
    border-radius: 4px;
}

.address-name {
    font-weight: 600;
    margin-bottom: 5px;
}

.address-actions {
    margin-top: 10px;
    font-size: 14px;
}

.address-actions a {
    color: #007185;
    text-decoration: none;
    margin-right: 8px;
}


.address-card {
    border: 1px solid #ddd;
    border-radius: 8px;
    background: #f8f9fa;
    padding: 10px;
    transition: 0.3s ease;
}

.address-card:hover {
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    transform: translateY(-2px);
}
</style>


    <style>

        .MyClass {
    background: #fff;
    border-radius: 20px;
    padding: 25px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    margin-top: 20px;
}

.profile-card {
    background: #fff;
    border-radius: 25px;
    padding: 25px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    margin-bottom: 30px;
}

.profile-img {
    width: 110px;
    height: 110px;
    border-radius: 50%;
    background: #FFE9E4;
    padding: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,.12);
}

.profile-title {
    font-size: 28px;
    font-weight: 700;
    color: #111;
}

.profile-subtitle {
    color: #666;
    font-size: 15px;
    margin-top: 5px;
}

.profile-badge {
    display: inline-block;
    margin-top: 12px;
    padding: 6px 18px;
    border: 1px solid #ff6a3d;
    color: #ff6a3d;
    border-radius: 20px;
    font-size: 13px;
    background: #fff5f2;
}

.field-label {
    display: block;
    font-size: 15px;
    font-weight: 600;
    color: #333;
    margin-bottom: 8px;
    margin-top: 10px;
}

.form-control {
    height: 46px;
    border-radius: 25px;
    border: 1px solid #e5e5e5;
    box-shadow: none;
}

.btn-default {
    background: #7C519B;
    color: #fff;
    border-radius: 25px;
    padding: 10px 35px;
    border: none;
    font-weight: 600;
}

.btn-default:hover {
    background: #69448a;
}

.field-label {
    display: block;
    font-size: 15px;
    font-weight: 600 !important;
    color: #333;
    margin-bottom: 8px;
    margin-top: 10px;
}



.address-title h2 {
    font-size: 36px;
    font-weight: 700;
    margin: 0;
    color: #111827;
}
.address-title p {
    color: #777;
    margin-top: 5px;
    font-size: 15px;
}

.add-btn {
    background: #F4512D;
    color: #fff;
    border: none;
    padding: 12px 28px;
    border-radius: 30px;
    font-size: 17px;
    font-weight: 600;
}

.add-btn:hover {
    background: #e54621;
}

.address-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    width:100%;
    margin-bottom:30px;
}

#divNewAdress{
    width:100%;
    max-width:1260px;
    margin:0 auto 30px auto;
}

.address-card{
    width:100%;
    background:#fff;
    border-radius:25px;
    padding:30px;
    box-shadow:0 5px 18px rgba(0,0,0,.12);
}
.btn-save {
    background: #F4512D;
    color: #fff;
    border: none;
    border-radius: 30px;
    padding: 10px 35px;
    font-size: 17px;
}

.btn-cancel {
    border: none;
    background: transparent;
    font-size: 17px;
    margin-right: 20px;
}




.gender-card {
    position: relative;
    background: #F8F8F8;
    border: 2px solid #F0F0F0;
    border-radius: 20px;
    padding: 25px;
    text-align: center;
    cursor: pointer;
    transition: .3s;
    margin-bottom: 15px;
}

.gender-card:hover {
    border-color: #FF5A2C;
    background: #FFF5F2;
}

.gender-radio {
    position: absolute;
    opacity: 0;
}

.gender-icon {
    font-size: 28px;
    color: #333;
    margin-bottom: 10px;
}

.gender-text {
    font-size: 18px;
    font-weight: 600;
    color: #222;
}

/* Highlight selected card */
.gender-card input[type=radio]:checked + .gender-content {
    color: #FF5A2C;
}

.gender-card input[type=radio]:checked + .gender-content .gender-icon {
    color: #FF5A2C;
}

.gender-card:has(input[type=radio]:checked) {
    border-color: #FF5A2C;
    background: #FFF3EE;
}


.upload-btn {
    display: inline-block;
    position: relative;
    background: #FF5722;
    color: #fff;
    padding: 12px 25px;
    border-radius: 25px;
    cursor: pointer;
    font-weight: 600;
    overflow: hidden;
}

.upload-btn:hover {
    background: #e64a19;
}

.upload-input {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    opacity: 0;
    cursor: pointer;
}

    </style>

    <div class="container" style="margin-top: 1%;">

        <asp:HiddenField ID="hdnUserId" runat="server" Value="0" />

        <div id="accordion">
            <h3>My Profile</h3>
            <div class="MyClass">
              <%--  <div class="row" style="border-bottom: 0.5px solid #f1f1f1; padding-bottom: 15px;">
                    <div class="col-md-1 col-xs-3">
                        <img src="../Images/System/avatar.png" class="img-responsive" />
                    </div>
                    <div class="col-md-11 col-xs-6" style="padding: 10px;">
                        <asp:Label ID="lblUserName" runat="server" Style="font-size: 18px; font-weight: bold; color: #000;" Text="User Name"></asp:Label>
                        <br />
                        <asp:Label ID="lblEmail" runat="server" Style="font-size: 14px; font-weight: 500; color: #999;" Text="abc@xyz.com"></asp:Label>

                    </div>

                </div>--%>


                <div class="profile-card">
    <div class="row">

        <div class="col-md-2 col-xs-4 text-center">
            <img src="../Images/System/avatar.png" class="img-responsive profile-img" />
        </div>

        <div class="col-md-10 col-xs-8" style="padding-top:15px;">

            <asp:Label ID="lblUserName"
                runat="server"
                CssClass="profile-title"
                Text="User">
            </asp:Label>

            <div class="profile-subtitle">
                Update your profile to help us identify you.
            </div>

            <span class="profile-badge">
                Primary Account
            </span>

            <br /><br />

            <asp:Label ID="lblEmail"
                runat="server"
                Style="font-size:14px;color:#777;"
                Text="abc@xyz.com">
            </asp:Label>

        </div>

    </div>
</div>



                <div class="row" style="padding: 10px; font-size: 14px; font-weight: bold">
                    Update your profile
                        <asp:HiddenField ID="hdnPassword" runat="server" />

                </div>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-6 col-xs-12">
                            <label class="field-label" style="font-weight:bold;">First Name</label>

                        <asp:TextBox ID="txtFirstName" runat="server" MaxLength="40" class="form-control" placeholder="First Name"></asp:TextBox>
                    </div>
                    <div class="col-md-6 col-xs-12" >
                            <label class="field-label" style="font-weight:bold;">Last Name</label>

                        <asp:TextBox ID="txtLastName" runat="server" MaxLength="40" class="form-control" placeholder="Last Name"></asp:TextBox>
                    </div>

                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                            <label class="field-label" style="font-weight:bold;">Mobile Number</label>

                        <asp:TextBox ID="txtMobile" runat="server" MaxLength="10" class="form-control" placeholder="Email Address"></asp:TextBox>
                    </div>
                    <div class="col-md-6 col-xs-12" >
                            <label class="field-label" style="font-weight:bold;">Email Address</label>

                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="40" class="form-control" placeholder="Mobile Number"></asp:TextBox>
                    </div>
                </div>


                                <div class="row" style="margin-bottom:20px;">

                <div class="col-md-6 col-xs-12">

    <label class="field-label" style="font-weight:bold;">
        Upload Signature
    </label>


<asp:Button ID="fuSignature"
    runat="server"
    Text="Update Profile"
    OnClick="btnUpdate_Click"
    CssClass="btn btn-primary" />

</div>
</div>

             <%--   <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:RadioButton ID="rdoMale" Style="font-size: 14px; font-weight: 500" Text="Male" runat="server" />
                        <asp:RadioButton ID="rdoFemale" Text="Female" Style="margin-left: 20px; font-size: 14px; font-weight: 500" runat="server" />

                    </div>
                    <div class="col-md-6 col-xs-12">
                    </div>
                </div>--%>

                <div class="row" style="margin-bottom:20px;">

    <div class="col-md-12">

        <label class="field-label" style="font-weight:600;">Gender</label>

    </div>

    <div class="col-md-2">

        <label class="gender-card">

            <asp:RadioButton
                ID="rdoMale"
                runat="server"
                GroupName="Gender"
                CssClass="gender-radio" />

            <div class="gender-content">

                <i class="fa fa-mars gender-icon"></i>

                <div class="gender-text">
                    Male
                </div>

            </div>

        </label>

    </div>

    <div class="col-md-2">

        <label class="gender-card">

            <asp:RadioButton
                ID="rdoFemale"
                runat="server"
                GroupName="Gender"
                CssClass="gender-radio" />

            <div class="gender-content">

                <i class="fa fa-venus gender-icon"></i>

                <div class="gender-text">
                    Female
                </div>

            </div>

        </label>

    </div>

</div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" OnClientClick="return Validate();" class="btn btn-default" Style="color: #fff; background-color: #7C519B" />

                    </div>
                    <div class="col-md-6 col-xs-12">
                    </div>
                </div>
            </div>
            <h3>My Address</h3>
            <div class="MyClass">


                <div class="row">
    <div class="col-xs-12">
        <asp:ListView ID="rptUserAddresss" runat="server">
            <LayoutTemplate>
                <div class="row">
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                </div>
            </LayoutTemplate>

            <ItemTemplate>
                <div class="col-md-4 col-sm-6 col-xs-12 mb-3">
                    <div class="card address-card">
                        <div class="card-body">
                            <input type="hidden" id="hdnUserContactId" value="<%#Eval("ContactId") %>" />

                            <h5 class="card-title"><%#Eval("Name") %></h5>

                            <p class="card-text">
                                <%#Eval("Building") %>, 
                                <%#Eval("Locality") %>, 
                                <%#Eval("City") %>, 
                                <%#Eval("State") %> - <%#Eval("Pincode") %>
                                <br />
                                <%# Convert.ToString(Eval("Mobile")) %>
                            </p>
                        </div>
                    </div>
                </div>
            </ItemTemplate>

        </asp:ListView>
    </div>
</div>
                <%--<div id="divNewAdress" style="display: visible !important;">
                    <div class="row" style="padding: 10px; font-size: 14px; font-weight: bold">
                        Your Address Book
                    </div>
                    <div>
                        <div id="AddressSection" class="row Section" style="height: 300px !important; max-height: 300px !important;">
                            <div class="col-md-6 col-xs-12">
                                <asp:TextBox runat="server" ID="txtName" class="form-control MyControl" placeholder="Full Name" />
                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px">
                                <asp:TextBox runat="server" ID="txtAddressMobile" class="form-control MyControl" placeholder="Mobile" />

                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtBuilding" class="form-control MyControl" placeholder="House Number/Building/Apartment" />

                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtLocality" class="form-control MyControl" placeholder="Street/Locality/Area" />

                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtCity" class="form-control MyControl" placeholder="City" />

                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtState" class="form-control MyControl" placeholder="State" />

                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtPincode" class="form-control MyControl" placeholder="Pincode" />

                            </div>
                            <div class="col-md-12 col-xs-12" style="text-align: left; margin-top: 5px;">
                                <asp:Button runat="server" ID="btnAddress" class="btn" OnClientClick="return ValidateAddress();" Style="margin-top: 5px; background-color: #7C519B; font-weight: 500; width: 200px; color: #fff;"
                                    Text="Save Address" />

                            </div>
                        </div>
                    </div>
                </div>--%>




<%--<div class="address-wrapper">

    <!-- ADD ADDRESS CARD -->
    <div class="address-card add-card" onclick="openAddressForm()">
        <div style="font-size:40px;">+</div>
        <div>Add address</div>
    </div>


    <!-- ADDRESS FORM -->
    <div id="divNewAdress" runat="server" ClientIDMode="Static"
         class="address-card"
         style="display:none; width:650px;">

        <div style="font-weight:600; margin-bottom:10px;">
            Add New Address
        </div>

        <div class="row">

            <div class="col-md-6 mb-2">
                <asp:TextBox runat="server" ID="txtName" class="form-control" placeholder="Full Name" />
            </div>

            <div class="col-md-6 mb-2">
                <asp:TextBox runat="server" ID="txtAddressMobile" class="form-control" placeholder="Mobile" />
            </div>

            <div class="col-md-6 mb-2">
                <asp:TextBox runat="server" ID="txtBuilding" class="form-control" placeholder="House / Building" />
            </div>

            <div class="col-md-6 mb-2">
                <asp:TextBox runat="server" ID="txtLocality" class="form-control" placeholder="Locality" />
            </div>

            <div class="col-md-6 mb-2">
                <asp:TextBox runat="server" ID="txtCity" class="form-control" placeholder="City" />
            </div>

            <div class="col-md-6 mb-2">
                <asp:TextBox runat="server" ID="txtState" class="form-control" placeholder="State" />
            </div>

            <div class="col-md-6 mb-2">
                <asp:TextBox runat="server" ID="txtPincode" class="form-control" placeholder="Pincode" />
            </div>
  <div class="col-12 mt-3">
             <button type="button"
    class="btn"
    style="background-color:#7C519B; width:200px; color:#fff;"
    onclick="saveAddress()">
    Save Address
</button>

        </div>
    </div>


    <!-- DATABASE ADDRESSES -->
    <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>

            <div class="address-card">

                <%# Container.ItemIndex == 0 ? "<div class='default-badge'>Default</div>" : "" %>

                <div class="address-name">
                    <%# Eval("FullName") %>
                </div>

                <div>
                    <%# Eval("Building") %><br />
                    <%# Eval("Locality") %><br />
                    <%# Eval("City") %>, <%# Eval("State") %> - <%# Eval("Pincode") %><br />
                    India<br />
                    Phone: <%# Eval("Mobile") %>
                </div>

                <div class="address-actions">
                    <a href="#">Edit</a> |
                    <a href="#">Remove</a>
                </div>

            </div>

        </ItemTemplate>
    </asp:Repeater>

</div>

            </div>--%>


           <div class="address-wrapper">

    <!-- Header -->
    <div class="address-header">

        <div class="address-title">
            <h2>Address Book</h2>
            <p>Manage your saved locations for home lab collections.</p>
        </div>

        <div>
            <button type="button"
                class="add-btn"
                onclick="openAddressForm();">
                + Add New Address
            </button>
        </div>

    </div>

    <!-- Add Address Form -->
    <div class="row">
        <div class="col-md-12">

            <div id="divNewAdress"
                runat="server"
                ClientIDMode="Static"
                class="address-card"
                style="display:none;">

                <div class="address-heading">
                    Add New Address
                </div>

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label class="field-label">Full Name</label>
                        <asp:TextBox ID="txtName" runat="server"
                            CssClass="form-control"
                            placeholder="Enter Full Name" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="field-label">Mobile Number</label>
                        <asp:TextBox ID="txtAddressMobile" runat="server"
                            CssClass="form-control"
                            placeholder="Enter Mobile Number" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="field-label">House / Building</label>
                        <asp:TextBox ID="txtBuilding" runat="server"
                            CssClass="form-control"
                            placeholder="House / Flat No." />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="field-label">Locality</label>
                        <asp:TextBox ID="txtLocality" runat="server"
                            CssClass="form-control"
                            placeholder="Street / Area" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="field-label">City</label>
                        <asp:TextBox ID="txtCity" runat="server"
                            CssClass="form-control"
                            placeholder="City" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="field-label">State</label>
                        <asp:TextBox ID="txtState" runat="server"
                            CssClass="form-control"
                            placeholder="State" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="field-label">Pincode</label>
                        <asp:TextBox ID="txtPincode" runat="server"
                            CssClass="form-control"
                            placeholder="Pincode" />
                    </div>



                    <div class="col-md-6 mb-3">
                                                <label class="field-label">Defailt Address</label>

                        <asp:RadioButton ID="RadioButton3" Style="font-size: 14px; font-weight: 500" Text="Set as default" runat="server" />

                    </div>

                </div>

                <div class="action-area">

                    <button type="button"
                        class="btn-cancel"
                        onclick="$('#divNewAdress').hide();">
                        Cancel
                    </button>

                    <button type="button"
                        class="btn-save"
                        onclick="saveAddress();">
                        Save
                    </button>

                </div>

            </div>

        </div>
    </div>

    <!-- Saved Addresses -->
    <div class="row">

        <div class="col-md-12">

            <asp:Repeater ID="Repeater1" runat="server">

                <ItemTemplate>

                    <div class="address-card">

                        <%# Container.ItemIndex==0 ? "<span class='default-badge'>Default</span>" : "" %>

                        <h4><%# Eval("FullName") %></h4>

                        <p>
                            <%# Eval("Building") %><br />
                            <%# Eval("Locality") %><br />
                            <%# Eval("City") %>, <%# Eval("State") %> - <%# Eval("Pincode") %><br />
                            Phone : <%# Eval("Mobile") %>
                        </p>

                        <div class="address-actions">
                            <a href="#">Edit</a> |
                            <a href="#">Remove</a>
                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </div>

    </div>

</div>
            <h3>Change Password</h3>
            <div class="MyClass">
                <div class="row" style="padding: 10px; margin-top: 10px; font-size: 14px; font-weight: bold">
                    Change Your Password
                </div>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-6 col-xs-12">
                        <asp:TextBox ID="txtCurrentPassword" runat="server" class="form-control" TextMode="Password" placeholder="Current Password"></asp:TextBox>
                    </div>


                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:TextBox ID="txtPassword" runat="server" class="form-control" TextMode="Password" placeholder="New Password"></asp:TextBox>
                    </div>

                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" class="form-control" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                    </div>

                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" OnClientClick="return ChangePassword();" class="btn btn-default" Style="color: #fff; background-color: #7C519B" />

                    </div>
                    <div class="col-md-6 col-xs-12">
                    </div>
                </div>
            </div>

        </div>

    </div>


    <script>
    function openAddressForm() {
        document.getElementById("divNewAdress").style.display = "block";
    }
</script>
    <script>

function saveAddress() {

    // Get values
    var name = document.getElementById('<%= txtName.ClientID %>').value;
    var mobile = document.getElementById('<%= txtAddressMobile.ClientID %>').value;
    var building = document.getElementById('<%= txtBuilding.ClientID %>').value;
    var locality = document.getElementById('<%= txtLocality.ClientID %>').value;
    var city = document.getElementById('<%= txtCity.ClientID %>').value;
    var state = document.getElementById('<%= txtState.ClientID %>').value;
    var pincode = document.getElementById('<%= txtPincode.ClientID %>').value;

    if (name == "") {
        alert("Please enter name");
        return;
    }

    // Create card
    var card = document.createElement("div");
    card.className = "address-card";

    card.innerHTML =
        "<div class='address-name'>" + name + "</div>" +
        "<div>" +
        building + "<br>" +
        locality + "<br>" +
        city + ", " + state + " - " + pincode + "<br>" +
        "India<br>" +
        "Phone: " + mobile +
        "</div>" +
        "<div class='address-actions'>" +
        "<a href='#'>Edit</a> | <a href='#'>Remove</a>" +
        "</div>";

    // Append after form
    document.querySelector(".address-wrapper").appendChild(card);

    // Clear form
    document.getElementById('<%= txtName.ClientID %>').value = "";
    document.getElementById('<%= txtAddressMobile.ClientID %>').value = "";
    document.getElementById('<%= txtBuilding.ClientID %>').value = "";
    document.getElementById('<%= txtLocality.ClientID %>').value = "";
    document.getElementById('<%= txtCity.ClientID %>').value = "";
    document.getElementById('<%= txtState.ClientID %>').value = "";
    document.getElementById('<%= txtPincode.ClientID %>').value = "";

    // Hide form
    document.getElementById("divNewAdress").style.display = "none";
}

    </script>


    <script>
        function ChangePassword() {
            var OldPassword = $('[id$=hdnPassword]').val();
            var CurrPassword = $('[id$=txtCurrentPassword]').val().trim();
            var NewPassword = $('[id$=txtPassword]').val().trim();
            var ConfirmPassword = $('[id$=txtConfirmPassword]').val().trim();

            if (OldPassword != CurrPassword) {
                alert('Current password does not match !');
                return false;
            }

            if (NewPassword != ConfirmPassword) {
                alert('New password & Confirm password is not same !');
                return false;
            }

            if (OldPassword == CurrPassword && NewPassword == ConfirmPassword) {
                $.ajax({
                    url: "MyAccount.aspx/ChangePassword",
                    async: false,
                    data: '{Password:"' + NewPassword + '",UserId:"' + $('[id$=hdnUserId]').val() + '"}',
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        var x = parseInt(result.d);
                        if (x > 0) {
                            alert('Password Changed Successfully !');
                        }
                        else {
                            alert('Some Error Occured !');
                        }
                    }
                });
            }


        }

        function Validate() {
            debugger
            var UserId = $('[id$=hdnUserId]').val();
            var FirstName = $('[id$=txtFirstName]').val().trim();
            var LastName = $('[id$=txtLastName]').val().trim();
            var Mobile = $('[id$=txtMobile]').val().trim();
            var Email = $('[id$=txtEmail]').val().trim();
            var Flag = false;

            if (FirstName == "") {
                Flag = true;
                $('[id$=txtFirstName]').css('border', '1px solid red');
            }
            else {
                $('[id$=txtFirstName]').css('border', '1px solid #ccc');

            }

            if (LastName == "") {
                Flag = true;
                $('[id$=txtLastName]').css('border', '1px solid red');
            }
            else {
                $('[id$=txtLastName]').css('border', '1px solid #ccc');

            }
            if (Mobile == "") {
                Flag = true;
                $('[id$=txtMobile]').css('border', '1px solid red');
            }
            else {
                $('[id$=txtMobile]').css('border', '1px solid #ccc');

            }
            if (Email == "") {
                Flag = true;
                $('[id$=txtEmail]').css('border', '1px solid red');
            }
            else {
                $('[id$=txtEmails]').css('border', '1px solid #ccc');

            }

            if (Flag) {
                return false;
            }
            else {
                $.ajax({
                    url: "MyAccount.aspx/UpdateUserData",
                    async: true,
                    data: JSON.stringify({ FirstName: FirstName, LastName: LastName, Email: Email, Mobile: Mobile, UserId: UserId }),
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        var IsUpdated = parseInt(result.d);
                        //if (IsUpdated > 0) {
                            alert('Profile Updated Successfully !');
                            $('[id$=lblUserName]').text(FirstName + ' ' + LastName);
                            $('[id$=lblEmail]').text(Email);
                        //}
                        //else {
                        //    alert('Some Error Ouccerd !');
                        //}

                    }
                });
            }
            return false;
        }
    </script>

    <script>
        $(document).ready(function () {

            $('#divNewAdress').css('display', 'visible');
        });
    </script>

</asp:Content>
