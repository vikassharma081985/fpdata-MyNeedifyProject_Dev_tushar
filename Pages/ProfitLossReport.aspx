<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ProfitLossReport.aspx.cs" Inherits="WSBillingMaster.Pages.ProfitLossReport" %>
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
               url: "ProfitLossReport.aspx/drawChart",
               data: JSON.stringify({ FromDate: FromDate, ToDate: ToDate }),
               contentType: "application/json; charset=utf-8",
               type: "POST", // data has to be Posted 
               timeout: 120000,
               dataType: "json",
               success: function (result) {
                   var Jsondata = $.parseJSON(result.d);
                   var data;
                   var arrSales = [['Date', 'Profit/Loss']];    // Define an array and assign columns for the chart.

                   // Loop through each data and populate the array.
                   $.each(Jsondata, function (index, value) {
                       arrSales.push([value.Date, value.ProfitLoss]);
                   });

                   data = google.visualization.arrayToDataTable(arrSales);
                   debugger
                   // Optional; add a title and set the width and height of the chart
                   var options = { 'title': 'Profit/Loss Report', 'width': 1024, 'height': 400};

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
                   <td>Total Income : <asp:Label ID="lblAmount" runat="server" ForeColor="BlueViolet" Font-Size="Large" Text="0.00"></asp:Label> </td>
                   <td>Total Expenses : <asp:Label ID="lblDiscount" runat="server" ForeColor="Red" Font-Size="Large" Text="0.00"></asp:Label> </td>
                   <td>Profit/Loss : <asp:Label ID="lblSales" runat="server" ForeColor="LawnGreen" Font-Size="Large" Text="0.00"></asp:Label> </td>

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

        function GetSalesSummary(result) {
            debugger
            var data = $.parseJSON(result);
            if (data.length > 0) {
                var TotalIncome = parseFloat(0.0);
                var TotalExpenses = parseFloat(0.0);
                var TotalProfitLoss = parseFloat(0.0);
                for (var i = 0; i < data.length; i++) {
                    TotalIncome = (TotalIncome + parseFloat(data[i].Income));
                    TotalExpenses = (TotalExpenses + parseFloat(data[i].Expenses));
                    TotalProfitLoss = (TotalProfitLoss + parseFloat(data[i].ProfitLoss));
                }

                $('[id$=lblAmount]').text(TotalIncome);
                $('[id$=lblDiscount]').text(TotalExpenses);
                $('[id$=lblSales]').text(TotalProfitLoss);
                drawChart();
                $('[id$=chart_div]').show();

            } else {
                $('[id$=chart_div]').hide();

            }



        }


        </script>
</asp:Content>
