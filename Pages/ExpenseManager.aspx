<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ExpenseManager.aspx.cs" Inherits="WSBillingMaster.Pages.ExpenseManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                        <label>Amount :</label>
                        <input type="text" id="txtAmount" class="form-control" maxlength="5" />
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
			<div class="section-title">Total Expense : Rs. <span id="lblExpenseAmt" style="color:LawnGreen;font-size:Large;">0</span> </div>
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
                        <th class="MyHeader">Date</th>
                        <th class="MyHeader">Expense On</th>
                        <th class="MyHeader">Amount</th>
                        <th class="MyHeader">Description</th>
                        <th class="MyHeader">File</th>
                        <th class="MyHeader">EntryDate</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>




        <!-- ====================== Modal ====================== -->
<div id="submitModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeSubmitModal();">&times;</span>
        <h3>Details which needs to be displayed on header </h3>
    <div id="rbmPopup" title="Submit Reimbursement" style="display:visible;">
    <label>Reporting Manager</label>
    <input type="text" id="txtManager" class="form-control" />

    <label>Employee Code</label>
    <input type="text" id="txtEmpCode" class="form-control" />

    <label>Company Name</label>
    <input type="text" id="txtCompany" class="form-control" />

    <label>Plant Code</label>
    <input type="text" id="txtPlant" class="form-control" />

    <label>Signature (Upload)</label>
    <input type="file" id="fpSignature" onchange="UploadSignature();" />

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
            .Header{
                margin-top:30%;
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
    </style>

    <!-- ======================== Scripts ========================= -->
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script>

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
                    if (data.length > 0) {
                        $.each(data, function (index, value) {
                            $('#ddlExpense').append('<option value="' + value.ExpenseId + '">' + value.Expense + '</option>');
                            $('#ddlExpenseSearch').append('<option value="' + value.ExpenseId + '">' + value.Expense + '</option>');
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
            var Amount = $('#txtAmount').val();

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
                }
            });
        }

        function Search() {
            var FromDate = $('#txtFromDate').val();
            var ToDate = $('#txtToDate').val();
            var ExpenseId = $('#ddlExpenseSearch').val();
	    var UserId = localStorage.getItem("UserId");
			var totExpense = 0;

            $.ajax({
                url: "ExpenseManager.aspx/SearchExpense",
                async: true,
                data: JSON.stringify({ FromDate: FromDate, ToDate: ToDate, ExpenseId: ExpenseId, UserId: UserId  }),
                contentType: "application/json; charset=utf-8",
                type: "POST",
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    $('#tblExpense tr').slice(1).remove();
                    $.each(data, function (index, value) {
					totExpense += value.Amount;
                        var html = '<tr>';
                        html += '<td class="MyHeader"><input type="checkbox" class="chkSingle" /></td>';

                        html += '<td class="MyHeader">' + (index + 1) + '</td>';
                        html += '<td class="MyHeader">' + value.ExpenseDate + '</td>';
                        html += '<td class="MyHeader">' + value.Expense + '</td>';
                        html += '<td class="MyHeader">' + value.Amount + '</td>';
                        html += '<td class="MyHeader">' + value.Description + '</td>';
                        html += '<td class="MyHeader">';
                        if (value.ExpenseFile != '') {
                            html += '<a href="../Uploads/Expense/' + value.ExpenseFile + '" target="_blank" style="color:#09f;">View Bill</a>';
                        }
                        html += '</td>';
                        html += '<td class="MyHeader">' + value.EntryDate + '</td>';
                        html += '<td class="MyHeader"><button type="button" class="btn btn-warning btn-sm" onclick="EditExpense(' + value.Id + ')">Edit</button></td>';

                        html += '</tr>';
                        $('#tblExpense').append(html);
                    });
					$('#lblExpenseAmt').text(totExpense);
                }
            });
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
            $('#txtExpenseDescription').val('');
        }
    </script>
</asp:Content>
