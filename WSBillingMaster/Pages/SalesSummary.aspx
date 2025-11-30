<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="SalesSummary.aspx.cs" Inherits="WSBillingMaster.Pages.SalesSummary" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
   <script type="text/javascript">
       // Load google charts
       google.charts.load('current', { 'packages': ['corechart'] });
       google.charts.setOnLoadCallback(drawChart);

       // Draw the chart and set the chart values
       function drawChart() {
           var FromDate = $('[id$=txtFromDate]').val();
           var ToDate = $('[id$=txtToDate]').val();

           $.ajax({
               url: "SalesSummary.aspx/drawChart",
               data: JSON.stringify({ FromDate: FromDate, ToDate: ToDate }),
               contentType: "application/json; charset=utf-8",
               type: "POST", // data has to be Posted 
               timeout: 120000,
               dataType: "json",
               success: function (result) {
                   var Jsondata = $.parseJSON(result.d);

                   var arrSales = [['Date', 'Sales']];    // Define an array and assign columns for the chart.

                   // Loop through each data and populate the array.
                   $.each(Jsondata, function (index, value) {
                       arrSales.push([value.Date, value.Sales]);
                   });

                   var data = google.visualization.arrayToDataTable(arrSales);
                   // Optional; add a title and set the width and height of the chart
                   var options = { 'title': 'Sales Summary', 'width': 1024, 'height': 400 };

                   // Display the chart inside the <div> element with id="piechart"
                   var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
                   chart.draw(data, options);
               }
           });



          
       }
</script>
    <div class="container">
        
        <div class="Content" style="margin-top:7%;">
            <table style="width: 100%">
                <tr>
                    <td style="width: 25%;">From Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">To Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;"></td>
                </tr>
                <tr>
                    <td style="width: 25%;">
                        <asp:TextBox runat="server" class="form-control datepicker" id="txtFromDate"  style="cursor:pointer" ></asp:TextBox>

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:TextBox runat="server" class="form-control datepicker" id="txtToDate"   style="cursor:pointer;" />

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:Button ID="btnSearch" runat="server" class="btn-danger" Text="Search" OnClick="btnSearch_Click"/>
                    </td>
                    
                </tr>
            </table>
        </div>
      
        <div class="Header"  style="margin-top:10px;margin-bottom:10px;">
           <table  style="width: 100%;font-size:16px">
               <tr>
                   <td>Total Amount : <asp:Label ID="lblAmount" runat="server" ForeColor="BlueViolet" Font-Size="Large" Text="0.00"></asp:Label> </td>
                   <td>Total Discount : <asp:Label ID="lblDiscount" runat="server" ForeColor="Red" Font-Size="Large" Text="0.00"></asp:Label> </td>
                   <td>Total Sales : <asp:Label ID="lblSales" runat="server" ForeColor="LawnGreen" Font-Size="Large" Text="0.00"></asp:Label> </td>

               </tr>
               <tr>
                   <td colspan="3">
                       <div id="chart_div" style="display:none;"></div>
                   </td>
               </tr>
           </table>
        </div>
        <div class="Content" style="max-height: 400px; overflow: auto;margin-top: -1%;">
            <asp:GridView ID="grdTransaction" runat="server" Width="100%" AutoGenerateColumns="true" EmptyDataText="No Record Found" ></asp:GridView>
           

        </div>
    </div>
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script>
        $(function () {
            $(".datepicker").datepicker(
                { dateFormat: 'dd-M-yy' }
            );
        });

        $(document).ready(function () {
//  $('[id$=grdTransaction]').dataTable().val($('[id$=grdTransaction]').html());

        });

        function GetSalesSummary(result)
        {
            debugger
            var data = $.parseJSON(result);
            if (data.length > 0)
            {
                var TotalAmount = parseFloat(0.0);
                var TotalDiscount = parseFloat(0.0);
                var TotalSales = parseFloat(0.0);
                for (var i = 0; i < data.length; i++)
                {
                    TotalAmount = (TotalAmount + parseFloat(data[i].Amount));
                    TotalDiscount = (TotalDiscount + parseFloat(data[i].Discount));
                    TotalSales = (TotalSales + parseFloat(data[i].GrandTotal));

                }

                $('[id$=lblAmount]').text(TotalAmount);
                $('[id$=lblDiscount]').text(TotalDiscount);
                $('[id$=lblSales]').text(TotalSales);
                drawChart();
                $('[id$=chart_div]').show();

            } else{
                $('[id$=chart_div]').hide();

            }



        }

       
        </script>
</asp:Content>