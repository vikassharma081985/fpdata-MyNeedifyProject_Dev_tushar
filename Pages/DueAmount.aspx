<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="DueAmount.aspx.cs" Inherits="WSBillingMaster.DueAmount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="Header">
            Due Amount
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
                        <asp:Button ID="btnSearch" runat="server" class="btn-danger" Text="Search" OnClick="btnSearchData_Click" />
                    </td>

                </tr>
            </table>
        </div>
        
        <div class="Content" style="max-height: 400px; overflow: auto;">
            <asp:GridView ID="grdDueAmount" runat="server" Width="100%" AutoGenerateColumns="false" EmptyDataText="No Record Found">
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
                    <asp:TemplateField HeaderText="Due Amount">
                        <ItemTemplate>
                            <%#Eval("DueAmount") %>
                            <img src="../Images/settlement.jpg" style="height: 35px; width: 40px; cursor: pointer; margin-left: 15px" onclick="MoveToSettlement(this);"  />
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
        function MoveToSettlement(ctrl) {
            var TransactionId = $(ctrl).next().val();
            TransactionId = TransactionId.substring(5, TransactionId.length);
            window.location.href = "AmountSettlement.aspx?TransactionId=" + TransactionId;
        }
    </script>
</asp:Content>
