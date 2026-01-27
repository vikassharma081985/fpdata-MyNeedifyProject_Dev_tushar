<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="EmployeeMaster.aspx.cs" Inherits="WSBillingMaster.Pages.EmployeeMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container-fluid" style="font-size: 12px !important">

         <style>
             .top-space {
             margin-top:20px;
             }
/* Container */
.form-wrapper {
    max-width: 450px; /* narrower and centered */
    margin: 50px auto;
    padding: 30px 25px;
    background: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    font-family: "Segoe UI", Arial, sans-serif;
}

/* Form heading */
.form-wrapper h2 {
    text-align: center;
    color: #6a8fe8;
    margin-bottom: 25px;
    font-weight: bold;
}

/* Form row */
.form-row {
    margin-bottom: 18px;
}

/* Labels */
.form-row label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #333;
}

/* Inputs */
.form-row input.form-control {
    width: 100%;
    padding: 10px 12px;
    border-radius: 6px;
    border: 1px solid #6a8fe8; /* highlighted border */
    background-color: #f0f4ff;  /* subtle background */
    font-size: 14px;
    box-sizing: border-box;
}

/* Dropdown */
.form-row select.form-control {
    width: 100%;
    padding: 10px 12px;
    border-radius: 6px;
    border: 1px solid #6a8fe8; 
    background-color: #f0f4ff;
    font-size: 14px;
    box-sizing: border-box;
    height: 40px;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-image: url("data:image/svg+xml;charset=US-ASCII,%3Csvg%20width%3D%2210%22%20height%3D%227%22%20viewBox%3D%220%200%2010%207%22%20xmlns%3D%22http%3A//www.w3.org/2000/svg%22%3E%3Cpath%20d%3D%22M0%200l5%207%205-7H0z%22%20fill%3D%226a8fe8%22/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
    background-size: 10px 7px;
}

/* Save button */
.btn-save {
    background-color: #6a8fe8;
    color: #fff;
    font-weight: bold;
    border: none;
    border-radius: 6px;
    width: 100%;
    padding: 12px;
    cursor: pointer;
    transition: background 0.3s;
}
.btn-save:hover {
    background-color: #5276d1;
}

/* Breadcrumb spacing */
.top-space {
    margin-top: 20px;
}

/* Mobile adjustments */
@media(max-width:767px){
    .form-wrapper {
        margin: 20px 15px;
        padding: 20px 15px;
    }
}
</style>
<!-- Breadcrumbs -->
<ol class="breadcrumb top-space">
    <li class="breadcrumb-item">
        <a href="Userdashboard.aspx">Dashboard</a>
    </li>
    <li class="breadcrumb-item active">Employee Master</li>
</ol>
</div>

<!-- Form wrapper -->
<div class="form-wrapper">
    <h2>Employee Master</h2>

    <div class="form-row">
        <label for="txtUserName">User Name</label>
        <input type="text" id="txtUserName" class="form-control" />
    </div>

    <div class="form-row">
        <label for="txtMobile">Mobile</label>
        <input type="text" id="txtMobile" class="NumbersOnly form-control" maxlength="10" />
    </div>

    <div class="form-row">
        <label for="txtEmail">Email</label>
        <input type="text" id="txtEmail" class="form-control" />
    </div>

    <div class="form-row">
        <label for="ddlRole">Role</label>
        <asp:DropDownList ID="ddlRole" runat="server" class="form-control"></asp:DropDownList>
    </div>

    <div class="form-row">
        <label for="txtPassword">Password</label>
        <input type="text" id="txtPassword" class="form-control" />
    </div>

    <div class="form-row">
        <input type="button" class="btn-save" onclick="Save();" value="Save" />
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