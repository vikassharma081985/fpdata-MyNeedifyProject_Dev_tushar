<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="AmountSettlement.aspx.cs" Inherits="WSBillingMaster.AmountSettlement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="Header">
            Amount Settlement
        </div>
        <div style="padding-top: 1em;"></div>
        <div class="content" style="padding-top: 1em; border: 1px solid !important;">
            <div class="row">
                <div class="col-md-4">
                    <div class="col-md-3">
                        <strong>Mobile</strong>
                    </div>
                    <div class="col-md-9 text-center">
                        <input type="text" id="txtMobile" onkeypress="return validateNumbers();" autocomplete="on" aria-autocomplete="none" maxlength="10" class="form-control" disabled="disabled" />
                        <input type="hidden" id="hdnCustomerId" value="" />
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="col-md-1">
                        <strong>Name</strong>
                    </div>
                    <div class="col-md-2 text-center" style="padding: 0px; margin: 0px;">
                        <select id="ddlTitle" class="form-control" disabled="disabled">
                            <option value="1">Mr.</option>
                            <option value="2">Mrs.</option>
                            <option value="3">Ms.</option>
                        </select>
                    </div>
                    <div class="col-md-4 text-center" style="padding: 0px; margin: 0px;">
                        <input type="text" id="txtName" maxlength="50" placeholder="First Name" class="form-control" disabled="disabled" />
                    </div>
                    <div class="col-md-4 text-center" style="padding: 0px; margin: 0px;">
                        <input type="text" id="txtLName" maxlength="50" placeholder="Last Name" class="form-control" disabled="disabled" />
                    </div>
                </div>
            </div>
            <div class="row" style="padding-top: 15px;">
                <div class="col-md-4">
                    <div class="col-md-3">
                        <strong>Email</strong>
                    </div>
                    <div class="col-md-9 text-center">
                        <input type="text" id="txtEmail" class="form-control" disabled="disabled" />
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="col-md-3">
                        <strong>Age</strong>
                    </div>
                    <div class="col-md-9 text-center">
                        <input type="text" id="txtAge" maxlength="2" class="form-control" disabled="disabled" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-md-2">
                        <strong>Gender</strong>
                    </div>
                    <div class="col-md-6 text-center">
                        <select id="ddlGender" class="form-control" disabled="disabled">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div style="padding-top: 1em;"></div>
        <div class="content" style="padding-top: 1em; border: 1px solid !important;">
            <div class="row" style="padding-top: 15px;">
                <div class="col-md-4">
                    <div class="col-md-4">
                        <strong>Invoice No.</strong>
                    </div>
                    <div class="col-md-8 text-center">
                        <input type="text" id="txtInvoice" class="form-control" disabled="disabled" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-md-5">
                        <strong>Payment Date</strong>
                    </div>
                    <div class="col-md-7 text-center">
                        <input type="text" id="txtPaymentDate" class="form-control" disabled="disabled" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-md-4">
                        <strong>Net Amount</strong>
                    </div>
                    <div class="col-md-8 text-center">
                        <input type="number" id="txtNetAmount" class="form-control" disabled="disabled" />
                    </div>
                </div>

            </div>
            <div class="row" style="padding-top: 15px;">
                <div class="col-md-4">
                    <div class="col-md-5">
                        <strong>Paid Amount</strong>
                    </div>
                    <div class="col-md-7 text-center">
                        <input type="number" id="txtPaidAmount" class="form-control" disabled="disabled" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-md-5">
                        <strong>Due Amount</strong>
                    </div>
                    <div class="col-md-7 text-center">
                        <input type="number" id="txtDueAmount" class="form-control" disabled="disabled" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-md-5">
                        <strong>Paid Through</strong>
                    </div>
                    <div class="col-md-7 text-center">
                        <input type="text" id="txtPaymentModeforPaidAmt" class="form-control" disabled="disabled" />
                    </div>
                </div>
            </div>
            <div class="row" style="padding-top: 15px;">
                <div class="col-md-4">
                    <div class="col-md-5">
                        <strong>Settlement Amount<span style="color: red;">*</span></strong>
                    </div>
                    <div class="col-md-7 text-center">
                        <input type="number" id="txtSettlementAmount" class="form-control" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-md-5">
                        <strong>Payment Mode</strong>
                    </div>
                    <div class="col-md-7 text-center">
                        <select id="ddlPaymentMode" class="form-control">
                            <option value="1">Cash</option>
                            <option value="2">Debit/Credit Card</option>
                            <option value="3">Paytm</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4" style="display: none;" id="dvPaytm">
                    <div class="col-md-5">
                        <strong>DC/CC/Paytm No.<span style="color: red;">*</span></strong>
                    </div>
                    <div class="col-md-7 text-center">
                        <input type="number" id="txtpaytmNum" class="form-control" maxlength="16" />
                    </div>
                </div>
            </div>
            <div class="row" style="padding-top: 15px;">
                <div class="col-md-6">
                    <div class="col-md-4">
                        <strong>Comments<span style="color: red;">*</span></strong>
                    </div>
                    <div class="col-md-8">
                        <textarea id="txtComments" class="form-control"></textarea>
                    </div>
                </div>
                <div class="col-md-3"></div>
                <div class="col-md-3">
                    <button id="btnBackToDue" class="btn btn-primary form-control" style="display: none;">Back</button>
                    <button id="btnSettlement" class="btn btn-primary form-control">OK</button>
                </div>
            </div>
        </div>
    </div>
    <script src="../Js/jquery.min.js"></script>
    <script src="../Js/Custom/AmountSettlement.js"></script>
    
</asp:Content>
