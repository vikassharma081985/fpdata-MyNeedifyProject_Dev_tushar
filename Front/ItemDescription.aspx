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





<div class="container mt-5">
  <div class="row align-items-center product-card shadow p-4 rounded">

    <div class="col-md-5 text-center">
      <img src="https://www.creativefabrica.com/wp-content/uploads/2021/06/09/Motorcycle-Sublimation-T-Shirt-Design-Graphics-13161222-2-580x387.jpg"
        alt="Product Image"
        class="img-fluid rounded product-image">
    </div>

    <!--  Product Details -->
    <div class="col-md-7 mt-4 mt-md-0">
      <h2 class="product-title mb-3">
        Motorcycle Sublimation T Shirt Design Graphic by DesignVerse Studio · Creative Fabrica
      </h2>

      <p class="product-description text-muted mb-3">
        Experience premium comfort with 100% cotton material and stylish print. Perfect for riders who want
        both style and quality in one.
      </p>

      <ul class="list-unstyled mb-3">
        <li><strong>Brand:</strong> AudioTech</li>
        <li><strong>Size:</strong> S, M, L, XL</li>
        <li><strong>Fabric:</strong> 100% Cotton</li>
        <li><strong>Warranty:</strong> 1 Month</li>
      </ul>

      <div class="product-price mb-4">
        <span class="text-muted" style="text-decoration: line-through;">₹4,999</span>
        <span class="text-success fw-bold" style="font-size: 1.5rem;">₹3,499</span>
      </div>

      <div class="d-flex justify-content-start flex-wrap gap-2">
        <button class="btn btn-sm product-btn"
          style="background-color:#F48B1E; color:#fff; border:none;">
          Add to Cart
        </button>

        <button class="btn btn-sm product-btn"
          style="background-color:#8EC243; color:#fff; border:none;">
          Buy Now
        </button>
      </div>
    </div>
  </div>

  <div class="review-section shadow-sm rounded p-4 mt-4 bg-white">
    <h4 class="mb-3" style="font-weight:600;">Customer Reviews</h4>

    <div class="d-flex align-items-center mb-3">
      <span class="text-warning me-2" style="font-size: 1.3rem;">
        <i class="bi bi-star-fill text-warning"></i>
<i class="bi bi-star-fill text-warning"></i>
<i class="bi bi-star-fill text-warning"></i>
<i class="bi bi-star-fill text-warning"></i>
<i class="bi bi-star text-warning"></i>
      </span>
      <span class="text-muted">(0 Reviews)</span>
    </div>

    <hr>

    <div class="text-center text-muted py-3">
      <i class="fa fa-comments" style="font-size:1.5rem;"></i>
      <p class="mt-2 mb-0">No comments yet</p>
    </div>

    <hr>

    <div class="add-review mt-3">
      <h5 class="mb-3">Write a Review</h5>

      <div class="mb-3">
        <label class="form-label">Your Rating:</label>
        <div class="star-rating">
          <i class="fa-regular fa-star" data-value="1"></i>
          <i class="fa-regular fa-star" data-value="2"></i>
          <i class="fa-regular fa-star" data-value="3"></i>
          <i class="fa-regular fa-star" data-value="4"></i>
          <i class="fa-regular fa-star" data-value="5"></i>
        </div>
      </div>

      <div class="mb-3">
        <input type="text" class="form-control form-control-sm" placeholder="Your Name">
      </div>

      <div class="mb-3">
        <textarea class="form-control form-control-sm" rows="3" placeholder="Write your review here..."></textarea>
      </div>

      <button class="btn btn-sm" style="background-color:#0AA6BF; color:#fff; border:none;">Submit Review</button>
    </div>
  </div>
</div>



 




























    <!----------------------------salhi code --------------------------------------------->


    <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 100%;    margin-top: 35px;">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <asp:Literal runat="server" ID="litBullets"></asp:Literal>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <asp:Repeater ID="rptSlider" runat="server">
                <ItemTemplate>
                  
                    <div id="SliderItem" class="item MySliderDiv">
  <a href="https://www.example.com" target="_blank">
       <!-- Slider Image 1 -->
   <img src="../Images/Slider/1_003.jpg" />
  </a>
</div>
<div id="SliderItem" class="item MySliderDiv">
  <%--<a href="https://www.example.net" target="_blank">--%>
    <!-- Slider Image 2 -->
    <img src="../Images/Slider/1_003.jpg" />
  </a>
</div>
<div id="SliderItem" class="item MySliderDiv">
  <%--<a href="https://www.example.io" target="_blank">--%>
    <!-- Slider Image 3 -->
    <img src="../Images/Slider/1_003.jpg" />
  </a>
