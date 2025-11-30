
 <%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="FaduPrice.Front.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Add Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />

<!-- Add FontAwesome for icons (optional) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />


    <script>


        $('.carousel').carousel({
            interval: 1000
        });

        $(document).ready(function () {
            $('.MySliderDiv').each(function (index) {
                if (index == 0) {
                    $(this).addClass('active');
                }
            }),
            $('.MyBullets').each(function (index) {
                if (index == 0) {
                    $(this).addClass('active');
                }
            });
        });

    </script>
    <!-- Include Slick Styles -->
<link href="./slick/slick.css" rel="stylesheet" />
<link href="./slick/slick-theme.css" rel="stylesheet" />



<!-- Responsive CSS -->
<style>
   /* Responsive Fixes for Item Tiles */
.Tile img {
    width: 100%;
    height: auto;
}

/* Center item name and price on smaller screens */
.ItemName, .ItemPrice, .ItemPriceOffer {
    display: block;
    text-align: center;
    font-size: 0.9rem;
}

/* Margin bottom on items */
.col-md-2.col-xs-6.col-sm-3 {
    margin-bottom: 20px;
}

/* Fix padding on mobile */
@media (max-width: 768px) {
    .site-header {
        padding: 15px 20px;
    }

    .site-header .logo {
        font-size: 1.5rem;
    }

    .site-header .nav-links {
        gap: 15px;
        flex-direction: column;
        width: 100%;
    }

    h2.text-uppercase {
        font-size: 1.3rem;
        text-align: center;
        margin: 20px 0;
    }

    .ItemName, .ItemPrice, .ItemPriceOffer {
        font-size: 0.85rem;
    }
}

@media (max-width: 480px) {
    h2.text-uppercase {
        font-size: 1.1rem;
    }

    .site-header {
        flex-direction: column;
        align-items: center;
    }

    .site-header .nav-links {
        align-items: center;
    }
}
.carousel-inner img {
    width: 100%;
    height: auto;
}
/*Sahil Code for Slider */

/*For Search Button*/
    .input-group-btn {
        padding-bottom: 80px;
    }
    /*For Slider CSS*/
    .carousel-inner>.item>a>img, .carousel-inner>.item>img, .img-responsive, .thumbnail a>img, .thumbnail>img {
    float: left;
    max-width: 50%;
    height: 270px;

    
}
    @media (max-width: 768px) {
  .carousel-inner>.item>a>img, .carousel-inner>.item>img, .img-responsive, .thumbnail a>img, .thumbnail>img {
    float: left;
    max-width: 100%;
    height: 50%;
}

 .carousel .item span img{
     display:none;
 }

    }
 /*Sahil Code for four icons */
    .col-3{
        border:1px solid black;
        margin-bottom:20px;
        border-radius:5px;
    }
    .sahil{
        display:flex;
        column-gap:10px;
    }

    @media (max-width: 768px){
        .sahil{
            display:block;
            margin-top: 20px;
        }
        .col-3{
         width: 45%;
        float: left;
        margin-left: 10px;
        }
    }
</style>

    
    <div class="container">
        <div class="container my-1">
            <h5 class="text-center mb-3 fw-bold">What are you looking for?
</h5>
            <div class="row g-3">
                <!-- Kids -->
                <div class="col-6 col-md-3">
               <div class="border bg-white p-3 d-flex justify-content-between align-items-center"
style="border-radius: 20px;">
                   <div class="text-start">
                                <a href="../Pages/ExpenseManager.aspx" target="_blank" style="color: blue;">

                            <h5 class="fw-bold mb-1">Daily</h5>
                            <p class="small text-muted mb-0">Expenses</p>
                        </div>
                        <img src="../Images/System/calculators.PNG"
                            width="50" alt="Kids"></a>
                    </div>
                </div>

                <!-- Grooming -->
                <div class="col-6 col-md-3">
               <div class="border bg-white p-3 d-flex justify-content-between align-items-center"
style="border-radius: 20px;">
                   <div class="text-start">
                       <a href="../Pages/Registration.aspx" target="_blank" style="color: blue;">
                            <h5 class="fw-bold mb-1">Looking For Job?</h5>
                            <p class="small text-muted mb-0">Registration</p>
                        </div>
                      <img src="../Images/System/posting.PNG"
    width="50" alt="Kids">
                    </div>
                </div>

                <!-- Accessories -->
                <div class="col-6 col-md-3">
               <div class="border bg-white p-3 d-flex justify-content-between align-items-center"
