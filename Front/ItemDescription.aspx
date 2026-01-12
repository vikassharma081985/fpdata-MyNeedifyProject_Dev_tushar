 <%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="FaduPrice.Front.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
     <script src="/slick/slick.js"></script>

    <script>


        $('.carousel').carousel({
            interval: 1000
        });

        $(document).ready(function () {
            $('.MySliderDiv').each(function (index) {
                if (index == 0) {
                    $(this).addClass('active');
                }
            });
            $('.MyBullets').each(function (index) {
                if (index == 0) {
                    $(this).addClass('active');
                }
            });
        });

    </script>

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

    <link href="/slick/slick.css" rel="stylesheet" />
    <link href="/slick/slick-theme.css" rel="stylesheet" />

    <!---------------sahil style --------------------------------->
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
        }

        * {
            box-sizing: border-box;
        }

        .slider {
            width: 95%;
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
            color: black;
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
       /*CSS For Sliders*/
        .carousel-inner > .item > img, .carousel-inner > .item > a > img {
            width: 100%;
        }

    </style>
    <!----------------------------end here-------------------------------------------------->










   <!--  Style -->
<style>
  .product-card {
    background-color: #fff;
    transition: 0.3s ease;
  }
  .product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
  }
  .product-title {
    font-size: 1.6rem;
    color: #333;
    font-weight: 600;
  }
  .product-description {
    font-size: 0.95rem;
    line-height: 1.6;
  }
  .product-image {
    max-height: 350px;
    object-fit: cover;
  }
  .product-btn {
    min-width: 120px;
    font-size: 12px;
    border-radius: 6px;
    padding: 6px 12px;
  }
  @media (max-width: 576px) {
    .product-btn {
      flex: 1 1 auto;
      min-width: 45%;
    }
  }
  .review-section {
    border: 1px solid #e5e5e5;
  }
  .star-rating i {
    font-size: 1.3rem;
    color: #ccc;
    cursor: pointer;
    margin-right: 5px;
    transition: color 0.2s;
  }
  .star-rating i.active,
  .star-rating i:hover,
  .star-rating i:hover ~ i {
    color: #F7C32E;
  }
</style>



    <!-----------tushar code-------------------->

<div class="container mt-5">
    <div class="row align-items-center product-card shadow p-4 rounded bg-white">

        <!-- Product Image (NO carousel) -->
        <div class="col-md-5 text-center">
            <img id="ImgMain"
                 class="img-fluid rounded img-thumbnail"
                 style="max-width:250px; max-height:150px;"
                 src=""
                 alt="Product Image" />
        </div>

        <!-- Product Details -->
        <div class="col-md-7 mt-4 mt-md-0">

            <h2 class="product-title mb-3">
                <asp:Label ID="Label1" runat="server" />
            </h2>

            <p class="product-description text-muted mb-3">
                <asp:Label ID="Label2" runat="server" />
            </p>

            <ul class="list-unstyled mb-3">
                <li><strong>Brand:</strong> AudioTech</li>
                <li><strong>Fabric:</strong> 100% Cotton</li>
                <li><strong>Warranty:</strong> 1 Month</li>
            </ul>

            <!-- Price -->
            <div class="product-price mb-4">
                <span class="text-muted" style="text-decoration: line-through;">
                    ₹<asp:Label ID="Label3" runat="server" />
                </span>
                &nbsp;
                <span class="text-success fw-bold" style="font-size:1.5rem;">
                    ₹<asp:Label ID="Label4" runat="server" />
                </span>
            </div>

            <!-- Buttons (same JS functions) -->
            <div class="d-flex gap-2 flex-wrap">
                <button class="btn btn-sm"
                        style="background-color:#F48B1E;color:#fff;border:none;"
                        onclick="return AddToCart();">
                    Add to Cart
                </button>

                <button class="btn btn-sm"
                        style="background-color:#8EC243;color:#fff;border:none;"
                        onclick="return BuyNow();">
                    Buy Now
                </button>
            </div>

        </div>
    </div>

    <!-- Reviews Section (UI only) -->
    <div class="review-section shadow-sm rounded p-4 mt-4 bg-white">
        <h4 class="mb-3 fw-semibold">Customer Reviews</h4>

        <div class="d-flex align-items-center mb-3">
            <span class="text-warning me-2">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star-o"></i>
            </span>
            <span class="text-muted">(0 Reviews)</span>
        </div>

        <hr />

        <div class="text-center text-muted py-3">
            <i class="fa fa-comments" style="font-size:1.5rem;"></i>
            <p class="mt-2 mb-0">No comments yet</p>
        </div>

        <hr />

        <div class="add-review mt-3">
            <h5 class="mb-3">Write a Review</h5>

            <div class="mb-3">
                <label>Your Rating:</label><br />
                <i class="fa fa-star-o"></i>
                <i class="fa fa-star-o"></i>
                <i class="fa fa-star-o"></i>
                <i class="fa fa-star-o"></i>
                <i class="fa fa-star-o"></i>
            </div>

            <div class="mb-3">
                <input type="text" class="form-control form-control-sm" placeholder="Your Name" />
            </div>

            <div class="mb-3">
                <textarea class="form-control form-control-sm" rows="3"
                          placeholder="Write your review here..."></textarea>
            </div>

            <button class="btn btn-sm"
                    style="background-color:#0AA6BF;color:#fff;border:none;">
                Submit Review
            </button>
        </div>
    </div>
