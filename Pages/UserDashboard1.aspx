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

            
            <a class="Admin" href="ItemImportExport.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Import/Export Product</h4>

                </div>
            </a>

            <a class="Admin" href="ManageItems.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-leaf logo-small"></span>
                    <h4>Manage Product</h4>

                </div>
            </a>

            <a class="Admin Booking Reporting" href="AllTransactions.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-certificate logo-small"></span>
                    <h4>Previous Transactions</h4>

                </div>
            </a>
            <a class="Admin Reporting" href="SalesSummary.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-indent-left logo-small"></span>
                    <h4 style="color: #303030;">Sales Summary</h4>

                </div>
            </a>
            <a class="Admin Reporting" href="StockInHand.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-wrench logo-small"></span>
                    <h4 style="color: #303030;">Stock Reports</h4>

                </div>
            </a>

            <a class="Admin Booking" href="DuplicateBill.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-print logo-small"></span>
                    <h4>Duplicate Bill</h4>

                </div>
            </a>
            <a class="Admin" href="SendSMS.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-fire logo-small"></span>
                    <h4 style="color: #303030;">Send Promotions/Offers</h4>

                </div>
            </a>
            <a class="Admin" href="DiscountMaster.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-align-center logo-small"></span>
                    <h4 style="color: #303030;">Manage Discount</h4>

                </div>
            </a>


            <a class="Admin Booking" href="Refund.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-list-alt logo-small"></span>
                    <h4>Product Refund</h4>

                </div>
            </a>

            <a class="Admin Reporting" href="ExpenseManager.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-indent-right logo-small"></span>
                    <h4>Expense Manager</h4>

                </div>
            </a>

            <a class="Admin Reporting" href="ProfitLossReport.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-indent-left logo-small"></span>
                    <h4>Profit/Loss Report</h4>

                </div>
            </a>


            <a class="Admin" href="EmployeeMaster.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Employee Master</h4>

                </div>
            </a>
            <a class="Admin" href="PhysicalVerification.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon glyphicon-ok logo-small"></span>
                    <h4>Physical Stock Verification</h4>

                </div>
            </a>
            <a class="Admin" href="stockreports.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon glyphicon-ok logo-small"></span>
                    <h4>Physical Stock Reports</h4>

                </div>
            </a>
            <a class="Admin" href="AddItem.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon glyphicon-ok logo-small"></span>
                    <h4>Add New Product</h4>
                </div>
            </a>
            <a class="Admin" href="SupplierList.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon glyphicon-ok logo-small"></span>
                    <h4>Manage Supplier</h4>
                </div>
            </a>
            <a class="Admin" href="VendorItemReport.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon glyphicon-ok logo-small"></span>
                    <h4>Vendor Item Report</h4>
                </div>
            </a>
            <a class="Admin" href="AdminList.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon glyphicon-ok logo-small"></span>
                    <h4>Manage Product</h4>
                </div>
            </a>
            <a class="Admin" href="PendingOrderList.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon glyphicon-ok logo-small"></span>
                    <h4>Pending Order List</h4>
                </div>
            </a>
            <a class="Admin" href="SliderManagement.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon glyphicon-ok logo-small"></span>
                    <h4>Banner Management</h4>
                </div>
            </a>
            <a class="Admin" href="stateMaster.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Add/Edit/View StateMaster</h4>
                </div>
            </a>
            <a class="Admin" href="cityMaster.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Add/Edit/View CityMaster</h4>
                </div>
            </a>
            <a class="Admin" href="areaMaster.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Add/Edit/View AreaMaster</h4>
                </div>
            </a>

            <a class="Admin" href="AddCategory.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Add/Edit/View Category </h4>
                </div>
            </a>

            <a class="Admin" href="AddSubCategory.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Add/Edit/View Sub Category</h4>
                </div>
            </a>
            <a class="Admin" href="AddSubSubCategory.aspx">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-plus-sign logo-small"></span>
                    <h4>Add/Edit/View Sub Sub Category</h4>
                </div>
            </a>
        </div>

        <%-- <div class="row slideanim">

        </div>--%>
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
            else if (RoleId == '4') {
                $('.Admin').show();

            }
        });

    </script>
</asp:Content>