style="border-radius: 20px;">
                   <div class="text-start">
                            <h5 class="fw-bold mb-1">Manpower Required?</h5>
                            <p class="small text-muted mb-0">Search here</p>
                        </div>
                        <img src="../Images/System/electrician.PNG"
    width="50" alt="Kids">
                    </div>
                </div>

                <!-- Footwear -->
                <div class="col-6 col-md-3">
<%--                    <div class="border bg-white p-3 d-flex justify-content-between align-items-center rounded">--%>
                    <div class="border bg-white p-3 d-flex justify-content-between align-items-center"
     style="border-radius: 20px;">

                        <div class="text-start">
                            <h5 class="fw-bold mb-1">Looking for Desi Products?</h5>
                            <p class="small text-muted mb-0"> Here I am</p>
                        </div>
                        <img src="../Images/System/products.PNG"
    width="50" alt="Kids">
                    </div>
                                        </div>





     <!-- NEW PRODUCTS ROW WITH HOVER EFFECT, RATINGS, AND ICONS -->
        </div>

                </div>




<div class="container my-4">
    <h5 class="text-center mb-3 fw-bold">WOMEN COLLECTION</h5>
    
    <div class="row g-3">
        <asp:Repeater ID="rptWomenCollection" runat="server">
            <ItemTemplate>
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card border bg-white rounded h-100 position-relative p-2 shadow-sm">

                        <!-- Product Image -->
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
                            <img src='<%# "../Images/Items/" + Eval("ImageName") %>' 
                                 class="img-fluid w-100 rounded" 
                                 alt='<%# Eval("ItemName") %>' style="height:200px;" />
                        </a>

                        <!-- Floating Wishlist Icon -->
                        <button class="btn btn-light border position-absolute top-0 end-0 m-2 rounded-circle">
                            <i class="bi bi-heart"></i>
                        </button>

                        <!-- Product Details -->
                        <div class="p-2 text-center">
                            <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>' 
                               class="text-decoration-none text-dark">
                                <p class="small text-muted mb-1">
                                    <%# Eval("ItemName").ToString().Length > 35 
                                        ? Eval("ItemName").ToString().Substring(0, 35) + "..." 
                                        : Eval("ItemName") %>
                                </p>
                            </a>

                            <!-- Star Ratings -->
                            <div class="mb-2">
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star text-warning"></i>
                            </div>

                            <!-- Price Section -->
                            <p class="mb-2 fw-bold">
                                ₹ <%# Eval("OfferPrice") %>
                                <span class="text-muted text-decoration-line-through">₹ <%# Eval("ItemPrice") %></span>
                            </p>

                            <!-- Action Buttons -->
                            <div class="d-flex flex-column flex-md-row gap-2">
                                <button class="btn btn-sm flex-fill"
                                    style="background-color:#F48B1E; color:#fff; border:none;">
                                    Add to Cart
                                </button>

                                <button class="btn btn-sm flex-fill"
                                    style="background-color:#8EC243; color:#fff; border:none;">
                                    Buy Now
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <div id="divWomenCollNoRecord" runat="server" 
         style="padding: 15px; border: 1px solid #ccc; display:none;">
        No Item Available!
    </div>
</div>


</div>


<!-- Sahil Code for four icons Section Complete -->


<!-- Carousel Section (Use Bootstrap Carousel if JS is added) -->
<div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-top: -10px;">
    <ol class="carousel-indicators">
        <asp:Literal runat="server" ID="litBullets"></asp:Literal>
    </ol>

    <div class="carousel-inner"> <asp:Repeater ID="rptSlider" runat="server"> <ItemTemplate> 
        <div id="SliderItem" class="item MySliderDiv"> 
        <a href="https://www.example.com" target="_blank"> 
         <img src="../Images/Slider/1_003.jpg" />
            <span><img src="../Images/Slider/1_003.jpg" style="max-width: 50%;height: 270px;" /></span>
        </a> </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>



<!-- Trending Collections (Static) -->
<%--<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <h2 class="text-uppercase">TRENDING COLLECTIONS</h2>
        </div>

        <div class="col-md-2 col-xs-6">
            <a href="/Search.aspx" target="_blank">
                <img src="../Images/Items/old images/Max-PC-1-231017.jpg" class="img-responsive img-thumbnail" />
            </a>
        </div>
    </div>
</div>--%>

<hr />

<!-- WOMEN COLLECTION -->

