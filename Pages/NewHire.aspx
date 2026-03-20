<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewHire.aspx.cs" Inherits="WSBillingMaster.Pages.NewHire" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>New Service Request</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">
        <form id="form1" runat="server">
            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-md-10">

                        <div class="card shadow">
                            <div class="card-header bg-warning">
                                <h4 class="mb-0">📢 New Hire Request</h4>
                            </div>

                            <div class="card-body">

                                <!-- Request Information -->
                                <div class="mb-3">
                                    <label class="fw-bold">Company Name / Job Role:</label>
                                    <p class="mb-1">
                                        <asp:Literal ID="litCompany" runat="server"></asp:Literal>
                                    </p>
                                </div>

                                <div class="mb-3">
                                    <label class="fw-bold">Client Contact:</label>
                                    <p class="mb-1">
                                        <asp:Literal ID="litContactPerson" runat="server"></asp:Literal>
                                    </p>
                                </div>

                                <div class="mb-3">
                                    <label class="fw-bold">Phone Number:</label>
                                    <p class="mb-1 text-primary">
                                        <asp:Literal ID="litPhone" runat="server"></asp:Literal>
                                    </p>
                                </div>

                                <div class="mb-3">
                                    <label class="fw-bold">Service Description:</label>
                                    <p class="mb-1">
                                        <asp:Literal ID="litRemarks" runat="server"></asp:Literal>
                                    </p>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="fw-bold">Hire Date:</label>
                                        <p class="mb-1">
                                            <asp:Literal ID="litDate" runat="server"></asp:Literal>
                                        </p>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="fw-bold">Salary Offered:</label>
                                        <p class="mb-1">₹<asp:Literal ID="litSalary" runat="server"></asp:Literal>
                                        </p>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="fw-bold">Preferred Time:</label>
                                    <p class="mb-1">
                                        <asp:Literal ID="litTime" runat="server"></asp:Literal>
                                    </p>
                                </div>

                                <div class="mb-3">
                                    <label class="fw-bold">Current Status:</label>
                                    <p class="mb-1">
                                        <asp:Literal ID="litStatus" runat="server"></asp:Literal>
                                    </p>
                                </div>

                                <hr>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-3 mt-4">
                                <asp:Button ID="btnAccept" runat="server" Text="✅ Accept Request"
                                    CssClass="btn btn-success w-50" OnClick="btnAccept_Click" />
                                <asp:Button ID="btnReject" runat="server" Text="❌ Reject" CssClass="btn btn-danger w-50"
                                    OnClick="btnReject_Click" />
                            </div>

                        </div>
                    </div>

                </div>
            </div>
            </div>
        </form>

    </body>

    </html>