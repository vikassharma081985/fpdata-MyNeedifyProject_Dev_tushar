<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="AddMenu.aspx.cs" Inherits="WSBillingMaster.Pages.AddMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="//cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="//cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <style>
        .mycheckbox input[type="checkbox"] {
            margin-right: 5px;
        }
    </style>
    <script>

        $(document).ready(function () {
            $('#tbldata').DataTable();
        });


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
                <span>Add/ Edit/ View Menu</span>
                <span style="float: right; font-weight: 100; font-size: 12px; margin-top: 5px; margin-right: 10px;"></span>
            </div>

            <div class="content" style="text-align: left; margin-top: 10px;">
                <div class="row">
                    <div class="col-md-12">

                        <div class="col-md-4">
                           <asp:Label for="txtMenuName" runat="server" Text="Menu Name" />
                            <asp:TextBox runat="server" ID="txtMenuName" class="form-control" />
                            <asp:RequiredFieldValidator ErrorMessage="Enter Menu Name" ForeColor="Red" ControlToValidate="txtMenuName" ValidationGroup="save" runat="server" />
                        </div>

                        <div class="col-md-4">
                           <asp:Label for="txtMenuUrl" runat="server" Text="MenuUrl Name" />
                            <asp:TextBox runat="server" ID="txtMenuUrl" class="form-control" />
                            <asp:RequiredFieldValidator ErrorMessage="Enter MenuUrl" ForeColor="Red" ControlToValidate="txtMenuUrl" ValidationGroup="save" runat="server" />
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
                                            <th>Menu Name</th>
                                            <th>Menu Url</th>
                                            <th>Status</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>

                            <ItemTemplate>
                                <tr>
                                    <td><%#Eval("MenuName") %></td>
                                    <td><%#Eval("MenuUrl") %></td>
                                    <td>
                                        <span style="color: green; font-weight: bold">
                                            <%# Convert.ToBoolean(Eval("isactive")) == true ? "Active":"" %>
                                        </span>
                                        <span style="color: red; font-weight: bold">
                                            <%# Convert.ToBoolean(Eval("isactive")) == false ? "InActive":"" %>
                                        </span>
                                    </td>

                                    <td>
                                        <asp:HiddenField runat="server" ID="hdnMenuId" Value='<%#Eval("MenuId") %>' />
                                        <asp:HiddenField runat="server" ID="hdnMenuName" Value='<%#Eval("MenuName") %>' />
                                        <asp:HiddenField runat="server" ID="hdnMenuUrl" Value='<%#Eval("MenuUrl") %>' />
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


</asp:Content>

