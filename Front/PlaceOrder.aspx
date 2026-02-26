<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master"
    AutoEventWireup="true" CodeBehind="PlaceOrder.aspx.cs"
    Inherits="FaduPrice.Pages.PlaceOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
body{
    background:#f5f5f5;
    font-family:'Segoe UI',sans-serif;
}

.container{
    margin-top:20px;
}

/* Section Title */
.checkout-title{
    font-size:20px;
    font-weight:600;
    margin-bottom:15px;
}

/* Card Layout */
.checkout-card{
    background:#fff;
    border-radius:12px;
    padding:18px;
    margin-bottom:18px;
    box-shadow:0 2px 8px rgba(0,0,0,0.05);
}

/* Address box */
.address-box{
    border:1px solid #eee;
    border-radius:12px;
    padding:15px;
    margin-bottom:15px;
    transition:0.3s;
    background:#fff;
}

.address-box:hover{
    background:#fafafa;
}

.address-name{
    font-weight:600;
    font-size:16px;
}

.address-text{
    font-size:14px;
    color:#555;
    line-height:22px;
}

/* Buttons */
.btn-primary-custom{
    background:#e30613;
    border:none;
    border-radius:10px;
    padding:14px;
    width:100%;
    color:#fff;
    font-weight:600;
    font-size:15px;
}

.btn-primary-custom:hover{
    background:#c80510;
}

/* Inputs */
.form-control{
    border-radius:10px;
    height:48px;
    margin-bottom:12px;
    font-size:14px;
}

/* Summary */
.summary-row{
    display:flex;
    justify-content:space-between;
    margin-bottom:10px;
    font-size:14px;
}

.summary-total{
    font-size:18px;
    font-weight:700;
}

input[type="radio"]{
    transform:scale(1.2);
}

/* ---------------- MOBILE DESIGN ---------------- */

@media (max-width: 768px){

    .row{
        display:flex;
        flex-direction:column-reverse;
    }

    .col-md-8,
    .col-md-4{
        width:100%;
        max-width:100%;
        flex:100%;
    }

    .checkout-card{
        border-radius:14px;
        padding:15px;
    }

    .address-box{
        border-radius:14px;
    }

    .checkout-title{
        font-size:18px;
    }

    /* Sticky bottom order button */
    #PaymentSection{
        position:fixed;
        bottom:0;
        left:0;
        right:0;
        background:#fff;
        padding:15px;
        box-shadow:0 -2px 10px rgba(0,0,0,0.1);
        z-index:999;
    }

    body{
        padding-bottom:120px;
    }

}
</style>

<div class="container">

<div class="row">

<!-- LEFT SIDE -->
<div class="col-md-8">

<div class="checkout-title">Delivery Address</div>

<asp:Repeater runat="server" ID="rptUserAddress">
<ItemTemplate>
<div class="address-box">

<div class="address-name">
<span id="<%#"spName_"+Eval("ContactId") %>"><%#Eval("Name") %></span>
</div>

<div class="address-text">
<span id="<%#"spBuilding_"+Eval("ContactId") %>"><%#Eval("Building") %></span><br />
<span id="<%#"spLocality_"+Eval("ContactId") %>"><%#Eval("Locality") %></span><br />
<span id="<%#"spCity_"+Eval("ContactId") %>"><%#Eval("City") %></span>,
<span id="<%#"spState_"+Eval("ContactId") %>"><%#Eval("State") %></span> -
<span id="<%#"spPincode_"+Eval("ContactId") %>"><%#Eval("Pincode") %></span><br />
📞 <span id="<%#"spMobile_"+Eval("ContactId") %>"><%#Eval("Mobile") %></span>
</div>

<br />

<input type="button"
class="btn-primary-custom"
onclick="return DeliverHere(<%#Eval("ContactId") %>, this);"
value="Deliver Here" />

</div>
</ItemTemplate>
</asp:Repeater>

<!-- ADD ADDRESS FORM -->
<div id="AddressSection" class="checkout-card">

<div class="checkout-title">Add New Address</div>

<asp:TextBox runat="server" ID="txtName" CssClass="form-control" placeholder="Full Name" />
<asp:TextBox runat="server" ID="txtMobile" CssClass="form-control" placeholder="Mobile Number" />
<asp:TextBox runat="server" ID="txtBuilding" CssClass="form-control" placeholder="House / Building" />

<select id="ddlStateMaster" class="form-control"></select>
<select id="ddlCityMaster" class="form-control"></select>
<select id="ddlLocality" class="form-control"></select>

<asp:TextBox runat="server" ID="txtPincode" CssClass="form-control" placeholder="Pincode" />

<asp:Button runat="server"
ID="btnAddress"
CssClass="btn-primary-custom"
OnClientClick="return ValidateAddress();"
Text="Save & Deliver Here" />

</div>

<!-- PAYMENT SECTION -->
<div id="PaymentSection" style="display:none;" class="checkout-card">

