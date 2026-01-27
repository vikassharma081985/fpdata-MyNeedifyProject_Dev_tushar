<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Settlement.aspx.cs" Inherits="WSBillingMaster.Pages.Settlement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <style>
            #tblData th {
                background-color: #09f;
                color: #fff;
                border: 1px solid #ccc;
                padding: 3px;
            }

            #tblData td {
                background-color: whitesmoke;
                color: #000;
                border: 1px solid #ccc;
                padding: 3px;
            }
        </style>
        <div class="Header">
            Amount Settlement
        </div>
        <div class="Content">
            <table style="width: 100%">
                <tr>
                    <td style="width: 20%;">From Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 20%;">To Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 20%;">Mobile#</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 20%;"></td>

                </tr>
                <tr>
                    <td style="width: 20%;">
                        <asp:TextBox runat="server" class="form-control datepicker" ReadOnly="true" ID="txtFromDate"></asp:TextBox>

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 20%;">
                        <asp:TextBox runat="server" class="form-control datepicker" ReadOnly="true" ID="txtToDate" />

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 20%;">
                        <asp:TextBox runat="server" class="form-control" ID="txtMobile" />

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 20%;">
                        <asp:Button ID="btnSearch" runat="server" class="btn-danger" Text="Search" OnClientClick="return Search();" />
                    </td>

                </tr>
            </table>
        </div>

        <div class="Content" style="max-height: 400px; overflow: auto; display: none" id="divData">
            <table width="100%">
                <tr>
                    <td style="text-align: right; padding: 10px;"><strong>Total Due : </strong><span id="spnDueAmount"></span></td>
                </tr>
            </table>
            <table id="tblData" width="100%">
                <tr>
                    <th>SNo.</th>
                    <th>Name</th>
                    <th>Mobile</th>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Remarks</th>
                    <th>Settle</th>
                    <th>SMS</th>

                </tr>
            </table>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog" style="top: 20%">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Amount Settlement</h4>
                </div>
                <div class="modal-body">
                    <table style="width: 100%">
                        <tr>
                            <td style="text-align: right">Amount : </td>
                            <td style="text-align: center">
                                <input type="text" id="txtAmount" />
                            </td>

                        </tr>
                        <tr>
                            <td style="text-align: right">Remarks : </td>
                            <td style="text-align: center">
                                <input type="text" id="txtRemarks" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center; padding: 10px;">
                                <input type="button" class="btn-danger" value="Save" onclick="SaveSettlement();" />
                                <input type="hidden" id="hdnSettlementId" />

                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>



    <div class="modal fade" id="SMSModal" role="dialog">
        <div class="modal-dialog" style="top: 20%">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send Reminder SMS</h4>
                </div>
                <div class="modal-body">
                    <table style="width: 100%">
                        <tr>
                            <td style="text-align: right">Mobile : </td>
                            <td style="text-align: center">
                                <input type="text" id="txtSMSMobile" style="width:300px;" />
                            </td>

                        </tr>
                        <tr>
                            <td style="text-align: right">SMS Text : </td>
                            <td style="text-align: center">
                                <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="txtSMSText" Style="height: 95px; width: 300px; word-wrap: break-word;"
                                    MaxLength="160"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center; padding: 10px;">
                                <input type="button" class="btn-danger" value="Save" onclick="SendSMS();" />
                                <input type="hidden" id="Hidden1" />

                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script>
        $(function () {
            $(".datepicker").datepicker({
                dateFormat: 'dd-M-yy'
            });
        });

        $(document).ready(function () {
            Search();
        });

        function Search() {
            $('#tblData tr').slice(1).remove();
            $('#spnDueAmount').text('0');
            var FromDate = $('[id$=txtFromDate]').val();
            var ToDate = $('[id$=txtToDate]').val();
            var Mobile = $('[id$=txtMobile]').val();

            $.ajax({
                url: "Settlement.aspx/Search",
                async: true,
                data: JSON.stringify({ FromDate: FromDate, ToDate: ToDate, Mobile: Mobile }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    if (data.length > 0) {
                        var TotalDue = 0;
                        $.each(data, function (index, val) {
                            var html = '<tr>';
                            html += '<td>' + (index + 1) + '</td>';
                            html += '<td>' + val.Name + '</td>';
                            html += '<td  id="tdMobile">' + val.Mobile + '</td>';
                            html += '<td>' + val.dtEntry + '</td>';
                            html += '<td id="tdAmt">' + val.Amount + '</td>';
                            html += '<td>' + val.Remarks + '</td>';
                            if (parseInt(val.Amount) > 0) {
                                html += '<td></td>';
                            } else {
                                html += '<td><input type="button" value="Settle" onclick="Settle(this);"><input type="hidden" id="hdnId" value="' + val.SettlementId + '" /></td>';
                            }
                            if (parseInt(val.Amount) > 0) {
                                html += '<td></td>';
                            } else {
                                html += '<td><input type="button" value="SMS" onclick="SMS(this);"></td>';
                            }
                            html += '</tr>';
                            TotalDue = parseInt(val.Amount) + TotalDue;
                            $('#tblData').append(html);
                        });
                        $('#spnDueAmount').text(TotalDue);

                        $('#divData').show();
                    } else {
                        $('#divData').hide();
                    }

                }
            });
            return false;

        }

        function Settle(ctrl) {
            var SettlementId = $(ctrl).next().val();

            $('#txtAmount').val(parseInt($(ctrl).closest('tr').find('#tdAmt').text()) * -1);
            $('#hdnSettlementId').val(SettlementId);
            $('#myModal').modal('show');
        }

        function SMS(ctrl) {

            $('#txtSMSMobile').val($(ctrl).closest('tr').find('#tdMobile').text());
            var SMSText = 'Dear Customer, Your total due amount is rupees ' + (parseInt($(ctrl).closest('tr').find('#tdAmt').text()) * -1) + ', kindly clear the dues at Rahul Collection.';
            $('#txtSMSText').val(SMSText);
            $('#SMSModal').modal('show');
        }

        function SendSMS() {
            $.ajax({
                url: "Settlement.aspx/SendSMS",
                async: true,
                data: JSON.stringify({ Mobile: $('#txtSMSMobile').val(), SMSText: $('#txtSMSText').val() }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        alert('SMS Send Successfully');
                        $('#SMSModal').modal('hide');
                    } else {
                        alert('Some error occured');

                    }
                }
            });
        }

        function SaveSettlement() {

            $.ajax({
                url: "Settlement.aspx/SaveSettlement",
                async: true,
                data: JSON.stringify({ SettlementId: $('#hdnSettlementId').val(), Amount: $('#txtAmount').val(), Remarks: $('#txtRemarks').val().trim() }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        $('#hdnSettlementId').val('');
                        $('#txtAmount').val('');
                        $('#txtRemarks').val('')
                        alert('Settlement Successfull!');
                        $('#myModal').modal('hide');
                        Search();
                    }
                }
            });


        }
    </script>
</asp:Content>
