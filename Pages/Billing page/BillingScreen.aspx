<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="BillingScreen.aspx.cs" Inherits="WSBillingMaster.Pages.BillingScreen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <style>
        .chosen-container {
            text-align: left !important;
        }

        .headingwidth {
        }

        .textbox {
            width: 170px;
            height: 12px;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
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

        .Purchaseheader1 {
            font-weight: bold;
            padding-left: 5px;
            /* color: maroon; */
            font-size: 10pt;
            text-align: left;
            margin-bottom: 4px;
            /* background-image: url(../App_Images/1.gif); */
            background-color: #009ccc;
            padding: 6px 9px;
            color: #fff;
        }

        .Header {
            font-weight: bold;
            text-align: right;
            /* color: maroon; */
            font-size: 10pt;
            /* background-image: url(../App_Images/1.gif); */
            background-color: #f2f2f2;
            padding: 2px;
        }

        .POuter_Box_Inventory1 {
            /*// border: solid 1px #303e54;*/
            float: left;
            clear: both;
            WIDTH: 995px;
            margin: 1px 1px 1px 1px;
            vertical-align: middle;
        }

        #Main {
            margin: 0px 10px 0px 10px;
            background-color: #f2f2f2;
            clear: both;
            width: 1000px;
            /*border: solid 1px #303e54;*/
            padding: 1px 1px 1px 1px;
            display: inline-block;
        }

        .GridViewHeaderStyle {
            border: solid 1px #C6DFF9;
            font-weight: bold;
            /*color: #000 !important;*/
            font-size: 8.5pt;
            background-image: url(../Images/headerBg.gif);
            background-repeat: repeat-x;
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
    <div id="Main" style="width: 1304px;">
        <div style="width: 1300px; background-color: #ccc;">
            <%--<div class="content" style="text-align: left;">
                <b></b>
            </div>--%>
        </div>
        <div class="POuter_Box_Inventory1" style="width: 1300px;">
            <div class="Purchaseheader1">
                Billing
            </div>
            <div style="text-align: right;">
                <asp:Label ID="lblDate" Text="19th Mar 2018" runat="server"></asp:Label>
            </div>
            <div class="content" style="text-align: left; margin-top: 10px;">
                <table width="50%">
                    <tr>

                        <td class="headingwidth">
                            <b>Mobile :</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMobile" onkeypress="return validateNumbers();" onpaste="return validateNumbers();" MaxLength="10" class="textbox" runat="server">
                            </asp:TextBox>
                        </td>
                        <td class="headingwidth">
                            <b>Name :</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtName" MaxLength="50" class="textbox" runat="server">
                            </asp:TextBox>
                        </td>

                    </tr>
                    <tr>

                        <td class="headingwidth">
                            <b>Gender :</b></td>
                        <td>
                            <asp:RadioButton ID="rdoMale" GroupName="a" Text="Male" MaxLength="10" class="textbox" runat="server"></asp:RadioButton>
                            <asp:RadioButton ID="rdoFemale" GroupName="a" Text="Female" MaxLength="10" class="textbox" runat="server"></asp:RadioButton>
                        </td>
                        <td class="headingwidth">
                            <b>Age :</b></td>
                        <td>
                            <asp:TextBox ID="txtAge" CssClass="textbox" MaxLength="2" runat="server">
                            </asp:TextBox>
                        </td>

                    </tr>
                    <tr>

                        <td class="headingwidth">
                            <b>Item :</b>
                        </td>
                        <td>

                            <input id="ddlInvestigation" size="50"  />

                        </td>
                        <td>
                            <input id="btnSearch" type="button" value="Search" class="button" onclick="SearchData();" />&nbsp;
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="POuter_Box_Inventory1" style="width: 1300px;">
            <div class="content" style="text-align: center;">
                <div class="Purchaseheader1">
                    <div>Billing(<asp:Label ID="lblTotalCount" Text="0" runat="server"></asp:Label>) </div>
                </div>
                <div style="width: 99%; overflow: auto; height: 410px;">

                    <table style="width: 99%" cellspacing="0" id="tb_ItemList" class="GridViewStyle">
                        <tr id="saheader" style="height: 20px;">
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: left; font-size: 13px;">Remove</th>
                            <th class="GridViewHeaderStyle" scope="col" style="width: 5%; text-align: left; font-size: 13px;">S.No.</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: left; font-size: 13px;">Name</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: left; font-size: 13px;">Qty</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: left; font-size: 13px;">Amount</th>
                            <th class="GridViewHeaderStyle" scope="col" style="text-align: left; font-size: 13px;">Total</th>

                        </tr>
                    </table>
                    <div id="divDiscountsection" style="text-align: right; margin-top: 10px; display: none;">
                        <div style="margin-top: 12px; padding-right: 25px">
                            <b><span style="margin-left: -20px;">Total :</span></b> <span id="spanTotal"></span>
                        </div>
                        <div style="padding-right: 20px; padding-left: 20px">
                            Discount if Applicable:    
                            <asp:DropDownList ID="ddldiscount" Style="margin-left: 20px;" onchange="DiscountChange();" runat="server">
                                <asp:ListItem Value="0">0%</asp:ListItem>
                                <asp:ListItem Value="5">5%</asp:ListItem>
                                <asp:ListItem Value="10">10%</asp:ListItem>
                                <asp:ListItem Value="15">15%</asp:ListItem>
                                <asp:ListItem Value="20">20%</asp:ListItem>
                                <asp:ListItem Value="30">30%</asp:ListItem>
                                <asp:ListItem Value="50">50%</asp:ListItem>
                            </asp:DropDownList>
                            <span style="padding-right: 28px" id="spnDiscountAmount"></span>
                        </div>
                        <div style="margin-top: 12px; padding-right: 25px">
                            <b>Tax: </b><span id="spanTax">50</span>
                        </div>
                        <div style="margin-top: 12px; padding-right: 25px">
                            <b>Grand Total: <span id="spanGrandTotal"></span></b>
                        </div>

                    </div>
                    <div style="text-align: right; margin-top: 10px;">
                        <input id="btnSave" type="button" onclick="savedata();" style="margin-right: 12px; display: none;" value="Save" class="button" />&nbsp;
                        <input id="btnReset" type="button" onclick="Reset();" style="margin-right: 12px; display: none;" value="Reset" class="button" />&nbsp;

                    </div>
                </div>

            </div>
        </div>
    </div>
    <script type="text/javascript">


        $(document).ready(function () {
            var config = {
                '.chosen-select': {},
                '.chosen-select-deselect': { allow_single_deselect: true },
                '.chosen-select-no-single': { disable_search_threshold: 10 },
                '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
                '.chosen-select-width': { width: "95%" }
            }
            for (var selector in config) {
                $(selector).chosen(config[selector]);
            }
            jQuery('#ddlUser').trigger('chosen:updated');
            //if ($('[id$=lblTotalCount]').val() = "0")
            //{
            //    $("input[type=text]").val("");
            //}

        });

        function TotalAmount1() {
            debugger
            var TotalAmount = 0;
            $('#tb_ItemList').find('tr').each(function (index) {
                debugger
                if (index > 0) {
                    var amount = $(this).find('[id$=txtTotal]').text();
                    if (amount != NaN)
                        TotalAmount = TotalAmount + parseInt(amount);
                }
            });

            $('[id$=spanTotal]').text(TotalAmount);
        }

        function DiscountChange() {

            var Total = $('[id$=spanTotal]').text();
            var Discount = $('[id$=ddldiscount]').val();
            var AmountAfterDiscount = (parseInt(Total) * parseInt(Discount)) / 100
            $('[id$=spnDiscountAmount]').text(AmountAfterDiscount);
            var Discountedvalue = $('[id$=spnDiscountAmount]').text();
            var Tax = $('[id$=spanTax]').text();
            var spanGrandTotal = ((parseInt(Total) - parseInt(Discountedvalue)) + parseInt(Tax));
            $('[id$=spanGrandTotal]').text(spanGrandTotal);
        }
        function Reset() {
            window.reload();
        }
        function SearchData() {

            //$('#tb_ItemList tr').slice(1).remove();
            $("#btnSearch").attr('disabled', 'disabled').val('Searching...');

            jQuery.ajax({
                url: "BillingScreen.aspx/SearchData",
                // data: '{Value:"' + $('[id$=ddlUser]').val() + '"}',
                data: '{}',
                type: "POST",
                timeout: 120000,
                async: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    //TestData = $.parseJSON(result.d);

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
                        $('[Id$=lblTotalCount]').text('0');

                        //$.unblockUI();
                        $('#btnsave').hide();
                        $('[id$=btnSave]').css('display', 'none');
                        $('[id$=btnReset]').css('display', 'none');
                        $('[id$=divDiscountsection]').css('display', 'none');


                        return;
                    }
                    else {
                        var a = 0;
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
                        mydata += '<td class="GridViewLabItemStyle" align="left" style="width:110px;font-size:12px;"><img src="../Images/Delete.gif" id="remove" onclick="remove(this);">  </td>';

                        mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:12px;">' + "1" + '</td>';
                        mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:12px;"><span  id="lblName">' + "Shoes" + ' </span></td>';
                        mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:12px;"><select onchange="AmountAccToQuantity(this);" id="ddlQuantity">';
                        mydata += '<option>1</option><option>2</option><option>3</option><option>4</option><option>5</option>';
                        mydata += '<option>6</option><option>7</option><option>8</option><option>9</option></select>';

                        mydata += ' </td>';
                        mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:12px;"><span  id="lblAmount">' + "1299" + '</span></td>';
                        mydata += '<td class="GridViewLabItemStyle" align="left" style="font-size:12px;"><span   id="txtTotal">' + "1299" + '</span></td>';
                        mydata += "</tr>";
                        $('#tb_ItemList').append(mydata);
                        TotalAmount1();
                        DiscountChange();
                        //}

                        //$('[Id$=lblTotalCount]').text(a);
                    }

                },
                error: function (xhr, status) {

                }

            });

        }
        function remove(ctrl) {

            $(ctrl).parent().parent().remove();
            TotalAmount1();
            DiscountChange();
            return false;
        }

        function AmountAccToQuantity(id) {
            debugger
            var TotalAmount = "0";
            var Quantity = $(id).closest('tr').find('[id$=ddlQuantity]').val();
            var amount = $(id).closest('tr').find('[id$=lblAmount]').text();
            var TotalAmount = parseInt(Quantity * amount);
            $(id).closest('tr').find('[id$=txtTotal]').text(TotalAmount);
            TotalAmount1();
            DiscountChange();
        }





        function savedata() {

            if (validation() == false) {
                return false;
            }

            var Employee_ID_By = $('[id$=tb_ItemList]').find('[id$=lblName]').text();
            var EmpId = $('[id$=tb_ItemList]').find('[id$=lblEmpId]').text();
            var PrevAmount = $('[id$=tb_ItemList]').find('[id$=lblPreviousBalance]').text();
            var CollectionAmount = $('[id$=tb_ItemList]').find('[id$=txtGetAmount]').text();
            var Deposit = $('[id$=tb_ItemList]').find('[id$=txtEntAmount]').val();
            var Date = $('[id$=tb_ItemList]').find('[id$=lblDepositat]').text();

            var BookingAmount = parseInt(CollectionAmount);
            var IsDoOrNot = confirm('Are you sure.......!');
            if (!IsDoOrNot) {
                return false;
            }
            $.ajax({
                url: "CollectionSummary.aspx/SaveData",
                async: false,
                data: '{EmpId:"' + EmpId + '",BookingAmount:"' + BookingAmount + '",Deposit:"' + Deposit + '",Date:"' + Date + '"}',
                contentType: "application/json; charset=utf-8",
                type: "POST",
                timeout: 120000,
                dataType: "json",
                success: function (result) {

                    if (result.d == "1") {
                        alert('Save successfully');
                        SearchData();
                    }
                    else {
                        alert('Contact IT Dose');
                    }
                }
            });
        }
        function showmsg(msg) {
            $('#msgField').html('');
            $('#msgField').append(msg);
            $(".alert").css('background-color', '#04b076');
            $(".alert").removeClass("in").show();
            $(".alert").delay(1500).addClass("in").fadeOut(1000);
        }
        function showerrormsg(msg) {
            $('#msgField').html('');
            $('#msgField').append(msg);
            $(".alert").css('background-color', 'red');
            $(".alert").removeClass("in").show();
            $(".alert").delay(1500).addClass("in").fadeOut(1000);
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


        function Export() {

            var UserId = $('[id$=ddlUser]').val();
            $.ajax({
                url: "CollectionSummary.aspx/Export",
                async: false,
                data: '{UserId:"' + UserId + '"}',
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        window.open("../Common/ExportToExcel.aspx");
                    }
                }
            });


        }
    </script>

    <asp:HiddenField ID="hdn1" runat="server" />
</asp:Content>
