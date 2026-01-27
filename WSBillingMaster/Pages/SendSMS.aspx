<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="SendSMS.aspx.cs" Inherits="WSBillingMaster.Pages.SendSMS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <style>
            #ContentPlaceHolder1_ddlCustomers td {
                padding: 5px;
            }
        </style>
        <div class="Header" style="height: auto;">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: left; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                Send Promotional SMS
            </div>
            <div class="container text-left" style="padding-bottom: 0px; margin-top: -30px;">
                <div class="col-xs-12 col-md-5 col-sm-5 col-lg-5 row top-buffer" style="border-right: 1px solid #ccc;">

                    <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace">
                        Mobile Number(s) <font color="red">*</font>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <asp:TextBox ID="txtMobile" CssClass="form-control" TextMode="MultiLine" Height="100px" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace ">
                        SMS<font color="red"> *</font>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <asp:TextBox ID="txtSMS" CssClass="form-control" TextMode="MultiLine" Height="100px" runat="server"></asp:TextBox>
                        <span style="font-weight: 100; color: #999;"><span id="spnChar">160</span> characters left</span>

                    </div>



                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 TopSpace" style="margin-top: 35px;">
                        <div class="col-xs-6 col-md-6 col-sm-6 col-lg-6" style="padding-left: 0px;">
                            <asp:Button ID="btnSend" runat="server" Text="Send SMS" OnClick="btnSend_Click" OnClientClick="return Validate();" />
                        </div>

                    </div>



                </div>

                <div class="col-xs-12 col-md-7 col-sm-7 col-lg-7 row top-buffer">


                    <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc; margin-left: 2%;">
                        Send Group SMS to Existing Customers
                    </div>
                    <div class="row" style="padding-left: 30px;">
                        <div class="col-md-12 col-lg-12 col-xs-12 text-left" style="font-weight: bold; padding-top: 20px;">
                            Group
                        </div>
                        <div class="col-md-12 col-lg-12 col-xs-12 text-left">
                            <asp:DropDownList ID="ddlGroup" runat="server" Style="font-weight: 500; color: #000;" onchange="BindNumbers();"></asp:DropDownList>
                        </div>
                        <div class="col-md-12 col-lg-12 col-xs-12 text-left" style="font-weight: bold; padding-top: 20px;">
                            Customers
                        </div>
                        <div class="col-md-12 col-lg-12 col-xs-12 text-center" style="border: 1px solid #ccc; margin-left: 15px; width: 97%; min-height: 100px;" id="divMobile">
                        </div>
                        <div class="col-md-12 col-lg-12 col-xs-12 text-left" style="font-weight: bold; padding-top: 20px;">
                            <input type="button" value="Send" onclick="Send();" id="btnSendGroupSMS" />

                        </div>
                    </div>

                </div>


            </div>
        </div>

    </div>
    <script>
        $(document).ready(function () {

            $('[id$=txtSMS]').keyup(function () {

                var textLen = parseInt($('[id$=txtSMS]').val().trim().length);

                if (textLen > 0)
                    $('#spnChar').text(160 - textLen);


            });
        });

        function Validate() {
            var SMS = $('[id$=txtSMS]').val().trim();
            var Mobile = $('[id$=txtMobile]').val().trim();

            if (Mobile == "") {
                alert('Please enter any mobile number');
                return false;
            }
            if (SMS == "") {
                alert('Please enter SMS');
                return false;
            }
        }


        function BindNumbers() {
            $('#divMobile').html('');

            $.ajax({
                url: "SendSMS.aspx/BindNumbers",
                async: true,
                data: JSON.stringify({ GroupName: $('[id$=ddlGroup]').val() }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    $.each(data, function (index, val) {
                        var html = '';
                        html += '<div style="float:left;padding:5px;width:20%;font-weight:500;font-size:12px;"><input type="checkbox" value="' + val.Mobile + '">' + val.Mobile + '</div>';
                        $('#divMobile').append(html);
                    });
                }
            });
        }

        function Send()
        {
            if ($('#divMobile').find('input[type=checkbox]').filter(':checked').length > 0)
            {
                var PromoGroup = $('[id$=ddlGroup]').val();
                $('#btnSendGroupSMS').val('Sending ...');
                $('#divMobile').find('input[type=checkbox]').filter(':checked').each(function (index) {
                    $.ajax({
                        url: "SendSMS.aspx/SendGroupSMS",
                        async: false,
                        data: JSON.stringify({ PromoGroup: PromoGroup,Mobile:$(this).val() }),
                        contentType: "application/json; charset=utf-8",
                        type: "POST", // data has to be Posted 
                        timeout: 120000,
                        dataType: "json",
                        success: function (result) {
                            
                        }
                    });
                });
                alert('Send Successfully');
                $('#divMobile').html('');
                $('[id$=ddlGroup]').val('0');
                $('#btnSendGroupSMS').val('Send');

            }
        }
    </script>
</asp:Content>
