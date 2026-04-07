<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ManualBilling.aspx.cs" Inherits="WSBillingMaster.Pages.ManualBilling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>--%>
    <!-- IMPORTANT: jQuery must be loaded BEFORE jquery-ui.js. I moved/added the jQuery include above jquery-ui to avoid runtime errors. (No lines removed from your original file — just ensured correct order.) -->
    <script src="../Js/jquery-1.4.1.min.js"></script>
    <script src="../Js/jquery-ui.js"></script>
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <link href="../Css/jquery.autocomplete.css" rel="stylesheet" />
    <script src="../Js/jquery.autocomplete.js"></script>
    <style type="text/css">
        /*.ui-autocomplete-loading { background: white url("../../jquery/jquery-ui-1.11.4.custom/images/ui-anim_basic_16x16.gif") right center no-repeat; }*/ .ui-autocomplete {
            max-height: 200px;
            max-width: 450px;
            overflow-y: auto; /* prevent horizontal scrollbar */
            overflow-x: hidden; /* add padding to account for vertical scrollbar */
            z-index: 1000 !important;
        }

        .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
            .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12

        {
            float: left;
            padding-left: 0px;
        }


            .col-md-6 {
        width: 75%;
    }
                                                                                                                                                    

        .Header {
            margin-top: 40px;
            margin-bottom: 02%;
            text-align: left;
                    margin-left: -10px;
                    margin-right: 124px;
        }

        .content{
            margin-top: 40px;
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
            font-size: 8.5pt;
            background-color: #09f;
            color: #fff;
        }

        user agent stylesheet th {
            font-weight: bold;
            text-align: -internal-center;
        }

        @media (max-width: 768px) {

            .container-fluid {
                padding-left: 5px;
                padding-right: 5px;
            }

            .Header span {
                margin-bottom: 5px;
            }

            .row .col-md-4, .row .col-md-8, .row .col-md-2, .row .col-md-6, .row .col-md-1, .row .col-md-3, .row .col-md-9 {
                width: 100% !important;
                margin-bottom: 10px;
                float: none !important;
                display: block !important;
                padding-left: 0px !important;
                padding-right: 8px !important;
            }
            /* Make all labels sit above inputs */

            .row strong {
                display: block !important;
                width: 100% !important;
                margin-bottom: 4px !important;
                text-align: left !important;
            }

            input[type="text"], select, .form-control {
                width: 100% !important;
                max-width: 100% !important;
                margin-bottom: 10px;
                box-sizing: border-box !important;
                display: block !important;
            }

            #btnSearch {
                width: 97% !important;
                margin-left: 5px;
                margin-right: 5px;
                margin-top: 10px;
            }

            .table-responsive {
                width: 100%;
                margin-bottom: 15px;
                overflow-y: hidden;
                -ms-overflow-style: -ms-autohiding-scrollbar;
                border: 1px solid #ddd;
            }

                .table-responsive table {
                    margin-bottom: 0;
                    width: 100% !important;
                }

                .table-responsive th, .table-responsive td {
                    white-space: nowrap;
                    font-size: 10px;
                    padding: 8px 4px !important;
                }

            #divDiscountsection div[style*="float: left"] {
                float: none !important;
                width: 100% !important;
                text-align: left !important;
                margin-bottom: 10px;
            }

            #divDiscountsection input, #divDiscountsection select {
                width: 100% !important;
                max-width: 100% !important;
                height: 30px;
            }

            #divDiscountsection .divTransaction, .divAmountRender {
                text-align: left !important;
            }

            #pHavePromo, #btnSave, #btnReset {
                text-align: center !important;
            }

            .MyModal {
                left: 0 !important;
                width: 100% !important;
            }

            .modal-content {
                width: 95% !important;
                margin: 10px auto !important;
                top: 0 !important;
            }

            #divPromo .modal-content {
                width: 95% !important;
            }

            #tblCustomerSearch th, #tblCustomerSearch td {
                font-size: 9px;
                padding: 5px !important;
            }


