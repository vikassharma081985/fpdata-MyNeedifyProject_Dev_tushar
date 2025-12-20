<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ExpenseManager.aspx.cs" Inherits="WSBillingMaster.Pages.ExpenseManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField runat="server" ID="hdnUserId" Value="0" />
    <div class="container">
        <!-- ======================== Expense Entry Section ========================= -->
        <div class="Header">
            <div class="section-title">Expense Manager</div>
            <input type="hidden" id="hfUploadedFile" />
            <div class="responsive-form">
                <div class="form-row">
                    <div class="form-group">
                        <label>Expense Date :</label>
                        <input type="text" class="form-control datepicker" id="txtExpenseDate" />
                    </div>

                    <div class="form-group">
                        <label>Expense On :</label>
                        <select id="ddlExpense" class="form-control"></select>
                    </div>

                    <div class="form-group">
                        <label>Rate :</label>
                        <input type="text" id="txtRate" value="0" class="form-control" maxlength="10" oninput="validateRate(this)" />
                    </div>
                    <div class="form-group">
                        <label>Quantity :</label>
                        <input type="text" id="txtQuantity" value="1" class="form-control" maxlength="10" />
                    </div>
                    <div class="form-group">
                        <label>Amount :</label>
                        <input type="text" disabled id="txtAmount" class="form-control" maxlength="5" />
                    </div>

                    <div class="form-group">
                        <label>Upload :</label>
                        <input type="file" id="fpUpload" onchange="FileChange(this);" />
                    </div>

                    <div class="form-group">
                        <label>Description :</label>
                        <input type="text" class="form-control" id="txtExpenseDescription" />
                    </div>
                </div>

                <div class="form-row center">
                    <input type="button" class="btn btn-danger" value="Save" onclick="Save();" />
                </div>
            </div>
        </div>

        <!-- ======================== All Expenses Section ========================= -->
        <div class="Header" style="margin-top: 20px;">
            <div class="section-title">All Expenses</div>
            <div class="section-title">Total Expense : Rs. <span id="lblExpenseAmt" style="color: LawnGreen; font-size: Large;">0</span> </div>
            <div class="responsive-form">
                <div class="form-row">
                    <div class="form-group">
                        <label>From Date :</label>
                        <input type="text" class="form-control datepicker" id="txtFromDate" />
                    </div>

                    <div class="form-group">
                        <label>To Date :</label>
                        <input type="text" class="form-control datepicker" id="txtToDate" />
                    </div>

                    <div class="form-group">
                        <label>Expense On :</label>
                        <select id="ddlExpenseSearch" class="form-control"></select>
                    </div>


                </div>


                <div class="form-row center">
                    <input type="button" class="btn btn-success" value="Search" onclick="Search();" />
                    <input type="button" class="btn btn-primary" value="Submit for Reimbursement" onclick="OpenRbmPopup();">
                </div>



            </div>

            <div class="table-responsive">
                <table id="tblExpense" style="width: 100%;">
                    <tr>
                        <th class="MyHeader">
                            <input type="checkbox" id="chkSelectAll" />
                        </th>
                        <th class="MyHeader">SNo.</th>
                        <th class="MyHeader" style="cursor:pointer;" onclick="sortByDate()">Date <span id="dateSortIcon">▲</span></th>
                        <th class="MyHeader">Expense On</th>
                        <th class="MyHeader">Rate</th>
                        <th class="MyHeader">Quantity</th>
                        <th class="MyHeader">Amount</th>
                        <th class="MyHeader">Description</th>
                        <th class="MyHeader">File</th>
                        <th class="MyHeader"></th>
                    </tr>
                </table>
                <div id="pagination" style="margin-top:10px;text-align:center;">
                    <button type="button" class="btn btn-secondary btn-sm" onclick="prevPage()">Prev</button>
                    <span id="pageInfo" style="margin:0 10px;"></span>
                    <button type="button" class="btn btn-secondary btn-sm" onclick="nextPage()">Next</button>
                </div>
            </div>
        </div>
    </div>




    <!-- ====================== Modal ====================== -->
    <div id="submitModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeSubmitModal();">&times;</span>
            <h3>Details which needs to be displayed on header </h3>
            <div id="rbmPopup" title="Submit Reimbursement" style="display: visible;">
                <label>Reporting Manager</label>
                <input type="text" id="txtManager" class="form-control" />

                <label>Employee Code</label>
                <input type="text" id="txtEmpCode" class="form-control" />

                <label>Company Name</label>
                <input type="text" id="txtCompany" class="form-control" />

                <label>Plant Code</label>
                <input type="text" id="txtPlant" class="form-control" />

                <%--<label>Signature (Upload)</label>
                <input type="file" id="fpSignature" onchange="UploadSignature();" />--%>
                <label style="cursor:pointer;color:#007bff;" onclick="openSignatureModal()">
                    Signature (Click to Sign)
                </label>
                <label id="lblSignatureFile"
                       style="display:none;color:green;font-weight:600;">
                </label>
                <input type="hidden" id="hfSignaturePath" />
                <input type="button" class="btn btn-success" value="Generate Document" onclick="GenerateReimbursementDoc();" />
            </div>

        </div>
    </div>


    <!-------------------------edit modal-------------------------->

    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal();">&times;</span>

            <h3>Generated Reimbursement Documents</h3>

            <!-- Table will be shown automatically -->
            <table id="tblRbmDocs" class="table table-bordered">
                <tr>
                    <th>SNo</th>
                    <th>Date</th>
                    <th>Document</th>
                    <th>Send Mail</th>
                    <th>Open / Print</th>
                </tr>
            </table>

        </div>
    </div>

