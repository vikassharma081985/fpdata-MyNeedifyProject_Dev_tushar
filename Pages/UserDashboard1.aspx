<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="WSBillingMaster.Pages.UserDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head>
        <!-- Theme Made By www.w3schools.com - No Copyright -->
        <title>Bootstrap Theme Company Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">



        <script>
            $(document).ready(function () {
                $(".navbar a, footer a[href='#myPage']").on('click', function (event) {
                    if (this.hash !== "") {
                        event.preventDefault();
                        var hash = this.hash;
                        $('html, body').animate({
                            scrollTop: $(hash).offset().top
                        }, 900, function () {
                            window.location.hash = hash;
                        });
                    } // End if
                });

                // $(window).scroll(function () {

                $(".slideanim").each(function () {
                    //var pos = $(this).offset().top;

                    //var winTop = $(window).scrollTop();
                    // if (pos < winTop + 600) {
                    $(this).addClass("slide");
                    //}
                });
                // });
            })
        </script>
        <style>
            @import url("//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css");

            .the-icons {
                font-size: 25px;
            }
            h4 {
                font-weight: bold !important;
                    margin-top: 10px;
                    font-size: 14px;
                    color: #303030;
            }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div id="services" class="container-fluid text-center">
        <h2>Welcome,
            <asp:Label ID="lblEmployeeName" runat="server" Text="User"></asp:Label>
        </h2>

        <br>
        <div class="row slideanim">
            <div>
                <asp:ListView runat="server" ID="lvMenu">
                    <ItemTemplate>

                        <a class="Admin Booking" href="<%# Eval("MenuUrl")%>">
                            <div class="col-xs-6 col-sm-4 col-md-3">
                                <span class="glyphicon <%# Eval("MenuClass")%> logo-small"></span>
                                <h4><%# Eval("MenuName")%></h4>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:ListView>


            </div>

            
        </div>

        <%-- <div class="row slideanim">

        </div>--%>
    </div>

    <script>
        $(document).ready(function () {
            // Role-based visibility is now handled by the server-side ListView binding
        });

    </script>
</asp:Content>

