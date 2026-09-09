
$(document).ready(function () {
    //debugger;
    var transactionid = GetParameterValues('TransactionId');
    //debugger;
    BindOrderTransactionDetails(transactionid);
    if (parseFloat($('#txtDueAmount').val()) <= 0) {
        $('#btnSettlement').hide();
        $('#btnBackToDue').show();
    } else {
        $('#btnSettlement').show();
        $('#btnBackToDue').hide();
    }
});
function GetParameterValues(param) {
    //debugger;
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}
function BindOrderTransactionDetails(transactionid) {
    //debugger;
    //alert('inside Bind order');
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "AmountSettlement.aspx/FetchTransactionDetails",
        data: JSON.stringify({ TransactionId: transactionid }),
        timeout: 120000,
        dataType: "json",
        async: false,
        success: function (result) {
            // debugger;
            //alert('success');
            var data = $.parseJSON(result.d);
            console.log(data);
            console.log(result.d);
            $('#txtMobile').val(data[0].Mobile);
            $('#hdnCustomerId').val(data[0].CustomerId);
            $('#txtName').val(data[0].FirstName);
            $('#txtLName').val(data[0].LastName);
            $('#txtAge').val(data[0].Age);
            $("#ddlGender option[value='" + data[0].Gender + "']").attr('selected', 'selected');
            $('#txtInvoice').val(data[0].InvoiveNum);
            $('#txtPaymentDate').val(data[0].TransactionDate);
            $('#txtNetAmount').val(data[0].NetAmount);
            $('#txtPaidAmount').val(data[0].PaidAmount);
            $('#txtDueAmount').val(data[0].DueAmount);
            var paymentmodeid = data[0].PaymentModeId;
            var paymentMode = '';
            switch (paymentmodeid) {
                case 1:
                    paymentMode = 'CASH';
                    break;
                case 2:
                    paymentMode = 'DEBIT/CREDIT CARD';
                    break;
                case 3:
                    paymentMode = 'PAYTM';
                    break;
                default:
                    break;
            }
            $('#txtPaymentModeforPaidAmt').val(paymentMode);
            var gettitle = '';
            switch (data[0].Title) {
                case 'Mr.':
                    gettitle = 1;
                    break;
                case 'Mrs.':
                    gettitle = 2;
                    break;
                case 'Ms.':
                    gettitle = 3;
                    break;
                default:
                    break;
            }
            $("#ddlTitle option[value=" + gettitle + "]").attr('selected', 'selected');
        },
        error: function (data) {
            alert('error occured');
        }

    });
}
$.urlParam = function (name) {
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (results == null) {
        return null;
    }
    return decodeURI(results[1]) || 0;
}
$('#ddlPaymentMode').on('change', function () {
    var PaymodeId = parseInt($('#ddlPaymentMode option:selected').val());
    if (PaymodeId > 1) {
        $('#dvPaytm').show();
    } else {
        $('#dvPaytm').hide();
    }
});
$('#btnSettlement').click(function () {
    debugger;
   // alert('Ok');
    //console.log("http://localhost:46692/Pages/DueAmount.aspx");
    //return;
    
    var SettlementAmt = 0;
    if (isNaN(parseFloat($('#txtSettlementAmount').val()))) {
        SettlementAmt = 0;
        alert('Enter the settlement amount greater than zero.');
        return;
    }
    if ($('#dvPaytm').show()==true && $('#txtpaytmNum').val() == '') {
        alert('Kindly enter Paytm/DC/CC Number.')
        return;
    }
    var CustomerId = $('#hdnCustomerId').val();
    var Mobile = $('#txtMobile').val();
    var FName = $('#txtName').val();
    var TransactionId = parseFloat($.urlParam('TransactionId'));
    var SettlementAmt = parseFloat($('#txtSettlementAmount').val());
    var Remarks = $('#txtComments').val() + '. '; 
    if ($('#dvPaytm').is(':visible')) {
        Remarks += $('#ddlPaymentMode option:selected').text() + ' : ' + $('#txtpaytmNum').val();
    } else {
        Remarks += 'Payment through cash.';
    }
    var PaymodeId = parseInt($('#ddlPaymentMode option:selected').val());
    //alert('now proceed to ajax');
    //return;
    $.ajax({
        url: "AmountSettlement.aspx/SaveAmountSettlement",
        async: false,
        data: JSON.stringify({ CustomerId: CustomerId, Mobile: Mobile, FName: FName, TransactionId: TransactionId, SettlementAmt: SettlementAmt, Remarks: Remarks, PaymodeId: PaymodeId }),
        contentType: "application/json; charset=utf-8",
        type: "POST", // data has to be Posted 
        timeout: 120000,
        dataType: "json",
        success: function (result) {
            debugger;
            alert('Specified amount of Rs. ' + SettlementAmt + ' paid by customer!');
            $('#btnBackToDue').show();
            //window.location.href = "../../../Pages/DueAmount.aspx";
            //window.location = "~/Pages/DueAmount.aspx";
            //setTimeout(function () { document.location.href = "~/Pages/DueAmount.aspx;" }, 500);
            return false;
        },
        error: function (data) {
            alert('Some Error Occured, Please try again later!');
        }
    });

});
$('#btnBackToDue').click(function () {
    debugger;
    window.location.href = "../../../Pages/DueAmount.aspx";
    return false;
});