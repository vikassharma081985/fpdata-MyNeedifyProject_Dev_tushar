
 <%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="FaduPrice.Front.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Add Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />

<!-- Add FontAwesome for icons (optional) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./slick/slick.min.js"></script>
<script src="./Js/bootstrap.min.js"></script>
    <script>



        $(function () {

    $('.carousel').carousel({
        interval: 1000
    });

    $('.MySliderDiv:first').addClass('active');
    $('.MyBullets:first').addClass('active');

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
    <!-- Include Slick Styles -->
<link href="/slick/slick.css" rel="stylesheet" />
<link href="/slick/slick-theme.css" rel="stylesheet" />



<!-- Responsive CSS -->
<style>
.btn-login-2{
background-color: #F6861F !important;
    color: #fff !important;
    height: 35px;
    padding: 7px;
    width: 50%;
    text-align: center;
    border: none;
}
   /* Responsive Fixes for Item Tiles */
.Tile img {
    width: 100%;
    height: auto;
}
.title{
    font-size: 24px;
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
    .title{
    font-size: 16px;
}
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



/* Featured Image */
.featured-img {
    background:#eee;
    border-radius: 6px;
    overflow: hidden;
}

.featured-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* Product Card */
.product-card {
    position: relative;
    background: #fff;
    border-radius: 6px;
    overflow: hidden;
    transition: 0.3s;
}

.product-card img {
    width: 100%;
    height: 260px;
    object-fit: cover;
}

.product-card:hover {
    transform: translateY(-5px);
}

/* SOLD Badge */
.sold-badge {
    position: absolute;
    top: 15px;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(0,0,0,0.6);
    color: #fff;
    padding: 40px 20px;
    border-radius: 50%;
    font-weight: 600;
    font-size: 14px;
}

/* Product Info */
.product-info {
    padding: 10px 5px;
}

.product-info h6 {
    font-size: 14px;
    margin: 0;
}

.product-info span {
    font-size: 13px;
    color: #555;
}

/* Mobile */
@media (max-width: 767px) {
    .featured-img {
        height: 300px;
        margin-bottom: 20px;
    }
}



/* Dashboard-only layout: independent of the existing Bootstrap 3/5 mix. */
.needify-dashboard { width: 100%; max-width: 1280px; margin: 0 auto; padding: 24px 24px 40px; color: #202c28; font-family: Arial, sans-serif; }
.needify-dashboard, .needify-dashboard * { box-sizing: border-box; }
.needify-dashboard .dashboard-intro { position: relative; overflow: hidden; display: flex; align-items: center; justify-content: space-between; gap: 24px; padding: 36px 40px; margin-bottom: 30px; border: 1px solid #dce9d5; border-radius: 24px; background: linear-gradient(110deg, #edf6e6 0%, #f6faee 58%, #fff1d9 100%); }
.needify-dashboard .dashboard-eyebrow { margin: 0 0 12px; color: #467039; font-size: 12px; font-weight: 700; letter-spacing: 1.8px; text-transform: uppercase; }
.needify-dashboard h1 { max-width: 650px; margin: 0 0 14px; color: #203c2d; font-size: 38px; line-height: 1.18; font-weight: 700; letter-spacing: -1px; }
.needify-dashboard .dashboard-description { max-width: 580px; margin: 0; color: #546257; font-size: 16px; line-height: 1.65; }
.needify-dashboard .dashboard-art { flex: 0 0 200px; display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; transform: rotate(-6deg); }
.needify-dashboard .dashboard-art span { display: flex; align-items: center; justify-content: center; height: 86px; border: 1px solid #ffffff; border-radius: 20px; background: rgba(255,255,255,.8); }
.needify-dashboard .dashboard-art img { width: 58px; height: 58px; object-fit: contain; }
.needify-dashboard .dashboard-categories { width: 100%; padding: 0; margin: 0; }
.needify-dashboard .dashboard-section-heading { display: flex; align-items: baseline; justify-content: space-between; gap: 16px; margin-bottom: 18px; }
.needify-dashboard .dashboard-section-heading .title { margin: 0; color: #202c28; font-size: 25px; font-weight: 700; line-height: 1.3; }
.needify-dashboard .dashboard-section-heading p { margin: 0; color: #68746d; font-size: 14px; }
.needify-dashboard .dashboard-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 18px; margin: 0; }
.needify-dashboard .dashboard-grid::before, .needify-dashboard .dashboard-grid::after { content: none; }
.needify-dashboard .dashboard-grid > .dashboard-category { width: auto; min-width: 0; float: none; padding: 0; margin: 0; }
.needify-dashboard .dashboard-card { position: relative; display: flex; flex-direction: column; height: 100%; min-height: 224px; padding: 20px; border: 1px solid #e3e8e1; border-radius: 18px; background: #fff; box-shadow: 0 3px 12px rgba(32,60,45,.035); transition: border-color .18s, box-shadow .18s; }
.needify-dashboard .dashboard-card:hover, .needify-dashboard .dashboard-card:focus-within { border-color: #97b77c; box-shadow: 0 6px 20px rgba(32,60,45,.09); }
.needify-dashboard .dashboard-icon { display: flex; align-items: center; justify-content: center; width: 100%; height: 110px; margin-bottom: 18px; border-radius: 12px; background: #f1f6ec; }
.needify-dashboard .dashboard-category:nth-child(4n+2) .dashboard-icon { background: #fff3e6; }
.needify-dashboard .dashboard-category:nth-child(4n+3) .dashboard-icon { background: #edf4fb; }
.needify-dashboard .dashboard-category:nth-child(4n+4) .dashboard-icon { background: #f7eff6; }
.needify-dashboard .dashboard-icon img { display: block; width: 76px; height: 76px; max-width: 100%; object-fit: contain; }
.needify-dashboard .dashboard-card h5 { margin: 0 0 7px; font-size: 16px; font-weight: 700; line-height: 1.35; overflow-wrap: anywhere; }
.needify-dashboard .dashboard-card p { margin: 0; padding-right: 18px; color: #6b746e; font-size: 13px; line-height: 1.5; }
.needify-dashboard .dashboard-card a { color: #263b2c; text-decoration: none; }
.needify-dashboard .dashboard-card a::after { content: ''; position: absolute; inset: 0; border-radius: 18px; }
.needify-dashboard .dashboard-card a:focus-visible { outline: none; }
.needify-dashboard .dashboard-card a:focus-visible::after { outline: 3px solid #426f28; outline-offset: 3px; }
.needify-dashboard .dashboard-arrow { position: absolute; right: 18px; bottom: 20px; color: #628443; font-size: 20px; pointer-events: none; }
@media (max-width: 991px) {
    .needify-dashboard { padding: 20px 20px 32px; }
    .needify-dashboard .dashboard-intro { padding: 28px; }
    .needify-dashboard h1 { font-size: 30px; }
    .needify-dashboard .dashboard-art { flex-basis: 156px; gap: 8px; }
    .needify-dashboard .dashboard-art span { height: 70px; }
    .needify-dashboard .dashboard-grid { gap: 12px; }
    .needify-dashboard .dashboard-card { padding: 14px; }
}
@media (max-width: 767px) {
    .needify-dashboard { padding: 16px 14px 28px; }
    .needify-dashboard .dashboard-intro { padding: 24px; margin-bottom: 24px; border-radius: 18px; }
    .needify-dashboard h1 { font-size: 28px; }
    .needify-dashboard .dashboard-description { font-size: 14px; }
    .needify-dashboard .dashboard-art { display: none; }
    .needify-dashboard .dashboard-section-heading { display: block; }
    .needify-dashboard .dashboard-section-heading .title { font-size: 22px; margin-bottom: 6px; }
    .needify-dashboard .dashboard-section-heading p { font-size: 13px; }
    .needify-dashboard .dashboard-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
    .needify-dashboard .dashboard-card { min-height: 210px; border-radius: 14px; }
    .needify-dashboard .dashboard-icon { height: 96px; margin-bottom: 14px; }
    .needify-dashboard .dashboard-icon img { width: 64px; height: 64px; }
    .needify-dashboard .dashboard-card h5 { font-size: 15px; }
}
@media (max-width: 359px) {
    .needify-dashboard .dashboard-grid { gap: 8px; }
    .needify-dashboard .dashboard-card { padding: 10px; }
    .needify-dashboard .dashboard-card h5 { font-size: 14px; }
}
@media (prefers-reduced-motion: reduce) {
    .needify-dashboard .dashboard-card { transition: none; }
}
</style>

    
    <div class="container needify-dashboard">
        <section class="dashboard-intro" aria-label="Welcome to My Needify">
            <div>
                <p class="dashboard-eyebrow">Your everyday, made easier</p>
                <h1>Everyday needs.<br />All in one place.</h1>
                <p class="dashboard-description">Shop local finds, discover services and manage your day with My Needify.</p>
            </div>
            <div class="dashboard-art" aria-hidden="true">
                <span><img src="../Images/System/products.PNG" alt="" /></span>
                <span><img src="../Images/System/salon.PNG" alt="" /></span>
                <span><img src="../Images/System/fashion.PNG" alt="" /></span>
                <span><img src="../Images/System/calculators.PNG" alt="" /></span>
            </div>
        </section>
        <div class="container my-1 dashboard-categories">
            <div class="dashboard-section-heading">
                <h2 class="title">What are you looking for?</h2>
                <p>Explore your everyday essentials</p>
            </div>
            <div class="row g-3 dashboard-grid">
                <div class="col-6 col-md-3 dashboard-category">
                    <div class="dashboard-card">
                        <div class="dashboard-icon"><img src="../Images/System/calculators.PNG" width="76" height="76" alt="" /></div>
                        <div class="text-start">
                            <h5 class="fw-bold mb-1"><a href="../Pages/ExpenseManager.aspx">Daily Expenses</a></h5>
                            <p class="small text-muted mb-0">Manage your everyday spending</p>
                        </div>
                        <span class="dashboard-arrow" aria-hidden="true">&#8599;</span>
                    </div>
                </div>
                <div class="col-6 col-md-3 dashboard-category">
                    <div class="dashboard-card">
                        <div class="dashboard-icon"><img src="../Images/System/posting.PNG" width="76" height="76" alt="" /></div>
                        <div class="text-start">
                            <h5 class="fw-bold mb-1"><a href="../Pages/RegistrationList.aspx">Looking for a Job?</a></h5>
                            <p class="small text-muted mb-0">Register and take the next step</p>
                        </div>
                        <span class="dashboard-arrow" aria-hidden="true">&#8599;</span>
                    </div>
                </div>
                <div class="col-6 col-md-3 dashboard-category">
                    <div class="dashboard-card">
                        <div class="dashboard-icon"><img src="../Images/System/electrician.PNG" width="76" height="76" alt="" /></div>
                        <div class="text-start">
                            <h5 class="fw-bold mb-1"><a href="../Pages/Job.aspx">Manpower Required?</a></h5>
                            <p class="small text-muted mb-0">Find the help you need</p>
                        </div>
                        <span class="dashboard-arrow" aria-hidden="true">&#8599;</span>
                    </div>
                </div>
                <div class="col-6 col-md-3 dashboard-category">
                    <div class="dashboard-card">
                        <div class="dashboard-icon"><img src="../Images/System/products.PNG" width="76" height="76" alt="" /></div>
                        <div class="text-start">
                            <h5 class="fw-bold mb-1"><a href="../Front/Apparels.aspx">Desi Products</a></h5>
                            <p class="small text-muted mb-0">Discover something local</p>
                        </div>
                        <span class="dashboard-arrow" aria-hidden="true">&#8599;</span>
                    </div>
                </div>
                <div class="col-6 col-md-3 dashboard-category">
                    <div class="dashboard-card">
                        <div class="dashboard-icon"><img src="../Images/System/seller.PNG" width="76" height="76" alt="" /></div>
                        <div class="text-start">
                            <h5 class="fw-bold mb-1"><a href="../Pages/AddOrganization.aspx">Register as Seller</a></h5>
                            <p class="small text-muted mb-0">Start selling today</p>
                        </div>
                        <span class="dashboard-arrow" aria-hidden="true">&#8599;</span>
                    </div>
                </div>
                <div class="col-6 col-md-3 dashboard-category">
                    <div class="dashboard-card">
                        <div class="dashboard-icon"><img src="../Images/System/salon.PNG" width="76" height="76" alt="" /></div>
                        <div class="text-start">
                            <h5 class="fw-bold mb-1"><a href="../Front/AppointmentMaster.aspx" onclick="return checkLoginBeforeAppointment();">Salon Appointment</a></h5>
                            <p class="small text-muted mb-0">Schedule your visit</p>
                        </div>
                        <span class="dashboard-arrow" aria-hidden="true">&#8599;</span>
                    </div>
                </div>
                <div class="col-6 col-md-3 dashboard-category">
                    <div class="dashboard-card">
                        <div class="dashboard-icon"><img src="../Images/System/staircase.PNG" width="76" height="76" alt="" /></div>
                        <div class="text-start">
                            <h5 class="fw-bold mb-1">Home Decor</h5>
                            <p class="small text-muted mb-0">Make room for inspiration</p>
                        </div>

                    </div>
                </div>
                <div class="col-6 col-md-3 dashboard-category">
                    <div class="dashboard-card">
                        <div class="dashboard-icon"><img src="../Images/System/fashion.PNG" width="76" height="76" alt="" /></div>
                        <div class="text-start">
                            <h5 class="fw-bold mb-1"><a href="../Front/indexShubh.aspx">Apparels</a></h5>
                            <p class="small text-muted mb-0">Find your everyday style</p>
                        </div>
                        <span class="dashboard-arrow" aria-hidden="true">&#8599;</span>
                    </div>
                </div>
            </div>
        </div>

<div class="container my-4" style="visibility:hidden; display: none;">
    <p class="title text-center mb-3">Latest Collection</p>    
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
                            <%--    <button class="btn btn-sm flex-fill"
                                    style="background-color:#F48B1E; color:#fff; border:none;">
                                    Add to Cart
                                </button>--%>

                                <button class="btn btn-sm flex-fill"
        style="background-color:#F48B1E; color:#fff; border:none;"
        onclick="AddToCart('<%# Eval("ItemId") %>')">
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
<div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-top: -10px; visibility:hidden; display: none;" >
    <ol class="carousel-indicators">
        <asp:Literal runat="server" ID="litBullets"></asp:Literal>
    </ol>

    <div class="carousel-inner"> <asp:Repeater ID="rptSlider" runat="server"> <ItemTemplate> 
        <div id="SliderItem" class="item MySliderDiv"> 
        <a href="https://www.example.com" > 
         <img src="../Images/Slider/1_003.jpg" />
            <span><img src="../Images/Slider/1_003.jpg" style="max-width: 50%;height: 270px;" /></span>
        </a> </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>



<!-- Trending Collections (Static) -->
<%--<div class="container new-arrival" style="margin-top:-250px; visibility:hidden;">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="title">New Arrival</h2>
        <a href="#" class="text-decoration-none fw-semibold">Catalogue ↗</a>
    </div>

    <div class="row g-3">

        <!-- LEFT BIG IMAGE -->
        <div class="col-lg-6 col-md-12">
            <div class="featured-img h-100">
<img src="https://maison-novague.com/wp-content/uploads/2024/07/classic-fashion-styleTH2.jpg" alt="New Arrival">
            </div>
        </div>

        <!-- RIGHT GRID -->
        <div class="col-lg-6 col-md-12">
            <div class="row g-3">

                <!-- Product 1 -->
                <div class="col-6">
                    <div class="product-card">
                        <img src="https://img.freepik.com/free-photo/fashionable-pale-brunette-long-green-dress-black-jacket-sunglasses-standing-street-daytime-against-wall-light-city-building_197531-24468.jpg?semt=ais_hybrid&w=740&q=80" alt="">
                        <div class="product-info">
                            <h6>Fiz-R2000</h6>
                            <span>$200</span>
                        </div>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="col-6">
                    <div class="product-card">
                        <img src="https://www.creativehut.org/wp-content/uploads/2020/06/the-ultimate-guide-of-fashion-photography-2020.jpg" alt="">
                        <div class="product-info">
                            <h6>Fiz-R200J</h6>
                            <span>$70</span>
                        </div>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="col-6">
                    <div class="product-card">
                        <img src="https://images.unsplash.com/photo-1512436991641-6745cdb1723f" alt="">
                        <div class="product-info">
                            <h6>Fiz-R201X</h6>
                            <span>$150</span>
                        </div>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="col-6">
                    <div class="product-card">
                        <img src="https://images.unsplash.com/photo-1517841905240-472988babdf9" alt="">
                        <div class="product-info">
                            <h6>Fiz-R202Y</h6>
                            <span>$180</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>
--%>

<hr />















       <%-- <div class="container-fluid px-0" > 
    
  <div id="twoImageCarousel" class="carousel slide"
       data-bs-ride="carousel"
       data-bs-interval="3000"
       data-bs-pause="false">

    <!-- Indicators -->
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#twoImageCarousel" data-bs-slide-to="0" class="active"></button>
      <button type="button" data-bs-target="#twoImageCarousel" data-bs-slide-to="1"></button>
      <button type="button" data-bs-target="#twoImageCarousel" data-bs-slide-to="2"></button>
    </div>

    <!-- Carousel Inner -->
    <div class="carousel-inner">

      <!-- Slide 1 -->
      <div class="carousel-item active">
        <div class="row g-0"> <!-- g-0 removes gap -->
          
          <div class="col-6">
            <div class="slider-box">
              <img src="https://marketplace.canva.com/EAF0XmkzgQA/1/0/1600w/canva-gray-minimalist-new-collection-banner-O7EU5YM_MGU.jpg" class="w-100" alt="Image 1" />
            </div>
          </div>

          <div class="col-6">
            <div class="slider-box">
              <img src="https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/shark-new-collection-sale-clothing-banner-template-p3ztild89dffd0.webp" class="w-100" alt="Image 2" />
            </div>
          </div>

        </div>
      </div>

      <!-- Slide 2 -->
      <div class="carousel-item">
        <div class="row g-0">
          
          <div class="col-6">
            <div class="slider-box">
              <img src="https://marketplace.canva.com/EAGHC5NUD-Q/1/0/1600w/canva-black-and-white-modern-fashion-sale-banner-landscape-n7GVeIDu0Tg.jpg" class="w-100" alt="Image 3" />
            </div>
          </div>

          <div class="col-6">
            <div class="slider-box">
              <img src="https://marketplace.canva.com/EAFoEJMTGiI/1/0/1600w/canva-beige-aesthetic-new-arrival-fashion-banner-landscape-cNjAcBMeF9s.jpg" class="w-100" alt="Image 4" />
            </div>
          </div>

        </div>
      </div>

      <!-- Slide 3 -->
      <div class="carousel-item">
        <div class="row g-0">
          
          <div class="col-6">
            <div class="slider-box">
              <img src="https://img.freepik.com/free-vector/fashion-template-design_23-2150745419.jpg?semt=ais_hybrid&w=740&q=80" class="w-100" alt="Image 5" />
            </div>
          </div>

          <div class="col-6">
            <div class="slider-box">
              <img src="https://mir-s3-cdn-cf.behance.net/projects/808/701cc2238095479.Y3JvcCw2MzkyLDQ5OTksMTQyLDA.png" class="w-100" alt="Image 6" />
            </div>
          </div>

        </div>
      </div>

    </div>

    <!-- Navigation -->
    <button class="carousel-control-prev" type="button" data-bs-target="#twoImageCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>

    <button class="carousel-control-next" type="button" data-bs-target="#twoImageCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>

  </div>
</div>
       --%>















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
<div class="container-fluid" style="visibility:hidden; display: none;">
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
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
                            <div class="Tile">
                                <img class="img-responsive img-thumbnail" src='<%# "../Images/Items/" + Eval("ImageName") %>' />
                            </div>
                        </a>
                        <a href='<%# "/Front/ItemDescription.aspx?ItemId=" + Eval("ItemId") %>' >
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
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
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
                        });

            function checkLoginBeforeAppointment() {

    var userId = $('[id$=MasterhdnUserId]').val();
    if (userId && userId.trim() !== "" && userId.trim() !== "0") {
        // User is logged in
        return true;
    }
    
    // User is not logged in
       var modalElement = document.getElementById('loginRequiredModal');

    var loginModal = bootstrap.Modal.getOrCreateInstance(modalElement);
    modalElement.classList.add("in");
    loginModal.show();
    return false;
    // Stop the <a> from navigating
    
}
function redirectToLogin() {

    var modalElement = document.getElementById("loginRequiredModal");

    var modal = bootstrap.Modal.getOrCreateInstance(modalElement);

    // When modal has completely finished closing
    modalElement.addEventListener("hidden.bs.modal", function () {

        var loginButton = document.getElementById("loginBtnClick");

        if (loginButton) {
            loginButton.click();
        }

    }, { once: true });

    // Close the popup
    modal.hide();
var loginModal = bootstrap.Modal.getOrCreateInstance(modalElement);
    modalElement.classList.remove("in");
}
function closePop(){
    var modalElement = document.getElementById("loginRequiredModal");

    var modal = bootstrap.Modal.getOrCreateInstance(modalElement);

    // When modal has completely finished closing

    // Close the popup
    modal.hide();
    var loginModal = bootstrap.Modal.getOrCreateInstance(modalElement);
    modalElement.classList.remove("in");
}
</script>
<!-- Login Required Modal -->
<div id="loginRequiredModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>

                <h4 class="modal-title">
                    Login Required
                </h4>
            </div>

            <div class="modal-body text-center">
                <i class="fa fa-lock"
                   style="font-size:40px; margin-bottom:15px;"></i>

                <p>
                    Please login first to book a Salon Appointment.
                </p>
            </div>

            <div class="modal-footer text-center">

                <button type="button"
                        onclick="closePop();"
                        class="btn btn-default"
                        data-dismiss="modal">
                    Cancel
                </button>

                <a 
                    onclick="redirectToLogin();"
                   class="btn btn-login-2">
                    Login
                </a>

            </div>

        </div>
    </div>
</div>

</asp:Content>