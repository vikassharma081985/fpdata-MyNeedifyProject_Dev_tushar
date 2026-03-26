<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="ItemDescription.aspx.cs" Inherits="FaduPrice.Pages.ItemDescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
    <%--<script src="../Jscript/jquery.zoom.js"></script>--%>
    <%--<script src="../Jscript/jquery.zoom.min.js"></script>        --%>
    <script src="../Jscript/easyzoom.js"></script>


    <style>

        @media (max-width: 768px) {
            #easy_zoom {
                width: 170px !important;
                height: 300px !important;
                top: 180px !important;
            }

        }
        /*.jcf-number .jcf-btn-dec:before, .jcf-number .jcf-btn-dec:after, .jcf-number .jcf-btn-inc:before, .jcf-number .jcf-btn-inc:after {
            background: #fff;
            background-color: white;
        }

        .zoom {
            display: inline-block;
            position: relative;
        }

            
            .zoom:after {
                content: '';
                display: block;
                width: 33px;
                height: 33px;
                position: absolute;
                top: 0;
                right: 0;
                background: url(icon.png);
            }

            .zoom img {
                display: block;
            }

                .zoom img::selection {
                    background-color: transparent;
                }

        .SelectSize {
            border: 1px solid #09f;
        }*/
        .SelectSize {
            border: 1px solid #09f;
        }
    </style>

    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
        }

        * {
            box-sizing: border-box;
        }

        .slider {
            width: 100%;
            margin: 0px auto;
        }

        .slick-slide {
            margin: 0px 20px;
        }

            .slick-slide img {
                width: 100%;
            }

        .slick-prev:before,
        .slick-next:before {
            color: black !important;
        }


        .slick-slide {
            transition: all ease-in-out .3s;
            opacity: 1;
        }

        .slick-active {
            opacity: 1;
        }

        .slick-current {
            opacity: 1;
        }
    </style>
    <script>
        $(document).ready(function () {
            debugger;
            $('[id$=ImgMain]').attr('src', $('#subImg').attr('src'));
            $('[id$=ImgLarge]').attr('href', $('[id$=ImgMain]').attr('src'));
            $('a.zoom').easyZoom({
                width: 250,
                position: 'right',
                background: '#222'
            });

        });
    </script>
    <script type="text/javascript">        
          
        var flagWishList = false;
        function FillHeart() {
            $('#WishlistIco').removeClass("glyphicon-heart-empty");
            $('#WishlistIco').addClass("glyphicon-heart");

        }
        function EmptyHeart() {
            if (!flagWishList) {
                $('#WishlistIco').removeClass("glyphicon-heart");
                $('#WishlistIco').addClass("glyphicon-heart-empty");
            }
        }
        function AddToWishList() {
            var ItemId = $('[id$=hdnItemId]').val();
            var UserId = $('[id$=hdnUserId]').val();

            if (!flagWishList) {
                $('#WishlistIco').removeClass("glyphicon-heart-empty");
                $('#WishlistIco').addClass("glyphicon-heart");
                flagWishList = true;
                if (UserId != "0") {
                    $.ajax({
                        url: "ItemDescription.aspx/AddToWishList",
                        async: true,
                        data: '{ItemId:"' + ItemId + '",UserId:"' + UserId + '"}',
                        contentType: "application/json; charset=utf-8",
                        type: "POST", // data has to be Posted 
                        timeout: 120000,
                        dataType: "json",
                        success: function (result) {

                        }
                    });
                }

            } else {
                $('#WishlistIco').removeClass("glyphicon-heart");
                $('#WishlistIco').addClass("glyphicon-heart-empty");
                flagWishList = false;
            }
        }
    </script>

    <script src="slick/slick.js"></script>
    <link href="slick/slick-theme.css" rel="stylesheet" />
    <link href="slick/slick.css" rel="stylesheet" />
    <style>
        /*

Copy/paste this into your own stylesheet.
Edit width, height and placement of the dynamically created image zoom box. 

*/
          .navbar-brand img {
      margin-top: -14px;
  }
        #easy_zoom {
            width: 600px;
            height: 500px;
            border: 2px solid #eee;
            background: #fff;
            color: #333;
            position: absolute;
            top: 80px;
            left: 38%;
            overflow: hidden;
            -moz-box-shadow: 0 0 10px #777;
            -webkit-box-shadow: 0 0 10px #777;
            box-shadow: 0 0 10px #777;
            /* vertical and horizontal alignment used for preloader text */
            line-height: 400px;
            text-align: center;
            z-index: 999999;
        }

        .product-details h1 {
            font-weight: bold;
            margin: 0 0 10px;
            font-size: 20px;
            line-height: 26px;
            padding-right: 42px;
        }
    </style>
    <div class="container mt-5">

     <asp:HiddenField runat="server" ID="hdnItemId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnUserId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnStockAvailable" Value="0" />
    <asp:HiddenField runat="server" ID="hdnTotalStock" Value="0" />
    <asp:HiddenField ID="hdnRating" runat="server" Value="0" />
    <asp:HiddenField ID="hdnSizeId" runat="server" Value="0" />

    <div class="row align-items-start product-card p-4 rounded">

        <!-- LEFT IMAGE SECTION -->
        <div class="col-md-5 text-center position-relative">

            <a href="#" id="ImgLarge" class="zoom">
                            <img id="ImgMain" style="width: auto; height: 350px;" src="" class="img-responsive" alt="New York">
                        </a>


            <div id="divWishList" style="position: absolute; top: 5px; right: 10px;">
                <a href="#" title="Add to Wishlist" onclick="AddToWishList();">
                    <i id="WishlistIco"
                        style="font-size:25px;color:#7C519B"
                        class="glyphicon glyphicon-heart-empty">
                    </i>
                </a>
            </div>

            <!-- IMAGE REPEATER -->
            <div class="mt-3">
                <asp:Repeater ID="rptItemImages" runat="server">
                    <ItemTemplate>
                         <img id="subImg" src="<%#"http://198.38.88.185:8082/Images/Items/"+Eval("ImageName") %>" style="width: 65px !important;" onclick="Switch(this)" class="img-responsive img-thumbnail" />

                    </ItemTemplate>
                </asp:Repeater>
            </div>

        </div>

        <!-- RIGHT DETAILS SECTION -->
        <div class="col-md-7 mt-4 mt-md-0">

            <h2 class="product-title mb-3">
                <asp:Label runat="server" ID="lblItemName"></asp:Label>
            </h2>

            <div class="product-price mb-3">
                <span class="text-muted" style="text-decoration:line-through;">
                    ₹<asp:Label ID="lblPrice" runat="server"></asp:Label>
                </span>

                <span class="text-success fw-bold ms-3" style="font-size:1.5rem;">
                    ₹<asp:Label ID="lblOfferPrice" runat="server"></asp:Label>
                </span>

                <span class="ms-3" style="color:#7C519B;font-weight:bold;">
                    <asp:Label ID="lblOff" runat="server"></asp:Label>
                </span>
            </div>

            <!-- SIZE SECTION -->
            <div class="mb-3">
                <strong>Available Sizes:</strong>

                <ul class="list-unstyled d-flex flex-wrap gap-2 mt-2">
                    <asp:Repeater ID="rptAvailableSize" runat="server">
                       <ItemTemplate>
                                <li onclick="SelectSize(this);">
                                    <input type="hidden" id="hdnSelectedSizeId" value='<%#Eval("SizeId") %>' />
                                    <input type="hidden" id="hdnSelectedSizeStock" value='<%#Eval("Stock") %>' />
                                    <label><%#Eval("Size") %></label>

                                </li>
                            </ItemTemplate>

                    </asp:Repeater>
                </ul>
            </div>

            <!-- QUANTITY -->
            <div class="mb-3">
                <strong>Quantity:</strong>

                <div class="d-flex align-items-center gap-2 mt-2">

                    <button type="button" onclick="DecreaseQty()" class="btn btn-sm btn-secondary">-</button>

                    <input id="txtQty" type="number" value="1" min="1" max="10"
                        readonly class="form-control form-control-sm text-center"
                        style="width:70px;" />

                    <button type="button" onclick="IncreaseQty()" class="btn btn-sm btn-secondary">+</button>
                </div>

                <div class="mt-2">
                    <strong class="text-success" id="product-stock">In Stock</strong>

                    <strong style="color:red;display:none;" id="OutOfStock">
                        Out of Stock
                    </strong>
                </div>

            </div>

            <!-- DESCRIPTION -->
            <div class="mb-3">

                <div id="ShortDes">
                    <asp:Label ID="lblDescription" runat="server"></asp:Label>

                    <br />
                    <a href="#" onclick="ReadMore();" style="color:#7C519B;">Read More</a>
                </div>

                <div id="LongDes" style="display:none;">
                    <asp:Label ID="lblDescriptionFull" runat="server"></asp:Label>

                    <br />
                    <a href="#" onclick="ReadLess();" style="color:#7C519B;">Read Less</a>
                </div>

            </div>

            <!-- PINCODE CHECK -->
            <div class="mb-3">

                <input id="txtPincode" maxlength="6"
                    class="form-control form-control-sm d-inline-block"
                    placeholder="Enter Pincode"
                    style="width:150px;" />

                <button onclick="return CheckDelivery();"
                    class="btn btn-sm"
                    style="background:#0AA6BF;color:#fff;">
                    Check
                </button>

                <span id="ErrorMsg"></span>

            </div>

            <!-- BUTTONS -->
            <div class="d-flex gap-2 flex-wrap">

                <button onclick="return AddToCart();"
                    class="btn btn-sm"
                    style="background:#F48B1E;color:#fff;">
                    Add to Cart
                </button>

                <button onclick="return BuyNow();"
                    class="btn btn-sm"
                    style="background:#8EC243;color:#fff;">
                    Buy Now
                </button>

            </div>

        </div>
    </div>

    <!-- YOU MAY ALSO LIKE SECTION -->
    <div class="mt-5">

        <h4 class="mb-3">YOU MAY ALSO LIKE</h4>

        <div class="row">

            <asp:Repeater ID="rptYouMayLike" runat="server">
                <ItemTemplate>

                    <div class="col-md-2 col-6 text-center mb-3">

                        <a href="<%#"http://trendzshopping.in/Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>">

                             <img class="img-responsive img-thumbnail" src="<%#"../Images/Items/"+Eval("ImageName") %>" />

                        </a>

                        <div class="mt-2">
                            <%#Eval("ItemName") %>
                        </div>

                        <div class="text-success fw-bold">
                            ₹<%#Eval("OfferPrice") %>
                        </div>

                        <div class="text-muted" style="text-decoration:line-through;">
                            ₹<%#Eval("ItemPrice") %>
                        </div>

                    </div>

                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>

