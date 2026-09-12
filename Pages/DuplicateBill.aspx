<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="DuplicateBill.aspx.cs" Inherits="WSBillingMaster.Pages.DuplicateBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <style>
        /* Page Styling */
        body {
            background-color: #f5f7fa;
        }

        .duplicate-bill-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header Section */
        .bill-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding-top: 70px;
        }

        .bill-header h1 {
            margin: 0;
            font-size: 32px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .bill-header p {
            margin: 5px 0 0 0;
            font-size: 14px;
            opacity: 0.9;
        }

        /* Filter Section */
        .filter-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .filter-section h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
        }

        .filter-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            align-items: flex-end;
        }

        .form-group-custom {
            display: flex;
            flex-direction: column;
        }

        .form-group-custom label {
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .form-group-custom input {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px;
            font-size: 14px;
            transition: all 0.3s ease;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-group-custom input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        .form-group-custom input::placeholder {
            color: #999;
        }

        /* Search Button */
        .search-btn-wrapper {
            display: flex;
            gap: 10px;
        }

        .btn-search {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            flex: 0 0 auto;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-search:active {
            transform: translateY(0);
        }

        /* Results Section */
        .results-section {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .results-header {
            background-color: #f8f9fa;
            padding: 20px;
            border-bottom: 2px solid #e5e7eb;
        }

        .results-header h3 {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
            color: #333;
        }

        .results-body {
            overflow-x: auto;
        }

        /* GridView Styling */
        .grdTransaction {
            width: 100%;
            border-collapse: collapse;
        }

        .grdTransaction thead {
            background-color: #f8f9fa;
            border-bottom: 2px solid #e5e7eb;
        }

        .grdTransaction th {
            padding: 18px;
            text-align: left;
            font-weight: 600;
            color: #333;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            white-space: nowrap;
        }

        .grdTransaction td {
            padding: 16px 18px;
            border-bottom: 1px solid #e5e7eb;
            color: #555;
            font-size: 14px;
        }

        .grdTransaction tbody tr {
            transition: background-color 0.2s ease;
        }

        .grdTransaction tbody tr:hover {
            background-color: #f8f9fa;
        }

        .grdTransaction tbody tr:last-child td {
            border-bottom: none;
        }

        /* Action Button */
        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background-color: #e8f0ff;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            background-color: #667eea;
            transform: scale(1.05);
        }

        .action-btn img {
            width: 20px;
            height: 20px;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        .empty-state-text {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .empty-state-sub {
            font-size: 13px;
            color: #bbb;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .duplicate-bill-container {
                padding: 15px;
            }

            .bill-header {
                padding: 20px;
            }

            .bill-header h1 {
                font-size: 24px;
            }

            .filter-section {
                padding: 15px;
            }

            .filter-group {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .search-btn-wrapper {
                flex-direction: column;
            }

            .btn-search {
                width: 100%;
            }

            .grdTransaction th,
            .grdTransaction td {
                padding: 12px;
                font-size: 12px;
            }

            .grdTransaction th {
                font-size: 11px;
            }

            .results-body {
                overflow-x: auto;
            }

            .grdTransaction {
                min-width: 600px;
            }
        }

        @media (max-width: 480px) {
            .duplicate-bill-container {
                padding: 10px;
            }

            .bill-header {
                padding: 15px;
                margin-bottom: 20px;
            }

            .bill-header h1 {
                font-size: 20px;
            }

            .bill-header p {
                font-size: 12px;
            }

            .filter-section {
                padding: 12px;
                margin-bottom: 20px;
            }

            .filter-section h3 {
                font-size: 15px;
                margin-bottom: 15px;
            }

            .form-group-custom label {
                font-size: 11px;
            }

            .form-group-custom input {
                padding: 10px;
                font-size: 13px;
            }

            .btn-search {
                padding: 10px 20px;
                font-size: 12px;
            }

            .grdTransaction th,
            .grdTransaction td {
                padding: 10px 8px;
                font-size: 11px;
            }

            .grdTransaction th {
                font-size: 10px;
            }

            .grdTransaction {
                min-width: 500px;
            }

            .action-btn {
                width: 35px;
                height: 35px;
            }

            .action-btn img {
                width: 18px;
                height: 18px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="duplicate-bill-container">

        <!-- Header Section -->
        <div class="bill-header">
            <h1>Previous Transactions</h1>
            <p>View and download your billing history and receipts</p>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <h3>Search Transactions</h3>
            <div class="filter-group">
                <div class="form-group-custom">
                    <label for="txtFromDate">From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" class="datepicker" placeholder="Select start date"></asp:TextBox>
                </div>

                <div class="form-group-custom">
                    <label for="txtToDate">To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" class="datepicker" placeholder="Select end date"></asp:TextBox>
                </div>

                <div class="form-group-custom">
                    <label for="txtKeyword">Search By</label>
                    <asp:TextBox ID="txtKeyword" runat="server" placeholder="Customer Name/Mobile" class=""></asp:TextBox>
                </div>

                <div class="search-btn-wrapper">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" class="btn-search" />
                </div>
            </div>
        </div>

        <!-- Results Section -->
        <div class="results-section">
            <div class="results-header">
                <h3>Transaction Results</h3>
            </div>

            <div class="results-body">
                <asp:GridView ID="grdTransaction" runat="server" Width="100%" AutoGenerateColumns="false" 
                    EmptyDataText="No records found" CssClass="grdTransaction">
                    <HeaderStyle BackColor="#f8f9fa" ForeColor="#333" />
                    <RowStyle BackColor="White" />
                    <AlternatingRowStyle BackColor="#fafbfc" />
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate>
                                <%#Eval("SNo") %>
                            </ItemTemplate>
                            <ItemStyle Width="60px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Invoice#">
                            <ItemTemplate>
                                <strong><%#Eval("InvoiceNumber") %></strong>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <%#Eval("TransactionOn") %>
                            </ItemTemplate>
                            <ItemStyle Width="120px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Customer">
                            <ItemTemplate>
                                <%#Eval("Customer") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Mobile">
                            <ItemTemplate>
                                <%#Eval("Mobile") %>
                            </ItemTemplate>
                            <ItemStyle Width="110px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Net Amount">
                            <ItemTemplate>
                                <strong style="color: #667eea;"><%#Eval("GrandTotal") %></strong>
                            </ItemTemplate>
                            <ItemStyle Width="120px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <div class="action-btn" onclick="Download(this);" title="Download Receipt">
                                    <img src="../Images/download.png" alt="Download" />
                                </div>
                                <asp:HiddenField ID="hdnId" runat="server" Value='<%#Eval("InvoiceNumber") %>' />
                            </ItemTemplate>
                            <ItemStyle Width="80px" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </div>

    <!-- Scripts -->
    <script src="../Js/jquery-ui.js"></script>
    <script>
        $(function () {
            $(".datepicker").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: true,
                changeYear: true
            });
        });

        function Download(ctrl) {
            var TransactionId = $(ctrl).next().val();
            TransactionId = TransactionId.substring(5, TransactionId.length);
            window.open("BillReceipt.aspx?TransactionId=" + TransactionId);
        }
    </script>
</asp:Content>