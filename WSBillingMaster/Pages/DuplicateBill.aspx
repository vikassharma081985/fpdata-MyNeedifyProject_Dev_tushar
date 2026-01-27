<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="DuplicateBill.aspx.cs" Inherits="WSBillingMaster.Pages.DuplicateBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="Header">
            Previous Transactions
        </div>
        <div class="Content">
            <table style="width: 100%">
                <tr>
                    <td style="width: 25%;">From Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">To Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;"></td>
                </tr>
                <tr>
                    <td style="width: 25%;">
                        <asp:TextBox runat="server" class="form-control datepicker" ID="txtFromDate"></asp:TextBox>

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:TextBox runat="server" class="form-control datepicker" ID="txtToDate" />

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:TextBox runat="server" class="form-control" ID="txtKeyword" placeholder="Customer Name/Mobile" />

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 10%;">
                        <asp:Button ID="btnSearch" runat="server" class="btn-danger" Text="Search" OnClick="btnSearch_Click" />
                    </td>

                </tr>
            </table>
        </div>
        <%--<div class="col-md-12" style="padding: 5px; background-color: #f1f1f1; border: 1px solid #000; color: #000">
            <div class="col-md-1" style="text-align: center;">
                SN
            </div>
            <div class="col-md-1" style="text-align: center;">
                Invoice#
            </div>
            <div class="col-md-2" style="text-align: center;">
                Date of Txn
            </div>
            <div class="col-md-3" style="text-align: center;">
                Customer
            </div>
            <div class="col-md-1" style="text-align: center;">
                Amount
            </div>
            <div class="col-md-1" style="text-align: center;">
                Tax
            </div>
            <div class="col-md-1" style="text-align: center;">
                Discount
            </div>
            <div class="col-md-1" style="text-align: center;">
                Grand Total
            </div>
            <div class="col-md-1" style="text-align: center;">
                Mode
            </div>

        </div>--%>
        <div class="Content" style="max-height: 400px; overflow: auto;">
            <asp:GridView ID="grdTransaction" runat="server" Width="100%" AutoGenerateColumns="false" EmptyDataText="No Record Found">
                <Columns>
                    <asp:TemplateField HeaderText="SNo">
                        <ItemTemplate>
                            <%#Eval("SNo") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Invoice#">
                        <ItemTemplate>
                            <%#Eval("InvoiceNumber") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <%#Eval("TransactionOn") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Customer">
                        <ItemTemplate>
                            <%#Eval("Customer") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mobile">
                        <ItemTemplate>
                            <%#Eval("Mobile") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Net Amount">
                        <ItemTemplate>
                            <%#Eval("GrandTotal") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Print">
                        <ItemTemplate>
                            <img src="../Images/download.png" style="height: 35px; width: 40px; cursor: pointer; margin-left: 15px"
                                onclick="Download(this);" />
                            <asp:HiddenField ID="hdnId" runat="server" Value='<%#Eval("InvoiceNumber") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>
    </div>
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script>
        $(function () {
            $(".datepicker").datepicker();
        });


        function Download(ctrl) {
            var TransactionId = $(ctrl).next().val();
            TransactionId = TransactionId.substring(5, TransactionId.length);
            window.open("BillReceipt.aspx?TransactionId=" + TransactionId);
        }
    </script>
</asp:Content>
