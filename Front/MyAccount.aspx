<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="FaduPrice.Pages.MyAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="/resources/demos/style.css" />


    <script src="../Js/jquery-ui.js"></script>

    <script>
        $(function () {
            $("#accordion").accordion();
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

    <div class="container" style="margin-top: 1%;">

        <asp:HiddenField ID="hdnUserId" runat="server" Value="0" />

        <div id="accordion">
            <h3>My Profile</h3>
            <div class="MyClass">
                <div class="row" style="border-bottom: 0.5px solid #f1f1f1; padding-bottom: 15px;">
                    <div class="col-md-1 col-xs-3">
                        <img src="../Images/System/avatar.png" class="img-responsive" />
                    </div>
                    <div class="col-md-11 col-xs-6" style="padding: 10px;">
                        <asp:Label ID="lblUserName" runat="server" Style="font-size: 18px; font-weight: bold; color: #000;" Text="User Name"></asp:Label>
                        <br />
                        <asp:Label ID="lblEmail" runat="server" Style="font-size: 14px; font-weight: 500; color: #999;" Text="abc@xyz.com"></asp:Label>

                    </div>

                </div>
                <div class="row" style="padding: 10px; font-size: 14px; font-weight: bold">
                    Update your profile
                        <asp:HiddenField ID="hdnPassword" runat="server" />

                </div>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-6 col-xs-12">
                        <asp:TextBox ID="txtFirstName" runat="server" MaxLength="40" class="form-control" placeholder="First Name"></asp:TextBox>
                    </div>
                    <div class="col-md-6 col-xs-12" style="margin-top: 5px">
                        <asp:TextBox ID="txtLastName" runat="server" MaxLength="40" class="form-control" placeholder="Last Name"></asp:TextBox>
                    </div>

                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:TextBox ID="txtMobile" runat="server" MaxLength="10" class="form-control" placeholder="Email Address"></asp:TextBox>
                    </div>
                    <div class="col-md-6 col-xs-12" style="margin-top: 5px">
                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="40" class="form-control" placeholder="Mobile Number"></asp:TextBox>
                    </div>
                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:RadioButton ID="rdoMale" Style="font-size: 14px; font-weight: 500" Text="Male" runat="server" />
                        <asp:RadioButton ID="rdoFemale" Text="Female" Style="margin-left: 20px; font-size: 14px; font-weight: 500" runat="server" />

                    </div>
                    <div class="col-md-6 col-xs-12">
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
<%--                <div class="row">
                    <div class="col-xs-12">
                        <asp:ListView ID="rptUserAddresss" runat="server">
                        
                            <ItemTemplate>
                                <div class="col-md-8">
                                    <div style="border: 1px solid #ccc; background-color: #f1f1f1; padding: 2px;">
                                        <input type="hidden" id="hdnUserContactId" value="<%#Eval("ContactId") %>" />
                                        <p><strong><%#Eval("Name") %></strong></p>
                                        <p><%#Eval("Building") %>, <%#Eval("Locality") %>, <%#Eval("City") %>,  <%#Eval("State") %>- <%#Eval("Pincode") %>, <span>, <%# Convert.ToString(Eval("Mobile")) %></span></p>


                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
--%>



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




<div class="address-wrapper">

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

            </div>


            <h3>My Signature</h3>
            <div class="MyClass">
                <div class="row" style="padding: 10px; font-size: 14px; font-weight: bold">
                    Manage Signature
                    <asp:HiddenField ID="hdnSignature" runat="server" ClientIDMode="Static" />
                </div>

                <div class="row" style="margin-top: 10px; margin-bottom: 20px;">

                    <!-- STATE 1: SIMPLE UPLOAD (shown when no signature exists or removed) -->
                    <div id="divUploadSignature" runat="server" ClientIDMode="Static" class="col-md-6 col-xs-12" style="display: none;">
                        <label style="font-weight: 600; color: #555;">Upload Signature</label>
                        <div style="margin-top: 5px;">
                            <input type="file" id="fileSignature" accept="image/png, image/jpeg, image/jpg" class="form-control" style="padding: 4px 10px; height: 35px !important;" onchange="previewSignature(this);" />
                            <span style="font-size: 11px; color: #888; display: block; margin-top: 4px;">Supported formats: PNG, JPG, JPEG (Max 2MB)</span>
                        </div>

                        <!-- Selected Preview Box -->
                        <div id="divPreviewContainer" style="display: none; margin-top: 15px; padding: 12px; border: 1px dashed #7C519B; border-radius: 6px; background: #fff; text-align: center;">
                            <div style="font-size: 12px; font-weight: 600; color: #7C519B; margin-bottom: 6px;">Selected Preview</div>
                            <img id="imgSignaturePreview" src="#" alt="Preview" style="max-height: 90px; max-width: 100%; object-fit: contain; border: 1px solid #eee; padding: 4px; background: #fafafa;" />
                            <div style="margin-top: 6px;">
                                <a href="javascript:void(0);" onclick="cancelSignaturePreview();" style="color: #d9534f; font-size: 12px; text-decoration: underline; cursor: pointer;">Cancel</a>
                            </div>
                        </div>

                        <div style="margin-top: 15px;">
                            <button type="button" id="btnUploadSig" class="btn" style="color: #fff; background-color: #7C519B; width: 160px; font-weight: 500;" onclick="uploadSignature();">
                                <span id="btnUploadSigText">Upload</span>
                            </button>
                            <span id="sigUploadMsg" style="margin-left: 10px; font-size: 13px; font-weight: 500;"></span>
                        </div>
                    </div>

                    <!-- STATE 2: SIGNATURE DISPLAY & REMOVE (shown on side when signature exists) -->
                    <div id="divViewSignature" runat="server" ClientIDMode="Static" class="col-md-6 col-xs-12" style="display: none;">
                        <label style="font-weight: 600; color: #555;">Your Signature</label>
                        <div style="margin-top: 5px; padding: 15px; border: 1px solid #ddd; border-radius: 6px; background: #fafafa; display: flex; align-items: center; justify-content: space-between; gap: 20px;">
                            <div style="background: #fff; border: 1px solid #e0e0e0; border-radius: 4px; padding: 10px; flex: 1; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.06);">
                                <asp:Image ID="imgCurrentSignature" ClientIDMode="Static" runat="server" CssClass="img-responsive" Style="max-height: 100px; max-width: 100%; object-fit: contain; display: inline-block; cursor: pointer;" title="Click to view full size" onclick="viewFullSignature();" />
                            </div>
                            <div>
                                <button type="button" id="btnRemoveSig" class="btn btn-danger" style="font-weight: 500; padding: 8px 16px;" onclick="removeSignature();">
                                    <span class="glyphicon glyphicon-trash"></span> Remove
                                </button>
                            </div>
                        </div>
                        <span style="font-size: 11px; color: #888; display: block; margin-top: 6px;">To upload a different signature, remove the current signature first.</span>
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

    <script>
        var selectedSignatureBase64 = "";
        var selectedSignatureFileName = "";

        function previewSignature(input) {
            if (input.files && input.files[0]) {
                var file = input.files[0];
                var validTypes = ["image/png", "image/jpeg", "image/jpg"];

                if ($.inArray(file.type.toLowerCase(), validTypes) < 0 && !file.name.match(/\.(png|jpe?g)$/i)) {
                    alert("Please select a valid image file (PNG, JPG, or JPEG).");
                    input.value = "";
                    cancelSignaturePreview();
                    return;
                }

                // Check file size (max 2MB)
                if (file.size > 2 * 1024 * 1024) {
                    alert("Image file size should not exceed 2MB.");
                    input.value = "";
                    cancelSignaturePreview();
                    return;
                }

                selectedSignatureFileName = file.name;

                var reader = new FileReader();
                reader.onload = function (e) {
                    selectedSignatureBase64 = e.target.result;
                    $('#imgSignaturePreview').attr('src', selectedSignatureBase64);
                    $('#divPreviewContainer').show();
                    $('#sigStatusMsg').text('').css('color', '');
                };
                reader.readAsDataURL(file);
            }
        }

        function cancelSignaturePreview() {
            selectedSignatureBase64 = "";
            selectedSignatureFileName = "";
            $('#fileSignature').val('');
            $('#imgSignaturePreview').attr('src', '#');
            $('#divPreviewContainer').hide();
            $('#sigStatusMsg').text('');
        }

        function viewFullSignature() {
            var src = $('#imgCurrentSignature').attr('src');
            if (src && src !== '#' && src !== '') {
                window.open(src, '_blank');
            }
        }

        function uploadSignature() {
            var userId = $('[id$=hdnUserId]').val();
            if (!userId || userId === "0") {
                alert("User session not found. Please log in again.");
                return;
            }

            var fileInput = document.getElementById('fileSignature');
            if (!fileInput.files || fileInput.files.length === 0) {
                alert("Please select a signature image file first.");
                return;
            }

            var file = fileInput.files[0];
            var validTypes = ["image/png", "image/jpeg", "image/jpg"];
            if ($.inArray(file.type.toLowerCase(), validTypes) < 0 && !file.name.match(/\.(png|jpe?g)$/i)) {
                alert("Please select a valid image file (PNG, JPG, or JPEG).");
                return;
            }

            if (file.size > 4 * 1024 * 1024) {
                alert("File size exceeds 4MB. Please select a smaller image.");
                return;
            }

            $('#btnUploadSig').prop('disabled', true);
            $('#btnUploadSigText').text('Uploading...');
            $('#sigUploadMsg').text('Uploading signature...').css('color', '#7C519B');

            var formData = new FormData();
            formData.append("signatureFile", file);
            formData.append("userId", userId);

            $.ajax({
                url: "UploadSignature.ashx",
                type: "POST",
                data: formData,
                contentType: false,
                processData: false,
                timeout: 120000,
                success: function (res) {
                    $('#btnUploadSig').prop('disabled', false);
                    $('#btnUploadSigText').text('Upload');

                    if (typeof res === "string") {
                        try {
                            res = JSON.parse(res);
                        } catch (e) { }
                    }

                    if (res && res.success) {
                        alert(res.message || 'Signature uploaded successfully!');
                        var updatedUrl = res.imageUrl + '?t=' + new Date().getTime();
                        $('#imgCurrentSignature').attr('src', updatedUrl);
                        $('[id$=hdnSignature]').val(res.fileName);
                        cancelSignaturePreview();

                        // Switch state: Hide upload option, show signature with remove button
                        $('#divUploadSignature').hide();
                        $('#divViewSignature').show();
                    } else {
                        var errMsg = (res && res.message) ? res.message : 'Upload failed. Please check the file and try again.';
                        alert(errMsg);
                        $('#sigUploadMsg').text(errMsg).css('color', 'red');
                    }
                },
                error: function (xhr, status, error) {
                    $('#btnUploadSig').prop('disabled', false);
                    $('#btnUploadSigText').text('Upload');

                    var errMsg = 'Error uploading signature.';
                    if (xhr.responseJSON) {
                        errMsg = xhr.responseJSON.Message || xhr.responseJSON.message || xhr.responseJSON.ExceptionMessage || errMsg;
                    } else if (xhr.responseText) {
                        try {
                            var json = JSON.parse(xhr.responseText);
                            errMsg = json.Message || json.message || json.ExceptionMessage || errMsg;
                        } catch (e) {
                            if (xhr.status === 413) {
                                errMsg = "The file is too large to upload. Please choose an image under 4MB.";
                            } else if (xhr.status === 404) {
                                errMsg = "Upload handler not found on server.";
                            } else if (xhr.status === 500) {
                                errMsg = "Server error during upload. Please verify database stored procedures.";
                            } else {
                                errMsg = error || status || errMsg;
                            }
                        }
                    }
                    alert(errMsg);
                    $('#sigUploadMsg').text(errMsg).css('color', 'red');
                }
            });
        }

        function removeSignature() {
            if (!confirm("Are you sure you want to remove your signature?")) {
                return;
            }

            var userId = $('[id$=hdnUserId]').val();
            if (!userId || userId === "0") {
                alert("User session not found. Please log in again.");
                return;
            }

            $('#btnRemoveSig').prop('disabled', true).text('Removing...');

            $.ajax({
                url: "MyAccount.aspx/RemoveSignature",
                type: "POST",
                data: JSON.stringify({ userId: userId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                timeout: 120000,
                success: function (response) {
                    $('#btnRemoveSig').prop('disabled', false).html('<span class="glyphicon glyphicon-trash"></span> Remove');

                    var res = response.d;
                    if (typeof res === "string") {
                        try { res = JSON.parse(res); } catch (e) { }
                    }

                    if (res && res.success) {
                        alert(res.message || 'Signature removed successfully!');
                        $('#imgCurrentSignature').attr('src', '');
                        $('[id$=hdnSignature]').val('');
                        cancelSignaturePreview();

                        // Switch state: Hide signature display, show simple upload option
                        $('#divViewSignature').hide();
                        $('#divUploadSignature').show();
                    } else {
                        var errMsg = (res && res.message) ? res.message : 'Error removing signature.';
                        alert(errMsg);
                    }
                },
                error: function (xhr, status, error) {
                    $('#btnRemoveSig').prop('disabled', false).html('<span class="glyphicon glyphicon-trash"></span> Remove');
                    var errMsg = 'Error removing signature.';
                    if (xhr.responseJSON) {
                        errMsg = xhr.responseJSON.Message || xhr.responseJSON.message || errMsg;
                    } else if (xhr.responseText) {
                        try {
                            var json = JSON.parse(xhr.responseText);
                            errMsg = json.Message || json.message || errMsg;
                        } catch (e) { }
                    }
                    alert(errMsg);
                }
            });
        }
    </script>
</asp:Content>
