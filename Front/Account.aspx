<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeFile="Account.aspx.cs" Inherits="FaduPrice.Front.Account" %>

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
        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, 
        a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
            border: 1px solid #F6861F;
            background: #F6861F;
            font-weight: normal;
            color: #ffffff;
            padding: 5px !important;
            font-size: 16px !important;
            font-family: raleway;
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
            font-weight: 500 !important;
        }

        .Section {
            text-align: left;
            color: #999;
            font-size: 16px;
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
            color: #555;
            background-color: #fff;
            border: 1px solid #dddfe2;
            border-radius: 2px;
            box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
            transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container" style="margin-top: 1%;">

        <asp:HiddenField ID="hdnUserId" runat="server" Value="0" />
        <asp:HiddenField ID="hdnPassword" runat="server" />

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
                        <asp:TextBox ID="txtMobile" runat="server" MaxLength="10" class="form-control" placeholder="Mobile Number"></asp:TextBox>
                    </div>
                    <div class="col-md-6 col-xs-12" style="margin-top: 5px">
                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="40" class="form-control" placeholder="Email Address"></asp:TextBox>
                    </div>
                </div>

                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:RadioButton ID="rdoMale" Text="Male" runat="server" />
                        <asp:RadioButton ID="rdoFemale" Text="Female" Style="margin-left: 20px;" runat="server" />
                    </div>
                </div>

                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-6 col-xs-12">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile"
                            OnClientClick="return Validate();" class="btn btn-default"
                            Style="color: #fff; background-color: #7C519B" />
                    </div>
                </div>
            </div>

            <h3>My Address</h3>
            <div class="MyClass">
                <div class="row">
                    <div class="col-xs-12">
                        <asp:ListView ID="rptUserAddresss" runat="server">
                            <ItemTemplate>
                                <div class="col-md-8">
                                    <div style="border: 1px solid #ccc; background-color: #f1f1f1; padding: 2px;">
                                        <input type="hidden" id="hdnUserContactId" value="<%#Eval("ContactId") %>" />
                                        <p><strong><%#Eval("Name") %></strong></p>
                                        <p><%#Eval("Building") %>, <%#Eval("Locality") %>, <%#Eval("City") %>, <%#Eval("State") %> - <%#Eval("Pincode") %>,
                                            <span><%#Eval("Mobile") %></span></p>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>

                <div id="divNewAdress" style="display: none;">
                    <div class="row" style="padding: 10px; font-size: 14px; font-weight: bold">
                        Your Address Book
                    </div>
                    <div>
                        <div id="AddressSection" class="row Section" style="height: 300px !important;">
                            <div class="col-md-6 col-xs-12">
                                <asp:TextBox runat="server" ID="txtName" class="form-control" placeholder="Full Name" />
                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px">
                                <asp:TextBox runat="server" ID="txtAddressMobile" class="form-control" placeholder="Mobile" />
                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtBuilding" class="form-control" placeholder="House Number/Building/Apartment" />
                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtLocality" class="form-control" placeholder="Street/Locality/Area" />
                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtCity" class="form-control" placeholder="City" />
                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtState" class="form-control" placeholder="State" />
                            </div>
                            <div class="col-md-6 col-xs-12" style="margin-top: 5px;">
                                <asp:TextBox runat="server" ID="txtPincode" class="form-control" placeholder="Pincode" />
                            </div>
                            <div class="col-md-12 col-xs-12" style="text-align: left; margin-top: 5px;">
                                <asp:Button runat="server" ID="btnAddress" class="btn" OnClientClick="return ValidateAddress();"
                                    Style="margin-top: 5px; background-color: #7C519B; font-weight: 500; width: 200px; color: #fff;"
                                    Text="Save Address" />
                            </div>
                        </div>
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
                        <asp:Button ID="btnChangePassword" runat="server" Text="Change Password"
                            OnClientClick="return ChangePassword();" class="btn btn-default"
                            Style="color: #fff; background-color: #7C519B" />
                    </div>
                </div>
            </div>
        </div>
    </div>

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

            $.ajax({
                url: "MyAccount.aspx/ChangePassword",
                async: false,
                data: '{Password:"' + NewPassword + '",UserId:"' + $('[id$=hdnUserId]').val() + '"}',
                contentType: "application/json; charset=utf-8",
                type: "POST",
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var x = parseInt(result.d);
                    if (x > 0) {
                        alert('Password Changed Successfully !');
                    } else {
                        alert('Some Error Occured !');
                    }
                }
            });
        }

        function Validate() {
            var UserId = $('[id$=hdnUserId]').val();
            var FirstName = $('[id$=txtFirstName]').val().trim();
            var LastName = $('[id$=txtLastName]').val().trim();
            var Mobile = $('[id$=txtMobile]').val().trim();
            var Email = $('[id$=txtEmail]').val().trim();
            var Flag = false;

            if (FirstName == "") { Flag = true; $('[id$=txtFirstName]').css('border', '1px solid red'); }
            else { $('[id$=txtFirstName]').css('border', '1px solid #ccc'); }

            if (LastName == "") { Flag = true; $('[id$=txtLastName]').css('border', '1px solid red'); }
            else { $('[id$=txtLastName]').css('border', '1px solid #ccc'); }

            if (Mobile == "") { Flag = true; $('[id$=txtMobile]').css('border', '1px solid red'); }
            else { $('[id$=txtMobile]').css('border', '1px solid #ccc'); }

            if (Email == "") { Flag = true; $('[id$=txtEmail]').css('border', '1px solid red'); }
            else { $('[id$=txtEmail]').css('border', '1px solid #ccc'); }

            if (Flag) return false;

            $.ajax({
                url: "MyAccount.aspx/UpdateUserData",
                async: true,
                data: JSON.stringify({ FirstName: FirstName, LastName: LastName, Email: Email, Mobile: Mobile, UserId: UserId }),
                contentType: "application/json; charset=utf-8",
                type: "POST",
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var IsUpdated = parseInt(result.d);
                    if (IsUpdated > 0) {
                        alert('Profile Updated Successfully !');
                        $('[id$=lblUserName]').text(FirstName + ' ' + LastName);
                        $('[id$=lblEmail]').text(Email);
                    } else {
                        alert('Some Error Occurred !');
                    }
                }
            });
            return false;
        }

        $(document).ready(function () {
            $('#divNewAdress').css('display', 'none');
        });
    </script>

</asp:Content>
