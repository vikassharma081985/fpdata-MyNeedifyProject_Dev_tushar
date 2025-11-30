<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="StateMaster.aspx.cs" Inherits="WSBillingMaster.Pages.StateMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .mycheckbox input[type="checkbox"] {
            margin-right: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- <Ajax:ScriptManager ID="ScriptManager1" runat="server">
    </Ajax:ScriptManager>--%>
    <link href="//cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="//cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>

    <div class="container">
        <div style="width: 1300px; background-color: #ccc;">
        </div>
        <div class="col-md-12">
            <div class="Header" style="padding: 5px;">
                <span>Add/Edit/View State Master</span>
                <span style="float: right; font-weight: 100; font-size: 12px; margin-top: 5px; margin-right: 10px;"></span>
            </div>

            <div class="content" style="text-align: left; margin-top: 10px;">
                <div class="row">
                    <div class="col-md-12">

                        <div class="col-md-4">
                            <asp:Label for="txtStateName" Text="State Name" runat="server" />
                            <asp:TextBox runat="server" ID="txtStateName" class="form-control" />
                            <asp:RequiredFieldValidator ErrorMessage="Please Enter State Name" ForeColor="Red" ControlToValidate="txtStateName" ValidationGroup="save" runat="server" />

                        </div>


                        <div class="col-md-12">
                            <label for="cblActive">&nbsp;</label>
                            <div class="col-md-6">
                                <asp:CheckBox runat="server" CssClass="mycheckbox" ID="cblActive" Text="To activated click on checkbox" />
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="clearfix"></div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="col-md-4">
                            <asp:HiddenField runat="server" ID="hdnSateID" Value="" />
                            <asp:Button Text="Submit" ValidationGroup="save"  ID="btnSave" OnClick="btnSave_Click" runat="server" /><br />
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
                                            <th>State Name</th>
                                            <th>Status</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>

                            <ItemTemplate>
                                <tr>
                                    <td><%#Eval("State") %></td>
                                    <td>
                                        <span style="color: green; font-weight: bold">
                                            <%# Convert.ToBoolean(Eval("isactive")) == true ? "Active":"" %>
                                        </span>
                                        <span style="color: Red; font-weight: bold">
                                            <%# Convert.ToBoolean(Eval("isactive")) == false ? "InActive":"" %>
                                        </span>

                                    </td>

                                    <td>
                                        <asp:HiddenField runat="server" ID="hdnID" Value='<%#Eval("id") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSate" Value='<%#Eval("State") %>' />
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
            // $.noConflict();

            $('#tbldata').DataTable();
        });


        function Save() {
            var Name = $('#txtUserName').val().trim();


            if (Name == '') {
                alert('Enter User Name');
                return;
            }




        }

        function ClearForm() {
            $('input[type=text]').val('');
            $('select').val('0');

        }




    </script>
</asp:Content>