.modal-dialog {
    position: relative;
    width: auto;
    margin-top: 150px;
}
            .ac_results {
                width: 100% !important;
                max-width: 300px;
            }

            .ui-autocomplete {
                max-width: 100% !important;
            }

            .alert {
                width: 90% !important;
                left: 5% !important;
                right: auto !important;
                float: none !important;
            }
        }

        @media (max-width: 480px) {
            th, td {
                font-size: 9px !important;
                padding: 4px !important;
            }

            .button {
                padding: 6px 12px;
                font-size: 14px;
                width: 100% !important;
                padding-left: 5px;
            }

            #ddlPaymentMode, #txtTransactionId, #txtPaidAmount, #txtAmountRender, #txtManualDiscount, #txtPromocode {
                width: 100% !important;
                max-width: 100% !important;
            }
        }
    </style>
    <style>
        /* Keep original markup unchanged — these overrides just improve alignment */ 
        .content .row {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            margin-bottom: 8px;
        }

            .content .row > .col-md-4, .content .row > .col-md-8, .content .row > .col-md-6, .content .row > .col-md-2 {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
            }

            .content .row .col-md-3, .content .row .col-md-2, .content .row .col-md-1 {
                display: flex;
                align-items: center;
                justify-content: flex-end;
                padding-right: 8px;
                box-sizing: border-box;
            }

            .content .row .col-md-9, .content .row .col-md-6, .content .row .col-md-4 {
                padding-left: 0;
            }

        .content input.form-control, .content select.form-control, .content input[type="text"] {
            width: 100%;
            max-width: 100%;
        }

        #btnSearch {
            width: 60%;
        }

        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .MyModal {
            left: 30%;
            top: 0;
        }

        @media (max-width:768px) {
            .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
    .content {
margin-top: 0px;

             }
            .Header {
                margin-top: 08%;
                margin-bottom: 04%;
                 margin-left: -8px !important;
            margin-right: 8px !important;
            }
            .content .row {
                display: block;
            }

                .content .row .col-md-3, .content .row .col-md-2, .content .row .col-md-1 {
                    text-align: left;
                    justify-content: flex-start;
                    padding-right: 0;
                    margin-bottom: 5px;
                }

            #btnSearch {
                width: 97% !important;
            }

            .alert {
                left: 5% !important;
                width: 90% !important;
            }

            .MyModal {
                left: 0 !important;
                width: 100% !important;
            }

            .modal-content {
                width: 95% !important;
                margin: 10px auto !important;
                top: 0 !important;
            }
            .promocode{
                text-align: center !important;
            }
        }
    </style>
    <div class="alert fade" style="position: absolute; left: 30%; border-radius: 15px; z-index: 11111">
        <p id="msgField" style="color: white; padding: 10px; font-weight: bold;"></p>
    </div>
    <%-- <Ajax:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackErrorMessage="Error..."> </Ajax:ScriptManager>--%>
    <div class="container-fluid">
        <div style="width: 100%; background-color: #ccc;"><%--<div class="content" style="text-align: left;"> <b></b> </div>--%> </div>
        <div class="col-md-4">
            <div class="Header" style="padding: 5px;"><span>Product Billing</span> <span style="float: right; font-weight: 100; font-size: 12px; margin-top: 5px; margin-right: 10px;">
                <asp:Label ID="lblDate" Text="19th Mar 2018" runat="server"></asp:Label>
            </span></div>
            <div class="content" style="text-align: left; margin-top: 10px;">
                <div class="row">
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Mobile</strong> </div>
                        <div class="col-md-9 col-xs-12 text-center">
                            <input type="text" id="txtMobile" onkeypress="return validateNumbers();" autocomplete="on" aria-autocomplete="none" maxlength="10" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Name</strong> </div>
                        <div class="col-md-2 col-xs-12 text-center" style="padding: 0px; margin: 0px;">
                            <asp:DropDownList ID="ddlTitle" class="form-control" runat="server" onchange="CheckGender();">
                                <asp:ListItem Value="1" Text="Mr."></asp:ListItem>
                                <asp:ListItem Value="2" Text="Mrs."></asp:ListItem>
                                <asp:ListItem Value="3" Text="Ms."></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 col-xs-12 text-center" style="padding: 0px; margin: 0px; width:118px;">
                            <input type="text" id="txtName" maxlength="50" placeholder="First Name" class="form-control" />
                        </div>
                        <div class="col-md-4 col-xs-12 text-center" style="padding: 0px; margin: 0px; width:118px;">
                            <input type="text" id="txtLName" maxlength="50" placeholder="Last Name" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row" style="padding-top: 15px;">
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Email</strong> </div>
                        <div class="col-md-9 col-xs-12 text-center">
                            <input type="text" id="txtEmail" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Age</strong> </div>
                        <div class="col-md-9 col-xs-12 text-center">
                            <input type="text" id="txtAge" maxlength="2" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Gender</strong> </div>
                        <div class="col-md-6 col-xs-12 text-center">
                            <asp:DropDownList ID="ddlGender" class="form-control" runat="server">
                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="col-md-12 col-xs-12">
    <div class="col-md-12 col-xs-12"><strong>Sales Man</strong> </div>
    <div class="col-md-6 col-xs-12 text-center">
        <asp:DropDownList ID="DropDownList1" class="form-control" runat="server">
            <asp:ListItem Text="Sales" Value="Sales"></asp:ListItem>
            <asp:ListItem Text="IT" Value="IT"></asp:ListItem>
        </asp:DropDownList>
    </div>
