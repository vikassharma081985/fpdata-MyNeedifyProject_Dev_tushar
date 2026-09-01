<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="FaduPrice.Pages.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .shopping-basket .cartItem select {
            position: relative;
            left: 0;
        }
    </style>
    <div class="container">
        <div class="basket-section">
            <div class="container-fluid">
                <!-- basket heading -->
                <header class="headline row">

                    <div class="col-sm-6 col-md-9">

                        <h2>Your <span class="hidden-xs">Shopping</span> Basket</h2>
                    </div>
                    <div class="col-sm-6 col-md-3 text-right">
                        <a href="PlaceOrder.aspx" style="background-color: #F6861F; background-image: none; border: none;" class="btn btn-primary btn-block">Checkout Now</a>
                    </div>
                    <div class="col-sm-12 order-promotion">
                    </div>
                </header>

                <ul class="shopping-basket">
                    <li class="title-row">
                        <div class="col-img" style="text-align: center;">
                            <strong>Item</strong>
                        </div>
                        <div class="col-descr">
                            <strong>Description</strong>
                        </div>
                        <div class="col-qty">
                            <strong>Quantity</strong>
                        </div>
                        <div class="col-price" style="text-align: center;">
                            <strong>Price</strong>
                        </div>

                        <div class="col-total">
                            <strong>Total Price</strong>
                        </div>
                    </li>

                    <%-- Item list Starts here --%>

                    <asp:Repeater ID="rptItems" runat="server">
                        <ItemTemplate>
                            <li class="shopping-basket-product cartItem">
                                <div class="col-img">
                                    <a href="#" class="product-link">
                                        <img src='<%#"../Images/Items/"+Eval("ItemImage") %>' class="img-responsive" style="max-height: 150px;" />
                                    </a>
                                </div>
                                <div class="col-descr">
                                    <div class="text-holder">
                                        <strong class="title">
                                            <a href='<%#"https://myneedify.com/Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>' class="product-link"><%#Eval("ItemName") %>

                                            </a></strong>
                                        <div class="item-options">
                                            <div>
                                                <p><span style="color: #808080; font-weight: bold">Colour: </span><span style="color: #000;"><strong><%#Eval("Color") %></strong></span></p>
                                                <p><span style="color: #808080; font-weight: bold">Size: </span><span style="color: #000;"><strong><%#Eval("Size") %></strong></span></p>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-qty" style="padding-left: 0px; text-align: center;">
                                    <input type="button" value="-" style="border-radius: 100%; width: 25px; border: none; font-weight: bold; font-size: 20px; float: left; font-family: arial;" />
                                    <asp:Label ID="txtQuantity" Text='<%#Eval("ItemQuantity") %>' runat="server" Style="text-align: center; width: 50px; float: left; font-size: 18px;"></asp:Label>
                                    <input type="button" value="+" style="border-radius: 100%; width: 25px; border: none; font-weight: bold; font-size: 20px; float: left; font-family: arial;" />
                                    <br />
                                    <br />
                                    <a href="#" style="color: #09f;">Remove</a>
                                </div>
                                <div class="col-price" style="text-align: center;">

                                    <p>
                                        <span>Price : </span><span style="color: #000; font-weight: bold; font-family: Arial;"><i class="fa fa-inr"></i><%#Eval("MRP") %></span>
                                        <p><span>Discount : </span><span style="color: #000; font-weight: bold; font-family: Arial;"><i class="fa fa-inr"></i><%#Eval("Discount") %> </span></p>
                                        <p><span>Shipping fee : </span><span style="color: green; font-weight: bold;">Free</span> </p>
                                </div>

                                <div class="col-total" style="font-family: Arial;">
                                    <strong class="price">
                                        <span></span><span>
                                            <i class="fa fa-inr"></i><%# Convert.ToInt32(Eval("ItemPrice"))*Convert.ToInt32(Eval("ItemQuantity")) %></span></strong>
                                </div>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>


                    <%-- One Item Ends here --%>
                </ul>




                <div class="row">
                    <div class="col-sm-6 col-sm-push-6 col-md-6 col-md-push-6">
                        <div class="row">
                            <div class="col-md-6" style="text-align: right; font-weight: 600; font-size: 24px;">
                                Total
                            </div>
                            <div class="col-md-2 col-md-push-4" style="text-align: right; font-weight: 600; font-size: 24px;">
                                <strong><i style="float: left" class="fa fa-inr"></i>&nbsp;
                                <asp:Label ID="lblSubTotal" Style="float: left; font-family: Arial; margin-left: 6px;" runat="server"></asp:Label></strong>
                            </div>
                        </div>
                        <div class="total" style="display: none;">
                            <strong>Total</strong>
                            <strong class="price">
                                <i style="float: left" class="fa fa-inr"></i>
                                <asp:Label ID="lblTotal" Style="float: left; font-family: Arial; margin-left: 10px;" runat="server"></asp:Label></strong>
                        </div>
                    </div>


                </div>
                <div class="row">
                    <div class="col-md-3 col-md-push-9 ">
                        <br />
                        <br />
                        <a href="PlaceOrder.aspx" id="shopping-actions-btn-checkout" style="background-color: #F6861F; background-image: none; border: none;" class="btn btn-primary btn-block">Checkout Now</a>

                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
