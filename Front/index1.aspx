 <%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="FaduPrice.Front.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
    <style type="text/css">
        

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
    height: 250px;
    /*margin-top:-100px;*/
}
    </style>


    <script src="/slick/slick.js"></script>
    <div id="myCarousel" class="carousel slide" data-ride="carousel" style=" margin-top: -10px;">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <asp:Literal runat="server" ID="litBullets"></asp:Literal>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <asp:Repeater ID="rptSlider" runat="server">
                <ItemTemplate>
                    <div id="SliderItem" class="item MySliderDiv">
                        <a href='<%#Eval("RedirectTo") %>' target="_blank">
                            <img src='<%#"/Images/Slider/"+Eval("ImageName") %>' alt="Los Angeles" style="width: 100%; height:250px;">
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
                    <img src="../Images/Items/Max-PC-1-231017.jpg" style="max-height: 200px;" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/Max-PC-2-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/Max-PC-3-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/Max-PC-4-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/Max-PC-5-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="/Search.aspx" target="_blank">
                    <img src="../Images/Items/Max-PC-6-231017.jpg" class="img-responsive img-thumbnail" />
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
                    No Item Available !
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
                                        <a href="<%#"http://trendzshopping.in//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>">
                                            <div class="Tile">
                                                <img class="img-responsive img-thumbnail"  style="max-width:250px;max-height: 150px;" src="<%#"~/Images/Items/"+Eval("ImageName") %>" />
                                            </div>
                                        </a>
                                        <a href="<%#"http://trendzshopping.in//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>">
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
                    No Item Available !
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
                                        <a href="#"http://trendzshopping.in//Front/ItemDescription.aspx?ItemId="+Eval("ItemId")"  target="_blank">
                                            <div class="Tile">
                                                <img class="img-responsive img-thumbnail"  style="max-width:250px;max-height: 150px;" src="#"http://trendzshopping.in//Images/Item/"+Eval("ImageName")" />
                                            </div>
                                        </a>
                                        <a href="#"http://trendzshopping.in//Front/ItemDescription.aspx?ItemId="+Eval("ItemId")"  target="_blank">
                                            <span class="ItemName">#Eval("ItemName").ToString().Length >35?Eval("ItemName").ToString().Substring(0,35):Eval("ItemName")></span>
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
    <script src="http://trendzshopping.in//Front/slick/slick.js" type="text/javascript" charset="utf-8"></script>
    

   
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