</div>

                </ItemTemplate>
            </asp:Repeater>

        </div>

        <!-- Left and right controls -->
        <%--<a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span>
        </a>--%>
    </div>

    <div class="container-fluid" style="display:none;">
        <div class="container-fluid">
            <div class="col-md-12">
                <h2 id="section-heading-title-02" class="text-uppercase">TRENDING COLLECTIONS</h2>
            </div>

            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/old images/Max-PC-1-231017.jpg" style="max-height: 200px;" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/old images/Max-PC-2-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/old images/Max-PC-3-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/old images/Max-PC-4-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/old images/Max-PC-5-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/old images/Max-PC-6-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>

        </div>
    </div>
    <div class="container">
        <hr />
    </div>
    <div class="container-fluid" style="    margin-top: -25px;">
        <div class="container-fluid">
            <div class="col-md-12">
                <h2 id="H1" class="text-uppercase">WOMEN COLLECTIONS</h2>
            </div>

            <div class="products-carousel gallery-js-ready autorotation-disabled">
                <div class="mask">
                    <div class="row">
                        <section class="regular slider">
                            <asp:Repeater ID="rptWomenCollection" runat="server">
                                <ItemTemplate>
                                    <div class="col-md-2 col-xs-6 col-sm-3" style="margin:0px;">
                                        <a href="<%#"/Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>">
                                            <div class="Tile">
                                                <img class="img-responsive img-thumbnail" style="max-width:250px;max-height: 150px;"  src="<%#"../Images/Items/"+Eval("ImageName") %>" />
                                            </div>
                                        </a>
                                        <a href="<%#"/Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>" >
                                            <span class="ItemName"><%#Eval("ItemName").ToString().Length >35?Eval("ItemName").ToString().Substring(0,35):Eval("ItemName") %></span>
                                        </a>
                                        <div class="ItemPrice">
                                            <span><i class="fa fa-inr"></i><%#Eval("OfferPrice") %></span>
                                        </div>
                                        <div class="ItemPriceOffer">
                                            <span><i class="fa fa-inr"></i><%#Eval("ItemPrice") %></span>
                                        </div>
                                        <div class="ItemPriceOffer">
<%--                                            <span style="color: #7C519B"><%#Eval("Discount") %></span>--%>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </section>
                    </div>
                </div>
                <div id="divWomenCollNoRecord" runat="server" style="padding: 15px; border: 1px solid #ccc;">
                    No Item Available hello !
                </div>
            </div>


        </div>
    </div>

    
    <div class="container-fluid" style="margin-top: -20px;">
        <div class="container-fluid">
            <div class="col-md-12">
                <h2 id="H2" class="text-uppercase">MEN COLLECTIONS</h2>
            </div>

            <div class="products-carousel gallery-js-ready autorotation-disabled">
                <div class="mask">
                    <div class="row">
                        <section class="regular slider">
                            <asp:Repeater ID="rptMenCollection" runat="server">
                                <ItemTemplate>
                                    <div class="col-md-2 col-xs-6 col-sm-3"  style="margin:0px;">
                                        <a href="<%#"http://localhost:46692//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>">
                                            <div class="Tile">
                                                <img class="img-responsive img-thumbnail"  style="max-width:250px;max-height: 150px;" src="<%#"~/Images/Items/"+Eval("ImageName") %>" />
                                            </div>
                                        </a>
                                        <a href="<%#"http://localhost:46692//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>">
                                            <span class="ItemName"><%#Eval("ItemName").ToString().Length >35?Eval("ItemName").ToString().Substring(0,35):Eval("ItemName") %></span>
                                        </a>
                                        <div class="ItemPrice">
                                            <span><i class="fa fa-inr"></i><%#Eval("OfferPrice") %></span>
                                        </div>
                                        <div class="ItemPriceOffer">
                                            <span><i class="fa fa-inr"></i><%#Eval("ItemPrice") %></span>
                                        </div>
                                        <%--<div class="ItemPriceOffer">
                                            <span style="color: #7C519B"><%#Eval("Discount") %></span>
                                        </div>--%>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </section>
                    </div>
                </div>

                <div id="divMenCollNoRecord" runat="server" style="padding: 15px; border: 1px solid #ccc;">
                    No Item Available!
                </div>
            </div>


        </div>
    </div>

 
    <div class="container-fluid"  style="margin-top: -20px;">
        <div class="container-fluid">
            <div class="col-md-12">
                <h2 id="H3" class="text-uppercase">Electronic Appliances</h2>
            </div>

            <div class="products-carousel gallery-js-ready autorotation-disabled">
                <div class="mask">
                    <div class="row">
                        <section class="regular slider">
                            <asp:Repeater ID="rptElectronics" runat="server">
                                <ItemTemplate>
                                    <div class="col-md-2 col-xs-6 col-sm-3"  style="margin:0px;">
                                        <a href="<%#"http://localhost:46692//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>"  target="_blank">
                                            <div class="Tile">
                                                <img class="img-responsive img-thumbnail"  style="max-width:250px;max-height: 150px;" src="<%#"http://localhost:46692//Images/Item/"+Eval("ImageName") %>" />
                                            </div>
                                        </a>
                                        <a href="<%#"http://localhost:46692//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>"  target="_blank">
                                            <span class="ItemName"><%#Eval("ItemName").ToString().Length >35?Eval("ItemName").ToString().Substring(0,35):Eval("ItemName") %></span>
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
                        </section>
                    </div>
                </div>

                <div id="divElectronicsNoRecord" runat="server" style="padding: 15px; border: 1px solid #ccc;">
                    No Item Available !
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

</asp:Content>
