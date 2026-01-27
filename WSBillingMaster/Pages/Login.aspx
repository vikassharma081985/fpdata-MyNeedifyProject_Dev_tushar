<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WSBillingMaster.Pages.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Js/jquery.min.js"></script>
    <script src="../Js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link href="../Css/MyStyle.css" rel="stylesheet" />
    <link href="../Css/Common.css?v=0.1" rel="stylesheet" />
    <link href="style-mobile.css" rel="stylesheet">
    <style>
        span {
            font-family: Helvetica;
            font-size: 14px;
        }

        .b {
            font-family: Helvetica;
            font-size: 16px;
            font-weight: bold;
        }

        .container-fluid {
            padding-right: 0;
            padding-left: 0;
            margin-right: auto;
            margin-left: auto
        }

        @media screen and (max-height: 450px) {
            .sidenav {
                padding-top: 15px;
            }

                .sidenav a {
                    font-size: 18px;
                }
        }

        @media only screen and (max-width:480px) {
            .dropdown-menu {
                display: block;
                position: static;
                background-color: transparent;
                border: 0 none;
                box-shadow: none;
                margin-top: 0;
                position: static;
                width: 100%;
            }

            .navbar-nav .dropdown-menu > li > a,
            .navbar-nav .dropdown-menu .dropdown-header {
                padding: 5px 15px 5px 25px;
            }

            .navbar-nav .dropdown-menu > li > a {
                line-height: 20px;
            }

            .navbar-default .navbar-nav .dropdown-menu > li > a {
                color: #fff;
            }
        }
    </style>

    <script>
    function closeWindow() {
        window.open('','_parent','');
        window.close();
    }
