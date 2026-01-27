<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="StockReports.aspx.cs" Inherits="WSBillingMaster.Pages.StockReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="Header">
            <div style="font-weight: bold; color: #000; font-size: 20px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc; margin-top: 20px">
                Stock Reports
            </div>
            <div class="Header" style="margin-top: 10px; margin-bottom: 10px;">
                <table style="width: 100%; font-size: 16px">
                    <tr>
                        <td>Total Amount :
                            <asp:Label ID="lblAmount" runat="server" ForeColor="BlueViolet" Font-Size="Large" Text="0.00"></asp:Label>
                        </td>
                        <td>Total Discount :
                            <asp:Label ID="lblDiscount" runat="server" ForeColor="Red" Font-Size="Large" Text="0.00"></asp:Label>
                        </td>
                        <td>Total Sales :
                            <asp:Label ID="lblSales" runat="server" ForeColor="LawnGreen" Font-Size="Large" Text="0.00"></asp:Label>
                        </td>

                    </tr>
                    <tr>

                        <td colspan="3">
                            <div id="chart_div" style="display: none;"></div>
                        </td>
                    </tr>


                </table>
            </div>
            <div class="Content" style="margin-top: 7%;">





                <table style="width: 100%">
                    <tr>
                        <td style="width: 25%;">Report Name</td>
                        <td style="width: 25%;">From Date</td>
                        <td style="width: 5%;"></td>
                        <td style="width: 20%;">To Date</td>
                        <td style="width: 5%;"></td>
                        <td style="width: 20%;"></td>
                    </tr>
                    <tr>
                        <td style="width: 50%; text-align: left">
                            <asp:RadioButtonList ID="rblType" runat="server" ClientIDMode="Static" RepeatDirection="Horizontal" onclick="getMonthDate()">

                                <asp:ListItem Text="Item Wise Detail Report" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Category wise total Count Report" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Item Wise Prift Report" Value="3"></asp:ListItem>

                            </asp:RadioButtonList>
                        </td>
                    </tr>


                    <%--<td style="width: 25%;">
                        <asp:DropDownList runat="server" ID="ddlReport" CssClass="active"> </asp:DropDownList>
                        

                    </td>--%>
                    <tr>
                        <td style="width: 5%;"></td>
                        <td style="width: 20%;">
                            <asp:TextBox runat="server" class="form-control datepicker" ID="txtFromDate" Style="cursor: pointer"></asp:TextBox>

                        </td>

                        <td style="width: 5%;"></td>
                        <td style="width: 20%;">
                            <asp:TextBox runat="server" class="form-control datepicker" ID="txtToDate" Style="cursor: pointer;" />

                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%;"></td>
                        <td style="width: 20%;">
                            <%-- <input type="button" onclick="GetTotalStockValues('Search')" value="Search" class="btn-danger"  />--%>
                            <asp:Button ID="btnsearch" runat="server" OnClick="btnsearch_Click" Text="search" CssClass="alert-info" />

                        </td>
                        <td style="width: 5%;"></td>
                        <td style="width: 20%;">
                            <%--<input type="button" onclick="GetTotalStockValues1()" value="Export" class="btn-danger"  />--%>
                            <asp:Button ID="btnExcel" runat="server" OnClientClick="GetExportData();" Text="Export2Excel" CssClass="alert-info" />

                        </td>
                    </tr>
                </table>
                  <div style="width:1100px;overflow:auto;">
                <asp:GridView ID="grdData" Style="width: 100%;" runat="server" AutoGenerateColumns="true"></asp:GridView>

            </div>
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

        .InnerHeader {
            font-size: 12px;
            font-weight: bold;
            text-align: right;
            border: 1px solid #ccc;
            padding: 5px;
            color: #fff;
            background-color: #09f;
        }

        .InnerCell {
            font-size: 12px;
            font-weight: 100;
            text-align: right;
            border: 1px solid #ccc;
            padding: 5px;
            color: #000;
            background-color: #f1f1f1;
        }
    </style>
    

    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script>
        $(function () {
            $(".datepicker").datepicker(
                { dateFormat: 'dd-M-yy' }
            );
        });
        $(document).ready(function () {
            //  GetTotalStockValues('Search');
        });

        function GetExportData() {
            // alert($('[id$=rblType]').val());

            var type = $("#rblType input[type=radio]:checked").val();

            $.ajax({
                url: "StockReports.aspx/GetExportData",
                data: JSON.stringify({ FromDate: $('[id$=txtFromDate]').val(), ToDate: $('[id$=txtToDate]').val(), Type: type }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {

                    window.open("ExportToExcel.aspx");


                },
                error: function (ex) {
                    alert("some went wrong");
                }

            });

        }

        var CategoryWiseItemData;
        function GetTotalStockValues(data) {

            $.ajax({
                url: "StockReports.aspx/GetTotalStockValues",
                data: JSON.stringify({ FromDate: $('[id$=txtFromDate]').val(), ToDate: $('[id$=txtToDate]').val(), Type: data }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {

                    var data = $.parseJSON(result.d);
                    //alert(data);
                    if (result.dEXPORT == "Export") {
                        window.open("ExportToExcel.aspx");
                    }

                    else if (data.length > 0) {

                        $.each(data, function (index, value) {
                            var html = '<tr>';
                            html += '<td class="MyCol">' + (index + 1) + '</td>';
                            //html += '<td class="MyCol"><img src="../Images/details_open.png" style="cursor:pointer;float:right" onclick="ShowDetails(this,' + value.CategoryId + ');" /><img src="../Images/details_close.png" style="cursor:pointer;float:right;display:none;"  onclick="HideDetails(this);" /></td>';
                            html += '<td class="MyCol">' + value.ItemName + '</td>';
                            html += '<td class="MyCol">' + value.Cost + '</td>';
                            html += '<td class="MyCol">' + value.AddedOn + '</td>';
                            html += '<td class="MyCol">' + value.Stock + '</td>';
                            html += '<td class="MyCol">' + value.totalstockvalue + '</td>';
                            html += '</tr>';

                            $('#tblItem').append(html);
                        });

                    }

                }
            });

        }







        function ShowDetails(ctrl, ItemId) {
            var html = '';
            var Sno = 1;
            html += '<tr><td></td><td colspan=5>';
            html += '<table style="width:100%;">';
            html += '<tr>';
            html += '<th class="InnerHeader">Sno</th>';
            html += '<th class="InnerHeader">Item Name</th>';
            html += '<th class="InnerHeader">Cost</th>';
            html += '<th class="InnerHeader">AddedOn</th>';
            html += '<th class="InnerHeader">Stock</th>';
            html += '<th class="InnerHeader">TotalStockValue</th>';
            html += '</tr>';
            $.each(CategoryWiseItemData, function (index, value) {

                if (value.ItemId == ItemId) {

                    html += '<tr>';
                    html += '<td class="InnerCell">' + Sno + '</td>';
                    html += '<td class="InnerCell">' + value.ItemName + '</td>';
                    html += '<td class="InnerCell">' + value.Cost + '</td>';
                    html += '<td class="InnerCell">' + value.AddedOn + '</td>';
                    html += '<td class="InnerCell">' + value.Stock + '</td>';
                    html += '<td class="InnerCell">' + value.totalstockvalue + '</td>';
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
        function GetSalesSummary(result) {
            debugger
            var data = $.parseJSON(result);
            if (data.length > 0) {
                var TotalAmount = parseFloat(0.0);
                var TotalDiscount = parseFloat(0.0);
                var TotalSales = parseFloat(0.0);
                for (var i = 0; i < data.length; i++) {
                    TOTAL
                    TotalAmount = (TotalAmount + parseFloat(data[i].totalstockvalue));
                    TotalDiscount = (TotalDiscount + parseFloat(data[i].Discount));
                    TotalSales = (TotalSales + parseFloat(data[i].GrandTotal));

                }

                $('[id$=lblAmount]').text(TotalAmount);
                $('[id$=lblDiscount]').text(TotalDiscount);
                $('[id$=lblSales]').text(TotalSales);
            }
        }


        function getMonthDate() {

            if ($("#rblType input[type=radio]:checked").val() == "1") {
                $(".spnToMonth").show();
            }
            else {
                $(".spnToMonth").hide();
            }

        }

    </script>
</asp:Content>