</div>

    <style>
        .morecontent span {
            display: none;
        }

        .morelink {
            display: block;
        }
    </style>
    <script>

        $(document).ready(function () {
            debugger;
            var TotalStock = parseInt($('[id$=hdnTotalStock]').val());
            if (TotalStock > 0) {
                $('#product-stock').show();
                $('#OutOfStock').hide();

                $('#txtQty').removeAttr('disabled');
                $('#product-actions-btn-add').removeAttr('disabled');
                $('#btnBuyNow').removeAttr('disabled');
            }
            else {
                $('#product-stock').hide();
                $('#OutOfStock').show();

                $('#txtQty').attr('disabled', 'disabled');
                $('#product-actions-btn-add').attr('disabled', 'disabled');
                $('#btnBuyNow').attr('disabled', 'disabled');

            }

        });


        function CheckDelivery() {
            Pincode = $('#txtPincode').val();
            if (Pincode != "") {
                $.ajax({
                    url: "PlaceOrder.aspx/CheckDelivery",
                    async: false,
                    data: '{Pincode:"' + Pincode + '"}',
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        var Ctr = parseInt(result.d);
                        if (Ctr > 0) {

                            $('#ErrorMsg').css('color', 'green');
                            $('#ErrorMsg').html('yay ! Delivery is available in this Area. We will deliver this item within 10 days.');
                        }
                        else {
                            $('#ErrorMsg').css('color', 'red');
                            $('#ErrorMsg').html('Oops ! Sorry currently delivery is not available in this Area.');
                        }
                    }
                });
            }
            return false;
        }

        function Switch(ctrl) {
            var Path = $(ctrl).attr('src');
            $('[id$=ImgMain]').attr('src', Path);
            $('[id$=ImgLarge]').attr('href', $('[id$=ImgMain]').attr('src'));
            $('a.zoom').easyZoom();

        }

        function IncreaseQty() {
            var StockAvailable = parseInt($('[id$=hdnStockAvailable]').val());
            if (StockAvailable == 0) {
                alert('Item is Out of Stock !');
            }
            else {
                var Qty = parseInt($('[id$=txtQty]').val().trim());
                if (Qty < StockAvailable) {
                    Qty = Qty + 1;
                    $('[id$=txtQty]').val(Qty);
                } else {
                    alert('Only ' + StockAvailable + ' Item left in stock !');
                }
            }

        }

        function DecreaseQty() {
            var Qty = parseInt($('[id$=txtQty]').val().trim());
            if (Qty > 1) {
                Qty = Qty - 1;
                $('[id$=txtQty]').val(Qty);
            }
        }

        function AddToCart() {
            debugger
            var MasterUserId = $('[id$=MasterhdnUserId]').val();
            if (MasterUserId != "" && MasterUserId != "0") {
                var Qty = $('[id$=txtQty]').val();
                var SizeId = $('[id$=hdnSizeId]').val();
                var ItemId = $('[id$=hdnItemId]').val();

                if (SizeId == "0") {
                    alert('Please select size.');
                }
                else {

                    $.ajax({
                        url: "ItemDescription.aspx/AddToCart",
                        async: true,
                        data: JSON.stringify({ Qty: Qty, SizeId: SizeId, ItemId: ItemId }),
                        contentType: "application/json; charset=utf-8",
                        type: "POST", // data has to be Posted 
                        timeout: 120000,
                        dataType: "json",
                        success: function (result) {
                            debugger
                            var CartCtr = parseInt(result.d);
                            if (CartCtr > 0) {
                                $('.Cart-Counter').html(CartCtr);
                                $('.Cart-Counter').show();
                                alert('Item has been added in your cart.');
                            }
                            else {
                                $('.Cart-Counter').html('');
                                $('.Cart-Counter').hide();
                            }
                        }
                    });

                }
            }
            else {
                alert('Login your account first !');
                $('[id$=lnkLogin]').click();
            }

            return false;
        }


        function BuyNow() {
            debugger
            var MasterUserId = $('[id$=MasterhdnUserId]').val();
            if (MasterUserId != "" && MasterUserId != "0") {
                var Qty = $('[id$=txtQty]').val();
                var SizeId = $('[id$=hdnSizeId]').val();
                var ItemId = $('[id$=hdnItemId]').val();

                if (SizeId == "0") {
                    alert('Please select size.');
                }
                else {

                    $.ajax({
                        url: "ItemDescription.aspx/AddToCart",
                        async: true,
                        data: JSON.stringify({ Qty: Qty, SizeId: SizeId, ItemId: ItemId }),
                        contentType: "application/json; charset=utf-8",
                        type: "POST", // data has to be Posted 
                        timeout: 120000,
                        dataType: "json",
                        success: function (result) {
                            window.location.href = "PlaceOrder.aspx";
                        }
                    });

                }
            }
            else {
                alert('Login your account first !');
                $('[id$=lnkLogin]').click();
            }

            return false;
        }

        function SelectSize(ctrl) {
            debugger;
            $(ctrl).parent().find('li').each(function () {
                $(this).removeClass('SelectSize');
            });
            var SizeId = $(ctrl).find('[id$=hdnSelectedSizeId]').val();
            $('[id$=hdnSizeId]').val(SizeId);
            var StockAvailable = parseInt($(ctrl).find('[id$=hdnSelectedSizeStock]').val());

            if (StockAvailable > 0) {
                $('#product-stock').show();
                $('#OutOfStock').hide();

                $('#txtQty').removeAttr('disabled');
                $('#product-actions-btn-add').removeAttr('disabled');
                $('#btnBuyNow').removeAttr('disabled');
            }
            else {
                $('#product-stock').hide();
                $('#OutOfStock').show();

                $('#txtQty').attr('disabled', 'disabled');
                $('#product-actions-btn-add').attr('disabled', 'disabled');
                $('#btnBuyNow').attr('disabled', 'disabled');

            }

            $('[id$=hdnStockAvailable]').val(StockAvailable);

            $(ctrl).addClass('SelectSize');
        }


        function ReadMore() {
            $('#ShortDes').css('display', 'none');
            $('#LongDes').css('display', 'block');
        }
        function ReadLess() {
            $('#ShortDes').css('display', 'block');
            $('#LongDes').css('display', 'none');
        }
    </script>
    <script src="slick/slick.js"></script>
    <script>
        $(document).on('ready', function () {

            $(".regular").slick({
                dots: false,
                infinite: true,
                slidesToShow: 1,
                slidesToScroll: 1
            });

            $(".variable").slick({
                dots: true,
                infinite: true,
                variableWidth: true
            });
            $(".lazy").slick({
                lazyLoad: 'ondemand', // ondemand progressive anticipated
                infinite: true
            });
        });
    </script>
</asp:Content>