</script> 
</head>
<body class="img-responsive" style="background-image: url(../Js/Snowflakes/baby-wallpaper-preview.jpg);">
    <form id="form1" runat="server">
        <div class="container-fluid PageContent">
            <div style="margin-top: 20px;" class="container h-100">
                <div class="row align-items-center h-100">
                    <div class="col-6">
                        <div class="jumbotron">
                            <div class="row">
                                <div>
                                    <asp:LinkButton Text="Home" CssClass="btn btn-default" PostBackUrl="javascript:closeWindow();" runat="server" /></div>
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" style="border: solid 1px #D7DCE6;">
                                    <div style="margin-bottom: 50px;">
                                        <img src="../Images/logoRC.png" style="width: 200px;" />
                                        <hr />
                                        <div style="text-align: left; padding: 15px;">
                                            <span>
                                                <strong>Address : </strong>
                                                Rahul Collection, VPO Rehan, Teh Fatehpur, Distt. Kangra (H.P.) Pin code - 176022<br />
                                                <strong>Phone: </strong>9650362525, <strong>
                                                    <br />
                                                    Email-id:</strong> rahulrocker88@gmail.com
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" style="border: solid 1px #D7DCE6;">
                                    <div style="margin-bottom: 92px;">
                                        <div style="text-align: left; padding: 15px;">
                                            <div>
                                                <div style="margin-bottom: 20px;">
                                                    <span class="b">Login to Admin Panel</span>
                                                </div>
                                            </div>
                                            <div>
                                                <div>
                                                    <div style="margin-bottom: 20px;">
                                                        <span id="lblLogin" class="lblName">Login ID</span>
                                                        <div>
                                                        </div>
                                                    </div>
                                                    <div style="margin-bottom: 20px;">
                                                        <input name="txtLogin" type="text" id="txtLogin" class="txtbox" style="border-color: #E5E3E3; border-width: 1px; border-style: solid;" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div>
                                                <div style="margin-bottom: 20px;">
                                                    <span id="lblPassword" class="lblName">Password</span>
                                                </div>
                                                <div>
                                                    <input name="txtPassword" type="password" id="txtPassword" class="txtbox" style="border-color: #E5E3E3; border-width: 1px; border-style: solid;" />&nbsp;                                                                          
                                                </div>
                                            </div>
                                            <div>
                                                <div style="float: left; color: #000; font-family: Helvetica; font-size: 14px; width: 100px; text-align: left;">
                                                    &nbsp;
                                                </div>
                                                <div style="float: left; width: 74%; text-align: left; display: none;">
                                                    <a id="lnkForgetpwd" href="javascript:__doPostBack('lnkForgetpwd','')" style="font-size: 12px;">Forgot password?</a>
                                                </div>
                                            </div>
                                            <div style="float: left; width: 100%; text-align: center; padding-left: 45px; padding-top: 5px;">
                                                <div style="float: left; width: 53%; font-family: Helvetica; color: #000; font-size: 12px;">
                                                    <input id="chkRemember" type="checkbox" name="chkRemember" /><label for="chkRemember">Remember me</label>
                                                </div>
                                            </div>
                                            <div style="float: left; width: 43.5%; padding-left: 15px; text-align: right; padding-top: 10px;">

                                                <input type="button" id="btnLogin" value="Login" onclick="Validate();" style="width: 84px; height: 28px; background: #FFCC01; border: 1px #E4B702; font-family: Helvetica; font-size: 14px; color: #000; cursor: pointer;" />

                                            </div>
                                            <div style="float: left; width: 100%;">
                                                <span id="lblMessage" style="color: Red; font-size: 10px; display: none;">Invalid User Name / Password</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
                                                    var IsValid = result.d;
                                                    if (IsValid == "1") {
                                                        window.location.href = "UserDashboard.aspx";
                                                    }
                                                    else {
                                                        alert('Invalid UserName/Password !');
                                                        return false;
                                                    }

                                                }
                                            });

                                        }
                                        else {
                                            alert('Please enter user name and password');
                                            return false;
                                        }

                                    }

                                </script>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <%--<div>            
            <script src="../Js/jquery.min.js"></script>
            <center>
            <table class="tbllogin" border="0" cellpadding="0" cellspacing="0" >
                <tbody>
                    <tr>
                        <td style="padding-top: 0px;">
                            <center>
                        <table style="width: 946px; background-color: #FFF; height: 364px; margin-top: 110px;opacity:0.9" cellpadding="0" cellspacing="0">
                            <tbody><tr>
                                <td align="center" style="border-bottom: 1px #D7DCE6;">
                                    <table>
                                        <tbody><tr>
                                            <td style="width: 850px;    border: 1px solid #ccc;" valign="middle">
                                                <center>
                                                    <table style="width: 100%; height: 250px;">
                                                        <tbody><tr>
                                                            <td align="center" style="padding-right: 35px;font-family:Arial;position:relative">
                                                                
                                                                
                                                                <p style="font-family:Segoe UI;font-size:28px;line-height:20px;letter-spacing:-1px;    margin-top: 120px;
    margin-left: 35px;">
                               <img src="../Js/Snowflakes/Christmas-Hat-PNG-Image.png" style="position: absolute;
    height: 100px;
    top: 9%;
    left: 14%;" />                                    
                            <img src="../Images/logoRC.png" style="width: 200px; margin-left: 0%; margin-top: -40%;">
                                                                    <br />
                                                                    <br />
                                                                    
                                                                </p>
                                                                <hr style="margin-left: 30px;" />
                                                                    <br />
                                                                    <div style="text-align:left;padding:15px;font-size:14px;">
                                                                    <span>
                                                                        <strong>Address : </strong>
                                                                        Rahul Collection, VPO Rehan, Teh Fatehpur, Distt. Kangra (H.P.) Pin code - 176022<br />