</div>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="content" style="text-align: center;"><%--<div class="Header" style="padding: 0px; margin: 10px;text-align:left;padding-left:15px;"> <div>Billing (<asp:Label ID="lblTotalCount" Text="0" runat="server"></asp:Label>) </div> </div>--%>
             <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 10px;">
    
    <strong>Barcode</strong>

    <input type="text" id="txtBarcode" class="form-control" style="width: 200px;" />

   <%-- <input id="btnSearch" type="button" value="Search" 
           class="btn btn-success" onclick="SearchData();" />--%>

    <input id="btnadd" type="button" value="Add" 
           class="btn btn-primary" onclick="addData();" />

</div>
                <div class="col-md-12" style="padding: 0px; margin-top: 10px;">
                    <div class="table-responsive">
                        <table style="width: 100%" id="tb_ItemList" class="GridViewStyle">
                            <tr id="saheader" style="height: 20px;">
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 50px;">Remove</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 50px;">SNo.</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 300px;">Name</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 100px;">Qty</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 200px;">Amount</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; font-size: 13px; width: 200px;">Total</th>
                            </tr>
                        </table>
<div id="divDiscountsection" style="margin-top: 10px;">
    <table style="width: 100%; border-collapse: collapse;" class="GridViewStyle">

        <!-- Total -->
        <tr>
            <td colspan="5" style="text-align: right; padding: 8px;"><b>Total :</b></td>
            <td style="text-align: right; padding: 8px;">
                <strong>₹ <span id="spanTotal"></span></strong>
            </td>
        </tr>

        <!-- Discount -->
        <tr>
            <td colspan="5" style="text-align: right; padding: 8px;">
                <strong>Discount if Applicable:</strong>
            </td>
            <td style="text-align: right; padding: 8px;">
                <asp:DropDownList ID="ddldiscount" onchange="DiscountChange();" runat="server"></asp:DropDownList>
                ₹ 
                <input type="text" id="txtManualDiscount" onkeypress="return validateNumbers();" maxlength="4"
                       style="display: none; font-weight: bold; width: 50px; text-align: right;" />
                <strong><span id="spnDiscountAmount">0.00</span></strong>
            </td>
        </tr>

        <!-- Tax -->
        <tr>
            <td colspan="5" style="text-align: right; padding: 8px;"><b>Tax:</b></td>
            <td style="text-align: right; padding: 8px;">
                <b>₹ <span id="spanTax">0.00</span></b>
            </td>
        </tr>

        <!-- Grand Total -->
        <tr>
            <td colspan="5" style="text-align: right; padding: 8px;"><b>Grand Total:</b></td>
            <td style="text-align: right; padding: 8px;">
                <b>₹ <span id="spanGrandTotal"></span></b>
            </td>
        </tr>

        <!-- Payment Mode -->
        <tr>
            <td colspan="5" style="text-align: right; padding: 8px;"><b>Payment Mode:</b></td>
            <td style="text-align: right; padding: 8px;">
                <select id="ddlPaymentMode" onchange="CheckTransactionType();" style="width: 140px;">
                    <option value="1">Cash</option>
                    <option value="2">Debit/Credit Card</option>
                    <option value="3">Paytm</option>
                </select>
            </td>
        </tr>

        <!-- Transaction -->
        <tr class="divTransaction">
            <td colspan="5" style="text-align: right; padding: 8px;"><strong>Transaction No:</strong></td>
            <td style="text-align: right; padding: 8px;">
                <input type="text" id="txtTransactionId" style="width: 140px;" placeholder="Tnx. No" />
            </td>
        </tr>

        <!-- Paid Amount -->
        <tr class="divAmountRender">
            <td colspan="5" style="text-align: right; padding: 8px;"><b>Paid Amount:</b></td>
            <td style="text-align: right; padding: 8px;">
                ₹ 
                <input type="text" id="txtPaidAmount" onkeypress="return validateNumbers();" maxlength="5"
                       style="width: 140px;" placeholder="Amount Paid" />
            </td>
        </tr>

        <!-- Amount Render -->
        <tr class="divAmountRender">
            <td colspan="5" style="text-align: right; padding: 8px;"><b>Amount Render:</b></td>
            <td style="text-align: right; padding: 8px;">
                ₹ 
                <input type="text" id="txtAmountRender" readonly style="width: 140px;" placeholder="0.00" />
            </td>
        </tr>

    </table>
