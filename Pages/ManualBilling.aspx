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
        /* Base typography & colors */
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --success: #10b981;
            --success-hover: #059669;
            --bg-body: #f3f4f6;
            --bg-card: #ffffff;
            --text-main: #111827;
            --text-muted: #6b7280;
            --border: #e5e7eb;
            --radius-md: 8px;
            --radius-lg: 12px;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        #billingContainer {
            font-family: var(--font-family);
            background-color: var(--bg-body);
            color: var(--text-main);
            padding-left: 24px;
            padding-right: 24px;
            padding-bottom: 24px;
            padding-top: 50px;
            max-width: 1400px;
            margin: 0 auto;
            -webkit-font-smoothing: antialiased;
        }

            #billingContainer::after {
                content: "";
                display: table;
                clear: both;
            }

        /* Layout Grid */
        .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
            padding-left: 12px;
            padding-right: 12px;
            box-sizing: border-box;
            float: left;
        }

        .col-md-3 {
            width: 25%;
        }

        .col-md-4 {
            width: 33.333333%;
        }

        .col-md-5 {
            width: 41.666667%;
        }

        .col-md-6 {
            width: 50%;
        }

        .col-md-8 {
            width: 66.666667%;
        }

        .col-md-9 {
            width: 75%;
        }

        .col-md-12 {
            width: 100%;
        }

        /* Card Panels */
        .content {
            background: var(--bg-card);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: 24px;
            margin-bottom: 24px;
            border: 1px solid var(--border);
        }

        .Header {
            background: var(--bg-card);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: 16px 24px;
            margin-bottom: 16px;
            border: 1px solid var(--border);
        }

            .Header::after {
                content: "";
                display: table;
                clear: both;
            }

            /* Headers */
            .Header span:first-child {
                font-size: 20px;
                font-weight: 600;
                color: var(--text-main);
            }

            .Header span:last-child {
                color: var(--text-muted);
                font-weight: 500;
                font-size: 14px;
                margin-top: 0 !important;
            }

        /* Inputs & Controls */
        .form-control, input[type="text"], select {
            width: 100%;
            padding: 0.625rem 0.875rem;
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            box-sizing: border-box;
            height: 42px;
            font-size: 14px;
            color: var(--text-main);
            background-color: var(--bg-card);
            transition: all 0.2s ease-in-out;
            margin-bottom: 16px;
            font-family: inherit;
        }

            .form-control:focus, input[type="text"]:focus, select:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
                outline: none;
            }

        strong {
            display: block;
            margin-bottom: 6px;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        /* Flex Row Utilities */
        .content .row {
            display: flex;
            flex-wrap: wrap;
            margin-left: -12px;
            margin-right: -12px;
        }

            .content .row > div {
                padding-left: 12px;
                padding-right: 12px;
                box-sizing: border-box;
            }

        .text-center {
            text-align: left !important;
        }

        /* Buttons */
        .button, .btn, input[type="button"] {
            border: none;
            color: white;
            padding: 0 1.25rem;
            text-align: center;
            font-size: 15px;
            font-weight: 500;
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all 0.2s ease-in-out;
            background-color: var(--primary);
            height: 42px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-family: inherit;
            line-height: 42px;
        }

            .button:hover, .btn:hover, input[type="button"]:hover {
                background-color: var(--primary-hover);
            }

        .btn-success {
            background-color: var(--success);
        }

            .btn-success:hover {
                background-color: var(--success-hover);
            }

        #btnReset {
            background-color: white;
            color: var(--text-main);
            border: 1px solid var(--border);
        }

            #btnReset:hover {
                background-color: #f9fafb;
                border-color: #d1d5db;
            }

        /* Table */
        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border-radius: var(--radius-md);
            border: 1px solid var(--border);
            margin-bottom: 24px;
            background: var(--bg-card);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            padding: 12px 16px;
            font-size: 13px;
            font-weight: 600;
            text-align: left;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            background-color: #f9fafb;
            color: var(--text-muted);
            border-bottom: 1px solid var(--border);
            white-space: nowrap;
        }

        td {
            padding: 16px;
            font-size: 14px;
            color: var(--text-main);
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .GridViewHeaderStyle {
            background-color: #f9fafb;
            color: var(--text-muted);
            border: none;
            border-bottom: 1px solid var(--border);
        }

        #tb_ItemList input[type="text"] {
            margin-bottom: 0;
            height: 36px;
            padding: 0.375rem 0.5rem;
            text-align: center;
        }

        /* Search Bar */
        .col-md-8 > .content > div:first-child {
            background: #f9fafb;
            padding: 16px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border);
            margin-bottom: 24px !important;
        }

        #txtBarcode {
            max-width: none !important;
            flex-grow: 1;
            margin-bottom: 0 !important;
        }

        #btnSearch {
            margin-bottom: 0 !important;
            width: auto !important;
            padding: 0 24px;
        }

        /* Summary Section */
        #divDiscountsection {
            background: #f9fafb;
            border-radius: var(--radius-md);
            padding: 24px;
            border: 1px solid var(--border);
            margin-top: 24px;
        }

        .summary-row {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 16px;
            font-size: 15px;
        }

            .summary-row:last-child {
                margin-bottom: 0;
            }

            .summary-row > div:first-child {
                width: 70%;
                text-align: right;
                padding-right: 24px;
                color: var(--text-muted);
            }

            .summary-row > div:last-child {
                width: 30%;
                text-align: right;
                font-weight: 600;
                color: var(--text-main);
                display: flex;
                justify-content: flex-end;
                align-items: center;
            }

        #divDiscountsection input, #divDiscountsection select {
            margin-bottom: 0;
            width: 140px !important;
            margin-left: 12px;
        }

        #spanGrandTotal {
            font-size: 20px;
            color: var(--text-main);
            font-weight: 700;
        }

        /* Modals / Autocomplete */
        .ui-autocomplete {
            max-height: 250px;
            max-width: 400px;
            overflow-y: auto;
            overflow-x: hidden;
            z-index: 1000 !important;
            background: var(--bg-card);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border);
            padding: 4px;
        }

        .ac_over, .ui-menu-item:hover {
            background-color: #f3f4f6;
            color: var(--primary);
            border-radius: 4px;
            cursor: pointer;
        }

        .MyModal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            background: rgba(0,0,0,0.5);
            backdrop-filter: blur(4px);
        }

        .modal-dialog {
            width: 100%;
            /*max-width: 600px;*/
            padding: 20px;
        }

        .modal-content {
            background: var(--bg-card);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            padding: 24px;
            position: relative;
        }

        .modal-header h4 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: var(--text-main);
        }

        .close {
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 24px;
            cursor: pointer;
            color: var(--text-muted);
            border: none;
            background: none;
            line-height: 1;
        }

        .alert {
            display: none;
            height: auto;
            width: 300px;
            font-weight: 500;
            color: white;
            background-color: var(--success);
            padding: 16px;
            border-radius: var(--radius-md);
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10000;
            box-shadow: var(--shadow-md);
        }

        .promocode {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 24px;
        }

            .promocode .button {
                width: auto;
                min-width: 120px;
                margin: 0;
            }

        /* MOBILE RESPONSIVE TWEAKS */
        @media (max-width: 768px) {
            .container-fluid {
                padding: 12px;
            }

            .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
                float: none;
                width: 100% !important;
                padding-left: 0;
                padding-right: 0;
            }

            .content .row {
                flex-direction: column;
                margin-left: 0;
                margin-right: 0;
            }

                .content .row > div {
                    width: 100% !important;
                    padding-left: 0;
                    padding-right: 0;
                }

            .content, .Header {
                padding: 16px;
                border-radius: var(--radius-md);
            }

            .col-md-8 > .content > div:first-child {
                flex-direction: column;
                align-items: stretch !important;
                gap: 12px;
            }

                .col-md-8 > .content > div:first-child strong {
                    margin-right: 0 !important;
                    line-height: 1;
                    margin-bottom: 4px;
                }

            #txtBarcode {
                width: 100% !important;
                margin-right: 0 !important;
            }

            #btnSearch {
                width: 100% !important;
            }

            #divDiscountsection {
                padding: 16px;
            }

            .summary-row {
                /*flex-direction: column;
                align-items: flex-start;*/
                gap: 8px;
                padding-bottom: 16px;
                border-bottom: 1px dashed var(--border);
            }

                .summary-row:last-child {
                    border-bottom: none;
                    padding-bottom: 0;
                }

                .summary-row > div:first-child {
                    width: 100%;
                    text-align: left;
                    padding-right: 0;
                }

                .summary-row > div:last-child {
                    width: 100%;
                    justify-content: flex-start;
                }

            #divDiscountsection input, #divDiscountsection select {
                margin-left: 0;
                margin-top: 4px;
                width: 100% !important;
                max-width: 100% !important;
            }

            .promocode {
                flex-direction: column;
                width: 100%;
            }

                .promocode .button {
                    width: 100%;
                }

            .table-responsive {
                border-radius: 0;
                border-left: none;
                border-right: none;
                margin-left: -16px;
                margin-right: -16px;
                width: calc(100% + 32px);
            }

            td {
                padding: 12px;
            }
        }
    </style>

    <div class="alert fade" style="position: absolute; left: 30%; border-radius: 15px; z-index: 11111">
        <p id="msgField" style="color: white; padding: 10px; font-weight: bold;"></p>
    </div>
    <%-- <Ajax:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackErrorMessage="Error..."> </Ajax:ScriptManager>--%>
    <div id="billingContainer" class="container-fluid">
        <div style="width: 100%; background-color: #ccc;"><%--<div class="content" style="text-align: left;"> <b></b> </div>--%> </div>
        <div class="col-md-4">
            <div class="Header" style="padding: 5px;">
                <span>Product Billing</span> <span style="float: right; font-weight: 100; font-size: 12px; margin-top: 5px; margin-right: 10px;">
                    <asp:Label ID="lblDate" Text="19th Mar 2018" runat="server"></asp:Label>
                </span>
            </div>
            <div class="content" style="text-align: left; margin-top: 10px;">
                <div class="row">
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Mobile</strong> </div>
                        <div class="col-md-12 col-xs-12 text-center">
                            <input type="text" id="txtMobile" onkeypress="return validateNumbers();" autocomplete="on" aria-autocomplete="none" maxlength="10" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-12 col-xs-12" style="display: flex; flex-wrap: wrap;">
                        <div class="col-md-12 col-xs-12"><strong>Name</strong> </div>
                        <div class="col-md-3 col-xs-12 text-center">
                            <asp:DropDownList ID="ddlTitle" class="form-control" runat="server" onchange="CheckGender();">
                                <asp:ListItem Value="1" Text="Mr."></asp:ListItem>
                                <asp:ListItem Value="2" Text="Mrs."></asp:ListItem>
                                <asp:ListItem Value="3" Text="Ms."></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 col-xs-12 text-center">
                            <input type="text" id="txtName" maxlength="50" placeholder="First Name" class="form-control" />
                        </div>
                        <div class="col-md-5 col-xs-12 text-center">
                            <input type="text" id="txtLName" maxlength="50" placeholder="Last Name" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row" style="padding-top: 15px;">
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Email</strong> </div>
                        <div class="col-md-12 col-xs-12 text-center">
                            <input type="text" id="txtEmail" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Age</strong> </div>
                        <div class="col-md-12 col-xs-12 text-center">
                            <input type="text" id="txtAge" maxlength="2" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Gender</strong> </div>
                        <div class="col-md-12 col-xs-12 text-center">
                            <asp:DropDownList ID="ddlGender" class="form-control" runat="server">
                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="col-md-12 col-xs-12"><strong>Sales Man</strong> </div>
                        <div class="col-md-12 col-xs-12 text-center">
                            <asp:DropDownList ID="ddlEmployee" class="form-control" runat="server">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="content" style="text-align: center;">
                <%--<div class="Header" style="padding: 0px; margin: 10px;text-align:left;padding-left:15px;"> <div>Billing (<asp:Label ID="lblTotalCount" Text="0" runat="server"></asp:Label>) </div> </div>--%>
                <div style="text-align: left; margin-bottom: 20px; display: flex; align-items: center; flex-wrap: wrap; clear: both;">
                    <strong style="margin-right: 10px;">Item</strong>
                    <input type="text" id="txtBarcode" class="form-control" style="flex-grow: 1; max-width: 300px; margin-right: 10px; margin-bottom: 0;" />
                    <input id="btnSearch" type="button" value="Search" class="btn btn-success" onclick="SearchData();" style="margin-bottom: 0;" />
                </div>
                <div style="width: 100%; clear: both; margin-top: 10px;">
                    <div class="table-responsive">
                        <table style="width: 100%" id="tb_ItemList" class="GridViewStyle">
                            <tr id="saheader">
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; width: 5%;">Remove</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; width: 5%;">SNo.</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: left; width: 40%;">Name</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; width: 15%;">Qty</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; width: 15%;">Amount</th>
                                <th class="GridViewHeaderStyle" scope="col" style="text-align: center; width: 20%;">Total</th>
                            </tr>
                        </table>
                        <div id="divDiscountsection" style="display: none;">
                            <div class="summary-row">
                                <div><b>Total :</b></div>
                                <div><strong>&#8377; <span id="spanTotal"></span></strong></div>
                            </div>
                            <div class="summary-row">
                                <div>
                                    <strong>Discount if Applicable: </strong>
                                    <asp:DropDownList ID="ddldiscount" onchange="DiscountChange();" runat="server"></asp:DropDownList>
                                </div>
                                <div>
                                    <b>&#8377; </b>
                                    <input type="text" id="txtManualDiscount" onkeypress="return validateNumbers();" maxlength="4" style="display: none;" />
                                    <strong><span id="spnDiscountAmount">0.00</span></strong>
                                </div>
                            </div>
                            <div class="summary-row">
                                <div><b>Tax: </b></div>
                                <div><b>&#8377; <span id="spanTax">0.00</span></b> </div>
                            </div>
                            <div class="summary-row">
                                <div><b>Grand Total:</b> </div>
                                <div><b>&#8377; <span id="spanGrandTotal"></span></b></div>
                            </div>
                            <div class="summary-row">
                                <div><b>Payment Mode: </b></div>
                                <div>
                                    <select id="ddlPaymentMode" onchange="CheckTransactionType();">
                                        <option value="1">Cash</option>
                                        <option value="2">Debit/Credit Card</option>
                                        <option value="3">Paytm</option>
                                    </select>
                                </div>
                            </div>
                            <div class="summary-row divTransaction" style="display: none;">
                                <div><strong>Transaction No:</strong> </div>
                                <div>
                                    <input type="text" id="txtTransactionId" placeholder="Tnx. No" />
                                </div>
                            </div>
                            <div class="summary-row divAmountRender">
                                <div><b>Paid Amount: </b></div>
                                <div>
                                    &#8377;
                                <input type="text" id="txtPaidAmount" onkeypress="return validateNumbers();" maxlength="5" placeholder="Amount Paid" />
                                </div>
                            </div>
                            <div class="summary-row divAmountRender">
                                <div><b>Amount Render: </b></div>
                                <div>
                                    &#8377;
                                <input type="text" id="txtAmountRender" readonly placeholder="0.00" />
                                </div>
                            </div>
                        </div>
                        <div class="promocode" style="text-align: right; margin-top: 10px; padding-right: 8px; width: 100%; float: left;">
                            <%--<p id="pHavePromo" style="display: visible;"><a href="#" style="color: #09f" onclick="OpenPromoPop();">Have Promocode?</a></p>
                        <p style="color: green; display: visible;" id="pPromoApplied"><span id="spnPromoApplied"></span>Applied Successfully! <a href="#" style="color: red" onclick="RemovePromocode();">Remove?</a></p>--%>
                            <input id="btnSave" type="button" onclick="savedata();" style="display: none;" value="Save" class="button" />&nbsp;
                        <input id="btnReset" type="button" onclick="Reset();" style="display: none;" value="Reset" class="button" />&nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%-- Customer Search Popup --%>
        <!-- Modal -->
        <%--<div id="CustomerSearchPopUp" style="display: visible;" class="MyModal">
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

        </div>
    </div>--%>
        <div id="CustomerSearchPopUp" style="display: none;" class="MyModal">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" id="btnClose" onclick="HideModal();">&times;</button>
                        <h4 class="modal-title">Customer Search</h4>
                    </div>
                    <div class="modal-body" style="overflow-x:auto;">
                        <table id="tblCustomerSearch" class="table-responsive" border="1">
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
                </div>
            </div>
        </div>
        <!-- Modal -->
        <%--<div id="divPromo" style="display: visible;" class="MyModal">
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
                <div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> </div> </div>
        </div>
    </div>--%>

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


                        if (!isNaN(parseFloat(amount)))
                            TotalAmount = TotalAmount + parseFloat(amount);

                        if (!isNaN(parseFloat(GST)))
                            TotalGST = TotalGST + parseFloat(GST);

                        if (!isNaN(parseFloat(Cost)))
                            TotalCost = TotalCost + parseFloat(Cost);
                    }
                });

                $('[id$=spanTotal]').text(TotalCost.toFixed(2));
                $('[id$=spanTax]').text(TotalGST.toFixed(2));

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
                    var AmountAfterDiscount = (parseFloat(Total) * parseFloat(Discount)) / 100
                    $('[id$=spnDiscountAmount]').text(AmountAfterDiscount.toFixed(2));
                    var Discountedvalue = $('[id$=spnDiscountAmount]').text();
                    var Tax = $('[id$=spanTax]').text();
                    var spanGrandTotal = ((parseFloat(Total) - parseFloat(Discountedvalue)) + parseFloat(Tax));
                    $('[id$=spanGrandTotal]').text(spanGrandTotal.toFixed(2));
                }

            }
            function SetDiscount() {
                var Total = $('[id$=spanTotal]').text();
                var Disct = $('#txtManualDiscount').val().trim();
                if (parseFloat(Disct) > parseFloat(Total)) {
                    alert('Discount amount cannot be allowed more than total amount');
                    $('#txtManualDiscount').val('0');
                    Disct = '0';
                }
                $('[id$=spnDiscountAmount]').text(parseFloat(Disct).toFixed(2));
                var Discountedvalue = $('[id$=spnDiscountAmount]').text();
                var Tax = $('[id$=spanTax]').text();
                var spanGrandTotal = ((parseFloat(Total) - parseFloat(Discountedvalue)) + parseFloat(Tax));
                $('[id$=spanGrandTotal]').text(spanGrandTotal.toFixed(2));

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
                        url: "ManualBilling.aspx/SearchData",
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

                                //$('#pHavePromo').show();
                                //$('#pPromoApplied').hide();
                                //for (var i = 0; i <= TestData.length - 1; i++) {
                                //    a++;
                                var mydata = "";
                                mydata += "<tr>";
                                mydata += '<td class="GridViewLabItemStyle" align="center"><img src="../Images/Delete.gif" id="remove" onclick="remove(this);" style="cursor: pointer;"></td>';
                                mydata += '<td class="GridViewLabItemStyle" align="center" style="font-weight:bold">' + a + ' <input type="hidden" id="hdnBarcode" value="' + Data[0]["Barcode"] + '" /> </td>';
                                mydata += '<td class="GridViewLabItemStyle" align="left" style="font-weight:bold"><input type="hidden" id="hdnItemId" value="' + Data[0]["ItemId"] + '" /> <span id="lblName">' + Data[0]["ItemName"] + ' </span></td>';
                                mydata += '<td class="GridViewLabItemStyle" align="center"><input type="text" style="width:100%; text-align:center; min-width: 50px;" class="form-control" onkeyup="AmountAccToQuantity(this);" onkeypress="return validateNumbers();" value="1" id="txtQuantity" /></td>';
                                mydata += '<td class="GridViewLabItemStyle" align="center" style="font-weight:bold"><input type="text" style="width:100%; text-align:center; min-width: 60px;" class="form-control" onkeyup="AmountAccToQuantity(this);" onkeypress="return validateNumbers();" value="0" id="txtAmount" /></td>';
                                mydata += '<td class="GridViewLabItemStyle" align="center" style="font-weight:bold"><span id="txtTotal">0</span></td>';

                                mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:14px;text-align:center;font-weight:bold;display:none"><span  id="txtTotalCost">0</span></td>';
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
                var Quantity = $(id).closest('tr').find('[id$=txtQuantity]').val();
                var amount = $(id).closest('tr').find('[id$=txtAmount]').val();

                var GST = $(id).closest('tr').find('[id$=txtSingleItemGST]').text();

                if (isNaN(Quantity) || Quantity == "") Quantity = 0;
                if (isNaN(amount) || amount == "") amount = 0;

                var TotalAmount = parseFloat(Quantity * amount);

                var TotalCost = parseFloat(Quantity * amount); // Use user-entered amount as the cost for billing
                var TotalGST = parseFloat(Quantity * GST);

                $(id).closest('tr').find('[id$=txtTotal]').text(TotalAmount.toFixed(2));


                $(id).closest('tr').find('[id$=txtTotalCost]').text(TotalCost.toFixed(2));
                $(id).closest('tr').find('[id$=txtGST]').text(TotalGST.toFixed(2));

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
                $('#CustomerSearchPopUp').hide();
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
                        var paid = parseFloat($('#txtPaidAmount').val().trim());
                        var grandTotal = parseFloat($('#spanGrandTotal').text());
                        if (!isNaN(paid) && !isNaN(grandTotal)) {
                            $('#txtAmountRender').val((paid - grandTotal).toFixed(2));
                        }
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
                var SalesManId = $('[id$=ddlEmployee]').val();

                if (isNaN($('#txtPaidAmount').val())) {
                    PaidAmount = 0;
                }

                var DiscPerItem = 0;
                if (parseFloat(Discount) > 0) {
                    DiscPerItem = parseFloat(Discount) / parseFloat($('[id$=tb_ItemList] tr').length - 1);
                }
                var xml = "<Root>";
                $('[id$=tb_ItemList]').find('tr').each(function (index) {
                    if (index > 0) {
                        var Qty = parseFloat($(this).find('#txtQuantity').val());
                        if (isNaN(Qty)) Qty = 0;
                        xml += "<Node>";
                        xml += "<ItemId>" + $(this).find('#hdnItemId').val() + "</ItemId>";
                        xml += "<Quantity>" + Qty + "</Quantity>";
                        xml += "<Total>" + $(this).find('#txtTotal').text() + "</Total>";
                        xml += "<Barcode>" + $(this).find('#hdnBarcode').val() + "</Barcode>";
                        xml += "<TotalCost>" + $(this).find('#txtTotal').text() + "</TotalCost>";
                        xml += "<GST>" + 0 + "</GST>";
                        xml += "<Freight>" + 0 + "</Freight>";
                        xml += "<Misc>" + 0 + "</Misc>";
                        xml += "<Discount>" + (DiscPerItem || 0) + "</Discount>";
                        xml += "</Node>";
                    }
                });

                xml += "</Root>";

                $.ajax({
                    url: "ManualBilling.aspx/SaveBill",
                    async: false,
                    data: JSON.stringify({ Title: Title, LName: LName, Email: Email, Mobile: Mobile, Name: Name, Gender: Gender, Age: Age, GrandTotal: GrandTotal, Discount: Discount, Tax: 0, NetAmount: NetAmount, PaymentMode: PaymentMode, PaidAmount: PaidAmount, LtDetail: xml, SalesManId: SalesManId }),
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
                            debugger;
                            $.ajax({
                                url: "ManualBilling.aspx/MarkDueEntry",
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
                            //var Promocode = $('#spnPromoApplied').text();
                            //if (Promocode != '') {
                            //    $.ajax({
                            //        url: "ManualBilling.aspx/SavePromoUsed",
                            //        async: true,
                            //        data: JSON.stringify({ Promocode: Promocode, Mobile: Mobile }),
                            //        contentType: "application/json; charset=utf-8",
                            //        type: "POST", // data has to be Posted 
                            //        timeout: 120000,
                            //        dataType: "json",
                            //        success: function (result) {

                            //        }
                            //    });
                            //}


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

            //function OpenPromoPop() {
            //    $('#divPromo').show();
            //    $('#txtPromocode').focus();
            //}
            //function ClosePromoPop() {
            //    $('#txtPromocode').val('');
            //    $('#divPromo').hide();
            //}

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
                                $('#tb_ItemList').find('#txtQuantity').attr('disabled', 'disabled');
                                $('#tb_ItemList').find('#txtAmount').attr('disabled', 'disabled');
                                //$('#pHavePromo').hide();
                                //$('#pPromoApplied').show();
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
                    //$('#pHavePromo').show();
                    //$('#pPromoApplied').hide();
                    $('#spnPromoApplied').text('');
                    $('#tb_ItemList').find('#remove').show();
                    $('#tb_ItemList').find('#txtQuantity').removeAttr('disabled');
                    $('#tb_ItemList').find('#txtAmount').removeAttr('disabled');
                    $('[id$=txtManualDiscount],[id$=ddldiscount]').removeAttr('disabled');
                    $('[id$=txtManualDiscount]').val('0');
                    SetDiscount();
                    $('#txtPromocode').val('');
                }
            }
        </script>
</asp:Content>