<strong>Phone: </strong>9650362525, <strong><br /> Email-id:</strong> rahulrocker88@gmail.com
                                                                    </span>
                                                                    </div>
                                                            </td>
                                                            <td style="border-left: solid 1px #E5E3E3;">
                                                                &nbsp;
                                                            </td>
                                                            <td style="width: 50%; padding-left: 30px;">
                                                                <div style="float: left; width: 100%; text-align: center;">
                                                                    <div style="float: left; width: 100%; margin-top: 20px;">
                                                                        <div style="float: left; color: #000; font-family: Helvetica; width: 100%; padding-bottom: 10px;
                                                                            font-weight: bold; font-size: 16px; text-align: left;">
                                                                            Login to Admin Panel
                                                                        </div>
                                                                    </div>
                                                                    <div style="float: left; width: 100%; margin-top: 20px;">
                                                                        <div style="float: left; width: 100%; padding-bottom: 10px;">
                                                                            <div style="float: left; color: #000; font-family: Helvetica; font-size: 14px; padding-bottom: 5px;
                                                                                width: 100px; text-align: left;">
                                                                                <span id="lblLogin" class="lblName">Login ID</span>
                                                                                <div style="margin-top:6px; float:right; color:gray; ">
                                                                                </div>
                                                                            </div>
                                                                            <div style="float: left; width: 72%; text-align: left;">
                                                                                <input name="txtLogin" type="text" id="txtLogin" class="txtbox" style="border-color:#E5E3E3;border-width:1px;border-style:solid;">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div style="float: left; width: 100%; padding-bottom: 10px;">
                                                                        <div style="float: left; color: #000; font-family: Helvetica; font-size: 14px; width: 100px;
                                                                            text-align: left;">
                                                                            <span id="lblPassword" class="lblName">Password</span>
                                                                        </div>
                                                                        <div style="float: left; width: 74%; text-align: left;">
                                                                            <input name="txtPassword" type="password" id="txtPassword" class="txtbox" style="border-color:#E5E3E3;border-width:1px;border-style:solid;">&nbsp;
                                                                          
                                                                        </div>
                                                                    </div>
                                                                    <div style="float: left; width: 100%; padding-bottom: 5px;">
                                                                        <div style="float: left; color: #000; font-family: Helvetica; font-size: 14px; width: 100px;
                                                                            text-align: left;">
                                                                            &nbsp;
                                                                        </div>
                                                                        <div style="float: left; width: 74%; text-align: left;display:none;">
                                                                            <a id="lnkForgetpwd" href="javascript:__doPostBack('lnkForgetpwd','')" style="font-size:12px;">Forgot password?</a>
                                                                        </div>
                                                                    </div>
                                                                    <div style="float: left; width: 100%; text-align: center; padding-left: 45px; padding-top: 5px;">
                                                                        <div style="float: left; width: 53%; font-family: Helvetica; color: #000; font-size: 12px;">
                                                                            <input id="chkRemember" type="checkbox" name="chkRemember"><label for="chkRemember">Remember me</label>
                                                                        </div>
                                                                    </div>
                                                                    <div style="float: left; width: 43.5%; padding-left: 15px; text-align: right; padding-top: 10px;">
                                                                        
                                                                        <input type="Button" ID="btnLogin" value="Login" onclick="Validate();" style="width: 84px; height: 28px; background: #FFCC01;
                                                                            border: 1px #E4B702; font-family: Helvetica; font-size: 14px; color: #000;cursor:pointer;" />
                                                                        
                                                                    </div>
                                                                    <div style="float: left; width: 100%;">
                                                                        <span id="lblMessage" style="color:Red;font-size:10px;display:none;">Invalid User Name / Password</span>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </center>
                                            </td>
                                            <td>
                                                <div style="float: left; width: 100%;">
                                                    &nbsp;
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                        </tbody></table>
                    </center>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 20px;">
                            <center>
                        <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0">
                            <tbody><tr>
                                <td>
                                    <div style="float: left; width: 100%;">
                                        &nbsp;
                                    </div>
                                </td>
                                <td style="width: 830px;">
                                    &nbsp;
                                </td>
                                <td>
                                    <div style="float: left; width: 100%;">
                                        &nbsp;
                                    </div>
                                </td>
                            </tr>
                        </tbody></table>
                    </center>
                        </td>
                    </tr>
                </tbody>
            </table>
                </center>            

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
                                var IsValid = result.d;
                                if (IsValid == "1") {
                                    window.location.href = "UserDashboard.aspx";
                                }
                                else {
                                    alert('Invalid UserName/Password !');
                                    return false;
                                }

                            }
                        });

                    }
                    else {
                        alert('Please enter user name and password');
                        return false;
                    }

                }

            </script>
        </div>--%>
        <link href="../Js/Snowflakes/snowflakes.css" rel="stylesheet" />
        <script src="../Js/Snowflakes/jquery-latest.min.js"></script>
        <script src="../Js/Snowflakes/snowfall.jquery.js"></script>
        <script type='text/javascript'>

            $(document).ready(function () {

                $(document).snowfall({ deviceorientation: true, round: true, minSize: 1, maxSize: 8, flakeCount: 250 });

            });

        </script>
    </form>
</body>
</html>