</div>
                    <div class="promocode" style="text-align: right; margin-top: 10px; padding-right: 8px; width: 100%; float: left;">
                        <p id="pHavePromo" style="display: visible;"><a href="#" style="color: #09f" onclick="OpenPromoPop();">Have Promocode?</a></p>
                        <p style="color: green; display: visible;" id="pPromoApplied"><span id="spnPromoApplied"></span>Applied Successfully! <a href="#" style="color: red" onclick="RemovePromocode();">Remove?</a></p>
                        <input id="btnSave" type="button" onclick="savedata();" style="display: none;" value="Save" class="button" />&nbsp;
                        <input id="btnReset" type="button" onclick="Reset();" style="display: none;" value="Reset" class="button" />&nbsp; </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Customer Search Popup --%>
    <!-- Modal -->
    <div id="CustomerSearchPopUp" style="display: visible;" class="MyModal">
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
                            <th>Select </th>
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
                <%--<div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> </div>--%> </div>
        </div>
    </div>
    <!-- Modal -->
    <div id="divPromo" style="display: visible;" class="MyModal">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width: 48%;">
                <div class="modal-header">
                    <button type="button" class="close" id="Button1" onclick="ClosePromoPop();">&times;</button>
                    <h4 class="modal-title">Apply Promocode</h4>
                </div>
                <div class="modal-body">
                    <table style="width: 100%">
                        <tr>
                            <td class="text-left">
                                <input type="text" placeholder="Enter Promocode here" id="txtPromocode" />
                            </td>
                            <td class="text-center">
                                <input type="button" value="Apply" onclick="CheckPromo();" style="background-color: #09f; color: #fff; border: 1px solid #009ccc" />
                            </td>
                        </tr>
                    </table>
                </div>
                <%--<div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> </div>--%> </div>
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

                            $('#pHavePromo').show();
                            $('#pPromoApplied').hide();
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
            var PaidAmount = $('#txtPaidAmount').val();
            if (isNaN($('#txtPaidAmount').val())) {
                PaidAmount = 0;
            }


            var DiscPerItem = 0;
            if (parseInt(Discount) > 0) {
                DiscPerItem = parseFloat(Discount) / parseFloat($('[id$=tb_ItemList] tr').length - 1);
            }
            var perItemDisc = parseInt($('[id$=spnDiscountAmount]').text()) / $('[id$=tb_ItemList] tr').length - 1;
            var xml = "<Root>";
            $('[id$=tb_ItemList]').find('tr').each(function (index) {
                if (index > 0) {
                    var Qty = parseFloat($(this).find('#ddlQuantity').val());

                    for (var i = 0; i < Qty; i++) {
                        xml += "<Node>";
                        xml += "<ItemId>" + $(this).find('#hdnItemId').val() + "</ItemId>";
                        xml += "<Quantity>1</Quantity>";
                        xml += "<Total>" + parseFloat($(this).find('#txtTotal').text()) / Qty + "</Total>";
                        //xml += "<Total>" + parseFloat($('#spanGrandTotal').text()) / Qty + "</Total>";
                        xml += "<Barcode>" + $(this).find('#hdnBarcode').val() + "</Barcode>";
                        xml += "<TotalCost>" + parseInt($('#spanGrandTotal').text()) / Qty + "</TotalCost>";
                        xml += "<GST>" + parseInt($(this).find('#txtGST').text()) + "</GST>";
                        xml += "<Freight>" + parseFloat($(this).find('#txtFreight').text()) + "</Freight>";
                        xml += "<Misc>" + parseFloat($(this).find('#txtMisc').text()) + "</Misc>";
                        if (DiscPerItem != 0) {
                            xml += "<Discount>" + parseFloat(DiscPerItem) / Qty + "</Discount>";

                        } else {
                            xml += "<Discount>0</Discount>";
                        }

                        xml += "</Node>";
                    }
                }
            });

            xml += "</Root>";

            $.ajax({
                url: "Billing.aspx/SaveBill",
                async: false,
                data: JSON.stringify({ Title: Title, LName: LName, Email: Email, Mobile: Mobile, Name: Name, Gender: Gender, Age: Age, GrandTotal: GrandTotal, Discount: Discount, Tax: Tax, NetAmount: NetAmount, PaymentMode: PaymentMode, PaidAmount: PaidAmount, LtDetail: xml }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    debugger;
                    //alert(result.d);
                    var TransactionId = result.d.split('^')[0];
                    var ReceiptId = result.d.split('^')[1];
                    if (TransactionId != "0") {
                        //alert(TransactionId);
                        //---------Check Due Amount------------

                        $.ajax({
                            url: "Billing.aspx/MarkDueEntry",
                            async: false,
                            data: JSON.stringify({ TransactionId: TransactionId, Mobile: Mobile, Name: Name, GrandTotal: GrandTotal, PaidAmount: PaidAmount, ReceiptId: ReceiptId }),
                            contentType: "application/json; charset=utf-8",
                            type: "POST", // data has to be Posted 
                            timeout: 120000,
                            dataType: "json",
                            success: function (result) {

                            }
                        });
                        //--------------------------------------


                        showmsg('Billing Successfully !');
                        var Promocode = $('#spnPromoApplied').text();
                        if (Promocode != '') {
                            $.ajax({
                                url: "Billing.aspx/SavePromoUsed",
                                async: true,
                                data: JSON.stringify({ Promocode: Promocode, Mobile: Mobile }),
                                contentType: "application/json; charset=utf-8",
                                type: "POST", // data has to be Posted 
                                timeout: 120000,
                                dataType: "json",
                                success: function (result) {

                                }
                            });
                        }


                        window.open("BillReceipt.aspx?TransactionId=" + TransactionId);
                        Reset();
                    }
                    else {
                        showerrormsg('Some Error Occured, Please try again later!');
                    }

                }
            });

            //-------

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

            $.ajax({
                url: "Billing.aspx/CheckPromoAvailable",
                async: true,
                data: JSON.stringify({ Mobile: $('#txtMobile').val() }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d != "")
                        alert(result.d);
                }
            });
        }

        function HideModal() {
            $('#CustomerSearchPopUp').hide();

        }

        function OpenPromoPop() {
            $('#divPromo').show();
            $('#txtPromocode').focus();
        }
        function ClosePromoPop() {
            $('#txtPromocode').val('');
            $('#divPromo').hide();
        }

        function CheckPromo() {
            $.ajax({
                url: "Billing.aspx/CheckPromo",
                async: true,
                data: JSON.stringify({ Promocode: $('#txtPromocode').val(), TotalAmount: $('#spanGrandTotal').text() }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d != "") {
                        var ret = result.d
                        var CashbackAmount = ret.split('#')[0];
                        var MinTransactionRequired = ret.split('#')[1];
                        if (parseFloat(MinTransactionRequired) > parseFloat($('#spanGrandTotal').text())) {
                            alert('to apply this promocode minimum amount should be Rs. ' + MinTransactionRequired);
                        } else {
                            $('[id$=ddldiscount]').val('-1');
                            DiscountChange();
                            $('[id$=txtManualDiscount]').val(parseInt(CashbackAmount));
                            $('[id$=txtManualDiscount],[id$=ddldiscount]').attr('disabled', 'disabled');
                            SetDiscount();
                            $('#divPromo').hide();
                            $('#tb_ItemList').find('#remove').hide();
                            $('#tb_ItemList').find('#ddlQuantity').attr('disabled', 'disabled');
                            $('#pHavePromo').hide();
                            $('#pPromoApplied').show();
                            $('#spnPromoApplied').text($('#txtPromocode').val());
                            $('#txtPromocode').val('');
                            alert('Promocode applied successfully');
                        }

                    } else {
                        alert("Invalid Promocode");
                    }
                }
            });
        }

        function RemovePromocode() {
            if (confirm('Are you sure?')) {
                $('#pHavePromo').show();
                $('#pPromoApplied').hide();
                $('#spnPromoApplied').text('');
                $('#tb_ItemList').find('#remove').show();
                $('#tb_ItemList').find('#ddlQuantity').removeAttr('disabled');
                $('[id$=txtManualDiscount],[id$=ddldiscount]').removeAttr('disabled');
                $('[id$=txtManualDiscount]').val('0');
                SetDiscount();
                $('#txtPromocode').val('');
            }
        }
    </script>


</asp:Content>
