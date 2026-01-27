<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="AddSubSubCategory.aspx.cs" Inherits="WSBillingMaster.Pages.AddSubSubCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .mycheckbox input[type="checkbox"] {
            margin-right: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="//cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="//cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>

    <div class="container">
        <div style="width: 1300px; background-color: #ccc;">
        </div>
        <div class="col-md-12">
            <div class="Header" style="padding: 5px;">
                <span>Add/Edit/View Sub Category Master</span>
                <span style="float: right; font-weight: 100; font-size: 12px; margin-top: 5px; margin-right: 10px;"></span>
            </div>

            <div class="content" style="text-align: left; margin-top: 10px;">
                <div class="row">
                    <div class="col-md-12">

                        <div class="col-md-4">
                            <asp:Label for="ddlCategoryMaster" runat="server" Text="Select Category" />
                            <asp:DropDownList runat="server" class="form-control" ID="ddlCategoryMaster" AutoPostBack="true" OnSelectedIndexChanged="ddlStateMaster_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ErrorMessage="Select Category" ForeColor="Red" ControlToValidate="ddlCategoryMaster" ValidationGroup="save" runat="server" />
                        </div>

                        <div class="col-md-4">
                            <asp:Label for="ddlSubCategoryMaster" runat="server" Text="Select SubCategory" />
                            <asp:DropDownList runat="server" class="form-control" ID="ddlSubCategoryMaster" AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategoryMaster_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ErrorMessage="Select SubCategory" ForeColor="Red" ControlToValidate="ddlSubCategoryMaster" ValidationGroup="save" runat="server" />
                        </div>

                        <div class="col-md-4">
                            <asp:Label for="txtSubSubCategoryName" runat="server" Text="Sub Sub Category Name" />
                            <asp:TextBox runat="server" ID="txtSubSubCategoryName" class="form-control" />
                            <asp:RequiredFieldValidator ErrorMessage="Enter SubCategory Name" ForeColor="Red" ControlToValidate="txtSubSubCategoryName" ValidationGroup="save" runat="server" />
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
                            <asp:HiddenField runat="server" ID="hdnSubCatID" Value="" />
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
                                            <th>Category Name</th>
                                            <th>SubCategory Name</th>
                                             <th>Sub Sub Category Name</th>
                                            <th>Status</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>

                            <ItemTemplate>
                                <tr>
                                    <td><%#Eval("Category") %></td>
                                    <td><%#Eval("SubCategory") %></td>
                                    <td><%#Eval("SubSubCategory") %></td>
                                    <td>
                                        <span style="color: green; font-weight: bold">
                                            <%# Convert.ToBoolean(Eval("isactive")) == true ? "Active":"" %>
                                        </span>
                                        <span style="color: red; font-weight: bold">
                                            <%# Convert.ToBoolean(Eval("isactive")) == false ? "InActive":"" %>
                                        </span>

                                    </td>

                                    <td>
                                        <asp:HiddenField runat="server" ID="hdnSubSubCategoryId" Value='<%#Eval("SubSubCategoryId") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSubCategoryId" Value='<%#Eval("SubCategoryId") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSubSubCategoryName" Value='<%#Eval("SubSubCategory") %>' />
                                        <asp:HiddenField runat="server" ID="hdnCategoryId" Value='<%#Eval("CategoryId") %>' />
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
