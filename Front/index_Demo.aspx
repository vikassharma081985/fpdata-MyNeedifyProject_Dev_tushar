<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="index_Demo.aspx.cs" Inherits="WSBillingMaster.Front.index" %>

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
    <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 108%;">
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
                            <img src='<%#"../Images/Slider/"+Eval("ImageName") %>' alt="Los Angeles" style="width: 100%;">
                        </a>
                    </div>

                </ItemTemplate>
            </asp:Repeater>

        </div>

        <!-- Left and right controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <div class="container-fluid">
        <div class="container-fluid">
            <div class="col-md-12">
                <h2 id="section-heading-title-02" class="text-uppercase">TRENDING COLLECTIONS</h2>
            </div>

            <div class="col-md-2 col-xs-6 Over">
                <a href="http://faduprice.in/Pages/Search.aspx"  target="_blank">
                    <img src="../Images/Item/Max-PC-1-231017.jpg" style="max-height: 200px;" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="http://faduprice.in/Pages/Search.aspx"  target="_blank">
                    <img src="../Images/Item/Max-PC-2-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="http://faduprice.in/Pages/Search.aspx"  target="_blank">
                    <img src="../Images/Item/Max-PC-3-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="http://faduprice.in/Pages/Search.aspx"  target="_blank">
                    <img src="../Images/Item/Max-PC-4-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="http://faduprice.in/Pages/Search.aspx"  target="_blank">
                    <img src="../Images/Item/Max-PC-5-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>
            <div class="col-md-2 col-xs-6 Over">
                <a href="http://faduprice.in/Pages/Search.aspx"  target="_blank">
                    <img src="../Images/Item/Max-PC-6-231017.jpg" class="img-responsive img-thumbnail" />
                </a>
            </div>

        </div>
    </div>
    <div class="container">
        <hr />
    </div>
    <div class="container-fluid">
        <div class="container-fluid">
            <div class="col-md-12">
                <h2 id="H1" class="text-uppercase">WOMEN COLLECTIONS</h2>
            </div>

            <div class="products-carousel gallery-js-ready autorotation-disabled">
                <div class="mask">
                    <div class="row">
                        <asp:Repeater ID="rptWomenCollection" runat="server">
                            <ItemTemplate>
                                <div class="col-md-2 col-xs-6 col-sm-3">
                                    <a href="<%#"http://faduprice.in/Pages/ItemDescription.aspx?ItemId="+Eval("ItemId") %>"  target="_blank">
                                        <div class="Tile">
                                            <img class="img-responsive img-thumbnail" src="<%#"../Images/Item/"+Eval("ImageName") %>" />
                                        </div>
                                    </a>
                                    <a href="<%#"http://faduprice.in/Pages/ItemDescription.aspx?ItemId="+Eval("ItemId") %>"  target="_blank">
                                        <span class="ItemName"><%#Eval("ItemName").ToString().Length >50?Eval("ItemName").ToString().Substring(0,50):Eval("ItemName") %></span>
                                    </a>
                                    <div class="ItemPrice">
                                        <span><i class="fa fa-inr"></i><%#Eval("OfferPrice") %></span>
                                    </div>
                                    <div class="ItemPriceOffer">
                                        <span><i class="fa fa-inr"></i><%#Eval("ItemPrice") %></span>
                                    </div>
                                    <div class="ItemPriceOffer">
                                        <span style="color:#7C519B"><%#Eval("Discount") %></span>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div id="divWomenCollNoRecord" runat="server" style="padding:15px;border:1px solid #ccc;">
                    No Item Available !
                </div>
            </div>


        </div>
    </div>

    <div class="container">
        <hr />
    </div>
    <div class="container-fluid">
        <div class="container-fluid">
            <div class="col-md-12">
                <h2 id="H2" class="text-uppercase">MEN COLLECTIONS</h2>
            </div>

            <div class="products-carousel gallery-js-ready autorotation-disabled">
                <div class="mask">
                    <div class="row">
                        <asp:Repeater ID="rptMenCollection" runat="server">
                            <ItemTemplate>
                                <div class="col-md-2 col-xs-6 col-sm-3">
                                    <a href="<%#"http://faduprice.in/Pages/ItemDescription.aspx?ItemId="+Eval("ItemId") %>"  target="_blank">
                                        <div class="Tile">
                                            <img class="img-responsive img-thumbnail" src="<%#"../Images/Item/"+Eval("ImageName") %>" />
                                        </div>
                                    </a>
                                    <a href="<%#"http://faduprice.in/Pages/ItemDescription.aspx?ItemId="+Eval("ItemId") %>"  target="_blank">
                                        <span class="ItemName"><%#Eval("ItemName").ToString().Length >50?Eval("ItemName").ToString().Substring(0,50):Eval("ItemName") %></span>
                                    </a>
                                    <div class="ItemPrice">
                                        <span><i class="fa fa-inr"></i><%#Eval("OfferPrice") %></span>
                                    </div>
                                    <div class="ItemPriceOffer">
                                        <span><i class="fa fa-inr"></i><%#Eval("ItemPrice") %></span>
                                    </div>
                                    <div class="ItemPriceOffer">
                                        <span style="color:#7C519B"><%#Eval("Discount") %></span>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div id="divMenCollNoRecord"  runat="server" style="padding:15px;border:1px solid #ccc;">
                    No Item Available !
                </div>
            </div>


        </div>
    </div>


</asp:Content>
