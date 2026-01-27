<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Billing.aspx.cs" Inherits="WSBillingMaster.Pages.Billing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>--%>
    <script src="../Js/jquery-ui.js"></script>
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <link href="../Css/jquery.autocomplete.css" rel="stylesheet" />
    <script src="../Js/jquery-1.4.1.min.js"></script>
    <script src="../Js/jquery.autocomplete.js"></script>
    <style type="text/css">
        /*.ui-autocomplete-loading {
    background: white url("../../jquery/jquery-ui-1.11.4.custom/images/ui-anim_basic_16x16.gif") right center no-repeat;
  }*/
        .ui-autocomplete {
            max-height: 200px;
            max-width: 450px;
            overflow-y: auto; /* prevent horizontal scrollbar */
            overflow-x: hidden; /* add padding to account for vertical scrollbar */
            z-index: 1000 !important;
        }

        .alert {
            display: none;
            height: 50px;
            width: 220px;
            font-weight: bold;
            color: white;
            background-color: #04b076;
            float: right;
            top: 3em;
            padding: 10px;
            right: 1em;
            border-radius: 5px;
            position: absolute;
        }


        .ui-autocomplete-loading {
            background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
        }

        .ac_over {
            background-color: #09f;
            color: white;
        }

        .ac_results {
            width: 235px !important;
        }
    </style>
    <style>
        .MyModal {
            position: absolute;
            top: 0%;
            left: 30%;
        }

        .chosen-container {
            text-align: left !important;
        }

        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            top: 80px;
        }

        .modal-backdrop.in {
            filter: alpha(opacity=50);
            opacity: .5;
            z-index: 0;
        }

        .modal-body {
            position: relative;
            padding: 15px;
            max-height: 250px !important;
            overflow: auto !important;
        }


        .button {
            /*background-color: #4CAF50;*/ /* Green */
            border: none;
            color: white;
            padding: 8px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            background-color: #009ccc;
        }

        td {
            padding: 5px;
            font-size: 11px;
        }

        th {
            padding: 5px;
            font-size: 12px;
        }


        .GridViewHeaderStyle {
            border: solid 1px #C6DFF9;
            font-weight: bold;
            /*color: #000 !important;*/
            font-size: 8.5pt;
            background-color: #09f;
            color: #fff;
        }

        user agent stylesheet th {
            font-weight: bold;
            text-align: -internal-center;
        }
    </style>
    <div class="alert fade" style="position: absolute; left: 30%; border-radius: 15px; z-index: 11111">
        <p id="msgField" style="color: white; padding: 10px; font-weight: bold;"></p>
    </div>
    <%--  <Ajax:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackErrorMessage="Error...">
    </Ajax:ScriptManager>--%>
    <div class="container">
        <div style="width: 1300px; background-color: #ccc;">
            <%--<div class="content" style="text-align: left;">
                <b></b>
            </div>--%>
        </div>
        <div class="col-md-12">
            <div class="Header" style="padding: 5px;">
                <span>Product Billing</span>
                <span style="float: right; font-weight: 100; font-size: 12px; margin-top: 5px; margin-right: 10px;">
                    <asp:Label ID="lblDate" Text="19th Mar 2018" runat="server"></asp:Label>
                </span>
            </div>

            <div class="content" style="text-align: left; margin-top: 10px;">
                <div class="row">
                    <div class="col-md-4">
                        <div class="col-md-3">
                            <strong>Mobile</strong>
                        </div>
                        <div class="col-md-9 text-center">
                            <input type="text" id="txtMobile" onkeypress="return validateNumbers();" autocomplete="on" aria-autocomplete="none" maxlength="10" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="col-md-1">
                            <strong>Name</strong>
                        </div>
                        <div class="col-md-2 text-center" style="padding: 0px; margin: 0px;">
                            <asp:DropDownList ID="ddlTitle" class="form-control" runat="server" onchange="CheckGender();">
                                <asp:ListItem Value="1" Text="Mr."></asp:ListItem>
                                <asp:ListItem Value="2" Text="Mrs."></asp:ListItem>
                                <asp:ListItem Value="3" Text="Ms." ></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 text-center" style="padding: 0px; margin: 0px;">
                            <input type="text" id="txtName" maxlength="50" placeholder="First Name" class="form-control" />
                        </div>
                        <div class="col-md-4 text-center" style="padding: 0px; margin: 0px;">
                            <input type="text" id="txtLName" maxlength="50" placeholder="Last Name" class="form-control" />
                        </div>
                    </div>



                </div>
                <div class="row" style="padding-top: 15px;">
                    <div class="col-md-4">
                        <div class="col-md-3">
                            <strong>Email</strong>
                        </div>
                        <div class="col-md-9 text-center">
                            <input type="text" id="txtEmail" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="col-md-3">
                            <strong>Age</strong>
                        </div>
                        <div class="col-md-9 text-center">
                            <input type="text" id="txtAge" maxlength="2" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="col-md-2">
                            <strong>Gender</strong>
                        </div>
                        <div class="col-md-6 text-center">
                            <asp:DropDownList ID="ddlGender" class="form-control" runat="server">

                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>

                            </asp:DropDownList>

                        </div>
                    </div>



                </div>
                <div class="row" style="padding-top: 15px;">
                    <div class="col-md-4">
                        <div class="col-md-3">
                            <strong>Barcode</strong>
                        </div>
                        <div class="col-md-9 text-center">
                            <input type="text" id="txtBarcode" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <input id="btnSearch" type="button" value="Search" class="btn btn-success" style="width: 60%;" onclick="SearchData();" />&nbsp;
                    </div>


                </div>



            </div>
        </div>

        <div class="col-md-12">
            <div class="content" style="text-align: center;">
                <%--<div class="Header" style="padding: 0px; margin: 10px;text-align:left;padding-left:15px;">
                    <div>Billing (<asp:Label ID="lblTotalCount" Text="0" runat="server"></asp:Label>) </div>
                </div>--%>
                <div class="col-md-12" style="padding: 0px; margin-left: 10px; margin-top: 10px;">

                    <table style="width: 98.5%" id="tb_ItemList" class="GridViewStyle">
                        <tr id="saheader" style="height: 20px;">
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 50px;">Remove</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 50px;">SNo.</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 300px;">Name</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 100px;">Qty</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 200px;">Amount</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 200px;">Total</th>

                        </tr>
                    </table>
                    <div id="divDiscountsection" style="text-align: right; margin-top: 10px; display: none;">
                        <div style="margin-top: 12px; padding-right: 25px">
                            <div style="width: 90%; float: left; text-align: right">
                                <b><span style="margin-left: -20px;">Total :</span></b>
                            </div>
                            <div style="width: 10%; float: left; text-align: right">
                                <strong>₹ <span id="spanTotal"></span></strong>
                            </div>

                        </div>
                        <div style="padding-right: 20px; padding-left: 20px">
                            <div style="width: 90%; float: left; text-align: right">
                                <strong>Discount if Applicable:    </strong>
                                <asp:DropDownList ID="ddldiscount" Style="margin-left: 20px; margin-right: 15px;" onchange="DiscountChange();" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div style="width: 10%; float: left; text-align: right">

                              <b> ₹ </b>  <input type="text" id="txtManualDiscount" onkeypress="return validateNumbers();" maxlength="4" style="padding-right: 5px; display: none; font-weight: bold; width: 50px; text-align: right;" />
                              <strong><span style="padding-right: 6px; font-weight: bold" id="spnDiscountAmount">0.00</span></strong>
                            </div>

                        </div>
                        <div style="margin-top: 12px; padding-right: 25px">
                            <div style="width: 90%; float: left; text-align: right">
                                <b>Tax: </b>
                            </div>
                            <div style="width: 10%; float: left; text-align: right">
                                <b> ₹ <span id="spanTax">0.00</span></b>
                            </div>

                        </div>
                        <div style="margin-top: 12px; padding-right: 25px">
                            <div style="width: 90%; float: left; text-align: right">
                                <b>Grand Total:</b>
                            </div>
                            <div style="width: 10%; float: left; text-align: right">
                                <b> ₹ <span id="spanGrandTotal"></span></b>
                            </div>


                        </div>

                        <div style="margin-top: 12px; padding-right: 25px">
                            <div style="width: 90%; float: left; text-align: right">
                                <b>Payment Mode: </b>
                            </div>
                            <div style="width: 10%; float: left; text-align: right">
                                <select id="ddlPaymentMode" onchange="CheckTransactionType();" style="font-weight: 100; width: 90px;">
                                    <option value="1">Cash</option>
                                    <option value="2">Debit/Credit Card</option>
                                    <option value="3">Paytm</option>
                                </select>

                            </div>

                        </div>
                        <div style="margin-top: 12px; padding-right: 25px">
                            <div class="divTransaction" style="display: none;">
                                <div style="width: 90%; float: left; text-align: right">
                                    <strong>Transaction No:</strong>
                                </div>
                                <div style="width: 10%; float: left; text-align: right">
                                    <input type="text" id="txtTransactionId" style="font-weight: 100; width: 90px;" placeholder="Tnx. No" />
                                </div>
                            </div>
                        </div>

                        <div style="margin-top: 12px; padding-right: 25px; text-align: right;" class="divAmountRender">
                            <div style="width: 90%; float: left; text-align: right"><b>Paid Amount: </b></div>
                            <div style="width: 10%; float: left; text-align: right">
                               ₹   <input type="text" id="txtPaidAmount" onkeypress="return validateNumbers();" maxlength="5" style="font-weight: 100; width: 140px; width: 90px;" placeholder="Amount Paid" />
                            </div>

                        </div>
                        <div style="margin-top: 12px; padding-right: 25px; text-align: right;" class="divAmountRender">
                            <div style="width: 90%; float: left; text-align: right"><b>Amount Render: </b></div>
                            <div style="width: 10%; float: left; text-align: right">
                               ₹  <input type="text" id="txtAmountRender" readonly style="font-weight: 100; width: 90px;" placeholder="0.00" />

                            </div>
                        </div>
                    </div>
                    <div style="text-align: right; margin-top: 10px; padding-right: 25px; width: 100%; float: left;">
                        <input id="btnSave" type="button" onclick="savedata();" style="display: none;" value="Save" class="button" />&nbsp;
                        <input id="btnReset" type="button" onclick="Reset();" style="display: none;" value="Reset" class="button" />&nbsp;

                    </div>
                </div>

            </div>
        </div>
    </div>

    <%-- Customer Search Popup --%>
    <!-- Modal -->
    <div id="CustomerSearchPopUp" style="display: none;" class="MyModal">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" id="btnClose" onclick="HideModal();">&times;</button>
                    <h4 class="modal-title">Customer Search</h4>
                </div>
                <div class="modal-body">
                    <table id="tblCustomerSearch" style="width: 100%;" border="1">
                        <tr>
                            <th>Select
                            </th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>Age</th>
                            <th>Email</th>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>

                        </tr>
                    </table>
                </div>
                <%--<div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>--%>
            </div>

        </div>
    </div>
    <script>
        $(document).ready(function () {
            $("#txtBarcode").autocomplete("Search.ashx", {
                width: 200,
                formatItem: function (data, i, n, value) {
                    return "<img style = 'width:50px;height:50px' src='" + value.split(",")[1] + "'/> " + value.split(",")[0];
                },
                formatResult: function (data, value) {
                    return value.split(",")[0].split("#")[1];
                    $('[id$=btnSearch]').click();
                }
            });
        });
    </script>
    <script type="text/javascript">

        var a = 0;
        function TotalAmount1() {

            var TotalAmount = 0;
            var TotalGST = 0;
            var TotalCost = 0;


            $('#tb_ItemList').find('tr').each(function (index) {

                if (index > 0) {
                    var amount = $(this).find('[id$=txtTotal]').text();
                    var GST = $(this).find('[id$=txtGST]').text();
                    var Cost = $(this).find('[id$=txtTotalCost]').text();


                    if (amount != NaN)
                        TotalAmount = TotalAmount + parseInt(amount);

                    if (GST != NaN)
                        TotalGST = TotalGST + parseFloat(GST);

                    if (Cost != NaN)
                        TotalCost = TotalCost + parseFloat(Cost);
                }
            });

            $('[id$=spanTotal]').text(TotalCost);
            $('[id$=spanTax]').text(TotalGST);

        }

        function DiscountChange() {

            var Total = $('[id$=spanTotal]').text();
            var Discount = $('[id$=ddldiscount]').val();

            if (Discount == '-1') {
                $('[id$=spnDiscountAmount]').text('0.00');
                $('[id$=txtManualDiscount]').show();
                $('[id$=spnDiscountAmount]').hide();
                $('[id$=txtManualDiscount]').val('');

            } else {
                $('[id$=txtManualDiscount]').hide();
                $('[id$=spnDiscountAmount]').show();
                $('[id$=spnDiscountAmount]').text('0.00');
                var AmountAfterDiscount = (parseInt(Total) * parseInt(Discount)) / 100
                $('[id$=spnDiscountAmount]').text(AmountAfterDiscount);
                var Discountedvalue = $('[id$=spnDiscountAmount]').text();
                var Tax = $('[id$=spanTax]').text();
                var spanGrandTotal = ((parseInt(Total) - parseInt(Discountedvalue)) + parseInt(Tax));
                $('[id$=spanGrandTotal]').text(spanGrandTotal);
            }

        }
        function SetDiscount() {
            var Total = $('[id$=spanTotal]').text();
            var Disct = $('#txtManualDiscount').val().trim();
            if (parseInt(Disct) > parseInt(Total)) {
                alert('Discount amount cannot be allowed more than total amount');
                $('#txtManualDiscount').val('0');
                Disct = '0';
            }
            $('[id$=spnDiscountAmount]').text(Disct);
            var Discountedvalue = $('[id$=spnDiscountAmount]').text();
            var Tax = $('[id$=spanTax]').text();
            var spanGrandTotal = ((parseInt(Total) - parseInt(Discountedvalue)) + parseInt(Tax));
            $('[id$=spanGrandTotal]').text(spanGrandTotal);

        }
        function Reset() {
            window.location.reload();
        }
        function SearchData() {

            //$('#tb_ItemList tr').slice(1).remove();
            var Barcode = $('[id$=txtBarcode]').val().trim();

            if (Barcode != "") {
                $("#btnSearch").attr('disabled', 'disabled').val('Searching...');
                jQuery.ajax({
                    url: "Billing.aspx/SearchData",
                    data: JSON.stringify({ Barcode: Barcode }),
                    type: "POST",
                    timeout: 120000,
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        var Data = $.parseJSON(result.d);

                        if (result.d == "-1") {
                            $('#totalcount').html('0');
                            $("#btnSearch").removeAttr('disabled').val('Search');
                            //$.unblockUI();
                            alert('Your Session Expired.... Please Login Again');
                            var url = "../Pages/Login.aspx";
                            $(location).attr('href', url);
                            return;
                        }
                        if (result.d.length == 0) {
                            $("#btnSearch").removeAttr('disabled').val('Search');
                            $('#totalcount').html('0');
                            showerrormsg("No Record Found");
                            $('[Id$=DivTotalAmt]').css('display', 'none');
                            // $('[Id$=lblTotalCount]').text('0');

                            //$.unblockUI();
                            $('#btnsave').hide();
                            $('[id$=btnSave]').css('display', 'none');
                            $('[id$=btnReset]').css('display', 'none');
                            $('[id$=divDiscountsection]').css('display', 'none');


                            return;
                        }
                        else {
                            a++;
                            var TotalAmount = 0;
                            $("#btnSearch").removeAttr('disabled').val('Search');
                            //$.unblockUI();
                            $('#btnsave').show();
                            $('[id$=btnSave]').css('display', '');
                            $('[id$=btnReset]').css('display', '');
                            $('[id$=divDiscountsection]').css('display', '');


                            //for (var i = 0; i <= TestData.length - 1; i++) {
                            //    a++;
                            var mydata = "";
                            mydata += "<tr>";
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width:110px;font-size:12px;text-align:center"><img src="../Images/Delete.gif" id="remove" onclick="remove(this);">  </td>';

                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:12px;text-align:center;font-weight:bold">' + a + ' <input type="hidden" id="hdnBarcode" value="' + Data[0]["Barcode"] + '" /> </td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold"><input type="hidden"  id="hdnItemId"  value="' + Data[0]["ItemId"] + '" /> <span  id="lblName">' + Data[0]["ItemName"] + ' </span></td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:12px;"><select style="width:100%;" class="form-control" onchange="AmountAccToQuantity(this);" id="ddlQuantity">';
                            mydata += '<option>1</option><option>2</option><option>3</option><option>4</option><option>5</option>';
                            mydata += '<option>6</option><option>7</option><option>8</option><option>9</option></select>';

                            mydata += ' </td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold"><span  id="lblAmount">' + Data[0]["TotalCost"] + '</span></td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold"><span   id="txtTotal">' + Data[0]["TotalCost"] + '</span></td>';

                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold;display:none"><span  id="txtTotalCost">' + Data[0]["TotalCost"] + '</span></td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold;display:none"><span   id="txtGST">' + Data[0]["GST"] + '</span></td>';


                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold;display:none"><span  id="txtSingleItemCost">' + Data[0]["TotalCost"] + '</span></td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold;display:none"><span   id="txtSingleItemGST">' + Data[0]["GST"] + '</span></td>';

                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold;display:none"><span   id="txtFreight">' + Data[0]["Freight"] + '</span></td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold;display:none"><span   id="txtMisc">' + Data[0]["Misc"] + '</span></td>';



                            mydata += "</tr>";
                            $('#tb_ItemList').append(mydata);
                            TotalAmount1();
                            DiscountChange();
                            //}

                            $('[id$=txtBarcode]').val('');
                            $('[id$=txtBarcode]').focus();


                        }

                    },
                    error: function (xhr, status) {

                    }

                });
            }

        }

        function remove(ctrl) {

            $(ctrl).parent().parent().remove();
            TotalAmount1();
            DiscountChange();
            a--;
            return false;
        }

        function AmountAccToQuantity(id) {

            var TotalAmount = "0";
            var Quantity = $(id).closest('tr').find('[id$=ddlQuantity]').val();
            var amount = $(id).closest('tr').find('[id$=lblAmount]').text();

            var Cost = $(id).closest('tr').find('[id$=txtSingleItemCost]').text();
            var GST = $(id).closest('tr').find('[id$=txtSingleItemGST]').text();


            var TotalAmount = parseInt(Quantity * amount);

            var TotalCost = parseInt(Quantity * Cost);
            var TotalGST = parseInt(Quantity * GST);

            $(id).closest('tr').find('[id$=txtTotal]').text(TotalAmount);


            $(id).closest('tr').find('[id$=txtTotalCost]').text(TotalCost);
            $(id).closest('tr').find('[id$=txtGST]').text(TotalGST);

            TotalAmount1();
            DiscountChange();
        }


        function validation() {
            if ($('[id$=tb_ItemList]').find('[id$=txtEntAmount]').val() == "") {
                showerrormsg('Deposit amount cannot be empty');
                return false;
            }
            else {
                return true;
            }
        }

        function validateNumbers(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                }
                else if (e) {
                    var charCode = e.which;
                }
                else { return true; }
                if ((charCode > 47 && charCode < 58) || (charCode == 8))
                    return true;
                else
                    return false;

            }
            catch (err) {
                alert(err.Description);
            }
        }



    </script>

    <script>
        $(document).ready(function () {
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    $('[id$=btnSearch]').click();
                }
            });

            $("#txtMobile").keyup(function () {
                if ($("#txtMobile").val().trim().length == 10) {
                    SearchCustomer();
                }
            });

            $("#txtManualDiscount").keyup(function () {
                if ($("#txtManualDiscount").val().trim().length > 0) {
                    SetDiscount();
                }
            });

            $('#txtPaidAmount').keyup(function () {
                if ($('#txtPaidAmount').val().length > 0) {
                    $('#txtAmountRender').val(parseInt($('#txtPaidAmount').val().trim()) - parseInt($('#spanGrandTotal').text()));
                }
                else {
                    $('#txtAmountRender').val('');
                }
            });
        });

        function savedata() {

            if ($('[id$=tb_ItemList]').find('tr').length == 1) {
                showerrormsg('Please select an Item !');
                return;
            }

            var CustomerData = new Array();
            var LtData = new Array();
            var LtDetailData = new Array();


            var ObjLTData = new Object();


            var Mobile = $('[id$=txtMobile]').val().trim();
            var Name = $('[id$=txtName]').val().trim();
            var Gender = $('[id$=ddlGender] option:selected').text();
            var Age = $('[id$=txtAge]').val().trim();
            var Title = $('[id$=ddlTitle] option:selected').text().trim();
            var LName = $('[id$=txtLName]').val().trim();
            var Email = $('[id$=txtEmail]').val().trim();

            //------------------------------------------------
            if (Mobile == "") {
                $('[id$=txtMobile]').css('border', '1px solid red');
                showerrormsg('Enter Mobile No.');
                return;
            } else {
                $('[id$=txtMobile]').css('border', '1px solid #ccc');
            }

            if (Name == "") {
                $('[id$=txtName]').css('border', '1px solid red');
                showerrormsg('Enter Customer Name');
                return;
            } else {
                $('[id$=txtName]').css('border', '1px solid #ccc');
            }


            //------------------------------------------------

            var GrandTotal = $('[id$=spanGrandTotal]').text();
            var Discount = $('[id$=spnDiscountAmount]').text();
            var Tax = $('[id$=spanTax]').text();
            var NetAmount = $('[id$=spanTotal]').text();
            var PaymentMode = $('[id$=ddlPaymentMode]').val();


            var xml = "<Root>";
            $('[id$=tb_ItemList]').find('tr').each(function (index) {
                if (index > 0) {
                    xml += "<Node>";
                    xml += "<ItemId>" + $(this).find('#hdnItemId').val() + "</ItemId>";
                    xml += "<Quantity>" + $(this).find('#ddlQuantity').val() + "</Quantity>";
                    xml += "<Total>" + $(this).find('#txtTotal').text() + "</Total>";
                    xml += "<Barcode>" + $(this).find('#hdnBarcode').val() + "</Barcode>";
                    xml += "<TotalCost>" + $(this).find('#txtTotalCost').text() + "</TotalCost>";
                    xml += "<GST>" + $(this).find('#txtGST').text() + "</GST>";
                    xml += "<Freight>" + parseFloat($(this).find('#txtFreight').text()) * parseFloat($(this).find('#ddlQuantity').val()) + "</Freight>";
                    xml += "<Misc>" + parseFloat($(this).find('#txtMisc').text()) * parseFloat($(this).find('#ddlQuantity').val()) + "</Misc>";
                    xml += "</Node>";

                }
            });

            xml += "</Root>";

            $.ajax({
                url: "Billing.aspx/SaveBill",
                async: false,
                data: JSON.stringify({ Title: Title, LName: LName, Email: Email, Mobile: Mobile, Name: Name, Gender: Gender, Age: Age, GrandTotal: GrandTotal, Discount: Discount, Tax: Tax, NetAmount: NetAmount, PaymentMode: PaymentMode, LtDetail: xml }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var TransactionId = result.d;
                    if (TransactionId != "0") {
                        showmsg('Billing Successfully !');
                        window.open("BillReceipt.aspx?TransactionId=" + TransactionId);
                        Reset();
                    }
                    else {
                        showerrormsg('Some Error Occured, Please try again later!');
                    }

                }
            });

        }

        function CheckGender() {
            var Title = $('[id$=ddlTitle]').val();
            if (Title == "1") {
                $('[id$=ddlGender]').val('Male');
            }
            else if (Title == "2") {
                $('[id$=ddlGender]').val('Female');
            }
            else if (Title == "3") {
                $('[id$=ddlGender]').val('Female');
            }
        }


        function CheckTransactionType() {
            var PaymentMode = $('[id$=ddlPaymentMode]').val();
            if (PaymentMode == "1") {
                $('.divAmountRender').show();
                $('.divTransaction').hide();
                $('#txtPaidAmount').val('');
            }
            else {
                $('.divTransaction').show();
                $('.divAmountRender').hide();


            }
        }

        function SearchCustomer() {
            var Mobile = $('[id$=txtMobile]').val().trim();
            $.ajax({
                url: "Billing.aspx/SearchCustomer",
                async: false,
                data: JSON.stringify({ Mobile: Mobile }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    if (data.length > 0) {

                        $('#CustomerSearchPopUp').show();
                        $('#btnClose').focus();
                        $('#tblCustomerSearch tr').slice(1).remove();
                        for (var i = 0; i < data.length; i++) {
                            var html = '';
                            html += '<tr>';
                            html += '<td><input type="button" value="Select" onclick="SelectCustomer(this);"></td>';
                            html += '<td id="tdName">' + data[i].Title + ' ' + data[i].CustomerName + ' ' + data[i].LName + '</td>';
                            html += '<td id="tdGender">' + data[i].Gender + '</td>';
                            html += '<td id="tdAge">' + data[i].Age + '</td>';
                            html += '<td id="tdEmail">' + data[i].Email + '';
                            html += '<input type="hidden" id="hdnTitle" value="' + data[i].Title + '">';
                            html += '<input type="hidden" id="hdnName" value="' + data[i].CustomerName + '">';
                            html += '<input type="hidden" id="hdnLName" value="' + data[i].LName + '">';

                            html += '</td></tr>';
                            $('#tblCustomerSearch').append(html);

                        }

                    }
                    else {
                        alert("New Customer !");
                    }
                }
            });
        }

        function SelectCustomer(ctrl) {

            var Title = $("[id$=ddlTitle] option:contains('" + $(ctrl).closest('tr').find('#hdnTitle').val() + "')").val();
            var Gender = $("[id$=ddlGender] option:contains('" + $(ctrl).closest('tr').find('#tdGender').text() + "')").val();
            $('[id$=ddlTitle]').val(Title);
            $('[id$=txtName]').val($(ctrl).closest('tr').find('#hdnName').val());
            $('[id$=txtLName]').val($(ctrl).closest('tr').find('#hdnLName').val());
            $('[id$=txtEmail]').val($(ctrl).closest('tr').find('#tdEmail').text());
            $('[id$=ddlGender]').val(Gender);
            $('[id$=txtAge]').val($(ctrl).closest('tr').find('#tdAge').text())
            $('#CustomerSearchPopUp').hide();
        }

        function HideModal() {
            $('#CustomerSearchPopUp').hide();

        }
    </script>


</asp:Content>