<%--        <section class="regular slider">
            <asp:Repeater ID="rptWomenCollection" runat="server">
                <ItemTemplate>
                    <div class="col-md-2 col-xs-6 col-sm-3">
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
                            <div class="Tile">
                                <img class="img-responsive img-thumbnail" src='<%# "../Images/Items/" + Eval("ImageName") %>' />
                            </div>
                        </a>
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
                            <span class="ItemName"><%# Eval("ItemName").ToString().Length > 35 ? Eval("ItemName").ToString().Substring(0, 35) + "..." : Eval("ItemName") %></span>
                        </a>
                        <div class="ItemPrice">
                            <span><i class="fa fa-inr"></i> <%# Eval("OfferPrice") %></span>
                        </div>
                        <div class="ItemPriceOffer">
                            <span><i class="fa fa-inr"></i> <%# Eval("ItemPrice") %></span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </section>--%>



<!-- MEN COLLECTION -->
<div class="container-fluid" style="visibility:hidden;">
    <div class="row">
        <div class="col-md-12">
            <h2 class="text-uppercase">MEN COLLECTIONS</h2>
        </div>

        <section class="regular slider">
            <asp:Repeater ID="rptMenCollection" runat="server">
                <ItemTemplate>
                    <div class="col-md-2 col-xs-6 col-sm-3">
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
                            <div class="Tile">
                                <img class="img-responsive img-thumbnail" src='<%# "../Images/Items/" + Eval("ImageName") %>' />
                            </div>
                        </a>
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
                            <span class="ItemName"><%# Eval("ItemName").ToString().Length > 35 ? Eval("ItemName").ToString().Substring(0, 35) + "..." : Eval("ItemName") %></span>
                        </a>
                        <div class="ItemPrice">
                            <span><i class="fa fa-inr"></i> <%# Eval("OfferPrice") %></span>
                        </div>
                        <div class="ItemPriceOffer">
                            <span><i class="fa fa-inr"></i> <%# Eval("ItemPrice") %></span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </section>

        <div id="divMenCollNoRecord" runat="server" style="padding: 15px; border: 1px solid #ccc;">
            No Item Available!
        </div>
    </div>
</div>

<!-- ELECTRONIC APPLIANCES -->
<div class="container-fluid" style="visibility:hidden;">
    <div class="row">
        <div class="col-md-12">
            <h2 class="text-uppercase">Electronic Appliances</h2>
        </div>

        <section class="regular slider">
            <asp:Repeater ID="rptElectronics" runat="server">
                <ItemTemplate>
                    <div class="col-md-2 col-xs-6 col-sm-3">
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>' target="_blank">
                            <div class="Tile">
                                <img class="img-responsive img-thumbnail" src='<%# "../Images/Items/" + Eval("ImageName") %>' />
                            </div>
                        </a>
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>' target="_blank">
                            <span class="ItemName"><%# Eval("ItemName").ToString().Length > 35 ? Eval("ItemName").ToString().Substring(0, 35) + "..." : Eval("ItemName") %></span>
                        </a>
                        <div class="ItemPrice">
                            <span><i class="fa fa-inr"></i> <%# Eval("OfferPrice") %></span>
                        </div>
                        <div class="ItemPriceOffer">
                            <span><i class="fa fa-inr"></i> <%# Eval("ItemPrice") %></span>
                        </div>
                        <div class="ItemPriceOffer">
                            <span style="color: #7C519B"><%# Eval("Discount") %></span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </section>

        <div id="divElectronicsNoRecord" runat="server" style="padding: 15px; border: 1px solid #ccc;">
            No Item Available!
        </div>
    </div>
</div>




<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./slick/slick.min.js"></script>
<script>
                        $(document).ready(function () {
                            $('.regular.slider').slick({
                                dots: true,
                                infinite: false,
                                speed: 300,
                                slidesToShow: 4,
                                slidesToScroll: 4,
                                responsive: [
                                    {
                                        breakpoint: 1024,
                                        settings: {
                                            slidesToShow: 3,
                                            slidesToScroll: 3,
                                            infinite: true,
                                            dots: true
                                        }
                                    },
                                    {
                                        breakpoint: 768,
                                        settings: {
                                            slidesToShow: 2,
                                            slidesToScroll: 2
                                        }
                                    },
                                    {
                                        breakpoint: 480,
                                        settings: {
                                            slidesToShow: 1,
                                            slidesToScroll: 1
                                        }
                                    }
                                ]
                            })
                        })
</script>


</asp:Content>


