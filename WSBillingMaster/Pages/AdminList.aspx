<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="AdminList.aspx.cs" Inherits="WSBillingMaster.Pages.AdminList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 1170px; margin: 0 auto; border: 1px solid #ccc">

        <style>
            #ContentPlaceHolder1_grdAdminList tr td {
                padding: 10px !important;
            }

            #ContentPlaceHolder1_grdAdminList tr th {
                padding: 10px !important;
            }

            .Box-Container1 {
                background-color: #fff;
            }
        </style>

        <asp:HiddenField ID="hdnShowPageFrom" runat="server" Value="1" />
        <asp:HiddenField ID="hdnShowPageTo" runat="server" Value="5" />
        <asp:HiddenField ID="hdnCurrentPageIndex" runat="server" Value="1" />
        <asp:HiddenField ID="hdnTotalPages" runat="server" Value="0" />
        <div class="Box-Container1" style="margin-top: 60px">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6" style="font-size: 20px; font-family: Arial; color: #000; font-weight: bold; margin-bottom: 5px; margin-left: -28px; margin-top: 16px;">
                    Edit Your Item
                </div>
            </div>
            <div id="AdminList" class="content">
                <asp:GridView ID="grdAdminList" EmptyDataText="No record found..." AutoGenerateColumns="False" OnRowCommand="grdAdminList_RowCommand" runat="server" CssClass="GridViewStyle" Width="956px" CellPadding="4" ForeColor="#333333" GridLines="None">

                    <AlternatingRowStyle BackColor="White" />

                    <Columns>
                        <asp:TemplateField HeaderText="Item Name" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblItemName" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category">
                            <ItemTemplate>
                                <asp:Label ID="lblCat" runat="server" Text='<%#Eval("Category") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Seller Name">
                            <ItemTemplate>
                                <asp:Label ID="lblSellerName" runat="server" Text='<%#Eval("SupplierName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item Price">
                            <ItemTemplate>
                                <asp:Label ID="lblItemrice" runat="server" Text='<%#Eval("ItemPrice") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="edit" OnCommand="lnkEdit_Command" CommandArgument='<%#Eval("ItemId") %>' Text="Edit"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#f4511e" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#f4511e" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <RowStyle ForeColor="#333333" BackColor="#FFFBD6" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <SortedAscendingCellStyle BackColor="#FDF5AC" />
                    <SortedAscendingHeaderStyle BackColor="#4D0000" />
                    <SortedDescendingCellStyle BackColor="#FCF6C0" />
                    <SortedDescendingHeaderStyle BackColor="#820000" />
                </asp:GridView>

                <div class="NormalDiv" style='padding: 17px 0px 17px; text-align: left;'>
                    <asp:Repeater ID="rptPager" runat="server" OnItemCommand="rptPager_ItemCommand">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkBtnPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                                CommandName="Pager" Style='<%#Eval("Style") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
