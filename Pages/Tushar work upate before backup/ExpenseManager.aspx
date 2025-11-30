<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ExpenseManager.aspx.cs" Inherits="WSBillingMaster.Pages.ExpenseManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="Header">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                Expense Manager

            </div>
            <div style="padding-top: 15px;">
                <table id="tblItem" style="width: 100%; margin-top: 30px; color: #000; font-size: 11px;">
                    <tr>
                        <td style="text-align: right; width: 80px; font-weight: 600">Expense Date : &nbsp;</td>
                        <td style="text-align: left; width: 100px;">
                            <input type="text" class="form-control datepicker" id="txtExpenseDate" />
                        </td>
                        <td style="text-align: right; width: 80px; font-weight: 600">Expense On :&nbsp; </td>
                        <td style="text-align: left; width: 100px;">
                            <select id="ddlExpense" class="form-control" style="width: 150px;">
                            </select>
                        </td>
                        <td style="text-align: left; width: 50px;">
                            Amount :&nbsp;
                        </td>
                         <td style="text-align: left; width: 70px;">
                            <input type="text" id="txtAmount" class="form-control" style="width: 70px" maxlength="5"  />
                        </td>
                        <td style="text-align: right; width: 80px; font-weight: 600">Upload :&nbsp;</td>
                        <td style="text-align: left; width: 100px;">
                            <input type="file" id="fpUpload" onchange="FileChange(this);" style="width: 150px" value="" />
                        </td>

                        <td style="text-align: right; width: 80px; font-weight: 600">Description :&nbsp; </td>
                        <td style="text-align: left; width: 120px;">
                            <input type="text" class="form-control" id="txtExpenseDescription" />
                        </td>


                    </tr>
                    <tr>


                        <td colspan="10" style="text-align: center; padding-top: 20px;">
                            <input type="button" class="btn btn-danger" value="Save" onclick="Save();" style="width: 200px;" />
                        </td>


                    </tr>
                </table>
            </div>
        </div>
        <div class="Header" style="margin-top: 10px;">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                All Expenses

            </div>
            <div style="padding-top: 15px;">
                <div class="col-md-12">
                    <table width="100%" style="color: #000; font-size: 12px; margin: 15px;">
					<tr>
						<td colspan="7" style="text-align: right; padding-right: 6em;">Total Expense : Rs. <span id="lblExpenseAmt" style="color:LawnGreen;font-size:Large;">0</span> </td>
					</tr>
                        <tr>
                            <td style="text-align: right; width: 70px; font-weight: 600">From Date : &nbsp;</td>
                            <td style="text-align: left; width: 150px;">
                                <input type="text" class="form-control datepicker" id="txtFromDate" />
                            </td>
                            <td style="text-align: right; width: 70px; font-weight: 600">To Date : &nbsp;</td>
                            <td style="text-align: left; width: 200px;">
                                <input type="text" class="form-control datepicker" id="txtToDate" style="width:150px;" />
                            </td>
                            <td style="text-align: right; width: 80px; font-weight: 600">Expense On : &nbsp;</td>
                            <td style="text-align: left; width: 150px;">
                                <select id="ddlExpenseSearch" class="form-control" style="width: 150px;">
                                </select>
                            </td>
                            <td>
                                <input type="button" class="btn btn-success" value="Search" onclick="Search();" style="width: 200px;" />
                            </td>
                        </tr>
                    </table>
                </div>
                <table id="tblExpense" style="width: 100%;">
                    <tr>
                        <th class="MyHeader" style="width: 20px;">SNo.</th>

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
            $(".datepicker").datepicker({
                dateFormat: 'dd-M-yy',
                maxdate:0
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
                //data: JSON.stringify({ LtID: LtID }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    if (data.length > 0) {
                        $.each(data, function (index, value) {
                            $('#ddlExpense').append('<option value="' + value.ExpenseId + '" >' + value.Expense + '</option>');
                            $('#ddlExpenseSearch').append('<option value="' + value.ExpenseId + '" >' + value.Expense + '</option>');
                        });
                    }
                }
            });
        }


        function Save() {
            var Date = $('#txtExpenseDate').val();
            var ExpenseId = $('#ddlExpense').val();
            var File = $('#fpUpload').val();
            var Description = $('#txtExpenseDescription').val();
            var Amount = $('#txtAmount').val();


            if (Date == "" || ExpenseId == "" || Amount=="") {
                alert('Date and Expense on  & Amount are mandatory fields');
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
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        alert('Expense entered successfully !');
                        Search();
                        Clear();
                    } else {
                        alert('Some Error Occured !');

                    }
                }
            });


        }

        function Search() {
            var FromDate = $('#txtFromDate').val();
            var ToDate = $('#txtToDate').val();
            var ExpenseId = $('#ddlExpenseSearch').val();


            $.ajax({
                url: "ExpenseManager.aspx/SearchExpense",
                async: true,
                data: JSON.stringify({ FromDate: FromDate,ToDate:ToDate,ExpenseId:ExpenseId }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data=$.parseJSON(result.d);
                    $('#tblExpense tr').slice(1).remove();
                    $.each(data, function (index, value) {
                        //					
                        var html = '<tr>';
                        html += '<td class="MyHeader">' + (index + 1) + '</td>'
                        html += '<td class="MyHeader">' + value.ExpenseDate + '</td>'
                        html += '<td class="MyHeader">' + value.Expense + '</td>'
                        html += '<td class="MyHeader">' + value.Amount + '</td>'
                        html += '<td class="MyHeader">' + value.Description + '</td>'
                        html += '<td class="MyHeader">';
                        if (value.ExpenseFile != '')
                        {
                            html+='<a href="../Uploads/Expense/'+value.ExpenseFile + '" target="_blank" style="color:#09f;" >View Bill</> '
                        }
                        html+='</td>'
                        html += '<td class="MyHeader">' + value.EntryDate + '</td>'
                        html += '</tr>';
                        $('#tblExpense').append(html);

                    });
                   
                }
            });


        }

        function FileChange(ctrl) {
            var ItemId = $(ctrl).next().val();
            ImgPreview(ctrl.files, ctrl);
        }

        function ImgPreview(input, ctrl) {
            debugger
            var file = input[0];
           
            var fileType = file["type"];
            var ValidImageTypes = ["image/gif", "image/jpeg", "image/png", "image/jpg"];
            if ($.inArray(fileType, ValidImageTypes) < 0) {
                alert("Only '.jpeg', '.jpg', '.png', '.gif' formats are allowed");
                // $('#ImgPreView').attr('src', '../images/drag-drop-upload.gif');
                $(ctrl).val('');
            }
            else {
                debugger;
                if (input && input[0]) {
                    var filerdr = new FileReader();
                    filerdr.onload = function (e) {

                        // $('#divImages').append("<div style='position:relative;float:left;display:flex;'><img src='../images/System/Delete.gif' style='position: absolute;right: 0;top: 0;background-color: #fff;border-radius: 100%;padding: 3px;' onclick='Delete(this);' /><img id='imgPackImage' src='" + e.target.result + "' style='max-height:100px;float:left;display:flex;' class='img-responsive img-thumbnail PackageImage' /><input type='hidden' id='hdnUploadedImage' value='" + input[0].name.replace('^', '') + "'></div>");
                        //$(ctrl).parent().parent().find('#ImgPreView').attr('src', e.target.result);
                    }
                    filerdr.readAsDataURL(input[0]);

                    //            var fileUpload = $('[id$=' + input.id + ']').get(0);
                    //            var files = fileUpload.files;
                    var data = new FormData();
                    //            for (var i = 0; i < files.length; i++) {
                    data.append(input[0].name, input[0]);
                    // }
                    //var Path = '../images/Slider/Temp';
                    $('#hdnFileName').val(input[0].name);
                    $.ajax({
                        url: "../AjaxResponsePages/AsyAttachement_HandlerFile.ashx?callFor=Expense",
                        type: "POST",
                        async: true,
                        data: data,
                        contentType: false,
                        processData: false,
                        success: function (result) {
                            //  $('#ImgPreView').attr('src', e.target.result);
                        },
                        error: function (err) {

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
