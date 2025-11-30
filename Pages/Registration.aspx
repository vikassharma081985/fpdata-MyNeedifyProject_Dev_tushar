<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="WSBillingMaster.Pages.Registration" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Job Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server" class="container py-4">
        <div class="card">
            <div class="card-header bg-primary text-white">Job Registration</div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label>Aadhar No</label>
                        <asp:TextBox ID="txtAadhar" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-4">
                        <label>Skill</label>
                        <asp:DropDownList ID="ddlSkills" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label>Phone No</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>

                    <div class="col-md-12">
                        <label>Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>

                    <div class="col-md-12 text-end">
                        <asp:Button ID="btnSubmit" runat="server" Text="Register" CssClass="btn btn-success" OnClick="btnSubmit_Click" />
                        &nbsp;
                        <asp:Label ID="lblStatus" runat="server" CssClass="text-danger"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

