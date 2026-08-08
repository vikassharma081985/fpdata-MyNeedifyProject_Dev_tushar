<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="FaduPrice.Pages.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="description" content="Discover the latest fashion trends for men, women, and kids. Shop quality clothing online at affordable prices with secure checkout." />
    <meta name="keywords" content="online shopping, clothing, fashion, men's wear, women's wear, kids wear" />
    <style>
        #ex1Slider .slider-selection {
            background: #7c519b;
        }

        .slider.slider-horizontal {
            width: 170px;
            height: 20px;
        }

        .SelectedSize {
            border: 1px solid #09f;
        }

        .SelectedColor {
            border: 1px solid #09f;
        }
    </style>
    <script>        
        $(document).ready(function () {            
            $('#ex1').slider({
                formatter: function (value) {
                    $('[id$=hdnSearchByPrice]').val(value);
                    return 'Rs. : ' + value;
                    SetSearchData();
                }
            });
        });

        function SelectSize(ctrl) {
            $(ctrl).toggleClass('SelectedSize');
            SetSearchData();
        }

        function SelectColor(ctrl) {
            $(ctrl).toggleClass('SelectedColor');
            SetSearchData();
        }

        function SetSearchData() {
            var SelectedSize = '';
            var SelectedColor = '';

            $('.SelectedSize').find('input[type=hidden]').each(function () {
                SelectedSize += $(this).val() + ',';
            });

            $('.SelectedColor').find('input[type=hidden]').each(function () {
                SelectedColor += $(this).val() + ',';
            });

            SelectedSize = SelectedSize.substring(0, SelectedSize.length - 1);
            SelectedColor = SelectedColor.substring(0, SelectedColor.length - 1);
            var SearchText = $('[id$=hdnSearchText]').val();
            var SubSubCategory = $('[id$=hdnSubSubCategory]').val();
            var Price = $('[id$=hdnSearchByPrice]').val();

            var PriceOrder = $('#sort-field option:selected').val();

            // $('[id$=hdnSearchBySize]').val(SelectedSize);
            //$('[id$=hdnSearchByColor]').val(SelectedColor);

            $.ajax({
                url: "Search.aspx/SearchData",
                async: true,
                data: JSON.stringify({ SubSubCategory: SubSubCategory, SearchText: SearchText, SelectedSize: SelectedSize, SelectedColor: SelectedColor, Price: Price, PriceOrder: PriceOrder }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    debugger

                    $('[id$=divSearchData]').html('');
                    if (result.d.length > 0) {
                        var data = $.parseJSON(result.d);
                        var html = '';
                        for (var i = 0; i < data.length; i++) {
                            html += '<div class="col-md-3 col-xs-6 col-sm-3" style="margin-bottom: 20px;">';
                            html += '<div style="height: 250px !important; width: 100%;">';
                            html += '<a href="https://myneedify.com//Front/ItemDescription.aspx?ItemId=' + data[i].ItemId + ' >';
                            html += '<div class="Tile">';
                            html += ' <img class="img-responsive img-thumbnail" alt="Img" style="height: 250px !important; width: 100%;" src="../Images/Items/' + data[i].ImageName + '" />';
                            html += '</div>';
                            html += '</a> <a href="ItemDescription.aspx?ItemId=' + data[i].ItemId + '>';
                            html += ' <span class="ItemName">' + data[i].ItemName + '</span>';
                            html += '</a> <div class="ItemPrice">';
                            html += ' <span><i class="fa fa-inr"></i>' + data[i].OldPrice + '</span>';
                            html += '</div>';
                            html += '<div class="ItemPriceOffer">';
                            html += '<span><i class="fa fa-inr"></i>' + data[i].ItemPrice + '</span>';
                            html += '</div></div></div>';

                        }

                        $('[id$=divSearchData]').html(html);
                        $('[id$=lblTotalCount]').text(data.length);
                    }
                    else {
                        $('[id$=divSearchData]').html('Oops ! No Record Found.');
                        $('[id$=lblTotalCount]').text('0');
                    }
                }
            });

            return false;

        }
        function OpenLogin() {
            debugger;
            closeNav();         
            $('#myModal').modal('show');         
            return false;
        }
        function SetByPrice() {
            debugger;
            SetSearchData();
            return false;
        }

    </script>

    <div class="container">
        <asp:HiddenField ID="hdnSearchBySize" runat="server" />
        <asp:HiddenField ID="hdnSearchByColor" runat="server" />
        <asp:HiddenField ID="hdnSearchByPrice" runat="server" />
        <asp:HiddenField ID="hdnSubSubCategory" runat="server" />
        <asp:HiddenField ID="hdnSearchText" runat="server" />


        <!-- twocolumns -->
        <div class="row twocolumns">
            <!-- sidebar -->
            <div class="sidebar col-md-2 col-sm-3">

                <strong class="title hidden-xs">Results</strong>
                <div class="block hidden-xs">
                    <ul class="list-unstyled sub-categories">
                        <li>
                            <a href="#">
                                <asp:Label ID="lblResultOf" runat="server" Text="All Results"></asp:Label>
                            </a>
                        </li>

                    </ul>
                </div>

                <div class="block open-caret">
                    <strong class="title">Size - Numeric</strong>
                    <ul class="list-unstyled set-size">
                        <asp:Repeater runat="server" ID="rptSizeNum">
                            <ItemTemplate>
                                <li onclick="SelectSize(this)">
                                    <input type="hidden" id="hdnSizeId" value='<%#Eval("SizeId") %>' />
                                    <label>
                                        <%#Eval("Size") %>
                                    </label>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>


                    </ul>
                </div>
                <div class="block open-caret">
                    <strong class="title">Size - Alpha</strong>
                    <ul class="list-unstyled set-size">
                        <asp:Repeater runat="server" ID="rptSizeAlpha">
                            <ItemTemplate>
                                <li onclick="SelectSize(this)">
                                    <input type="hidden" id="hdnSizeId" value='<%#Eval("SizeId") %>' />
                                    <label>
                                        <%#Eval("Size") %>
                                    </label>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="block open-caret">
                    <strong class="title">Color</strong>
                    <ul class="list-unstyled color-set">
                        <asp:Repeater runat="server" ID="rptColor">
                            <ItemTemplate>
                                <li onclick="SelectColor(this)">
                                    <input type="hidden" id="hdnColorId" value='<%#Eval("ColorId") %>' />
                                    <label style='<%#"background-color:"+Eval("Code") %>'>
                                        <%#Eval("Color") %>
                                    </label>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>

                    </ul>
                </div>
                <div class="block" id="filter-form-block-05">
                    <strong class="title">Price</strong>
                    <div class="range-slider">
                        <input id="ex1" data-slider-id='ex1Slider' type="text" data-slider-min="50" data-slider-max="30000" data-slider-step="1" data-slider-value="30000" />
                    </div>
                </div>
                <div class="block" id="Div1" style="padding: 25px; padding-left: 0px; padding-right: 0px;">
                    <asp:Button ID="btnSearch" runat="server" Style="font-weight: 100; background-color: #7C519B; background-image: none; border: 1px solid  #7C519B;" class="btn btn-primary btn-block" OnClientClick="return SetSearchData();" Text="Search" />
                </div>

            </div>

            <!-- main content -->
            <div class="col-md-10 col-sm-9">
                <!-- heading-block -->
                <header class="heading-block text-center clearance-block">
                </header>
                <!-- sort-panel -->
                <div class="sort-panel">
                    <div class="row">
                        <div class="col-sm-4">
                            <h1 class="category-selected"></h1>
                            <strong class="count">
                                <asp:Label ID="lblTotalCount" runat="server" Text="0"></asp:Label>
                                Products
                            </strong>
                        </div>
                        <div class="col-sm-5 text-center hidden-xs">
                        </div>
                        <div class="col-sm-3 text-right hidden-xs">
                            <select id="sort-field" class="form-control" onchange="return SetByPrice();" style="height: 35px; text-align: right;">
                                <option value="price">Price - Low to High</option>
                                <option value="price-revers">Price - High to Low</option>
                            </select>
                        </div>
                    </div>

                </div>
                <!-- products-area -->
                <div id="divSearchData" class="products-area">
                    <!-- products list -->
                    <asp:Repeater ID="rptSearchData" runat="server">
                        <ItemTemplate>
                            <div class="col-md-3 col-xs-6 col-sm-3" style="margin-bottom: 20px;">
                                <div style="height: 250px !important; width: 100%;">

                                    <a href="<%#"https://myneedify.com//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>" >
                                        <div class="Tile">
                                            <%--<img class="img-responsive img-thumbnail" alt="Img" style="height: 250px !important; width: 100%;" src="<%#"https://myneedify.com//Images/Items/"+Eval("ImageName") %>" />--%>
                                            <img class="img-responsive img-thumbnail" alt="Img" style="height: 250px !important; width: 100%;" src="<%#"https://myneedify.com/Images/Items/"+Eval("ImageName") %>" />
                                        </div>
                                    </a>

                                    <a href="<%#"https://myneedify.com//Front/ItemDescription.aspx?ItemId="+Eval("ItemId") %>" >
                                        <span class="ItemName"><%#Eval("ItemName") %></span>
                                    </a>

                                    <div class="ItemPrice">
                                        <span><i class="fa fa-inr"></i><%#Eval("OldPrice") %></span>
                                    </div>
                                    <div class="ItemPriceOffer">
                                        <span><i class="fa fa-inr"></i><%#Eval("ItemPrice") %></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
