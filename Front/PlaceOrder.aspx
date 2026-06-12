<%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.Master" AutoEventWireup="true" CodeBehind="PlaceOrder.aspx.cs" Inherits="FaduPrice.Pages.PlaceOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<script src="../Js/jquery.min.js"></script>--%>
    <style>
        .Header {
            text-align: left;
            background-color: #f1f1f1;
            color: #000;
            padding: 10px;
            font-size: 18px;
            margin-top: 25px;
            border: 1px solid #ccc;
        }

        .Section {
            text-align: left;
            padding: 25px;
            color: #999;
            font-size: 16px;
            border: 1px solid #ccc;
            box-shadow: 1px 4px 5px #999;
            margin-left: 0px !important;
            margin-right: 0px !important;
        }

        .MyControl {
            margin-top: 5px;
            font-size: 14px;
            color: #999;
        }

        input[type='radio'] {
            transform: scale(2);
        }

        .DelAddress {
            margin-top: 15px;
            margin-bottom: 15px;
        }
     

        @media (max-width: 768px) {

            .frm {
                margin-bottom:600px !important;
            }
        }
    </style>
    <div class="container frm" style="padding-bottom:120px; margin-bottom:400px;">
        <div class="col-md-8 col-xs-12">
            <div class="Header">
                Delivery Address
            </div>
            <div class="row">
                <asp:Repeater runat="server" ID="rptUserAddress">
                    <ItemTemplate>
                        <div class="col-md-6 col-xs-12 DelAddress">
                            <div style="border: 1px solid #ccc; background-color: #fff; padding: 15px;">
                                <p><strong><span id="<%#"spName_"+Eval("ContactId") %>"><%#Eval("Name") %> </span></strong></p>
                                <p><span id="<%#"spBuilding_"+Eval("ContactId") %>"><%#Eval("Building") %></span></p>
                                <p><span id="<%#"spLocality_"+Eval("ContactId") %>"><%#Eval("Locality") %></span></p>
                                <p><span id="<%#"spCity_"+Eval("ContactId") %>"><%#Eval("City") %></span>, <span id="<%#"spState_"+Eval("ContactId") %>"><%#Eval("State") %></span>-<span id="<%#"spPincode_"+Eval("ContactId") %>"><%#Eval("Pincode") %></span></p>
                                <p><span id="<%#"spMobile_"+Eval("ContactId") %>"><%# Convert.ToString(Eval("Mobile")) %> </p>
                                <p>
                                    <input type="button" style="background-color: #7C519B; color: #fff" class="btn" onclick="return DeliverHere(<%#Eval("ContactId") %>, this);" value="Deliver Here" />
                                    <input type="hidden" value="<%#Eval("ContactId") %>" />
                                </p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>



            </div>

            <div id="AddressSection" class="row Section">
                <div class="col-md-6 col-xs-12">
                    <asp:TextBox runat="server" ID="txtName" class="form-control MyControl" placeholder="Full Name" />
                </div>
                <div class="col-md-6 col-xs-12">
                    <asp:TextBox runat="server" ID="txtMobile" class="form-control MyControl" placeholder="Mobile" />

                </div>
                <div class="col-md-6 col-xs-12">
                    <asp:TextBox runat="server" ID="txtBuilding" class="form-control MyControl" placeholder="House Number/Building/Apartment" />

                </div>

                <div class="col-md-6 col-xs-12">
                    <%--<asp:TextBox runat="server" ID="txtCity" class="form-control MyControl" placeholder="City" />--%>

                    <select id="ddlStateMaster" class="form-control MyControl">
                    </select>

                </div>
                <div class="col-md-6 col-xs-12">
                    <select id="ddlCityMaster" class="form-control MyControl">
                    </select>
                    <%--<asp:TextBox runat="server" ID="txtState" class="form-control MyControl" placeholder="State" />--%>
                </div>
                <div class="col-md-6 col-xs-12">
                    <%--<asp:TextBox runat="server" ID="txtLocality" class="form-control MyControl" placeholder="Street/Locality/Area" />--%>
                    <select id="ddlLocality" class="form-control MyControl">
                    </select>
                </div>
                <div class="col-md-6 col-xs-12">
                    <asp:TextBox runat="server" ID="txtPincode" class="form-control MyControl" placeholder="Pincode" />
                </div>
                <div class="col-md-6 col-xs-12" style="text-align: center;">
                    <asp:Button runat="server" ID="btnAddress" class="btn btn-warning" OnClientClick="return ValidateAddress();" Style="margin-top: 5px; font-weight: 500; width: 100%;" Text="Deliver Here" />

                </div>
            </div>

            <div id="PaymentSection" style="display: none;">
                <div class="Header">
                    Payment Option
                </div>
                <div class="row Section">
                    <div class="col-md-6 col-xs-12">
                        <input type="radio" checked="checked" id="rdbCOD" />
                        <span style="margin-left: 15px;">Cash on delivery</span>
                        <p style="font-size: 12px; color: #09f; margin-top: 5px; margin-left: 30px;">Delivery by Monday, 22nd jan</p>
                    </div>
                    <div class="col-md-6 col-xs-12">
                        <asp:Button runat="server" ID="btnPlaceOrder" class="btn btn-primary" OnClientClick="return PlaceOrder();" Style="margin-top: 5px; font-weight: 500; width: 100%; background-color: #7c519b; background-image: none; border: 1px solid #7c519b" Text="Place Order" />

                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 hidden-xs">
            <div style="width: 100%; float: left;">

                <div class="Header">
                    Order Summary
                </div>
                <div class="row Section" style="min-height: 250px; font-size: 14px; color: #000;">
                    <asp:Repeater runat="server" ID="rptItems">
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-md-9">
                                    <p><%#Eval("ItemName") %></p>
                                    <p>Quantity : <%#Eval("ItemQuantity") %></p>

                                </div>
                                <div class="col-md-3" style="text-align: right;">
                                    <p><i class="fa fa-inr"></i><%#Eval("ItemPrice") %> </p>
                                </div>
                                <div class="col-md-12">
                                    <hr style="margin-top: 0px; margin-bottom: 10px;" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>


                    <div class="row">
                        <div class="col-md-9">
                            <p style="font-weight: 500">Delivery Charges</p>

                        </div>
                        <div class="col-md-3" style="text-align: right;">
                            <p style="color: green">Free</p>
                        </div>
                        <div class="col-md-12">
                            <hr style="margin-top: 0px; margin-bottom: 10px;" />
                        </div>
                    </div>
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-9">
                            <p><strong>Amount Payable</strong></p>

                        </div>
                        <div class="col-md-3" style="text-align: right;">
                            <p>
                                <strong><i class="fa fa-inr"></i>
                                    <asp:Label Text="0" ID="lblTotal" runat="server" />
                                </strong>
                            </p>
                        </div>

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
                        window.location.href = "https://myneedify.com//Front/OrderSuccess.aspx?OrderId=" + data[0].OrderId;
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
