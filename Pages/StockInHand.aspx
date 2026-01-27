<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="StockInHand.aspx.cs" Inherits="WSBillingMaster.Pages.StockInHand" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="Header">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                Stock In Hand Report

            </div>
            <div style="padding-top: 15px;">
                <table id="tblItem" style="width: 100%; margin-top: 30px;">
                    <tr>
                        <th class="MyHeader" style="width: 20px;">SNo.</th>
                        <th class="MyHeader" style="width: 20px;">#</th>

                        <th class="MyHeader">Category</th>
                        <th class="MyHeader">Total Items</th>
                        <th class="MyHeader">Total Stock</th>
                        <th class="MyHeader">Total Price</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <style>
        .MyCol {
            font-size: 12px;
            font-weight: 100;
            text-align: right;
            border: 1px solid #ccc;
            padding: 5px;
        }

        .MyHeader {
            font-size: 12px;
            font-weight: bold;
            text-align: right;
            border: 1px solid #ccc;
            padding: 5px;
            color: #000;
        }

        .InnerHeader{
            font-size: 12px;
            font-weight: bold;
            text-align: right;
            border: 1px solid #ccc;
            padding: 5px;
            color: #fff;
            background-color:#09f;
        }

          .InnerCell {
            font-size: 12px;
            font-weight: 100;
            text-align: right;
            border: 1px solid #ccc;
            padding: 5px;
            color:#000;
            background-color:#f1f1f1;
        }
    </style>
    <script>
        $(document).ready(function () {
            GetStockInHand();
        });
        var CategoryWiseItemData;
        function GetStockInHand() {
            $.ajax({
                url: "StockInHand.aspx/GetStockInHand",
                // data: JSON.stringify({ FromDate: FromDate, ToDate: ToDate }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);

                    var CategoryWiseData = data.Table;
                    CategoryWiseItemData = data.Table1;
                    if (CategoryWiseData.length > 0) {
                        $.each(CategoryWiseData, function (index, value) {
                            var html = '<tr>';
                            html += '<td class="MyCol">' + (index + 1) + '</td>';
                            html += '<td class="MyCol"><img src="../Images/details_open.png" style="cursor:pointer;float:right" onclick="ShowDetails(this,' + value.CategoryId + ');" /><img src="../Images/details_close.png" style="cursor:pointer;float:right;display:none;"  onclick="HideDetails(this);" /></td>';
                            html += '<td class="MyCol">' + value.Category + '</td>';
                            html += '<td class="MyCol">' + value.TotalItems + '</td>';
                            html += '<td class="MyCol">' + value.TotalStock + '</td>';
                            html += '<td class="MyCol">' + value.TotalPrice + '</td>';
                            html += '</tr>';

                            $('#tblItem').append(html);
                        });
                    }

                }
            });

        }

        function ShowDetails(ctrl, CategoryId) {
            var html = '';
            var Sno = 1;
            html += '<tr><td></td><td colspan=5>';
            html += '<table style="width:100%;">';
            html += '<tr>';
            html += '<th class="InnerHeader">Sno</th>';
            html += '<th class="InnerHeader">Item Name</th>';
            html += '<th class="InnerHeader">Category</th>';
            html += '<th class="InnerHeader">Stock Available</th>';
            html += '<th class="InnerHeader">Total Price</th>';
            html += '</tr>';
            $.each(CategoryWiseItemData, function (index, value) {
         
                if (value.CategoryId == CategoryId) {
                   
                    html += '<tr>';
                    html += '<td class="InnerCell">' + Sno + '</td>';
                    html += '<td class="InnerCell">' + value.ItemName + '</td>';
                    html += '<td class="InnerCell">' + value.Category + '</td>';
                    html += '<td class="InnerCell">' + value.Stock + '</td>';
                    html += '<td class="InnerCell">' + value.TotalPrice + '</td>';
                    html += '</tr>';
                
                    Sno++;
                }
            });

            html += '</table></td></tr>';

            $(ctrl).closest('tr').after(html);
            $(ctrl).next().show();
            $(ctrl).hide();
        }

        function HideDetails(ctrl) {
            $(ctrl).prev().show();
            $(ctrl).hide();
            $(ctrl).closest('tr').next().remove();
        }
    </script>
</asp:Content>