</div>

 



    <!----------ends here----------------------------->
























    <!----------------------------salhi code --------------------------------------------->


      <div class="container">
        <asp:HiddenField runat="server" ID="hdnItemId" Value="0" />
        <asp:HiddenField runat="server" ID="hdnUserId" Value="0" />
        <asp:HiddenField runat="server" ID="hdnStockAvailable" Value="0" />
        <asp:HiddenField runat="server" ID="hdnTotalStock" Value="0" />


        <div class="product-details row">
            <div class="col-sm-4 col-xs-12" style="margin-top: 20px;">

                <div class="product-mask">

                    <div class="item" style="width: 100%; position: relative;">

                        <p>
                            <a href="#" id="ImgLarge" class="zoom">
                                <img id="ImgMain" style="width: auto; height: 350px;" src="" class="img-responsive" alt="New York">
                            </a>
                        </p>
                        <div id="divWishList" style="position: absolute; top: 0; right: 0;">
                            <a href="#" title="Add to Wishlist" onclick="AddToWishList();"><i id="WishlistIco" style="font-size: 25px; font-weight: 500; color: #7C519B" onmouseover="FillHeart();" onmouseout="EmptyHeart();" class=" glyphicon glyphicon-heart-empty myHeader"></i></a>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <section class="regular slider">
                            <asp:Repeater ID="rptItemImages" runat="server">
                                <ItemTemplate>
                                    <div class='container'>
                                        <div class='easyzoom example'>
                                            <img id="subImg" src="<%#"http://trendzshopping.in//Images/Items/"+Eval("ImageName") %>" style="width: 65px !important;" onclick="Switch(this)" class="img-responsive img-thumbnail" />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </section>
                    </div>

                </div>

            </div>

            <div class="col-sm-5 descr" id="product-details-col-2">

                <div class="holder">
                    <h1>
                        <asp:Label runat="server" ID="lblItemName"></asp:Label></h1>
                    <%--   <div id="RatingBox">
                        <div style="padding-top: 0px; text-align: center">

                            <section class='rating-widget'>

                                <!-- Rating Stars Box -->
                                <div class='rating-stars text-left' style="color: orange; font-size: 18px;">

                                    <i class='fa fa-star fa-fw'></i>

                                    <i class='fa fa-star fa-fw'></i>

                                    <i class='fa fa-star fa-fw'></i>

                                    <i class='fa fa-star fa-fw'></i>

                                    <i class='fa fa-star fa-fw' style="color: #ccc"></i>

                                </div>

                            </section>
                        </div>
                    </div>--%>
                    <div class="product-price">
                        <strong class="price">

                            <span>
                                <span style="font-weight: 100; text-decoration: line-through"><i style="font-weight: 100;" class="fa fa-inr"></i>
                                    <asp:Label ID="lblPrice" runat="server"></asp:Label></span>
                                <span style="margin-left: 15px;"><i class="fa fa-inr"></i>
                                    <asp:Label ID="lblOfferPrice" runat="server"></asp:Label>
                                </span>

                                <span style="margin-left: 15px; color: #7C519B; font-weight: 600">
                                    <asp:Label ID="lblOff" runat="server"></asp:Label>
                                </span>

                            </span>
                        </strong>

                    </div>
                    <asp:HiddenField ID="hdnRating" runat="server" Value="0" />

                    <div class="product-sets">
                        <strong class="title">
                            <label>
                                Size<%--<a href="#" style="color: #7C519B !important;">(Size Guide)</a>--%>
                            </label>
                        </strong>

                        <ul class="list-unstyled set-size">
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


                        <strong class="title">
                            <label>Quantity</label></strong>
                        <div class="qty-block">
                            <span class="jcf-number">
                                <input id="txtQty" name="quantity" type="number" min="1" value="1" max="10" readonly="true" class="jcf-real-element">
                                <span class="jcf-btn-inc" style="background-color: #7c519b; color: #fff" onclick="IncreaseQty()"></span>
                                <span class="jcf-btn-dec" style="background-color: #7c519b; color: #fff" onclick="DecreaseQty()"></span></span>


                            <strong class="stock" id="product-stock">
                                <i id="product-stock-icon" class="icon-full"></i>In stock</strong>


                            <strong style="color: red;" id="OutOfStock">
                                <i class="fa fa-times-circle-o" style="font-size: 24px;"></i>
                                <span style="font-size: 24px;">Out of stock </span></strong>

                        </div>
                        <div class="descr-text" id="product-details-text">
                            <%--   <hr class="visible-xs">--%>

                            <strong class="title visible-xs" id="product-details-text-title">Overview</strong>
                            <p></p>
                            <div class="row">
                                <div class="col-md-12 col-xs-12">

                                    <div id="ShortDes">
                                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                        <br />
                                        <a href="#" id="ReadMore" style="text-decoration: none; color: #7C519B;" onclick="ReadMore();">Read More</a>
                                    </div>
                                    <div id="LongDes" style="display: none;">
                                        <asp:Label ID="lblDescriptionFull" runat="server"></asp:Label>
                                        <br />
                                        <a href="#" id="ReadLess" style="text-decoration: none; color: #7C519B;" onclick="ReadLess();">Read Less</a>
                                    </div>
                                </div>

                            </div>


                        </div>


                    </div>
                </div>



            </div>
            <div class="col-sm-3" id="product-details-col3">
                <!-- product aside -->
                <div class="product-actions" id="product-actions">
                    <ul class="info-list list-unstyled" id="product-info-list">
                        <li id="product-info-list-item1" style="text-align: left;"><i id="product-info-list-item-icon1" class="fa fa-car"></i>When will I receive my order?</li>
                    </ul>
                    <div id="checkpin_div">
                        <div id="form_checkpin" class="">
                            <div class="pincode-form form-inline">
                                <input class="form-control" id="txtPincode" maxlength="6" placeholder="Enter Pincode" />
                                <button style="background-color: #F6861F !important;" id="pincode-check" onclick="return CheckDelivery();" class="btn">
                                    Check</button>

                            </div>

                        </div>

                    </div>
                    <ul class="info-list list-unstyled">
                        <li><span id="ErrorMsg"></span></li>

                    </ul>

                    <div class="product-from join-us-bottom" id="product-actions-form">
                        <fieldset class="show" id="product-actions-fieldset">
                            <button id="product-actions-btn-add" onclick="return AddToCart();" style="background-color: #7C519B !important; width: 205px; background-image: none; z-index: 999; border: none; position: fixed; bottom: -1%; left: 0;" class="btn btn-primary btn-block">Add to Cart <i class="fa fa-shopping-cart"></i></button>
                            <button id="btnBuyNow" onclick="return BuyNow();" style="background-color: #F6861F !important; background-image: none; width: 205px; z-index: 999; border: none; position: fixed; bottom: -1%; right: 0;" class="btn btn-primary btn-block">Buy Now <i class="fa fa-bolt"></i></button>
                            <asp:HiddenField ID="hdnSizeId" runat="server" Value="0" />
                        </fieldset>
                        <hr class="hide">
                    </div>


                </div>

            </div>

        </div>
        <div class="intro-area" id="section-products-carousel" style="display: none;">

            <!--YOU MAY ALSO LIKE-->

            <div class="container-fluid">
                <div class="col-md-12">
                    <h2 id="H1" class="text-uppercase">YOU MAY ALSO LIKE</h2>
                </div>

                <div class="products-carousel gallery-js-ready autorotation-disabled">
                    <div class="mask">
                        <div class="row">
                            <asp:Repeater ID="rptYouMayLike" runat="server">
                                <ItemTemplate>
                                    <div class="col-md-2 col-xs-6 col-sm-3">
                                        <a href="<%#"http://trendzshopping.in//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>">
                                            <div class="Tile">
                                                <img class="img-responsive img-thumbnail" src="<%#"../Images/Items/"+Eval("ImageName") %>" />
                                            </div>
                                        </a>
                                        <a href="<%#"http://trendzshopping.in//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>">
                                            <span class="ItemName"><%#Eval("ItemName") %></span>
                                        </a>
                                        <div class="ItemPrice">
                                            <span><i class="fa fa-inr"></i><%#Eval("OfferPrice") %></span>
                                        </div>
                                        <div class="ItemPriceOffer">
                                            <span><i class="fa fa-inr"></i><%#Eval("ItemPrice") %></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                </div>


            </div>
        </div>
    </div>

    

     <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
    <script src="http://localhost:46692//Front/slick/slick.js" type="text/javascript" charset="utf-8"></script>
    

   
    <script>
        $(document).on('ready', function () {

            $(".regular").slick({
                dots: false,
                infinite: true,
                slidesToShow: 2,
                slidesToScroll: 2
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