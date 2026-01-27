<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="FaduPrice.Pages.MyOrders" %>

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

                        <h2>Your <span class="hidden-xs">Orders</span></h2>
                    </div>

                    <div class="col-sm-12 order-promotion">
                    </div>
                </header>

                <ul class="shopping-basket">
                    <li class="title-row">
                        <div class="col-img">
                            <strong>Item</strong>
                        </div>
                        <div class="col-descr">
                            <strong>Description</strong>
                        </div>
                        <div class="col-qty">
                            <strong>Ordered On</strong>
                        </div>
                        <div class="col-price"  style="text-align:center;width: 150px;">
                            <strong>Status</strong>
                        </div>
                       
                        <div class="col-total" style="float:left;">
                            <strong>Total Price</strong>
                        </div>
                         <div class="col-total"  style="float:left;text-align:right">
                            <strong>Actions</strong>
                        </div>
                    </li>

                    <%-- Item list Starts here --%>

                    <asp:Repeater ID="rptItems" runat="server">
                        <ItemTemplate>
                            <li class="shopping-basket-product cartItem">
                                <div class="col-img">
                                    <a href="#" class="product-link">
                                        <img src='<%#"../Images/Items/"+Eval("ItemImage") %>' class="img-responsive" style="max-height: 125px;" />
                                    </a>
                                </div>
                                <div class="col-descr">
                                    <div class="text-holder">
                                        <strong class="title">
                                            <a href='<%#"ItemDescription.aspx?ItemId="+Eval("ItemId") %>' class="product-link"><%#Eval("ItemName") %>

                                            </a></strong>
                                        <div class="item-options">
                                            <div>
                                                <p><span style="color: #808080; font-weight: bold">Quantity: </span><span style="color: #000;"><strong><%#Eval("ItemQuantity") %></strong></span></p>
                                                <p><span style="color: #808080; font-weight: bold">Size: </span><span style="color: #000;"><strong><%#Eval("Size") %></strong></span></p>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-qty">
                                    <%#Eval("OrderedOn") %>
                                </div>

                                <div class="col-price" style="text-align:center;width: 150px;">
                                    <%#Eval("Status") %>
                                </div>

                                  
                                <div class="col-total" style="float:left;">
                                    <strong class="price">
                                        <span></span><span>
                                            <i class="fa fa-inr"></i><%# Eval("TotalPrice") %></span></strong>
                                </div>

                                <div class="col-total" style="float:left;text-align:left;padding-left:30px !important">
                                   <a href="#" style="color:#7C519B !important;text-decoration:none;" > <p> <i style="color:red;" class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp;&nbsp; Track Order</p></a>
                                    <a href="#" style="color:#7C519B !important;text-decoration:none;" > <p> <i style="color:red;" class="fa fa-user-o" aria-hidden="true"></i>&nbsp;&nbsp; Customer Support</p></a>
                                    <a href="#" style="color:#7C519B !important;text-decoration:none;" > <p> <i style="color:red;"class="fa fa-print"  aria-hidden="true"></i>&nbsp;&nbsp; Print Details</p></a>
                                    <a href="#" style="color:#7C519B !important;text-decoration:none;" onclick="CancelOrder(<%# Eval("OrderItemId") %>);" > <p> <i style="color:red;"  class="fa fa-times" aria-hidden="true"></i>&nbsp;&nbsp; Cancel Order</p></a>

                                </div>
                              
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>


                    <%-- One Item Ends here --%>
                </ul>

            </div>
        </div>



    </div>

    <script>
        function CancelOrder(OrderItemId)
        {
            var flag = confirm("Are you sure? You want to cancel ? ")
            if (flag) {
                $.ajax({
                    url: "MyOrders.aspx/CancelOrder",
                    async: true,
                    data: '{OrderItemId:"' + OrderItemId + '"}',
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        alert('Order Cancelled Successfully');
                        window.location.reload();
                    }
                });
            }
        }
    </script>
</asp:Content>
