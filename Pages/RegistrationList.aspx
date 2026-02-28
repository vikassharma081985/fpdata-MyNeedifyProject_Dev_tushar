<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationList.aspx.cs"
    Inherits="WSBillingMaster.Pages.RegistrationList" %>

    <!DOCTYPE html>
    <html lang="en">

    <head runat="server">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registration List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <style>
            .card {
                border-radius: 15px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .btn-add {
                background-color: #8EC243;
                color: white;
            }

            .btn-add:hover {
                background-color: #7ab035;
                color: white;
            }

            .table thead {
                background-color: #F48B1E;
                color: white;
            }
        </style>
    </head>

    <body class="bg-light">
        <form id="form1" runat="server" class="container py-5">
            <div class="card bg-white">
                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                    <h4 class="mb-0 fw-bold">Job Registrations</h4>
                    <div class="d-flex gap-2">
                        <asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="/Front/index.aspx" CssClass="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Back
                        </asp:HyperLink>
                        <asp:HyperLink ID="lnkAddNew" runat="server" NavigateUrl="Registration.aspx" CssClass="btn btn-add">
                            <i class="fas fa-plus me-2"></i>New Registration
                        </asp:HyperLink>
                    </div>
                </div>
                <div class="card-body">
                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

                    <div class="table-responsive">
                        <asp:GridView ID="gvRegistrations" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle" GridLines="None"
                            OnRowCommand="gvRegistrations_RowCommand" DataKeyNames="RegId">
                            <Columns>
                                <asp:BoundField DataField="RegId" HeaderText="ID" ItemStyle-Width="50px" />
                                <asp:BoundField DataField="AadharNumber" HeaderText="Aadhar Number" />
                                <asp:TemplateField HeaderText="Candidate Name">
                                    <ItemTemplate>
                                        <%# Eval("FirstName") %>
                                            <%# Eval("LastName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" />
                                <asp:BoundField DataField="Skill" HeaderText="Skill" />
                                <asp:BoundField DataField="ExperienceType" HeaderText="Experience" />
                                <asp:TemplateField HeaderText="Resume">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="lnkResume" runat="server"
                                            NavigateUrl='<%# Eval("ResumePath") %>' Target="_blank"
                                            Visible='<%# !string.IsNullOrEmpty(Eval("ResumePath").ToString()) %>'
                                            CssClass="text-primary text-decoration-none">
                                            <i class="fas fa-file-download me-1"></i>View
                                        </asp:HyperLink>
                                        <asp:Label ID="lblNoResume" runat="server" Text="N/A"
                                            Visible='<%# string.IsNullOrEmpty(Eval("ResumePath").ToString()) %>'
                                            CssClass="text-muted"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditReg"
                                            CommandArgument='<%# Eval("RegId") %>'
                                            CssClass="btn btn-sm btn-outline-primary me-2">
                                            <i class="fas fa-edit"></i> Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteReg"
                                            CommandArgument='<%# Eval("RegId") %>'
                                            CssClass="btn btn-sm btn-outline-danger"
                                            OnClientClick="return confirm('Are you sure you want to delete this registration?');">
                                            <i class="fas fa-trash"></i> Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">
                                    No registrations found.
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </form>
    </body>

    </html>