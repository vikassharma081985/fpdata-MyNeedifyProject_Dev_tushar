<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeBehind="OrderSuccess.aspx.cs" Inherits="WSBillingMaster.Front.OrderSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <div class="container" style="padding-bottom: 25px;text-align:center;margin-top:5%;margin-bottom:5%; min-height:200px;">
        <img src="../Images/System/Success.png" />
        <br />
        <br />
        <p style="font-size:18px;"><strong>Thank you for shopping with us. Your Order Placed Successfully !</strong></p>
        <p style="font-size:14px;">Your order Id for reference is <asp:Label Text="FP00001" ID="lblOrderId" runat="server" /></p>
        <br />
        <br />
        <a href="index.aspx" class="btn btn-primary" style="font-weight:100;background-color:#7c519b;background-image:none;border:1px solid #7c519b;" > Continue Shopping</a>
    </div>
</asp:Content>
