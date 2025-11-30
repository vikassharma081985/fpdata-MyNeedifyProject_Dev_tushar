<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="PromoMaster.aspx.cs" Inherits="WSBillingMaster.Pages.PromoMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .MyTable {
            border: 1px solid #000;
            padding: 2px;
        }
    </style>
    <div class="container">

        <div class="Header" style="height: 550px;">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                Promotional Code Master
            </div>
            <div class="col-md-6 col-lg-6 col-xs-12" style="text-align: left;">

                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    Group Name
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12">
                    <asp:TextBox ID="txtGroupName" Style="padding-left: 10px; width: 90%;" MaxLength="20" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    No of Promocodes
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12">
                    <asp:TextBox ID="txtPromoNumbers" Style="padding-left: 10px; width: 90%;" MaxLength="3" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    Min Transaction Required
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12">
                    <asp:TextBox ID="txtMinTransaction" Style="padding-left: 10px; width: 90%;" MaxLength="4" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    Discount Amount
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12">
                    <asp:TextBox ID="txtCashbackAmount" Style="padding-left: 10px; width: 90%;" MaxLength="3" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    ValidTill
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12">
                    <asp:TextBox ID="txtValidTill" Style="padding-left: 10px; width: 90%;" class="datepicker" runat="server"></asp:TextBox>
                </div>

                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    <asp:Button ID="btnSave" runat="server" Style="width: 42%;" OnClientClick="return Save();" Text="Save" CssClass="btn btn-primary" />
                    <asp:HiddenField ID="hdnDiscountId" runat="server" Value="0" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xs-12" style="text-align: left;">
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    SMS Template
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12">
                    <asp:TextBox ID="txtSMSText" Style="padding-left: 10px; width: 90%; height: 150px; font-weight: 500" Text="xxxxx offer! Get flat xxx on min purchase of xxxx by sharing {promocode} at counter. Offer valid till xxxxxx." MaxLength="163" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>

    </div>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script>
        $(function () {
            $(".datepicker").datepicker(
                { dateFormat: 'dd-M-yy' }
            );
        });

        $(document).ready(function () {

            $('#txtBarcode').focus();
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    return false;
                }
            });

        });

        function isNumberKey(evt) {
            debugger
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            else {
                // alert($(this).val());
                return true;
            }
        }

        function Save() {
            $('[id$=btnSave]').val('Saving...');
            var GroupName = $('[id$=txtGroupName]').val().trim();
            var PromocodeNumbers = $('[id$=txtPromoNumbers]').val().trim();
            var MinTransactionRequired = $('[id$=txtMinTransaction]').val().trim();
            var CashbackAmount = $('[id$=txtCashbackAmount]').val().trim();
            var ValidTill = $('[id$=txtValidTill]').val().trim();
            var SMSText = $('[id$=txtSMSText]').val().trim();


            var errMsg = '';

            if (SMSText.indexOf('{promocode}') < 0) {
                errMsg += 'SMS Template should contains {promocode} \n';
            }

            if (GroupName == '') {
                errMsg += 'Enter Group Name\n';
            }
            if (PromocodeNumbers == '') {
                errMsg += 'Enter Promocode Numbers\n';
            }
            if (MinTransactionRequired == '') {
                errMsg += 'Enter Min. Transaction Amount\n';
            }
            if (CashbackAmount == '') {
                errMsg += 'Enter Cashback Amount\n';
            }
            if (ValidTill == '') {
                errMsg += 'Enter Valid Till\n';
            }

          
            if (errMsg.length > 0) {
                alert(errMsg);
                $('[id$=btnSave]').val('Save');


            } else {
                $.ajax({
                    url: "PromoMaster.aspx/Save",
                    async: true,
                    data: JSON.stringify({ GroupName: GroupName, PromocodeNumbers: PromocodeNumbers, MinTransactionRequired: MinTransactionRequired, CashbackAmount: CashbackAmount, ValidTill: ValidTill, SMSText: SMSText }),
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "1") {
                            alert('Record Saved Successfully');
                            Clear();
                        }
                        $('[id$=btnSave]').val('Save');

                    }
                });
            }

            return false;

        }

        function Clear() {
            $('input').val('');
            $('[id$=txtSMSText]').val('xxxxx offer! Get flat xxx on min purchase of xxxx by sharing {promocode} at counter. Offer valid till xxxxxx.');
        }

    </script>
</asp:Content>
