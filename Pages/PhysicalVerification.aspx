<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="PhysicalVerification.aspx.cs" Inherits="WSBillingMaster.Pages.PhysicalVerification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <style>
       .MyTable {
       border:1px solid #000;
       padding:2px;
       }
   </style>
     <div class="container">
        <asp:Panel ID="pnl" runat="server" DefaultButton="btnSearch">

       
        <div class="Header" style="height: auto;">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                 Physical Stock Verification
            </div>
            <div class="container text-left" style="padding-bottom: 0px; margin-top: -30px;">
                <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">

                    <div class="col-xs-12 col-md-2 col-sm-12 col-lg-2 TopSpace">
                        Barcode <font color="red">*</font>
                    </div>
                    <div class="col-xs-12 col-md-3 col-sm-12 col-lg-3 TopSpace">
                        <input type="text" class="form-control" id="txtBarcode" />
                    </div>

                    <div class="col-xs-12 col-md-3 col-sm-12 col-lg-3 TopSpace">
                        <asp:Button ID="btnSearch" CssClass="btn-danger" Text="Search" OnClientClick="return Search();" runat="server" />
                    </div>



                </div>
                <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer" style="margin-top: 5%; font-weight: 500;">
                    <table style="width:95%;float:left;display:none;" id="tblAsset">
                        <tr>
                            <td style="text-align:left;width:50%;" >Total Amount as System : <span id="spnTotalSystemAmount" style="font-weight:bold;color:green">₹0</span></td>
                            <td style="text-align:right;width:50%;" >Total Verified Amount : <span id="spnTotalVerifiedAmount" style="font-weight:bold;color:red">₹0</span></td>
                        </tr>
                    </table>
                    <table id="tblStock" style="width:45%;float:left;">
                    </table>
                    <table id="tblVerified" style="margin-left:20px; width:50%;float:left;">
                    </table>
                </div>



            </div>
        </div>
            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer text-center" id="divActionButton" style="padding:15px;display:none;">
                <input type="button" id="btnSaveDraft" class="btn btn-danger" value="Save as Draft" onclick="SaveAsDraft();"  /> 
                <input type="button" id="Button1" class="btn btn-success" value="Export to Excel" onclick="Export();" /> 

            </div>
         </asp:Panel>
    </div>
    <script>
        $(document).ready(function () {
            
            $('#txtBarcode').focus();
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    Search();
                }
            });

            BindDraftData();
        });

        function Search()
        {
            if ($('#txtBarcode').val().trim() != '') {
                $.ajax({
                    url: "PhysicalVerification.aspx/Search",
                    async: true,
                    data: JSON.stringify({ Barcode: $('#txtBarcode').val().trim() }),
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        var data = $.parseJSON(result.d);
                        if (data.length > 0) {
                            if ($('#tblStock tr').length > 0) {
                                var IsNew = true;
                                $('#tblStock tr').each(function () {
                                    if ($(this).attr('id') == data[0].ItemId)
                                    {
                                        IsNew = false;
                                    }
                                });
                                if (IsNew) {
                                    BindStock(data);
                                    BindVerification(data, 1);
                                } else {
                                    $('#tblVerified tr').each(function () {
                                        if ($(this).attr('id') == data[0].ItemId) {
                                            var NewQty = parseInt($(this).find('#spnQty').text()) + 1;
                                            var NewTAmt = parseInt(data[0].MRP) * NewQty;
                                            $(this).find('#spnQty').text(NewQty);
                                            $(this).find('#spnTAmt').text(NewTAmt);
                                        }
                                    });
                                }
                            } else {
                                BindStock(data);
                                BindVerification(data);
                            }
                        }
                        EvaluateTotalAsset();
                  
                    }
                });
                
            }
            $('#txtBarcode').val('');
            $('#txtBarcode').focus();
            return false;

        }


        function BindStock(data)
        {
            var html = '<tr id="' + data[0].ItemId + '">';
            html += '<td class="MyTable" style="text-align:center;"><img id="imgItemImage" src="' + data[0].ItemImage + '" class="img-thumbnail img-rounded" style="height:50px;width:50px"></td>';
            html += '<td class="MyTable"  style="text-align:center;"><b><span id="spnItemName">' + data[0].ItemName + '</span></b><p><span id="spnBarcode">' + data[0].Barcode + '</span></p></td>';
            html += '<td class="MyTable"  style="text-align:center;">Total Amount :<b><span id="spnTAmt" style="color:green;"> ₹<span id="spnTotalAsSystem">' + parseInt(data[0].MRP) * parseInt(data[0].Stock) + '</span></span></b></td>';
            html += '<td class="MyTable"  style="text-align:center;">Stock :<b><span id="spnQty" style="color:green;"> ' + data[0].Stock + '</span></b></td>';
            html += '</tr>';
            $('#tblStock').append(html);
        }

        function BindVerification(data) {
            var html = '<tr id="' + data[0].ItemId + '">';
            html += '<td class="MyTable" style="text-align:center;"><img src="' + data[0].ItemImage + '" class="img-thumbnail  img-rounded" style="height:50px;width:50px"></td>';
            html += '<td class="MyTable"  style="text-align:center;"><b>' + data[0].ItemName + '</b><p>' + data[0].Barcode + '</p></td>';
            html += '<td class="MyTable"  style="text-align:center;">Total Amount :<b><span style="color:red;"> ₹<span id="spnTAmt" >' + parseInt(data[0].MRP) * parseInt(1) + '</span></span></b></td>';
            html += '<td class="MyTable"  style="text-align:center;">Stock :<b><span id="spnQty" style="color:red;">1</span></b></td>';
            html += '<td class="MyTable"  style="text-align:center;"><input type="button" value="Post" onclick="PostStock(this);"></td>';

            html += '</tr>';
            $('#tblVerified').append(html);
        }

        function PostStock(ctrl)
        {
            var IsConfirm=confirm('Are you sure, you want to post new stock?');
            if(IsConfirm)
            {
                var ItemId=$(ctrl).closest('tr').attr('id');
                var NewStock=$(ctrl).closest('tr').find('#spnQty').text();
                var PreviousStock = $('#tblStock').find('#' + ItemId).find('#spnQty').text();
                var NewTAmt = $(ctrl).closest('tr').find('#spnTAmt').text();
                if (parseInt(PreviousStock) == parseInt(NewStock))
                {
                    alert('Stock as per system is equal to Physical verification so no need to post it.');
                    return;
                }

                $.ajax({
                    url: "PhysicalVerification.aspx/PostStock",
                    async: true,
                    data: JSON.stringify({ItemId:ItemId,NewStock:NewStock,PreviousStock:PreviousStock}),
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        if(result.d=='1')
                        {
                            alert('Stock Posted Successfully');
                            $('#tblStock').find('#' + ItemId).find('#spnQty').text(NewStock);
                            $('#tblStock').find('#' + ItemId).find('#spnTAmt').text('₹' + NewTAmt);

                        }else{
                            alert('Some error occured!');
                        }
                        EvaluateTotalAsset();
                    }
                });
               
            }
        }

        function EvaluateTotalAsset()
        {
            var SystemAmount = 0;
            $('#tblStock tr').each(function () {
                SystemAmount = SystemAmount + parseInt($(this).find('#spnTAmt').text().replace('₹', ''));

            });
            var VerifiedAmount = 0;
            $('#tblVerified tr').each(function () {
                VerifiedAmount = VerifiedAmount + parseInt($(this).find('#spnTAmt').text().replace('₹', ''));
            });

            $('#spnTotalSystemAmount').text('₹'+SystemAmount);
            $('#spnTotalVerifiedAmount').text('₹' + VerifiedAmount);

            if (SystemAmount != 0)
            {
                $('#tblAsset').show();
                $('#divActionButton').show();
            }
        }


        function Export()
        {
            var arr=new Array();
            $('#tblStock tr').each(function (index) {

                var obj = new Object();
                obj.ItemId = $(this).attr('id');
                obj.ItemName = $(this).find('#spnItemName').text();
                obj.Barcode = $(this).find('#spnBarcode').text();
                obj.TotalAsSystem = $(this).find('#spnTotalAsSystem').text();
                obj.StockAsSystem = $(this).find('#spnQty').text();
                obj.ItemImage = $(this).find('#imgItemImage').attr('src');
                obj.TotalAsPhysicallyVerified = $('#tblVerified tr').eq(index).find('#spnTAmt').text();
                obj.StockAsPhysicallyVerified = $('#tblVerified tr').eq(index).find('#spnQty').text();
                arr.push(obj);
            });

            $.ajax({
                url: "PhysicalVerification.aspx/Export",
                async: true,
                data: JSON.stringify({ data: arr }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d == "1")
                    {
                        window.open('ExportToExcel.aspx');
                    }
                }
            });

        }


        function SaveAsDraft() {
            var arr = new Array();
            $('#tblStock tr').each(function (index) {

                var obj = new Object();
                obj.ItemId = $(this).attr('id');
                obj.ItemName = $(this).find('#spnItemName').text();
                obj.Barcode = $(this).find('#spnBarcode').text();
                obj.TotalAsSystem = $(this).find('#spnTotalAsSystem').text();
                obj.StockAsSystem = $(this).find('#spnQty').text();
                obj.ItemImage = $(this).find('#imgItemImage').attr('src');
                obj.TotalAsPhysicallyVerified = $('#tblVerified tr').eq(index).find('#spnTAmt').text();
                obj.StockAsPhysicallyVerified = $('#tblVerified tr').eq(index).find('#spnQty').text();
                arr.push(obj);
            });

            $.ajax({
                url: "PhysicalVerification.aspx/SaveAsDraft",
                async: true,
                data: JSON.stringify({ data: arr }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        alert('Saved Successfully !');
                    } else {
                        alert('Some Error occured');
                    }
                }
            });

        }

        function BindDraftData()
        {
            $.ajax({
                url: "PhysicalVerification.aspx/BindDraftData",
                async: true,
                //data: JSON.stringify({ data: arr }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    //ItemID,ItemName,Barcode,ImagePath,TotalAsSystem,StockAsSystem,TotalAsPhysicallyVerified,StockAsPhysicallyVerified,dtEntry
                    var data = $.parseJSON(result.d);
                    if (data.length > 0)
                    {
                        var IsConfirm = confirm('Do you want to load previously saved draft as on ' + data[0].dtEntry+' ,in case if you do not load previously saved draft it will be discarded');
                        if (IsConfirm) {
                            $.each(data, function (index, val) {

                                var html = '<tr id="' + val.ItemID + '">';
                                html += '<td class="MyTable" style="text-align:center;"><img id="imgItemImage" src="' + val.ImagePath + '" class="img-thumbnail img-rounded" style="height:50px;width:50px"></td>';
                                html += '<td class="MyTable"  style="text-align:center;"><b><span id="spnItemName">' + val.ItemName + '</span></b><p><span id="spnBarcode">' + val.Barcode + '</span></p></td>';
                                html += '<td class="MyTable"  style="text-align:center;">Total Amount :<b><span id="spnTAmt" style="color:green;"> ₹<span id="spnTotalAsSystem">' + val.TotalAsSystem + '</span></span></b></td>';
                                html += '<td class="MyTable"  style="text-align:center;">Stock :<b><span id="spnQty" style="color:green;"> ' + val.StockAsSystem + '</span></b></td>';
                                html += '</tr>';
                                $('#tblStock').append(html);

                                var html1 = '<tr id="' + val.ItemID + '">';
                                html1 += '<td class="MyTable" style="text-align:center;"><img src="' + val.ImagePath + '" class="img-thumbnail  img-rounded" style="height:50px;width:50px"></td>';
                                html1 += '<td class="MyTable"  style="text-align:center;"><b>' + val.ItemName + '</b><p>' + val.Barcode + '</p></td>';
                                html1 += '<td class="MyTable"  style="text-align:center;">Total Amount :<b><span style="color:red;"> ₹<span id="spnTAmt" >' + val.TotalAsPhysicallyVerified + '</span></span></b></td>';
                                html1 += '<td class="MyTable"  style="text-align:center;">Stock :<b><span id="spnQty" style="color:red;">' + val.StockAsPhysicallyVerified + '</span></b></td>';
                                html1 += '<td class="MyTable"  style="text-align:center;"><input type="button" value="Post" onclick="PostStock(this);"></td>';

                                html1 += '</tr>';
                                $('#tblVerified').append(html1);

                            });
                            EvaluateTotalAsset();
                        } else {
                            $.ajax({
                                url: "PhysicalVerification.aspx/DiscardDraft",
                                async: true,
                                contentType: "application/json; charset=utf-8",
                                type: "POST", // data has to be Posted 
                                timeout: 120000,
                                dataType: "json",
                                success: function (result) {

                                }
                            });
                        }
                    }
                }
            });
        }
    </script>
</asp:Content>
