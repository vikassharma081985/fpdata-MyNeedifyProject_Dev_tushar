<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="WSBillingMaster.Front.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <div class="container">

        <div class="basket-section">
            <div class="container-fluid">
                <!-- basket heading -->
                <header class="headline row">

                    <div class="col-sm-6 col-md-9">

                        <h2>Your <span class="hidden-xs">Wishlist</span></h2>
                    </div>

                    <div class="col-sm-12 order-promotion">
                    </div>
                </header>
            </div>
        </div>
        <div class="container-fluid">
            <div class="container-fluid">
              
                <div class="products-carousel gallery-js-ready autorotation-disabled">
                    <div class="mask">
                        <div class="row">
                            <asp:Repeater ID="rptMenCollection" runat="server">
                                <ItemTemplate>
                                    <div class="col-md-2 col-xs-6 col-sm-3">
                                        <a href="<%#"http://trendzshopping.in//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>" target="_blank">
                                            <div class="Tile">
                                                <img class="img-responsive img-thumbnail" src="<%#"../Images/Item/"+Eval("ImageName") %>" />
                                            </div>
                                        </a>
                                        <a href="<%#"http://trendzshopping.in//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>" target="_blank">
                                            <span class="ItemName"><%#Eval("ItemName").ToString().Length >50?Eval("ItemName").ToString().Substring(0,50):Eval("ItemName") %></span>
                                        </a>
                                        <div class="ItemPrice">
                                            <span><i class="fa fa-inr"></i><%#Eval("OfferPrice") %></span>
                                        </div>
                                        <div class="ItemPriceOffer">
                                            <span><i class="fa fa-inr"></i><%#Eval("ItemPrice") %></span>
                                        </div>
                                        <div class="ItemPriceOffer">
                                            <span style="color: #7C519B"><%#Eval("Discount") %></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <div id="divMenCollNoRecord" runat="server" style="padding: 15px; border: 1px solid #ccc;">
                        No Item Available !
                    </div>
                </div>


            </div>
        </div>

    </div>
</asp:Content>
