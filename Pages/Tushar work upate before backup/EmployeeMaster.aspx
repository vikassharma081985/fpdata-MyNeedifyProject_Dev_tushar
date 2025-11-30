<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="EmployeeMaster.aspx.cs" Inherits="WSBillingMaster.Pages.EmployeeMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container-fluid" style="font-size: 12px !important">

         <style>
             .top-space {
             margin-top:20px;
             }
         </style>
        <!-- Breadcrumbs-->
        <ol class="breadcrumb top-space">
            <li class="breadcrumb-item">
                <a href="Userdashboard.aspx">Dashboard</a>
            </li>
            <li class="breadcrumb-item active">Employee Master</li>
        </ol>

        <div class='col-md-12 col-xs-12'>
            <div class="row">
                <div class='col-md-12 col-xs-12 text-left'>
                    <strong>User Name </strong>
                </div>
                <div class='col-md-6 col-xs-12 text-left'>
                    <input type="text" id="txtUserName" class="form-control" />
                </div>
            </div>
        </div>

        <div class='col-md-12 col-xs-12 top-space'>
            <div class="row">
                <div class='col-md-12 col-xs-12 text-left'>
                    <strong>Mobile </strong>
                </div>
                <div class='col-md-6 col-xs-12 text-left'>
                    <input type="text" id="txtMobile" class="NumbersOnly form-control" maxlength="10" />
                </div>
            </div>
        </div>
        <div class='col-md-12 col-xs-12 top-space'>
            <div class="row">
                <div class='col-md-12 col-xs-12 text-left'>
                    <strong>Email </strong>
                </div>
                <div class='col-md-6 col-xs-12 text-left'>
                    <input type="text" id="txtEmail" class="form-control" />
                </div>
            </div>
        </div>

        

        <div class='col-md-12 col-xs-12 top-space'>
            <div class="row">
                <div class='col-md-12 col-xs-12 text-left'>
                    <strong>Role</strong>
                </div>
                <div class='col-md-6 col-xs-12 text-left'>
                    <asp:DropDownList ID="ddlRole" runat="server" class="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class='col-md-12 col-xs-12 top-space'>
            <div class="row">
                <div class='col-md-12 col-xs-12 text-left'>
                    <strong>Password</strong>
                </div>
                <div class='col-md-6 col-xs-12 text-left'>
                    <input type="text" id="txtPassword" class="form-control" />

                </div>
            </div>
        </div>

        <div class='col-md-12 col-xs-12 top-space'>
            <div class="row">
                <div class='col-md-6 col-xs-12 text-left'>
                    <input type="button" class="btn btn-danger" style="width: 100%" onclick="Save();" value="Save" />
                </div>

            </div>
        </div>

     
    </div>

     <script>
         function Save() {
             var Name = $('#txtUserName').val().trim();
             var Mobile = $('#txtMobile').val().trim();
             var Email = $('#txtEmail').val().trim();
            
             var RoleID = $('[id$=ddlRole]').val().trim();
             var Password = $('#txtPassword').val().trim();



             if (Name == '') {
                 alert('Enter User Name');
                 return;
             }

             if (Email == '') {
                 alert('Enter User Email');
                 return;
             } else {

                 if (Email != '') {
                     if (!ValidateEmail(Email)) {
                         alert('Invalid email id');
                         return;
                     }
                 }
             }

           
             if (RoleID == '0') {
                 alert('Select Role');
                 return;
             }
             if (Password == '') {
                 alert('Enter Password');
                 return;
             }




             $.ajax({
                 url: "EmployeeMaster.aspx/Save",
                 async: true,
                 data: JSON.stringify({ Name: Name, Mobile: Mobile, Email: Email, RoleID: RoleID, Password: Password }),
                 contentType: "application/json; charset=utf-8",
                 type: "POST", // data has to be Posted 
                 timeout: 120000,
                 dataType: "json",
                 success: function (result) {
                     if (result.d == "1") {
                         alert("Record Saved Successfully");
                         ClearForm();
                        
                     } else if (result.d == "-1") {
                         alert("Email already exists");
                     } else if (result.d == "-2") {
                         alert("Mobile already exists");
                     }
                 }
             });

         }

         function ClearForm() {
             $('input[type=text]').val('');
             $('select').val('0');

         }

        
      

        function ValidateEmail(email) {
            var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(email);
        }

    </script>

</asp:Content>