<div id="signatureModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeSignatureModal()">&times;</span>
        <h3>Draw Your Signature</h3>
        <canvas id="signatureCanvas"
                width="500" height="200"
                style="border:1px solid #ccc;background:#fff;"></canvas>
        <br /><br />
        <button type="button" class="btn btn-warning" onclick="clearSignature()">Clear</button>
        <button type="button" class="btn btn-success" onclick="saveSignature()">Save</button>
    </div>
</div>

HTML<!-- ====================== Edit Expense Modal ====================== -->
<div id="editExpenseModal" class="modal">
    <div class="modal-content" style="max-width:800px;">
        <span class="close" onclick="closeEditExpenseModal()">&times;</span>
        <h3 style="text-align:center;">Edit Expense</h3>
        <div class="responsive-form">
            <div class="form-row">
                <div class="form-group">
                    <label>Expense Date :</label>
                    <input type="text" class="form-control datepicker" id="txtEditExpenseDate" />
                </div>
                <div class="form-group">
                    <label>Expense On :</label>
                    <select id="ddlEditExpense" class="form-control"></select>
                </div>
                <div class="form-group">
                    <label>Rate :</label>
                    <input type="text" id="txtEditRate" value="0" class="form-control" maxlength="10" oninput="validateRate(this)" />
                </div>
                <div class="form-group">
                    <label>Quantity :</label>
                    <input type="text" id="txtEditQuantity" value="1" class="form-control" maxlength="10" />
                </div>
                <div class="form-group">
                    <label>Amount :</label>
                    <input type="text" disabled id="txtEditAmount" class="form-control" />
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Current File :</label>
                    <div id="currentFileLink"></div>
                </div>
                <div class="form-group">
                    <label>Replace File (Optional) :</label>
                    <input type="file" id="fpEditUpload" onchange="EditFileChange(this);" />
                    <input type="hidden" id="hfEditUploadedFile" />
                </div>
            </div>
            <div class="form-row">
                <div class="form-group" style="flex:1;">
                    <label>Description :</label>
                    <textarea class="form-control" id="txtEditDescription" rows="3"></textarea>
                </div>
            </div>
            <div class="form-row center">
                <input type="button" class="btn btn-success" value="Update Expense" onclick="UpdateExpense();" />
                <input type="button" class="btn btn-secondary" value="Cancel" onclick="closeEditExpenseModal();" style="margin-left:10px;" />
            </div>
        </div>
    </div>
