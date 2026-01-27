<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WSBillingMaster.Pages.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
     <style>
         img[src*="Christmas-Hat-PNG-Image.png"]{
     max-height: 60px !important;
     left: 18% !important;
     top: 18% !important;
 }
        /* Mobile only: make logo smaller */
        @media (max-width: 576px) {
           img[src*="logoRC.png"] {
                max-width: 120px !important;
            }
            img[src*="Christmas-Hat-PNG-Image.png"]{
                max-height: 50px !important;
                left: 24% !important;
                top: 30% !important;
            }
        }
    </style>
</head>
<body style="background-image: url(../Js/Snowflakes/baby-wallpaper-preview.jpg); background-size: cover; background-repeat: no-repeat;">
    <form id="form1" runat="server">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-md-10 col-lg-8">
                    <div class="card shadow mt-5" style="opacity:0.95;">

                        <!-- Mobile logo (shown only on mobile) -->
                        <div class="text-center p-3 d-block d-md-none" style="position:relative;">
                            <img src="../Js/Snowflakes/Christmas-Hat-PNG-Image.png" class="img-fluid" style="max-height:60px; position:absolute; top:0; left:35%;" />
                            <img src="../Images/logoRC.png" class="img-fluid mt-4" style="max-width:120px;">
                        </div>

                        <div class="row g-0">
                            
                            <!-- Login form (first on mobile, second on desktop) -->
                            <div class="col-12 col-md-6 border-start p-4 order-1 order-md-2">
                                <h5 class="fw-bold mb-4">Login to Admin Panel</h5>
                                <div class="mb-3">
                                    <label for="txtLogin" class="form-label">Login ID</label>
                                    <input name="txtLogin" type="text" id="txtLogin" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label for="txtPassword" class="form-label">Password</label>
                                    <input name="txtPassword" type="password" id="txtPassword" class="form-control">
                                </div>
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="chkRemember" name="chkRemember">
                                    <label class="form-check-label" for="chkRemember">Remember me</label>
                                </div>
                                <div class="d-grid mb-3">
                                    <input type="button" id="btnLogin" value="Login" onclick="Validate();" class="btn btn-warning">
                                </div>
                                <span id="lblMessage" class="text-danger small d-none">Invalid User Name / Password</span>
                            </div>

                            <!-- Logo & Address (hidden logo on mobile, visible on desktop) -->
                            <div class="col-12 col-md-6 text-center p-4 order-2 order-md-1">
                                <div style="position:relative;" class="d-none d-md-block">
                                    <img src="../Js/Snowflakes/Christmas-Hat-PNG-Image.png" class="img-fluid" style="max-height:100px; position:absolute; top:0; left:20%;" />
                                    <img src="../Images/logoRC.png" class="img-fluid mt-4" style="max-width:200px;">
                                </div>
                                <hr />
                                <div class="text-start mt-3" style="font-size:14px;">
                                    <p>
                                        <strong>Address:</strong> Rahul Collection, VPO Rehan, Teh Fatehpur, Distt. Kangra (H.P.) Pin code - 176022 <br />
                                        <strong>Phone:</strong> 9650362525 <br />
                                        <strong>Email:</strong> rahulrocker88@gmail.com
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- jQuery --%>
        <script src="../Js/jquery.min.js"></script>

        <%-- Validation Script --%>
        <script>
            function Validate() {
                var User = $('[id$=txtLogin]').val().trim();
                var Pwd = $('[id$=txtPassword]').val().trim();
                if (User != "" && Pwd != "") {
                    $.ajax({
                        url: "Login.aspx/ValidateUser",
                        async: true,
                        data: JSON.stringify({ User: User, Password: Pwd }),
                        contentType: "application/json; charset=utf-8",
                        type: "POST",
                        timeout: 120000,
                        dataType: "json",
                        success: function (result) {
						debugger
                            var IsValid = result.d;
                            if (IsValid == "1") {
                                window.location.href = "UserDashboard.aspx";
                            } else {
                                alert('Invalid UserName/Password !');
                                return false;
                            }
                        }
                    });
                } else {
                    alert('Please enter user name and password');
                    return false;
                }
            }
        </script>

        <%-- Snowfall Effect --%>
        <link href="../Js/Snowflakes/snowflakes.css" rel="stylesheet" />
        <script src="../Js/Snowflakes/jquery-latest.min.js"></script>
        <script src="../Js/Snowflakes/snowfall.jquery.js"></script>
        <script>
            $(document).ready(function () {
                $(document).snowfall({ deviceorientation: true, round: true, minSize: 1, maxSize: 8, flakeCount: 250 });
            });
        </script>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
