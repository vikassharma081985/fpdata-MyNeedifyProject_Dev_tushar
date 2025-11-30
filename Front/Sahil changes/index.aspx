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
            });
            $('.MyBullets').each(function (index) {
                if (index == 0) {
                    $(this).addClass('active');
                })
            });
        });

    </script>
    <!-- Include Slick Styles -->
<link href="/slick/slick.css" rel="stylesheet" />
<link href="/slick/slick-theme.css" rel="stylesheet" />



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
/*For Search Button*/
    .input-group-btn {
        padding-bottom: 80px;
    }
    /*For Slider CSS*/
    .carousel-inner>.item>a>img, .carousel-inner>.item>img, .img-responsive, .thumbnail a>img, .thumbnail>img {
    display: block;
    max-width: 50%;
    height: 270px;
    /*margin-top:-100px;*/
}

</style>


<!-- Carousel Section (Use Bootstrap Carousel if JS is added) -->
<div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-top: -10px;">
    <ol class="carousel-indicators">
        <asp:Literal runat="server" ID="litBullets"></asp:Literal>
    </ol>

    <div class="carousel-inner"> <asp:Repeater ID="rptSlider" runat="server"> <ItemTemplate> <div id="SliderItem" class="item MySliderDiv"> <a href="https://www.example.com" target="_blank"> <!-- Slider Image 1 --> <img src="../Images/Slider/1_003.jpg" /> </a> </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

<!-- Trending Collections (Static) -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <h2 class="text-uppercase">TRENDING COLLECTIONS</h2>
        </div>

        <%-- Static Items --%>
        <div class="col-md-2 col-xs-6">
            <a href="/Search.aspx" target="_blank">
                <img src="../Images/Items/old images/Max-PC-1-231017.jpg" class="img-responsive img-thumbnail" />
            </a>
        </div>
        <!-- Repeat for other items -->
    </div>
</div>

<hr />

<!-- WOMEN COLLECTION -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <h2 class="text-uppercase">WOMEN COLLECTIONS</h2>
        </div>

        <section class="regular slider">
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
        </section>

        <div id="divWomenCollNoRecord" runat="server" style="padding: 15px; border: 1px solid #ccc;">
            No Item Available!
        </div>
    </div>
</div>

<!-- MEN COLLECTION -->
<div class="container-fluid">
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
<div class="container-fluid">
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

 <!-- scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <script src="/slick/slick.min.js"></script>
 <!--Script>
   $(document).ready(function () {
         $('.regular.slider').slick({
             dots: true,
            infinite: false,
             speed: 300,
             slidestoshow: 4,
            slidestoscroll: 4,
         responsive: [
            {
          breakpoint: 1024,
          settings: {
            slidestoshow: 3,
           slidestoscroll: 3,
        infinite: true,
       dots: true
       }
       < script >
         $(document).ready(function () {
                     $('.regular.slider').slick({
                            dots: true,
                               infinite: false,
                              speed: 300,
                                 slidestoshow: 4,
                              slidestoscroll: 4,
                                responsive: [
                                     {
                                         breakpoint: 1024,
                                        settings: {
                                             slidestoshow: 3,
                                        slidestoscroll: 3,
                                           infinite: true,
                                           dots: true
               }
                                 },
                                   {
                                         breakpoint: 768,
                                         settings: {
                                             slidestoshow: 2,
                                            slidestoscroll: 2
                                         }
                                     },
                                     {
                                       breakpoint: 480,
                                        settings: {
                                             slidestoshow: 1,
                                             slidestoscroll: 1
                                        }
                                     }
                                 ]
                            };
                         };
 </script>-->
</asp:Content>
