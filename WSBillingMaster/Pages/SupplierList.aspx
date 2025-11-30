<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="SupplierList.aspx.cs" Inherits="WSBillingMaster.Pages.SupplierList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        #tb_ItemList tr td {
            padding: 7px !important;
        }

        #tb_ItemList tr th {
            padding: 7px !important;
        }

        .Box-Container1 {
            background-color: #fff;
        }
    </style>
    <div class="alert fade" style="position: absolute; left: 30%; border-radius: 15px; z-index: 11111">
        <p id="msgField" style="color: white; padding: 10px; font-weight: bold;"></p>
    </div>

    <div class="container-fluid">
        <div class="container" style="margin-top: 15px; background-color: #fff !important;">
            <div class="col-md-12">
                <div style="text-align: center; text-align: center; font-weight: 500; font-size: 20px;">
                    <b>Supplier Management</b>
                </div>
            </div>
            <div class="col-md-12">
                <div>
                    <asp:Label ID="lblMsg" runat="server" />
                </div>
                <div style="text-align: center; border: 1px solid #ccc; padding: 20px;">
                    <table width="100%">
                        <tr>
                            <td style="text-align: left;">
                                <a href="http://trendzshopping.in//Pages/AddSupplier.aspx"><b>Add New Supplier</b></a>
                                <br />
                                <br />
                                <b>Supplier Name :</b>                                
                                <asp:TextBox ID="txtSupplierName" runat="server"></asp:TextBox>
                            </td>
                            <td style="text-align: left;"></td>
                            <td style="text-align: left;"></td>
                            <td>
                                <b>&nbsp;</b>
                                <input id="btnSearch" type="button" style="width: 150px; margin-top: 28px;" value="Search" class="btn-primary form-control" onclick="SearchData();" />&nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="col-md-12" style="padding-top: 10px;">
                <div style="text-align: center;">
                    <div>
                        <b>
                            <div style="float: left; margin-left: -15px; width: 200px">Supplier List(<asp:Label ID="lblTotalCount" Text="0" runat="server"></asp:Label>) </div>
                        </b>
                        <div id="DivTotalAmt" runat="server" visible="false" style="float: left; display: none;">
                            <b>Total Amount:</b>
                            <asp:Label ID="lblTotalAmt" runat="server"></asp:Label>
                        </div>


                    </div>
                    <div style="width: 100%; overflow: auto; height: 410px; padding-top: 10px;">
                        <table border="1" style="width: 100%" cellspacing="0" id="tb_ItemList" runat="server">
                            <tr id="saheader" style="height: 20px; color: #000;">
                                <th class="GridViewHeaderStyle" scope="col" style="width: 5%; color: #000 !IMPORTANT; text-align: left; font-size: 13px;">S.No.</th>
                                <th class="GridViewHeaderStyle" scope="col" style="width: 15%; text-align: left; color: #000 !IMPORTANT; font-size: 13px;">SupplierName</th>
                                <th class="GridViewHeaderStyle" scope="col" style="width: 10%; text-align: left; color: #000 !IMPORTANT; font-size: 13px;">SupplierCode</th>
                                <th class="GridViewHeaderStyle" scope="col" style="width: 15%; text-align: left; color: #000 !IMPORTANT; font-size: 13px;">Landline</th>
                                <th class="GridViewHeaderStyle" scope="col" style="width: 15%; text-align: left; color: #000 !IMPORTANT; font-size: 13px;">EmailId</th>
                                <th class="GridViewHeaderStyle" scope="col" style="width: 10%; text-align: left; color: #000 !IMPORTANT; font-size: 13px;">PANCardNo</th>
                                <th class="GridViewHeaderStyle" scope="col" style="width: 10%; text-align: left; color: #000 !IMPORTANT; font-size: 13px;">Status</th>
                                <th class="GridViewHeaderStyle" scope="col" style="width: 10%; text-align: left; color: #000 !IMPORTANT; font-size: 13px;">CreateDate</th>
                                <th class="GridViewHeaderStyle" scope="col" style="width: 10%; text-align: left; color: #000 !IMPORTANT; font-size: 13px;">Edit</th>
                            </tr>
                        </table>
                        <div style="text-align: right; margin-right: 12px; display: none;">
                            <input type="button" id="btnUpdate" onclick="savedata();" style="width: 150px; margin-top: 10px;" class="btn-primary" value="Update" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">


        //$(document).ready(function () {
        //    var config = {
        //        '.chosen-select': {},
        //        '.chosen-select-deselect': { allow_single_deselect: true },
        //        '.chosen-select-no-single': { disable_search_threshold: 10 },
        //        '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
        //        '.chosen-select-width': { width: "95%" }
        //    }
        //    for (var selector in config) {
        //        $(selector).chosen(config[selector]);
        //    }

        //});


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

        function SearchData() {
            debugger
            $('#tb_ItemList tr').slice(1).remove();
            $("#btnSearch").attr('disabled', 'disabled').val('Searching...');
            //$.blockUI();
            jQuery.ajax({
                url: "SupplierList.aspx/SearchData",
                data: '{SupplierName:"' + $('[id$=txtSupplierName]').val() + '"}',
                type: "POST",
                timeout: 120000,
                async: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    debugger
                    TestData = $.parseJSON(result.d);

                    if (TestData.length == 0) {
                        $("#btnSearch").removeAttr('disabled').val('Search');
                        $('#totalcount').html('0');
                        showerrormsg("No Record Found");
                        return;
                    }
                    else {
                        var a = 0;
                        var TotalAmount = 0;
                        $("#btnSearch").removeAttr('disabled').val('Search');
                        $('#btnsave').show();
                        for (var i = 0; i <= TestData.length - 1; i++) {
                            $('[Id=lblTotalAmt]').val(TestData[i].TotalAmount);
                            a++;
                            var mydata = "";
                            mydata += "<tr>";
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 5%;font-size:12px;">' + parseInt(i + 1) + '</td>';                            
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 15%;font-size:12px;">' + TestData[i].SupplierName + '</td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 10%;font-size:12px;">' + TestData[i].SupplierCode + '</td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 15%;font-size:12px;">' + TestData[i].Landline + '</td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 15%;font-size:12px;">' + TestData[i].EmailId + '</td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 10%;font-size:12px;">' + TestData[i].PANCardNo + '</td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 10%;font-size:12px;">' + TestData[i].Status + '</td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 10%;font-size:12px;">' + TestData[i].CreateDate + '</td>';
                            mydata += '<td class="GridViewLabItemStyle" align="left" style="width: 10%;font-size:12px;"><input type="hidden" id="hdnSupplierId" value=' + TestData[i].SupplierID + ' /><a href="http://trendzshopping.in//Pages/AddSupplier.aspx?SupId=' + TestData[i].SupplierID + '>Edit</a></td>';
                            mydata += "</tr>";
                            $('#tb_ItemList').append(mydata);                            
                        }

                        $('[Id$=lblTotalCount]').text(a);
                    }

                },
                error: function (xhr, status) {

                }

            });

        }

        function validation() {

            var flag = false;
            $('#tb_ItemList').find('tr input[type=checkbox]').each(function () {
                debugger
                if ($(this).is(':checked')) {
                    flag = false;

                }
                else {
                    flag = true;
                }

            });

            if (flag) {
                alert("Please select atleast one");
                return false;
            }
            else {

                return true;
            }
        }
        function savedata() {
            debugger
            var callFunc = "0";
            $('#tb_ItemList tr').not(":first").each(function () {
                var checkedornot = $(this).closest('tr').find("#chkItem").is(':checked');
                if (checkedornot == true) {
                    callFunc = "1";
                }
            });
            if (callFunc == "1") {

                var IsDoOrNot = confirm('Are you sure.......!');
                if (IsDoOrNot == false) {
                    return false;
                }
                debugger
                var SaveData = RefundRequestData();

                $.ajax({
                    url: "PendingOrderList.aspx/SaveData",
                    data: JSON.stringify({ Data: SaveData }),
                    type: "POST", // data has to be Posted    	        
                    contentType: "application/json; charset=utf-8",
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        debugger
                        alert('Record Updated Successfully');
                        SearchData();
                    },
                    error: function (xhr, status) {
                        showerrormsg("Some Error Occure Please Try Again..!");
                        console.log(xhr.responseText);
                    }
                });
            }
            else {
                alert("Select at least one record.");
                return false;
            }
        }
        function RefundRequestData() {
            debugger
            var dataPLO = new Array();
            $('#tb_ItemList tr').not(":first").each(function () {
                debugger
                var checkedornot = $(this).closest('tr').find("#chkItem").is(':checked');
                if (checkedornot == true) {
                    var objPLO = new Object();
                    objPLO.Status = $(this).closest('tr').find("#spnStatus option:selected").text();
                    objPLO.Courier = $(this).closest('tr').find("#spnC").val();
                    objPLO.Remarks = $(this).closest('tr').find("#txtRemarks").val();
                    objPLO.OrderId = $(this).closest('tr').find("#hdnOrderId").val();
                    objPLO.ItemId = $(this).closest('tr').find("#hdnItemId").val();
                    dataPLO.push(objPLO);
                }
            });
            return dataPLO;
        }

        function Reject(id) {
            debugger
            var LabNo = $(id).parent().parent().find('td').eq(1).html();
            var ItemIds = $(id).parent().parent().find('td').eq(7).html();

            var LoginId = '<%= Session["ID"] %>'
            var LoginName = '<%= Session["LoginName"] %>'
            var IsDoOrNot = confirm('Are you sure.......!');
            if (!IsDoOrNot) {
                return false;
            }
            $.ajax({
                url: "RefundProcessList.aspx/RequestForReject",
                async: false,
                data: '{LabNo:"' + LabNo + '",LoginId:"' + LoginId + '",LoginName:"' + LoginName + '",ItemIds:"' + ItemIds + '"}',
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {

                    if (result.d == "1") {
                        alert('Reject successfully');
                        SearchData();
                    }
                    else {
                        alert('Contact IT Dose');
                    }
                }
            });
        }
        //$(document).ready(function () {

        //    SearchData();
        //});
        $(function () {
            $(".calen").datepicker();
        });

    </script>
</asp:Content>