<div class="checkout-title">Payment Option</div>

<div style="display:flex; justify-content:space-between; align-items:center;">
<div>
<input type="radio" checked="checked" id="rdbCOD" />
<span style="margin-left:8px;">Cash on Delivery</span>
</div>

<asp:Button runat="server"
ID="btnPlaceOrder"
CssClass="btn-primary-custom"
OnClientClick="return PlaceOrder();"
Text="Place Order" />
</div>

</div>

</div>

<!-- RIGHT SIDE SUMMARY -->
<div class="col-md-4">

<div class="checkout-card">

<div class="checkout-title">Order Summary</div>

<asp:Repeater runat="server" ID="rptItems">
<ItemTemplate>
<div class="summary-row">
<div>
<%#Eval("ItemName") %><br />
Qty: <%#Eval("ItemQuantity") %>
</div>
<div>₹ <%#Eval("ItemPrice") %></div>
</div>
<hr />
</ItemTemplate>
</asp:Repeater>

<div class="summary-row">
<div>Delivery</div>
<div style="color:green;">Free</div>
</div>

<hr />

<div class="summary-row summary-total">
<div>Total</div>
<div>₹ <asp:Label ID="lblTotal" runat="server" /></div>
</div>

</div>

</div>

</div>
</div>
    <script>
        function ValidateAddress() {
             
            localStorage["ddlLocality"] = null;
            var Name = $('[id$=txtName]').val().trim();
            var Mobile = $('[id$=txtMobile]').val().trim();
            var Building = $('[id$=txtBuilding]').val().trim();
            // var Locality = $('[id$=txtLocality]').val().trim();
            //var City = $('[id$=txtCity]').val().trim();
            //var State = $('[id$=txtState]').val().trim();
            var Locality = $("#ddlLocality option:selected").text();
            var City = $("#ddlCityMaster option:selected").text();
            var State = $("#ddlStateMaster option:selected").text();

            var Pincode = $('[id$=txtPincode]').val().trim();
            var flag = true;
            if (Name == "") {
                flag = false;
                $('[id$=txtName]').css('border', '1px solid red');
                $('[id$=txtName]').focus();
            }
            else {
                $('[id$=txtName]').css('border', '1px solid #ccc');
            }

            if (Mobile == "") {
                flag = false;
                $('[id$=txtMobile]').css('border', '1px solid red');
                $('[id$=txtMobile]').focus();
            }
            else {
                $('[id$=txtMobile]').css('border', '1px solid #ccc');
            }

            if (Building == "") {
                flag = false;
                $('[id$=txtBuilding]').css('border', '1px solid red');
                $('[id$=txtBuilding]').focus();
            }
            else {
                $('[id$=txtBuilding]').css('border', '1px solid #ccc');
            }

            if (Locality == "") {
                flag = false;
                $('[id$=ddlLocality]').css('border', '1px solid red');
                $('[id$=ddlLocality]').focus();
            }
            else {
                $('[id$=ddlLocality]').css('border', '1px solid #ccc');
            }
            if (City == "") {
                flag = false;
                $('[id$=ddlCityMaster]').css('border', '1px solid red');
                $('[id$=ddlCityMaster]').focus();
            }
            else {
                $('[id$=ddlCityMaster]').css('border', '1px solid #ccc');
            }
            if (State == "") {
                flag = false;
                $('[id$=ddlStateMaster]').css('border', '1px solid red');
                $('[id$=ddlStateMaster]').focus();
            }
            else {
                $('[id$=ddlStateMaster]').css('border', '1px solid #ccc');
            }
            if (Pincode == "") {
                flag = false;
                $('[id$=txtPincode]').css('border', '1px solid red');
                $('[id$=txtPincode]').focus();
            }
            else {
                $('[id$=txtPincode]').css('border', '1px solid #ccc');
            }

            if (flag) {

                if (Pincode != "") {
                    $.ajax({
                        url: "PlaceOrder.aspx/CheckDelivery",
                        async: false,
                        data: '{Pincode:"' + Pincode + '"}',
                        contentType: "application/json; charset=utf-8",
                        type: "POST", // data has to be Posted 
                        timeout: 120000,
                        dataType: "json",
                        success: function (result) {
                           
                            var Ctr = parseInt(result.d);
                            if (Ctr > 0) {
                                $('#AddressSection').find('input[type=text]').each(function () {
                                    $(this).attr('disabled', 'disabled');
                                });
                                $('#PaymentSection').show();
                            }
                            else {
                                alert('Sorry ! Currently delivery is not availabe at provided location');
                                $('#PaymentSection').hide();
                                sessionStorage.setItem("ddlLocality", null);
                            }
                        }
                    });
                }


            }

            return false;

        }


        function CheckDelivery() {
            
            var txtPincode = $('[id$=txtPincode]').val().trim();
            if (txtPincode != "") {
                $.ajax({
                    url: "PlaceOrder.aspx/CheckDelivery",
                    async: false,
                    data: '{Pincode:"' + txtPincode + '"}',
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        var Ctr = parseInt(result.d);
                        if (Ctr > 0) {
                            return "1";
                        }
                        else {
                            return "0";
                        }
                    }
                });
            }
            else {
                return "0";
            }
        }

        function PlaceOrder() {
            

            var Name = $('[id$=txtName]').val().trim();
            var Mobile = $('[id$=txtMobile]').val().trim();
            var Building = $('[id$=txtBuilding]').val().trim();           
            var Locality = $("#ddlLocality option:selected").text();
            var City = $("#ddlCityMaster option:selected").text();
            var State = $("#ddlStateMaster option:selected").text();
            if (localStorage["ddlLocality"] === "null") {
            } else {
                Locality = localStorage["ddlLocality"];
                City = localStorage["ddlCityMaster"];
                State = localStorage["ddlStateMaster"];
            }

            var Pincode = $('[id$=txtPincode]').val().trim();
            var Amount = $('[id$=lblTotal]').text();

            $.ajax({
                url: "PlaceOrder.aspx/Order",
                async: true,
                data: JSON.stringify({ Name: Name, Mobile: Mobile, Building: Building, Locality: Locality, City: City, State: State, Pincode: Pincode, Amount: Amount }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    if (data.length > 0) {
                        window.location.href = "http://trendzshopping.in//Front/OrderSuccess.aspx?OrderId=" + data[0].OrderId;
                    }
                    else {
                        alert('Unable to process your request. Please try again later');
                    }
                }
            });

            return false;
        }

        function DeliverHere(ContactId, ctrl) {
             
            $(ctrl).parent().parent().css('background-color', '#f1f1f1');
            $('[id$=txtName]').val($('#spName_' + ContactId).html());
            $('[id$=txtMobile]').val($('#spMobile_' + ContactId).html());
            $('[id$=txtBuilding]').val($('#spBuilding_' + ContactId).html());
            $('[id$=txtPincode]').val($('#spPincode_' + ContactId).html());
            // $('[id$=ddlLocality]').val($('#spLocality_' + ContactId).html());
            //$('[id$=ddlCityMaster]').val($('#spCity_' + ContactId).html());
            //$('[id$=ddlStateMaster]').val($('#spState_' + ContactId).html());

            localStorage["ddlLocality"] = $('#spLocality_' + ContactId).html();
            localStorage["ddlCityMaster"] = $('#spCity_' + ContactId).html();
            localStorage["ddlStateMaster"] = $('#spState_' + ContactId).html();

            $('#AddressSection').hide();
            var Pincode = $('#spPincode_' + ContactId).html();
            // ValidateAddress();
            if (Pincode != "") {
                $.ajax({
                    url: "PlaceOrder.aspx/CheckDelivery",
                    async: false,
                    data: '{Pincode:"' + Pincode + '"}',
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        var Ctr = parseInt(result.d);
                        if (Ctr > 0) {
                            $('#AddressSection').find('input[type=text]').each(function () {
                                $(this).attr('disabled', 'disabled');
                            });
                            $('#PaymentSection').show();
                        }
                        else {
                            alert('Sorry ! Currently delivery is not availabe at provided location');
                            $('#PaymentSection').hide();
                            sessionStorage.setItem("ddlLocality", null);
                        }
                    }
                });
            }

        }
    </script>

    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: "POST",
                url: "PlaceOrder.aspx/GetStateMaster",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlStateMaster = $("[id*=ddlStateMaster]");
                    ddlStateMaster.empty().append('<option selected="selected" value="0">Please select state</option>');
                     
                    $.each(r.d, function () {
                        ddlStateMaster.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });


            $("[id*=ddlStateMaster]").change(function () {

                var stateID = $(this).val();

                $.ajax({
                    type: "POST",
                    url: "PlaceOrder.aspx/GetCityMasterByStateID",
                    data: JSON.stringify({ stateID: stateID }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddlCityMaster = $("[id*=ddlCityMaster]");
                        ddlCityMaster.empty().append('<option selected="selected" value="0">Please select</option>');
                         
                        $.each(r.d, function () {
                            ddlCityMaster.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }
                });

            });
            $("[id*=ddlCityMaster]").change(function () {
                 
                var CityID = $(this).val();

                $.ajax({
                    type: "POST",
                    url: "PlaceOrder.aspx/GetAreaMasterByCityID",
                    data: JSON.stringify({ CityID: CityID }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                         
                        var ddlLocality = $("[id*=ddlLocality]");
                        ddlLocality.empty().append('<option selected="selected" value="0">Please select</option>');

                        $.each(r.d, function () {
                            ddlLocality.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }
                });
            });

            $("[id*=ddlLocality]").change(function () {
                var pincode = $(this).val();
                $('[id$=txtPincode]').val(pincode);
            });
        });
    </script>

</asp:Content>
