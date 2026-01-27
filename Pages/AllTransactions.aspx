<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="AllTransactions.aspx.cs" Inherits="WSBillingMaster.Pages.AllTransactions" %>

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
                        <asp:TextBox runat="server" class="form-control datepicker" id="txtFromDate" ></asp:TextBox>

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:TextBox runat="server" class="form-control datepicker" id="txtToDate" />

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:Button ID="btnSearch" runat="server" class="btn-danger" Text="Search" OnClick="btnSearch_Click"/>
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
            <asp:GridView ID="grdTransaction" runat="server" Width="100%" AutoGenerateColumns="true" EmptyDataText="No Record Found" ></asp:GridView>
           <%-- <asp:Repeater ID="rptItems" runat="server">
                <ItemTemplate>

                    <div class="col-md-12" style="padding: 15px;">
                        <div class="col-md-1" style="text-align: center;">
                            <%#Eval("RowId") %>
                        </div>
                        <div class="col-md-1">
                            <%#Eval("InvoiceNumber") %>
                        </div>
                        <div class="col-md-2">
                            <%#Eval("TransactionOn") %>
                        </div>
                        <div class="col-md-3">
                            <%#Eval("Customer") %>
                        </div>

                        <div class="col-md-1" style="text-align: center;">

                            <%#Eval("Amount") %>
                        </div>
                        <div class="col-md-1" style="text-align: center;">
                            <%#Eval("Tax") %>
                        </div>
                        <div class="col-md-1" style="text-align: center;">
                            <%#Eval("Discount") %>
                        </div>
                        <div class="col-md-1" style="text-align: center;">
                            <%#Eval("GrandTotal") %>
                        </div>
                        <div class="col-md-1" style="text-align: center;">
                            <%#Eval("PaymentMode") %>
                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>--%>
        </div>
    </div>
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script>
    $( function() {
        $(".datepicker").datepicker(
            {
                    dateFormat: 'dd-M-yy'
            }
            );
    } );
        </script>
</asp:Content>
