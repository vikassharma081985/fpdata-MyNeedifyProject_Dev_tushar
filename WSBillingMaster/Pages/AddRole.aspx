<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="AddRole.aspx.cs" Inherits="WSBillingMaster.AddRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="//cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="//cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css'
        media="screen" />
    <style>
        .mycheckbox input[type="checkbox"] {
            margin-right: 5px;
        }
    </style>
    <script>

        $(document).ready(function () {
            $("#tblMenuData [id*=chkHeader]").click(function () {
                if ($(this).is(":checked")) {
                    $("#tblMenuData [id*=chkRow]").attr("checked", "checked");
                } else {
                    $("#tblMenuData [id*=chkRow]").removeAttr("checked");
                }
            });
            $("#tblMenuData [id*=chkRow]").click(function () {
                if ($("#tblMenuData [id*=chkRow]").length == $("#tblMenuData [id*=chkRow]:checked").length) {
                    $("#tblMenuData [id*=chkHeader]").attr("checked", "checked");
                } else {
                    $("#tblMenuData [id*=chkHeader]").removeAttr("checked");
                }
            });

            $('#tbldata').DataTable();
        });

        function ShowPopup() {

            //  jQuery.noConflict(); 
            $("#myModal").modal();
        }

        function ClearForm() {
            $('input[type=text]').val('');
            $('select').val('0');

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="container">
        <div style="width: 1300px; background-color: #ccc;">
        </div>
        <div class="col-md-12">
            <div class="Header" style="padding: 5px;">
                <span>Add/Edit/View Role</span>
                <span style="float: right; font-weight: 100; font-size: 12px; margin-top: 5px; margin-right: 10px;"></span>
            </div>

            <div class="content" style="text-align: left; margin-top: 10px;">
                <div class="row">
                    <div class="col-md-12">

                        <div class="col-md-4">
                            <asp:Label for="txtrole" runat="server" Text="Role Name" />
                            <asp:TextBox runat="server" ID="txtrole" class="form-control" />
                            <asp:RequiredFieldValidator ErrorMessage="Enter Role Name" ForeColor="Red" ControlToValidate="txtrole" ValidationGroup="save" runat="server" />
                        </div>

                        <div class="from-group">
                            <div class="col-md-6">
                                <label for="cblActive">&nbsp;</label>
                                <div class="col-md-6">
                                    <asp:CheckBox runat="server" CssClass="mycheckbox" ID="cblActive" Text=" To activated click on checkbox" />
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="clearfix"></div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="col-md-4">
                            <asp:HiddenField runat="server" ID="hdnMenuID" Value="" />
                            <asp:Button Text="Submit" ID="btnSave" ValidationGroup="save" OnClick="btnSave_Click" runat="server" /><br />
                            <%--<asp:Button Text="Save" CssClass="btn btn-default" ValidationGroup="save" ID="btnSave" OnClick="btnSave_Click" runat="server" />--%>
                            <asp:Label Text="" ID="lblmsg" Style="font-size: 14px; font-weight: bold" runat="server" />
                        </div>
                    </div>
                </div>
                <hr />
                <div class="row" style="font-size: 12px">
                    <div class="col-md-12">
                        <asp:Repeater runat="server" ID="rptData">
                            <HeaderTemplate>
                                <table id="tbldata" class="table-responsive table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Role Name</th>
                                            <th>Assign</th>
                                            <th>Status</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>

                            <ItemTemplate>
                                <tr>
                                    <td><%#Eval("Role") %></td>
                                    <td>
                                        <%--<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>--%>
                                        <asp:LinkButton Text="Show" ID="lnkMenu" OnClick="lnkMenu_Click" CssClass="btn-link" runat="server" />
                                    </td>
                                    <td>
                                        <span style="color: green; font-weight: bold">
                                            <%# Convert.ToBoolean(Eval("isactive")) == true ? "Active":"" %>
                                        </span>
                                        <span style="color: red; font-weight: bold">
                                            <%# Convert.ToBoolean(Eval("isactive")) == false ? "InActive":"" %>
                                        </span>
                                    </td>

                                    <td>
                                        <asp:HiddenField runat="server" ID="hdnRoleId" Value='<%#Eval("RoleId") %>' />
                                        <asp:HiddenField runat="server" ID="hdnRole" Value='<%#Eval("Role") %>' />
                                        <asp:HiddenField runat="server" ID="hdnisactive" Value='<%#Eval("isactive") %>' />

                                        <asp:LinkButton Text="Edit" ID="lnkEdit" OnClick="lnkEdit_Click" CssClass="btn-link" runat="server" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

    </div>


    <%--Menu model--%>
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Menu</h4>
                </div>
                <div class="modal-body">
                    <div style="text-align: right; padding: 4px;">
                        <asp:HiddenField ID="hdnRoleID" runat="server" />
                        <asp:Button Text="Submit" CssClass="btn btn-info" Style="margin-right: 10px" ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" />
                    </div>
                    <asp:Repeater runat="server" ID="rptMenu">
                        <HeaderTemplate>
                            <table id="tblMenuData" class="table-responsive table-bordered">
                                <thead>
                                    <tr>
                                        <th>Menu Name</th>
                                        <th style="width: 200px"></th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td style=""><%#Eval("MenuName") %></td>

                                <td style="text-align: center">
                                    <asp:HiddenField runat="server" ID="hdnMenuId" Value='<%#Eval("MenuId") %>' />
                                    <asp:CheckBox ID="chkRow" Checked='<%# Convert.ToBoolean(Eval("CHECKED")) == true ? true:false %>' runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <div class="modal-footer">
                    <asp:Button Text="Submit" CssClass="btn btn-info" Style="margin-right: 10px" ID="Button1" OnClick="btnSubmit_Click" runat="server" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

