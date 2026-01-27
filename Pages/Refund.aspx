<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Refund.aspx.cs" Inherits="WSBillingMaster.Pages.Refund" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="Header" style="height: auto;">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                Product Refund
            </div>
            <div class="container text-left" style="padding-bottom: 0px; margin-top: -30px;">
                <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">

                    <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
                        Invoice Number <font color="red">*</font>
                    </div>
                    <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                        <input type="text" class="form-control" id="txtInvoice" />
                    </div>

                    <div class="col-xs-12 col-md-3 col-sm-3 col-lg-3 TopSpace">
                        <input type="button" class="btn btn-danger" id="btnSearch" value="Search" onclick="Search();" />
                    </div>



                </div>
                <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer" style="margin-top:5%;font-weight:500;">
                    <table id="tblData" width="100%" style="display:none;">
                        <tr>
                            <td style="text-align:right;width:100px;">
                                Customer Name :
                            </td>
                            <td style="text-align:left;width:100px;">
                              <strong>  <span id="spnName"></span></strong>
                            </td>
                             <td style="text-align:right;width:100px;">
                                Mobile :
                            </td>
                            <td style="text-align:left;width:100px;">
                               <strong>  <span id="spnMobile"></span>
                            </td>
                             <td style="text-align:right;width:100px;">
                                Age :
                            </td>
                            <td style="text-align:left;width:100px;">
                                 <strong><span id="spnAge"></span></strong>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right;width:100px;">
                                Invoice Number :
                            </td>
                            <td style="text-align:left;width:100px;">
                                 <strong><span id="spnInvoice"></span></strong>
                            </td>
                             <td style="text-align:right;width:100px;">
                                
                            </td>
                            <td style="text-align:left;width:100px;">
                              
                            </td>
                             <td style="text-align:right;width:100px;">
                              Bill  Date :
                            </td>
                            <td style="text-align:left;width:100px;">
                                 <strong><span id="spnBillDate"></span></strong>
                            </td>
                        </tr>
                          <tr>
                            <td style="text-align:right;width:100px;">
                               Total Amount :
                            </td>
                            <td style="text-align:left;width:100px;">
                                  <strong><span id="spnTotalAmount"></span></strong>
                            </td>
                             <td style="text-align:right;width:100px;">
                                  Total Discount :
                            </td>
                            <td style="text-align:left;width:100px;">
                                 <strong><span id="spnTotalDiscount"></span></strong>
                            </td>
                             <td style="text-align:right;width:100px;">
                             Paid Amount :
                            </td>
                            <td style="text-align:left;width:100px;">
                                 <strong><span id="spnPaidAmount"></span></strong>
                            </td>
                        </tr>
                    </table>
                </div>



            </div>
        </div>

    </div>
    <script>
        $(document).ready(function () {


        });

        function Search() {
            var Invoice = $('[id$=txtInvoice]').val().trim();


            if (Invoice == "") {
                alert('Please enter any invoice number');
                return false;
            }


            $.ajax({
                url: "Refund.aspx/Search",
                async: true,
                data: JSON.stringify({ Invoice: Invoice }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    $('#tblData tr').slice(3).remove();
                    if (data.length > 0) {
                        $('#tblData').show();

                        $('#spnName').text(data[0].CustomerName);
                        $('#spnMobile').text(data[0].Mobile);
                        $('#spnAge').text(data[0].Age);
                        $('#spnInvoice').text(data[0].InvoiceNumber);
                        $('#spnBillDate').text(data[0].BillDate);
                        $('#spnTotalAmount').text(data[0].TotalAmount);
                        $('#spnTotalDiscount').text(data[0].Discount);
                        $('#spnPaidAmount').text(data[0].PaidAmount);


                        $.each(data, function (index, value) {
                            var html = '<tr><td colspan="6"><br/><br/></td></tr>';
                            html += '<tr>';
                            html += '<td></td>';
                            html += '<td><input type="checkbox" id="chkTransactionDetailId"><input type="hidden" id="hdnTransactionDetailID" value="' + value.TransactionDetailId + '"></td>';
                            html += '<td><img src="' + value.ItemImage + '" style="max-width:100px;" /></td>';
                            html += '<td>' + value.ItemName + '  </td>';
                            html += '<td>' + value.Barcode + ' </td>';
                            html += '<td> Rs.' + (parseInt(value.ItemAmount) + parseInt(value.Tax)) + ' </td>';
                            html += '</tr>';

                            $('#tblData').append(html);

                        });

                        var html = '<tr><td colspan="6" style="text-align:center"><br/><br/> <input type="button" id="btnRefund" class="btn btn-success" value="Refund" onclick="Refund();" /> </td></tr>';
                        $('#tblData').append(html);
                    } else {
                        $('#tblData').hide();
                        alert('No Record Found');
                    }
                }
            });

        }

        function Refund()
        {
            debugger
            var IsValid = false;
            var TDId = '';
            $('#tblData').find('input[type=checkbox]').each(function () {
                if($(this).is(':checked'))
                {
                    IsValid = true;
                    TDId += $(this).closest('tr').find('[id$=hdnTransactionDetailID]').val() + ',';
                }
            });

            if (IsValid) {
                TDId = TDId.substring(0, (TDId.length - 1));

                $.ajax({
                    url: "Refund.aspx/RefundTransaction",
                    async: true,
                    data: JSON.stringify({ TDId: TDId }),
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        if (result.d != "0") {
                            alert("Item Refund Succesfully !");
                            window.location.href = window.location.href;
                        } else {
                            alert("Some error occured!");

                        }
                    }
                });


            }
            else {
                alert('Please select any Item');
            }
        }

    </script>
</asp:Content>