</div>

    <!-- ======================== Styles ========================= -->
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            padding-top: 80px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 20px;
            border-radius: 6px;
            width: 85%;
            max-width: 700px;
        }

        .close {
            float: right;
            font-size: 22px;
            cursor: pointer;
            font-weight: bold;
        }

        @media (max-width: 600px) {

            .modal-content {
                width: 95% !important;
                padding: 15px;
            }

                .modal-content h3 {
                    font-size: 16px;
                    text-align: center;
                }

            .table-responsive {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            table {
                width: 600px;
            }

            .MyHeader, .MyCol {
                font-size: 11px !important;
                padding: 4px !important;
                white-space: nowrap;
                text-align: center !important;
            }

            .close {
                font-size: 20px;
            }

            .btn {
                width: 100%;
                font-size: 14px;
                padding: 10px 0 !important;
            }
        }


        .MyCol, .MyHeader {
            font-size: 12px;
            text-align: right;
            border: 1px solid #ccc;
            padding: 5px;
        }

        .MyHeader {
            font-weight: bold;
            color: #000;
        }

        .container {
            width: 100%;
            padding: 10px 15px;
            box-sizing: border-box;
        }

        .section-title {
            font-weight: bold;
            color: #000;
            font-size: 16px;
            text-align: center;
            width: 100%;
            border-bottom: 1px solid #ccc;
            padding-bottom: 5px;
        }

        /* Form Layout for Desktop */
        .responsive-form {
            margin-top: 15px;
            width: 100%;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            width: 100%;
        }

        .form-group {
            flex: 1;
            min-width: 180px;
            display: flex;
            flex-direction: column;
        }

            .form-group label {
                font-weight: 600;
                margin-bottom: 5px;
                color: #000;
                text-align: left;
            }

            .form-control,
            .form-group input[type="file"],
            .form-group select {
                padding: 6px;
                font-size: 13px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                width: 100%;
            }

        .center {
            justify-content: center;
            display: flex;
            margin-top: 10px;
        }

        .btn {
            padding: 8px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        /* Responsive for Mobile/Tablet */
        @media (max-width: 1024px) {
            .Header {
                margin-top: 30%;
            }

            .form-group {
                margin-bottom: -10px;
            }
        }


        @media (max-width: 1024px) {
            html, body {
                overflow-x: hidden;
                width: 100%;
                margin: 0;
                padding: 0;
            }

            .form-row {
                flex-direction: column;
                width: 100%;
            }

            .form-group {
                width: 100% !important;
            }

                .form-group label {
                    font-size: 14px;
                }

                .form-control,
                .form-group select,
                .form-group input[type="file"],
                .form-group input[type="text"],
                .form-group input[type="button"],
                .btn {
                    width: 100% !important;
                    display: block;
                    font-size: 14px;
                    margin-bottom: 15px;
                    box-sizing: border-box;
                }

            .btn {
                padding: 10px 0;
                font-size: 15px;
            }

            input[type="file"] {
                background-color: #fff;
            }

            .table-responsive {
                overflow-x: auto;
            }

            #tblExpense th,
            #tblExpense td {
                font-size: 11px;
                white-space: nowrap;
            }
        }

        #loaderOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.4);
            z-index: 10000;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            }

            .loader {
            border: 6px solid #f3f3f3;
            border-top: 6px solid #28a745;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            }

            .loader-text {
            margin-top: 10px;
            color: #fff;
            font-weight: bold;
            font-size: 14px;
            }

            @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
            }
    </style>

    <!-- ======================== Scripts ========================= -->
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script>
        var expenseData = [];
        var currentPage = 1;
        var pageSize = 10;
        var dateSortAsc = true;
        function EditExpense() {
            document.getElementById("editModal").style.display = "block";
        }

        function closeEditModal() {
            document.getElementById("editModal").style.display = "none";
        }



        // Select/Deselect All checkboxes
        $(document).on('change', '#chkSelectAll', function () {
            var isChecked = $(this).is(':checked');
            $('.chkSingle').prop('checked', isChecked);
        });

        // If any single checkbox is unchecked, uncheck Select All
        $(document).on('change', '.chkSingle', function () {
            if (!$(this).is(':checked')) {
                $('#chkSelectAll').prop('checked', false);
            } else {
                // If all checkboxes are checked, check Select All
                if ($('.chkSingle:checked').length === $('.chkSingle').length) {
                    $('#chkSelectAll').prop('checked', true);
                }
            }
        }
        );


        function OpenRbmPopup() {
            $('#txtManager').val('');
            $('#txtEmpCode').val('');
            $('#txtPlant').val('');
            $('#txtCompany').val('');
            $('#fpSignature').val('');
            $('#hfSignaturePath').val('');
            $('#lblSignatureFile').text('').hide();
            document.getElementById("submitModal").style.display = "block";
        }

        function closeSubmitModal() {
            document.getElementById("submitModal").style.display = "none";
        }


        function saveSelected() {
            alert("Selected expenses saved! (Dummy action)");
        }













        $(function () {
            $(".datepicker").datepicker({
                dateFormat: 'dd-M-yy',
                maxdate: 0
            });
        });

        $(document).ready(function () {
            BindExpenseMaster();
            Search();
            calculateAmount();
            function calculateAmount() {
                var qty = parseFloat($('#txtQuantity').val()) || 0;
                var rate = parseFloat($('#txtRate').val()) || 0;

                var amount = qty * rate;
                $('#txtAmount').val(amount);
            }

            // Trigger on change / typing
            $('#txtQuantity, #txtRate').on('input', function () {
                calculateAmount();
            });
        });

        function BindExpenseMaster() {
            $.ajax({
                url: "ExpenseManager.aspx/BindExpenseMaster",
                async: false,
                contentType: "application/json; charset=utf-8",
                type: "POST",
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    //if (data.length > 0) {
                    //    $.each(data, function (index, value) {
                    //        $('#ddlExpense').append('<option value="' + value.ExpenseId + '">' + value.Expense + '</option>');
                    //        $('#ddlExpenseSearch').append('<option value="' + value.ExpenseId + '">' + value.Expense + '</option>');
                    //    });
                    //}
                    if (data.length > 0) {
                        $('#ddlExpense').empty().append('<option value="">Select</option>');
                        $('#ddlEditExpense').empty().append('<option value="">Select</option>');
                        $.each(data, function (index, value) {
                            if (value.ExpenseId > 0) {
                                $('#ddlExpense').append('<option value="' + value.ExpenseId + '">' + value.Expense + '</option>');
                                $('#ddlEditExpense').append('<option value="' + value.ExpenseId + '">' + value.Expense + '</option>');
                            }
                        });
                    }
                }
            });
        }

        function Save() {
            var Date = $('#txtExpenseDate').val();
            var ExpenseId = $('#ddlExpense').val();
            var File = $('#hfUploadedFile').val();// $('#fpUpload').val();
            var Description = $('#txtExpenseDescription').val();
            var Quantity = $('#txtQuantity').val();
            var Rate = $('#txtRate').val();
            var Amount = $('#txtAmount').val();
            var hdnUserId = $('#ContentPlaceHolder1_hdnUserId').val();

            if (Date == "" || ExpenseId == "" || Amount == "") {
                alert('Date, Expense On, and Amount are mandatory fields');
                return;
            }

            var obj = new Object();
            var data = new Array();
            obj.Date = Date;
            obj.ExpenseId = ExpenseId;
            obj.File = File;
            obj.Description = Description;
            obj.Amount = Amount;
            obj.userId = hdnUserId;
            obj.Quantity = Quantity;
            obj.Rate = Rate;
            data.push(obj);

            $.ajax({
                url: "ExpenseManager.aspx/Save",
                async: true,
                data: JSON.stringify({ data: data }),
                contentType: "application/json; charset=utf-8",
                type: "POST",
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        alert('Expense entered successfully!');
                        Search();
                        Clear();
                    } else {
                        alert('Some Error Occurred!');
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function sortByDate() {

            expenseData.sort(function (a, b) {

                var d1 = parseDate(a.ExpenseDate);
                var d2 = parseDate(b.ExpenseDate);

                return dateSortAsc ? d1 - d2 : d2 - d1;
            });

            dateSortAsc = !dateSortAsc;

            // Update icon
            $('#dateSortIcon').text(dateSortAsc ? '▲' : '▼');

            currentPage = 1;
            renderExpenseTable();
        }

        function parseDate(dateStr) {
            if (!dateStr) return 0;

            var parts = dateStr.split('-'); // dd-MMM-yyyy
            var day = parseInt(parts[0], 10);
            var month = new Date(Date.parse(parts[1] + " 1, 2000")).getMonth();
            var year = parseInt(parts[2], 10);

            return new Date(year, month, day).getTime();
        }

        function Search() {
            var FromDate = $('#txtFromDate').val();
            var ToDate = $('#txtToDate').val();
            var ExpenseId = $('#ddlExpenseSearch').val();
            var hdnUserId = $('#ContentPlaceHolder1_hdnUserId').val();
            var UserId = hdnUserId;//localStorage.getItem("UserId");
            var totExpense = 0;
            $.ajax({
                url: "ExpenseManager.aspx/SearchExpense",
                async: true,
                data: JSON.stringify({ FromDate: FromDate, ToDate: ToDate, ExpenseId: ExpenseId, UserId: UserId }),
                contentType: "application/json; charset=utf-8",
                type: "POST",
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    expenseData = $.parseJSON(result.d);
                    currentPage = 1;
                    renderExpenseTable();
                },
                error: function (xhr, status, error) {
                    // This is where ACTUAL exceptions and errors are caught
                    hideLoader();

                    var errorMessage = "An error occurred while searching expenses.";

                    console.error("AJAX Error Details:");
                    console.error("Status:", status);                    // e.g., "timeout", "error", "abort", "parsererror"
                    console.error("Error Thrown:", error);               // e.g., exception message
                    console.error("HTTP Status Code:", xhr.status);      // e.g., 500, 404, 0
                    console.error("Response Text:", xhr.responseText);   // Full server response (very useful!)
                    console.error("Full XHR Object:", xhr);

                    if (status === "timeout") {
                        errorMessage = "Request timed out. Please try again.";
                    } else if (status === "parsererror") {
                        errorMessage = "Failed to parse server response. Invalid JSON returned.";
                    } else if (xhr.status === 500) {
                        errorMessage = "Server error occurred. Check logs or contact admin.";
                    } else if (xhr.status === 404) {
                        errorMessage = "Search endpoint not found.";
                    } else if (xhr.status === 0) {
                        errorMessage = "No network connection or server unreachable.";
                    }

                    alert(errorMessage + "\nCheck browser console (F12) for detailed error logs.");
                }
                //success: function (result) {
                //    var data = $.parseJSON(result.d);
                //    $('#tblExpense tr').slice(1).remove();
                //    $.each(data, function (index, value) {
                //        totExpense += value.Amount;
                //        var html = '<tr>';
                //        html += '<td class="MyHeader"><input type="checkbox" class="chkSingle" data-id="' + value.ID + '" /></td>';

                //        html += '<td class="MyHeader">' + (index + 1) + '</td>';
                //        html += '<td class="MyHeader">' + value.ExpenseDate + '</td>';
                //        html += '<td class="MyHeader">' + value.Expense + '</td>';
                //        html += '<td class="MyHeader">' + value.Amount + '</td>';
                //        html += '<td class="MyHeader">' + value.Description + '</td>';
                //        html += '<td class="MyHeader">';
                //        if (value.ExpenseFile != '') {
                //            html += '<a href="../Uploads/Expense/' + value.ExpenseFile + '" target="_blank" style="color:#09f;">View Bill</a>';
                //        }
                //        html += '</td>';
                //        html += '<td class="MyHeader">' + value.EntryDate + '</td>';
                //        html += '<td class="MyHeader"><button type="button" class="btn btn-warning btn-sm" onclick="EditExpense(' + value.ID + ')">Edit</button></td>';

                //        html += '</tr>';
                //        $('#tblExpense').append(html);
                //    });
                //    $('#lblExpenseAmt').text(totExpense);
                //}
            });
        }

        function renderExpenseTable() {

            $('#tblExpense tr').slice(1).remove();
            var totExpense = 0;

            var start = (currentPage - 1) * pageSize;
            var end = start + pageSize;
            var pageData = expenseData.slice(start, end);

            $.each(pageData, function (index, value) {

                totExpense += value.Amount;

                var html = '<tr>';
                if (value.Status != "Reimbursement Created") {
                    html += '<td class="MyHeader"><input type="checkbox" class="chkSingle" data-id="' + value.ID + '" /></td>';
                }
                else {
                    html += '<td class="MyHeader"><input type="checkbox" disabled class="chkSingle" data-id="' + value.ID + '" /></td>';
                    //html += '<td class="MyHeader"></td>';
                }
                html += '<td class="MyHeader">' + (start + index + 1) + '</td>';
                html += '<td class="MyHeader">' + value.ExpenseDate + '</td>';
                html += '<td class="MyHeader">' + value.Expense + '</td>';
                html += '<td class="MyHeader">' + value.Rate + '</td>';
                html += '<td class="MyHeader">' + value.Quantity + '</td>';
                html += '<td class="MyHeader">' + value.Amount + '</td>';
                html += '<td class="MyHeader">' + value.Description + '</td>';
                html += '<td class="MyHeader">';
                if (value.ExpenseFile) {
                    html += '<a href="../Uploads/Expense/' + value.ExpenseFile + '" target="_blank">View Bill</a>';
                }
                html += '</td>';
                /*html += '<td class="MyHeader">' + value.EntryDate + '</td>';*/
                if (value.Status != "Reimbursement Created") {
                    //html += '<td class="MyHeader"><button type="button" class="btn btn-warning btn-sm" onclick="EditExpense(' + value.ID + ')">Edit</button></td>';
                    html += '<td class="MyHeader">' +
                        '<button type="button" class="btn btn-warning btn-sm" onclick="OpenEditModal(' + value.ID + ')">Edit</button>' +
                        '</td>';
                }
                else {
                    html += '<td class="MyHeader">' +
                        '<a href="javascript:void(0);" onclick="openExpensePdf(\'' + value.PdfPath + '\')">' +
                        'View Reimbursement</a></td>';
                }
                html += '</tr>';

                $('#tblExpense').append(html);
            });
            $('#lblExpenseAmt').text(
                expenseData.reduce((sum, x) => sum + parseFloat(x.Amount || 0), 0)
                    .toFixed(2)
            );

            updatePageInfo();
        }

        function updatePageInfo() {
            var totalPages = Math.ceil(expenseData.length / pageSize);
            $('#pageInfo').text("Page " + currentPage + " of " + totalPages);
        }

        function nextPage() {
            if (currentPage * pageSize < expenseData.length) {
                currentPage++;
                renderExpenseTable();
            }
        }

        function prevPage() {
            if (currentPage > 1) {
                currentPage--;
                renderExpenseTable();
            }
        }

        function FileChange(ctrl) {
            ImgPreview(ctrl.files, ctrl);
        }

        function ImgPreview(input, ctrl) {
            var file = input[0];
            var fileType = file["type"];
            var ValidImageTypes = ["image/gif", "image/jpeg", "image/png", "image/jpg"];
            if ($.inArray(fileType, ValidImageTypes) < 0) {
                alert("Only '.jpeg', '.jpg', '.png', '.gif' formats are allowed");
                $(ctrl).val('');
            } else {
                if (input && input[0]) {
                    var data = new FormData();
                    data.append(input[0].name, input[0]);
                    $.ajax({
                        url: "../AjaxResponsePages/AsyAttachement_HandlerFile.ashx?callFor=Expense",
                        type: "POST",
                        async: true,
                        data: data,
                        contentType: false,
                        processData: false,
                        success: function (response) {
                            $('#hfUploadedFile').val(response);
                        }
                    });
                }
            }
        }

        function Clear() {
            $('#txtExpenseDate').val('');
            $('#ddlExpense').val('0');
            $('#txtAmount').val('');
            $('#fpUpload').val('');
            $('#txtQuantity').val('0');
            $('#txtRate').val('0');
            $('#txtExpenseDescription').val('');
        }

        function parseDateSafe(dateStr) {
            var parts = dateStr.split('-'); // yyyy-MM-dd
            return new Date(
                parseInt(parts[0], 10),
                parseInt(parts[1], 10) - 1,
                parseInt(parts[2], 10)
            ).getTime();
        }

        function GenerateReimbursementDoc() {

            var selectedIds = [];
            var selectedDates = [];

            // Loop through all rows except header
            $('#tblExpense tr').not(':first').each(function () {

                var checkbox = $(this).find('.chkSingle');

                if (checkbox.is(':checked')) {
                    var id = checkbox.attr('data-id');
                    if (id) {
                        selectedIds.push(Number(id));
                    }
                    // ExpenseDate is in 3rd column (index 2)
                    var expenseDateText = $(this).find('td').eq(2).text().trim();
                    if (expenseDateText) {
                        selectedDates.push(expenseDateText);
                    }
                }
            });

            if (selectedIds.length === 0) {
                alert("Please select at least one expense.");
                return;
            }
            // Build comparable list
            var parsedDates = selectedDates.map(d => ({
                original: d,
                time: parseDateSafe(d)
            }));

            // Find start & end
            var startObj = parsedDates.reduce((min, cur) =>
                cur.time < min.time ? cur : min
            );

            var endObj = parsedDates.reduce((max, cur) =>
                cur.time > max.time ? cur : max
            );

            var startDateStr = startObj.original;
            var endDateStr = endObj.original;
            showLoader(); 
            var hdnUserId = $('#ContentPlaceHolder1_hdnUserId').val();
            var payload = {
                createdBy: hdnUserId,
                managerName: $('#txtManager').val(),
                plantCode: $('#txtPlant').val(),
                companyName: $('#txtCompany').val(),
                signature: $('#hfSignaturePath').val(),
                employeeCode: $('#txtEmpCode').val(),
                pdfPath: '',
                id: selectedIds[0],
                expenseIds: selectedIds,
                startExpenseDate: startDateStr,
                endExpenseDate: endDateStr
            };
            $.ajax({
                url: "ExpenseManager.aspx/CallSaveReimbursementAPI",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ payload: payload }),
                success: function (res) {
                    hideLoader();
                    var result = JSON.parse(res.d);
                    alert("Reimbursement Created with batch id: " + result.batchID);
                    Search();
                    closeSubmitModal();
                },
                error: function (err) {
                    hideLoader();
                    console.log(err);
                    alert("Server Error!");
                }
            });
        }

        //var canvas = document.getElementById('signatureCanvas');
        //var signaturePad = new SignaturePad(canvas);

        var signaturePad = null;
        function openSignatureModal() {
            document.getElementById("signatureModal").style.display = "block";
            setTimeout(function () {
                var canvas = document.getElementById("signatureCanvas");
                if (!signaturePad) {
                    signaturePad = new SignaturePad(canvas);
                } else {
                    signaturePad.clear();
                }
            }, 100);
        }

        function closeSignatureModal() {
            document.getElementById("signatureModal").style.display = "none";
        }

        function clearSignature() {
            if (signaturePad) {
                signaturePad.clear();
            }
        }

        function saveSignature() {
            var selectedIds = [];
            $('#tblExpense tr').not(':first').each(function () {

                var checkbox = $(this).find('.chkSingle');

                if (checkbox.is(':checked')) {
                    var id = checkbox.attr('data-id');
                    if (id) {
                        selectedIds.push(Number(id));
                    }
                }
            });

            if (selectedIds.length === 0) {
                alert("Please select at least one expense.");
                return;
            }

            if (signaturePad.isEmpty()) {
                alert("Please provide a signature.");
                return;
            }

            var base64Image = signaturePad.toDataURL("image/png");
            var expenseIds = selectedIds.join('_');
            showLoader(); 
            $.ajax({
                url: "ExpenseManager.aspx/SaveSignature",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ imageData: base64Image, expenseIds: expenseIds }),
                success: function (res) {
                    if (res.d !== "") {
                        hideLoader();
                        $('#hfSignaturePath').val(res.d);
                        $('#lblSignatureFile').text(res.d).show();
                        alert("Signature saved successfully!");
                        closeSignatureModal();
                    } else {
                        hideLoader();
                        alert("Error saving signature.");
                    }
                }
            });
        }

        function showLoader() {
            $('#loaderOverlay').show();
        }

        function hideLoader() {
            $('#loaderOverlay').hide();
        }

        function openExpensePdf(fileName) {
            if (fileName == '') {
                alert('File not found');
                return;
            }
            //var pdfUrl = "https://198.38.88.185/api/Download/DownloadPdf" //"https://localhost:7089/api/Download/DownloadPdf"
            var pdfUrl = "https://localhost:7089/api/Download/DownloadPdf"
                + "?fileName=" + encodeURIComponent(fileName);
            window.open(pdfUrl, "_blank");
        }

        function validateRate(input) {
            // Allow numbers with up to 2 decimal places
            input.value = input.value
                .replace(/[^0-9.]/g, '')          // remove non-numeric
                .replace(/(\..*)\./g, '$1');      // allow only one decimal

            if (input.value.includes('.')) {
                let parts = input.value.split('.');
                parts[1] = parts[1].substring(0, 2); // max 2 digits after decimal
                input.value = parts.join('.');
            }
        }
        var currentEditingId = 0; // To track which expense is being edited

        function OpenEditModal(expenseId) {
            var expense = expenseData.find(function (item) {
                return item.ID == expenseId;
            });

            if (!expense) {
                alert("Expense not found!");
                return;
            }

            currentEditingId = expense.ID;

            // Populate modal fields
            $('#txtEditExpenseDate').val(expense.ExpenseDate);
            $('#ddlEditExpense').val(expense.ExpenseId);
            $('#txtEditRate').val(expense.Rate || 0);
            $('#txtEditQuantity').val(expense.Quantity || 1);
            $('#txtEditAmount').val(expense.Amount);
            $('#txtEditDescription').val(expense.Description || '');
            $('#hfEditUploadedFile').val(expense.ExpenseFile || '');

            // Show current file link
            var fileHtml = '';
            if (expense.ExpenseFile) {
                fileHtml = '<a href="../Uploads/Expense/' + expense.ExpenseFile + '" target="_blank" style="color:#007bff;">View Current Bill</a>';
            } else {
                fileHtml = '<span style="color:gray;">No file uploaded</span>';
            }
            $('#currentFileLink').html(fileHtml);

            // Clear new file input
            $('#fpEditUpload').val('');

            // Open modal
            document.getElementById("editExpenseModal").style.display = "block";
        }

        function closeEditExpenseModal() {
            document.getElementById("editExpenseModal").style.display = "none";
            currentEditingId = 0;
        }

        // Calculate amount in edit modal
        function calculateEditAmount() {
            var qty = parseFloat($('#txtEditQuantity').val()) || 0;
            var rate = parseFloat($('#txtEditRate').val()) || 0;
            var amount = qty * rate;
            $('#txtEditAmount').val(amount.toFixed(2));
        }

        $('#txtEditQuantity, #txtEditRate').on('input', function () {
            calculateEditAmount();
        });

        // File upload for edit
        function EditFileChange(ctrl) {
            ImgPreview(ctrl.files, ctrl, 'hfEditUploadedFile');
        }

        // Modified ImgPreview to support different hidden field
        function ImgPreview(input, ctrl, hiddenFieldId = 'hfUploadedFile') {
            var file = input[0];
            var fileType = file["type"];
            var ValidImageTypes = ["image/gif", "image/jpeg", "image/png", "image/jpg", "application/pdf"];
            if ($.inArray(fileType, ValidImageTypes) < 0) {
                alert("Only image or PDF files are allowed");
                $(ctrl).val('');
                return;
            }

            if (input && input[0]) {
                var data = new FormData();
                data.append(input[0].name, input[0]);
                $.ajax({
                    url: "../AjaxResponsePages/AsyAttachement_HandlerFile.ashx?callFor=Expense",
                    type: "POST",
                    async: true,
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        $('#' + hiddenFieldId).val(response);
                    }
                });
            }
        }

        function UpdateExpense() {
            var Date = $('#txtEditExpenseDate').val().trim();
            var ExpenseId = $('#ddlEditExpense').val();
            var File = $('#hfEditUploadedFile').val(); // New file if uploaded, else old one
            var Description = $('#txtEditDescription').val().trim();
            var Quantity = $('#txtEditQuantity').val() || '1';
            var Rate = $('#txtEditRate').val() || '0';
            var Amount = $('#txtEditAmount').val();
            var hdnUserId = $('#ContentPlaceHolder1_hdnUserId').val();

            if (Date == "" || !ExpenseId || Amount == "0") {
                alert('Please fill all required fields.');
                return;
            }

            var obj = {
                ID: currentEditingId,
                Date: Date,
                ExpenseId: ExpenseId,
                File: File,
                Description: Description,
                Amount: Amount,
                userId: hdnUserId,
                Quantity: Quantity,
                Rate: Rate
            };
            showLoader();
            $.ajax({
                url: "ExpenseManager.aspx/UpdateExpense",
                async: true,
                data: JSON.stringify({ data: [obj] }),
                contentType: "application/json; charset=utf-8",
                type: "POST",
                dataType: "json",
                success: function (result) {
                    hideLoader();
                    if (result.d == "1") {
                        alert('Expense updated successfully!');
                        closeEditExpenseModal();
                        Search(); // Refresh table
                    } else {
                        alert('Error updating expense.');
                    }
                },
                error: function () {
                    hideLoader();
                    alert('Server error during update.');
                }
            });
        }

    </script>

    <div id="loaderOverlay" style="display:none;">
    <div class="loader"></div>
    <div class="loader-text">Please wait...</div>
</div>
</asp:Content>
