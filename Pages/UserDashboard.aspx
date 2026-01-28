<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="WSBillingMaster.Pages.UserDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head>
        <title>User Dashboard</title>
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
                    }
                });

                $(".slideanim").each(function () {
                    $(this).addClass("slide");
                });
            })
        </script>

        <style>
            @import url("//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css");

            .the-icons {
                font-size: 25px;
            }
            #services h2 {
                margin-top: 40px;
                margin-bottom: auto;
            }
            /* Dashboard styling */
            #services .row > a > div {
                margin-bottom: 25px;
                padding: 20px 10px;
                transition: 0.3s;
            }

                #services .row > a > div:hover {
                    background: #f9f9f9;
                    border-radius: 8px;
                    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
                }

            #services h4 {
                margin-top: 10px;
                font-size: 14px;
                color: #303030;
            }

            #services h4 {
                font-weight: bold !important;
            }

            .logo-small {
                font-size: 40px;
                color: #ff4500;
            }

            /* ✅ Force 2 per row only on mobile */
            @media (max-width: 767px) {
                #services h2 {
                    font-size: 18px;
                    margin-bottom: -20px;
                }

                .container-fluid {
                    padding: 60px 10px;
                }
                /* Make anchors block level and 3 per row */
                #services .row > a {
                    display: block;
                    width: 33.33%; /* 3 columns per row */
                    float: left;
                    padding: 5px;
                    box-sizing: border-box; /* Include padding in width */
                    height: 110px;
                }

                    /* Inner div full width */
                    #services .row > a > div {
                        width: 100% !important;
                        padding: 5px !important;
                    }

                /* Smaller icons on mobile */
                #services .logo-small {
                    font-size: 25px;
                }

                /* Smaller heading text */
                #services h4 {
                    font-size: 11px;
                }
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
                            <div class="col-sm-4">
                                <%--<span class="glyphicon <%# Eval("MenuClass")%> logo-small"></span>--%>
                                <span class="glyphicon logo-small"></span>
                                <h4><%# Eval("MenuName")%></h4>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:ListView>


            </div>

            <a class="Admin Booking" href="Billing.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-list-alt logo-small"></span>
                    <h4>Product Billing</h4>
                </div>
            </a>

            <a class="Admin" href="Billing.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-list-alt logo-small"></span>
                    <h4>Billing</h4>
                </div>
            </a>

            <a class="Admin" href="ItemImportExport.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Import/Export Product</h4>
                </div>
            </a>

            <a class="Admin" href="ManageItems.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-leaf logo-small"></span>
                    <h4>Manage Product</h4>
                </div>
            </a>

            <a class="Admin Booking Reporting" href="AllTransactions.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-certificate logo-small"></span>
                    <h4>Previous Transactions</h4>
                </div>
            </a>

            <a class="Admin Reporting" href="SalesSummary.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-indent-left logo-small"></span>
                    <h4>Sales Summary</h4>
                </div>
            </a>

            <a class="Admin Reporting" href="StockInHand.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-wrench logo-small"></span>
                    <h4>Stock Reports</h4>
                </div>
            </a>

            <a class="Admin Booking" href="DuplicateBill.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-print logo-small"></span>
                    <h4>Duplicate Bill</h4>
                </div>
            </a>

            <a class="Admin" href="SendSMS.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-fire logo-small"></span>
                    <h4>Send Promotions/Offers</h4>
                </div>
            </a>

            <a class="Admin" href="DiscountMaster.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-align-center logo-small"></span>
                    <h4>Manage Discount</h4>
                </div>
            </a>

            <a class="Admin Booking" href="Refund.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-list-alt logo-small"></span>
                    <h4>Product Refund</h4>
                </div>
            </a>

            <a class="Admin Reporting" href="ExpenseManager.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-indent-right logo-small"></span>
                    <h4>Expense Manager</h4>
                </div>
            </a>

            <a class="Admin Reporting" href="ProfitLossReport.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-indent-left logo-small"></span>
                    <h4>Profit/Loss Report</h4>
                </div>
            </a>

            <a class="Admin" href="EmployeeMaster.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Employee Master</h4>
                </div>
            </a>

            <a class="Admin" href="PhysicalVerification.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-ok logo-small"></span>
                    <h4>Physical Stock Verification</h4>
                </div>
            </a>

            <a class="Admin" href="stockreports.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-ok logo-small"></span>
                    <h4>Physical Stock Reports</h4>
                </div>
            </a>

            <a class="Admin" href="DueAmount.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-ok logo-small"></span>
                    <h4>Due Amount</h4>
                </div>
            </a>

            <a class="Admin" href="OrganizationMaster.aspx">
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <span class="glyphicon glyphicon-ok logo-small"></span>
                    <h4>Organization Master</h4>
                </div>
            </a>

        </div>
    </div>

    <script>
        $(document).ready(function () {
            var RoleId = '<%=RoleId%>';
            if (RoleId == '1') {
                $('.Admin').show();
            } else if (RoleId == '2') {
                $('.Booking').show();
            } else if (RoleId == '3') {
                $('.Reporting').show();
            }
        });
    </script>
</asp:Content>
