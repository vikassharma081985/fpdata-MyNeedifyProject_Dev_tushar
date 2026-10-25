<%@ Page Title="Employee Hierarchy" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ManageTeamHierarchy.aspx.cs" Inherits="WSBillingMaster.Pages.ManageTeamHierarchy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Employee Hierarchy</title>
    <style>
        .page-box {
            background: #ffffff;
            border: 1px solid #dce4ec;
            border-radius: 8px;
            padding: 22px 25px;
            margin-bottom: 20px;
            margin-top:70px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .page-header-title {
            margin: 0 0 5px 0;
            font-size: 22px;
            font-weight: 700;
            color: #2c3e50;
        }
        .page-header-sub {
            font-size: 13px;
            color: #7f8c8d;
            margin: 0;
        }
        .org-select-box {
            background: #f4f8fb;
            border: 1px solid #d5e4ef;
            border-left: 5px solid #3498db;
            border-radius: 6px;
            padding: 15px 20px;
            margin-bottom: 22px;
        }
        .assign-box {
            background: #fafcfe;
            border: 1px solid #e1e8ed;
            border-radius: 6px;
            padding: 18px 20px;
            margin-bottom: 25px;
        }
        .assign-box h4 {
            margin-top: 0;
            margin-bottom: 14px;
            font-size: 15px;
            font-weight: 700;
            color: #34495e;
        }
        
        /* Simple tree styling */
        .simple-tree-container {
            background: #ffffff;
            border: 1px solid #e1e8ed;
            border-radius: 6px;
            padding: 20px 25px;
            min-height: 250px;
        }
        .simple-tree ul {
            list-style: none;
            padding-left: 28px;
            position: relative;
            margin: 5px 0;
        }
        .simple-tree > ul {
            padding-left: 0;
        }
        .simple-tree li {
            margin: 8px 0;
            position: relative;
        }
        .emp-badge-card {
            display: inline-block;
            background: #f8fafc;
            border: 1px solid #dbe2e8;
            border-radius: 5px;
            padding: 7px 14px;
            font-size: 13px;
            color: #2c3e50;
            transition: all 0.15s ease;
        }
        .emp-badge-card:hover {
            background: #eef4f9;
            border-color: #3498db;
        }
        .emp-badge-card.is-root {
            border-left: 4px solid #8e44ad;
            background: #fdfaff;
        }
        .emp-badge-card.is-sub {
            border-left: 4px solid #3498db;
        }
        .emp-role-tag {
            font-size: 11px;
            background: #e1e8ed;
            color: #34495e;
            padding: 2px 7px;
            border-radius: 10px;
            margin-left: 6px;
            font-weight: 600;
        }
        .emp-level-tag {
            font-size: 10px;
            font-weight: 700;
            padding: 2px 6px;
            border-radius: 4px;
            margin-left: 6px;
        }
        .lvl-1 { background-color: #8e44ad; color: #fff; }
        .lvl-2 { background-color: #2980b9; color: #fff; }
        .lvl-3 { background-color: #16a085; color: #fff; }
        .lvl-4 { background-color: #e67e22; color: #fff; }

        /* Access Denied */
        .denied-card {
            background: #ffffff;
            border: 1px solid #e1e8ed;
            border-radius: 8px;
            padding: 40px;
            text-align: center;
            max-width: 550px;
            margin: 60px auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="max-width: 1050px; margin-top: 25px; margin-bottom: 50px;">

        <!-- ACCESS DENIED PANEL (Non-Super Admin) -->
        <asp:Panel ID="pnlAccessDenied" runat="server" Visible="false">
            <div class="denied-card">
                <span class="glyphicon glyphicon-lock" style="font-size: 48px; color: #e74c3c; margin-bottom: 15px;"></span>
                <h3 style="font-weight: 700; color: #2c3e50;">Super Admin Access Only</h3>
                <p style="color: #7f8c8d; font-size: 14px; margin: 15px 0 25px 0;">
                    You must be logged in as a <strong>Super Admin</strong> to manage employee hierarchy.
                </p>
                <a href="UserDashboard.aspx" class="btn btn-default" style="font-weight: 600;">
                    <span class="glyphicon glyphicon-arrow-left"></span> Back to Dashboard
                </a>
            </div>
        </asp:Panel>

        <!-- MAIN EMPLOYEE HIERARCHY PANEL -->
        <asp:Panel ID="pnlMainContent" runat="server">

            <!-- Page Title Card -->
            <div class="page-box">
                <div class="row">
                    <div class="col-sm-8">
                        <h2 class="page-header-title">
                            <%--<span class="glyphicon glyphicon-tree-conifer" style="color: #3498db; margin-right: 6px;"></span>--%>
                            Employee Hierarchy
                        </h2>
                        <p class="page-header-sub">
                            Manage multi-level reporting structure and team hierarchy with respect to any organization (OrgId).
                        </p>
                    </div>
                    <div class="col-sm-4 text-right" style="margin-top: 10px;">
                        <a href="UserDashboard.aspx" class="btn btn-default btn-sm" style="font-weight: 600;">
                            <%--<span class="glyphicon glyphicon-home"></span>--%> Dashboard
                        </a>
                    </div>
                </div>
            </div>

            <!-- STEP 1: SELECT ORGANIZATION (OrgId) -->
            <div class="org-select-box">
                <div class="row">
                    <div class="col-md-3" style="margin-top: 6px;">
                        <label for="<%= ddlOrganization.ClientID %>" style="font-size: 14px; font-weight: 700; color: #2c3e50;">
                            <%--<span class="glyphicon glyphicon-briefcase"></span>--%> Select Organization:
                        </label>
                    </div>
                    <div class="col-md-6">
                        <asp:DropDownList ID="ddlOrganization" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlOrganization_SelectedIndexChanged" Style="font-size: 14px; font-weight: 600;">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3" style="margin-top: 8px;">
                        <asp:Label ID="lblSelectedOrgInfo" runat="server" CssClass="text-muted" Font-Size="12px" Font-Bold="true"></asp:Label>
                    </div>
                </div>
            </div>

            <!-- STEP 2: ASSIGN REPORTING MANAGER FORM -->
            <div class="assign-box">
                <%--<h4><span class="glyphicon glyphicon-transfer" style="color: #3498db;"></span>--%> Set Employee Reporting Manager</h4>
                
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group" style="margin-bottom: 0;">
                            <label style="font-size: 12px; color: #555;">1. Select Employee:</label>
                            <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-group" style="margin-bottom: 0;">
                            <label style="font-size: 12px; color: #555;">2. Reports To (Manager):</label>
                            <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-3" style="margin-top: 24px;">
                        <asp:Button ID="btnSaveHierarchy" runat="server" Text="Save Hierarchy" CssClass="btn btn-primary btn-block" OnClick="btnSaveHierarchy_Click" Font-Bold="true" />
                    </div>
                </div>

                <div style="margin-top: 10px;">
                    <asp:Label ID="lblMsg" runat="server" EnableViewState="false" Font-Bold="true" Font-Size="13px"></asp:Label>
                </div>
            </div>

            <!-- STEP 3: HIERARCHY VIEWS (Tree & Table Tabs) -->
            <div class="page-box" style="padding: 15px 20px;">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist" style="margin-bottom: 20px;">
                    <li role="presentation" class="active">
                        <a href="#tabTree" aria-controls="tabTree" role="tab" data-toggle="tab" style="font-weight: 600;">
                            <%--<span class="glyphicon glyphicon-tree-conifer"></span>--%> Hierarchy Tree View
                        </a>
                    </li>
                    <li role="presentation">
                        <a href="#tabTable" aria-controls="tabTable" role="tab" data-toggle="tab" style="font-weight: 600;">
                            <%--<span class="glyphicon glyphicon-list"></span>--%> Employee List Table
                        </a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    
                    <!-- TAB 1: SIMPLE HIERARCHY TREE -->
                    <div role="tabpanel" class="tab-pane active" id="tabTree">
                        <div class="simple-tree-container">
                            <div class="simple-tree">
                                <asp:Literal ID="litSimpleTree" runat="server"></asp:Literal>
                            </div>
                        </div>
                    </div>

                    <!-- TAB 2: SIMPLE HIERARCHY TABLE -->
                    <div role="tabpanel" class="tab-pane" id="tabTable">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover" style="font-size: 13px;">
                                <thead style="background: #f7f9fa; color: #34495e;">
                                    <tr>
                                        <th style="width: 100px;">Level</th>
                                        <th>Employee Name</th>
                                        <th>Role</th>
                                        <th>Employee ID</th>
                                        <th>Reports To (Manager)</th>
                                        <th style="width: 170px; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptEmployees" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <span class='emp-level-tag <%# GetLevelCss(Eval("HierarchyLevel")) %>'>
                                                        Level <%# Eval("HierarchyLevel") %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <div style="padding-left: <%# (Convert.ToInt32(Eval("HierarchyLevel")) - 1) * 16 %>px;">
                                                        <span class="glyphicon glyphicon-user" style="color: #7f8c8d; margin-right: 4px;"></span>
                                                        <strong><%# Eval("FullName") %></strong>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="label label-default"><%# Eval("RoleName") %></span>
                                                </td>
                                                <td><%# Eval("EmployeeId") %></td>
                                                <td>
                                                    <%# Eval("ManagerName").ToString().StartsWith("None") 
                                                        ? "<span class='text-muted'><em>(Top Level / Head)</em></span>" 
                                                        : "<strong>" + Eval("ManagerName") + "</strong>" %>
                                                </td>
                                                <td style="text-align: center;">
                                                    <asp:LinkButton ID="lnkSelectEmp" runat="server" CssClass="btn btn-xs btn-info" 
                                                        CommandArgument='<%# Eval("UserId") %>' OnClick="lnkSelectEmp_Click">
                                                        <span class="glyphicon glyphicon-pencil"></span> Edit
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="lnkMakeRoot" runat="server" CssClass="btn btn-xs btn-default" 
                                                        CommandArgument='<%# Eval("UserId") %>' OnClick="lnkMakeRoot_Click" 
                                                        Visible='<%# Eval("ManagerId") != DBNull.Value && Convert.ToInt32(Eval("ManagerId")) > 0 %>'
                                                        OnClientClick="return confirm('Promote this employee to Top Level (No Manager)?');">
                                                        <span class="glyphicon glyphicon-arrow-up"></span> Set Root
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>

        </asp:Panel>

    </div>
</asp:Content>
