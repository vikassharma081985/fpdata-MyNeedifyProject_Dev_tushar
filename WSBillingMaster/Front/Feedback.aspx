<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="WSBillingMaster.Front.Feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <div class="container">
        <style>
            .MySection {
                background-blend-mode: hard-light;
                height: 320px;
                background-position: bottom;
                padding-top: 100px;
                text-align: center;
                font-size: 18px;
                color: #000;
                font-weight:bold;
                background-image: url(../Images/System/feedback.jpg);
                background-size: 95%;
                background-color: white;
                background-repeat-x: repeat;
                background-repeat-y: no-repeat;
            }
        </style>
        <div class="row">
            <div class="col-md-6 MySection" >
                <div style="color: #000; font-size: 28px; font-weight: bold; margin-bottom: 10px;">Share Your Feedback </div>
                <p>Share your experience with us, to serve you better in future.</p>
            </div>
            <div class="col-md-6" style="margin-top: 20px;">
                <div class="login-form" style="background-color: #fff; border: 1px solid #ccc; padding: 5%; height: 300px; border-radius: 5px;">

                    <div class="form-group">

                        <asp:TextBox ID="txtSellerName" runat="server" MaxLength="40" class="form-username form-control" placeholder="Email"></asp:TextBox>
                    </div>
                    
                  
                    <div class="form-group">
                        <asp:TextBox ID="txtSellerEmail" runat="server" MaxLength="40" class="form-username form-control" placeholder="Subject"></asp:TextBox>
                    </div>
                   
                    <div class="form-group">
                        <asp:TextBox ID="txtAdditionalComment" TextMode="MultiLine" MaxLength="1200" Height="80px" runat="server" class="form-control" placeholder="Your Feedback"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnSignup" runat="server" OnClientClick="return Submit();" class="cambutton" Style="background-color: #7C519B; height: 35px; color: #fff; padding: 7px; width: 100%; text-align: center; border: none;" Text="Submit"></asp:Button>



                    <br />
                    <br />

                </div>
            </div>
        </div>

    </div>
    <script>
        function Submit() {
            //var FName = $('[id$=txtSellerName]').val().trim();
            //var Address = $('[id$=txtAddress]').val().trim();
            //var Email = $('[id$=txtSellerEmail]').val().trim();
            //var Mobile = $('[id$=txtSellerMobile]').val().trim();

            var flag = true;
            //if (FName == "") {
            //    flag = false;
            //    $('[id$=txtSellerName]').css('border', '1px solid red');
            //}
            //else {
            //    $('[id$=txtSellerName]').css('border', '1px solid #ccc');
            //}

            //if (Address == "") {
            //    flag = false;
            //    $('[id$=txtAddress]').css('border', '1px solid red');
            //}
            //else {
            //    $('[id$=txtAddress]').css('border', '1px solid #ccc');
            //}
            //if (Email == "") {
            //    flag = false;
            //    $('[id$=txtSellerEmail]').css('border', '1px solid red');
            //}
            //else {
            //    $('[id$=txtSellerEmail]').css('border', '1px solid #ccc');
            //}
            //if (Mobile == "") {
            //    flag = false;
            //    $('[id$=txtSellerMobile]').css('border', '1px solid red');
            //}
            //else {
            //    $('[id$=txtSellerMobile]').css('border', '1px solid #ccc');
            //}



            if (flag) {
                alert('Thank you sharing your valuable feedback.');
                $('input').val('');
                $('textarea').val('');
            }

            return false;



        }
    </script>
</asp:Content>
