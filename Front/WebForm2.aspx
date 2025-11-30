<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WSBillingMaster.Front.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
* {
    box-sizing: border-box;
}
    .font {
  font-size: 14px !important;
    }

body {
    margin: 0;
}

.navbar {
    overflow: hidden;
    background-color: #333;
    font-family: Arial;
}

.navbar a {
    float: left;
    font-size: 16px;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

.dropdown {
    float: left;
    overflow: hidden;
}

.dropdown .dropbtn {
    font-size: 16px;    
    border: none;
    outline: none;
    color: white;
    padding: 14px 16px;
    background-color: inherit;
}

.navbar a:hover, .dropdown:hover .dropbtn {
    background-color: #5c646f;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    width: 100%;
    left: 0;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content .header {
    background: #5c646f;
    padding: 16px;
    color: white;
}

.dropdown:hover .dropdown-content {
    display: block;
}

/* Create three equal columns that floats next to each other */
.column {
    float: left;
    width: 25%;
    padding: 10px;
    background-color: #fff;
    height: 250px;
}

.column a {
    float: none;
    color: black;
    /*padding: 16px;*/
    text-decoration: none;
    display: block;
    text-align: left;
        margin-top: -9px;
}

.column a:hover {
    background-color: #fff;
}

/* Clear floats after the columns */
.row:after {
    content: "";
    display: table;
    clear: both;
}
</style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <div class="navbar">
  <a href="#home">Boys</a>
  <a href="#news">Men</a>
  <div class="dropdown">
    <button class="dropbtn">Women 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <div class="row">
          
        <div class="column" >
            <div style="float:left">  <img width="80px" style="border-radius:10px" height="80px" src="../Images/Item/T1.jpg" /></div>
            <div style="float:left;line-height:0;    margin-top: -10px;   ">  <h3 style=" margin-left: 16px !important;">Ethinic wear</h3>
            <a class="font" href="#">Top</a>
            <a class="font" href="#">Kurta</a>
                 <a class="font" href="#">Dress & salwar</a>
            <a class="font" href="#">Skirt</a></div>
        
        </div>
        <div class="column" >
            <div style="float:left">  <img width="80px" style="border-radius:10px" height="80px" src="../Images/Item/T4.jpg" /></div>
            <div style="float:left;line-height:0;       margin-top: -10px;">  <h3 style=" margin-left: 16px !important;">Ethinic wear</h3>
            <a class="font" href="#">Top</a>
            <a class="font" href="#">Kurta</a>
                 <a class="font" href="#">Dress & salwar</a>
            <a class="font" href="#">Skirt</a></div>
        
        </div>
         <div class="column" >
            <div style="float:left">  <img width="80px" style="border-radius:10px" height="80px" src="../Images/Item/T3.jpg" /></div>
            <div style="float:left;line-height:0;       margin-top: -10px;"> <h3 style=" margin-left: 16px !important;">Ethinic wear</h3>
            <a class="font" href="#">Top</a>
            <a class="font" href="#">Kurta</a>
                 <a class="font" href="#">Dress & salwar</a>
            <a class="font" href="#">Skirt</a></div>
        
        </div>
            <div class="column" >
            <div style="float:left">  <img width="80px" style="border-radius:10px" height="80px" src="../Images/Item/T3.jpg" /></div>
            <div style="float:left;line-height:0;        margin-top: -10px;"> <h3 style=" margin-left: 16px !important;">Ethinic wear</h3>
            <a class="font" href="#">Top</a>
            <a class="font" href="#">Kurta</a>
                 <a class="font" href="#">Dress & salwar</a>
            <a class="font" href="#">Skirt</a></div>
        
        </div>
      </div>
    </div>
  </div> 
</div>
    </form>
</body>
</html>

