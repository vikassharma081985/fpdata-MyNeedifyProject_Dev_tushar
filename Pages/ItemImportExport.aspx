<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" 
    CodeBehind="ItemImportExport.aspx.cs" ValidateRequest="false" 
    Inherits="WSBillingMaster.Pages.ItemImportExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
 /* ✅ Common Container */
.import-export-container {
    padding: 20px;
}

/* ✅ Step & Manual Tables Styling */
.responsive-table {
    width: 100%;
    border-collapse: collapse;
    table-layout: fixed; /* ✅ equal width columns */
}

.responsive-table th,
.responsive-table td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* ✅ Header - Blue */
.responsive-table th {
    background: #6a8fe8; /* 🔵 Blue */
    color: #fff;
    font-weight: bold;
}

/* ✅ Desktop (default) */
@media (min-width: 992px) {
    .responsive-table th,
    .responsive-table td {
        display: table-cell;
    }
}

/* ✅ Tablet */
@media (min-width: 768px) and (max-width: 991px) {
    .responsive-table {
        font-size: 14px;
    }
    .responsive-table th,
    .responsive-table td {
        padding: 8px;
    }
}

/* ✅ Mobile - Card Boxes */
@media (max-width: 767px) {

    .responsive-table,
    .responsive-table thead,
    .responsive-table tbody,
    .responsive-table th,
    .responsive-table td,
    .responsive-table tr {
        display: block;
        width: 100%;
    }

    /* Hide table header */
    .responsive-table thead { display: none; }

    /* Row as card */
    .responsive-table tr {
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 10px;
        background: #fafafa;
    }

    /* Each cell as box */
    .responsive-table td {
        display: block;
        width: 100%;
        text-align: left;
        border: 1px solid #ddd;
        border-radius: 6px;
        margin-bottom: 10px;
        padding: 12px 10px 12px 50%;
        position: relative;
        box-sizing: border-box;
        background: #fff;
    }

    /* Label inside box */
    .responsive-table td::before {
        content: attr(data-label);
        position: absolute;
        left: 10px;
        top: 12px;
        font-weight: bold;
        color: #6a8fe8; /* blue like header */
        white-space: nowrap;
    }

    /* Wrap cell value in span */
    .responsive-table td span.value {
        display: block;
        margin-top: 18px;
        font-weight: normal;
        color: #333;
    }

    /* ✅ GST & Profit Margin columns inputs & selects visible on mobile */
    .gst-column select,
    .gst-column input,
    .pm-column select,
    .pm-column input {
        display: block;
        width: 90%;      /* Fit inside the card */
        margin-top: 5px; /* Spacing between dropdown and input */
        box-sizing: border-box;
    }
    @media (max-width: 767px) {
    .gst-column .gst-wrapper select,
    .gst-column .gst-wrapper input,
    .pm-column .pm-wrapper select,
    .pm-column .pm-wrapper input {
        display: block;
        width: 90%;
        margin-top: 5px;
        box-sizing: border-box;
    }
}
}


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="import-export-container">
        <div class="Header mb-3 fw-bold fs-4">
            Import/Export Items
        </div>

        <!-- ✅ Step Section -->
        <div class="Content mb-2">
            <div class="table-responsive">
                <table class="responsive-table">
                    <thead>
                        <tr>
                            <th>Step 1</th>
                            <th>Step 2</th>
                            <th>Step 3</th>
                            <th>Step 4</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td data-label="Step 1">
                                <asp:Button ID="btnDownload" runat="server" CssClass="btn btn-danger w-100"
                                    OnClick="btnDownload_Click" OnClientClick="return GetTemplate();" 
                                    Text="Download Template" />
                            </td>
                            <td data-label="Step 2">
                                <asp:FileUpload ID="fpUpload" runat="server" CssClass="form-control" />
                            </td>
                            <td data-label="Step 3">
                                <asp:Button ID="btnUpload" runat="server" CssClass="btn btn-warning w-100"
                                    OnClick="btnupload_Click" Text="Upload File" />
                            </td>
                            <td data-label="Step 4">
                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success w-100"
                                    OnClientClick="return Save();" OnClick="btnSave_Click" 
                                    Text="Save to Database" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ✅ Manual Entry Header Table -->
        <div id="divContentManual" runat="server" class="manual-entry-container">
            <table class="responsive-table" id="tblHeader">
                <tr>
                    <th>Item Name</th>
                    <th>Category</th>
                    <th>Batch No</th>
                    <th>Size</th>
                    <th>Cost</th>
                    <th>GST</th>
                    <th>Freight</th>
                    <th>Misc</th>
                    <th>Profit Margin</th>
                    <th>MRP</th>
                    <th>Stock</th>
                    <th>Remarks</th>
                    <th></th>
                </tr>
            </table>

            <!-- ✅ Manual Entry Data Row -->
            <table class="responsive-table" id="tblData">
                <tr>
                    <td data-label="Item Name"><input type="text" id="txtItemNameMAN" style="height: 30px;width:100%;" placeholder="Item Name" /></td>
                    <td data-label="Category">
                        <select id="ddlCategory" onchange="ChangeCategory(this);" style="height: 30px;width:100%;"></select>
                        <input type="text" id="txtCategoryMAN" placeholder="Category" style="display: none;" />
                    </td>
                    <td data-label="Batch No"><input type="text" id="txtBatchNoMAN" style="height: 30px;width:100%;" placeholder="Batch No" /></td>
                    <td data-label="Size"><input type="text" id="txtSizeMAN" style="height: 30px;width:100%;"placeholder="Size" /></td>
                    <td data-label="Cost"><input type="text" id="txtCostMAN" maxlength="4" style="height: 30px;width:100%;" class="NumberOnly" placeholder="Cost" onkeyup="CalculateMRP(this);" /></td>
                    <td data-label="GST" class="gst-column">
    <div class="gst-wrapper">
        <select id="ddlGSTType" style="width: 50%; height: 34px;" onchange="ChangeProfitMarginType(this);">
            <option value="1">Rs.</option>
            <option value="2">Per(%)</option>
        </select>
        <input type="text" id="txtGSTMAN" maxlength="4" style="width: 50%; height: 30px;"; class="NumberOnly" placeholder="GST" onkeyup="CalculateMRP(this);" />
    </div>
</td>

                    <td data-label="Freight"><input type="text" id="txtFreightMAN" maxlength="4" style="height: 30px;width:100%;" class="NumberOnly" placeholder="Freight" onkeyup="CalculateMRP(this);" /></td>
                    <td data-label="Misc"><input type="text" id="txtMiscMAN" maxlength="4" class="NumberOnly" style="height: 30px;width:100%;" placeholder="MISC" onkeyup="CalculateMRP(this);" /></td>
                    <td data-label="Profit Margin" class="pm-column">
    <div class="pm-wrapper">
        <select id="ddlPMType" style="width: 50%; height: 30px;" onchange="ChangeProfitMarginType(this);">
            <option value="1">Rs.</option>
            <option value="2">Per(%)</option>
        </select>
        <input type="text" id="txtProfitMarginMAN" maxlength="4" style="height: 30px;width:50%;" class="NumberOnly" placeholder="Profit Margin" onkeyup="CalculateMRP(this);" />
    </div>
</td>

                    <td data-label="MRP"><input type="text" id="txtMRPMAN" style="height: 30px;width:100%;" placeholder="MRP" readonly="readonly" /></td>
                    <td data-label="Stock"><input type="text" id="txtStockMAN" style="height: 30px;width:100%;" class="NumberOnly" placeholder="Stock" /></td>
                    <td data-label="Remarks"><input type="text" id="txtRemarksMAN" style="height: 30px;width:100%;" placeholder="Remarks" /></td>
                    <td><input type="button" value="Add" onclick="AddRow(this);" /></td>
                </tr>
            </table>
        </div>
        <!-- HiddenField for XML -->
        <asp:HiddenField ID="hdnXML" runat="server" />

        <!-- ✅ GridView -->
        <div id="divContent" runat="server" class="manual-entry-container" visible="false">
            <asp:GridView CssClass="responsive-table" Width="100%" ID="grd" runat="server" 
                BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" 
                CellPadding="4" ForeColor="Black" AutoGenerateColumns="False" 
                OnRowDataBound="grd_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="SNo.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ItemName" HeaderText="ItemName" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" />
                    <asp:BoundField DataField="Size" HeaderText="Size" />
                    <asp:BoundField DataField="Cost" HeaderText="Cost" />
                    <asp:BoundField DataField="GST" HeaderText="GST" />
                    <asp:BoundField DataField="Freight" HeaderText="Freight" />
                    <asp:BoundField DataField="Misc" HeaderText="Misc" />
                    <asp:BoundField DataField="ProfitMargin" HeaderText="ProfitMargin" />
                    <asp:BoundField DataField="MRP" HeaderText="MRP" />
                    <asp:BoundField DataField="Stock" HeaderText="Stock" />
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" />                  
             
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="#09f" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
        </div>

    </div>
    <script type="text/javascript">
        function GetTemplate() {
            $.ajax({
                url: "ItemImportExport.aspx/GetTemplate",
                async: true,
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    debugger
                    window.open("ExportToExcel.aspx");
                    return false;
                }
            });
        }

        function Save() {
            var IsValid = false;
            var XML = '<Root>';
            $('[id$=grd]').find('tr').each(function (index) {
                if (index > 0) {
                    IsValid = true;
                    var ItemName = $(this).find('td').eq(1).html();
                    var Category = $(this).find('td').eq(2).html();
                    var BatchNo = $(this).find('td').eq(3).html();
                    var Size = $(this).find('td').eq(4).html();
                    var Cost = $(this).find('td').eq(5).html();
                    var GST = $(this).find('td').eq(6).html();
                    var Freight = $(this).find('td').eq(7).html();
                    var Misc = $(this).find('td').eq(8).html();
                    var ProfitMargin = $(this).find('td').eq(9).html();
                    var MRP = $(this).find('td').eq(10).html();
                    var Stock = $(this).find('td').eq(11).html();
                    var Remarks = $(this).find('td').eq(11).html();

                    XML += '<Node>';
                    XML += '<ItemName>' + ItemName + '</ItemName>';
                    XML += '<Category>' + Category + '</Category>';
                    XML += '<BatchNo>' + BatchNo + '</BatchNo>';
                    XML += '<Cost>' + Cost + '</Cost>';
                    XML += '<GST>' + GST + '</GST>';
                    XML += '<Freight>' + Freight + '</Freight>';
                    XML += '<Misc>' + Misc + '</Misc>';
                    XML += '<ProfitMargin>' + ProfitMargin + '</ProfitMargin>';
                    XML += '<MRP>' + MRP + '</MRP>';
                    XML += '<Stock>' + Stock + '</Stock>';
                    XML += '<Remarks>' + Remarks + '</Remarks>';

                    XML += '</Node>';
                }
            });

            $('#tblData tr').each(function (index) {
                if (index != ($('#tblData tr').length - 1)) {
                    IsValid = true;

                    var ItemName = $(this).find('td').eq(0).html();
                    var Category = $(this).find('td').eq(1).html();
                    var BatchNo = $(this).find('td').eq(2).html();
                    var Size = $(this).find('td').eq(3).html();
                    var Cost = $(this).find('td').eq(4).html();
                    var GST = $(this).find('td').eq(5).html();
                    var Freight = $(this).find('td').eq(6).html();
                    var Misc = $(this).find('td').eq(7).html();
                    var ProfitMargin = $(this).find('td').eq(8).html();
                    var MRP = $(this).find('td').eq(9).html();
                    var Stock = $(this).find('td').eq(10).html();
                    var Remarks = $(this).find('td').eq(11).html();

                    var TotalCost = parseInt(Cost);

                    var ChkPMType = ProfitMargin.split('%');
                    ProfitMargin = ChkPMType.length > 1 ? parseInt((TotalCost * parseInt(ProfitMargin.replace('%', '').trim())) / 100) : ProfitMargin.replace('Rs.', '').trim();

                    var ChkGSTType = GST.split('%');
                    GST = ChkGSTType.length > 1 ? parseInt((Cost * parseInt(GST.replace('%', '').trim())) / 100) : GST.replace('Rs.', '').trim();


                    XML += '<Node>';
                    XML += '<ItemName>' + ItemName + '</ItemName>';
                    XML += '<Category>' + Category + '</Category>';
                    XML += '<BatchNo>' + BatchNo + '</BatchNo>';
                    XML += '<Cost>' + Cost + '</Cost>';
                    XML += '<GST>' + GST + '</GST>';
                    XML += '<Freight>' + Freight + '</Freight>';
                    XML += '<Misc>' + Misc + '</Misc>';
                    XML += '<ProfitMargin>' + ProfitMargin + '</ProfitMargin>';
                    XML += '<MRP>' + MRP + '</MRP>';
                    XML += '<Stock>' + Stock + '</Stock>';
                    XML += '<Remarks>' + Remarks + '</Remarks>';
                    XML += '</Node>';
                }
            });




            XML += '</Root>';

            if (!IsValid) {
                return false;
            } else {
                $('[id$=hdnXML]').val(XML);
                return true;
            }
        }

        $(document).ready(function () {
            //called when key is pressed in textbox
            $(".NumberOnly").keypress(function (e) {
                //if the letter is not digit then display error and don't type anything
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {

                    return false;
                }
            });
        });
        function CalculateMRP(ctrl) {
            var Cost = $(ctrl).closest('tr').find('#txtCostMAN').val().trim() == "" ? 0 : $(ctrl).closest('tr').find('#txtCostMAN').val().trim();

            var Freight = $(ctrl).closest('tr').find('#txtFreightMAN').val().trim() == "" ? 0 : $(ctrl).closest('tr').find('#txtFreightMAN').val().trim();
            var Misc = $(ctrl).closest('tr').find('#txtMiscMAN').val().trim() == "" ? 0 : $(ctrl).closest('tr').find('#txtMiscMAN').val().trim();


            var ProfitMargin = $(ctrl).closest('tr').find('#txtProfitMarginMAN').val().trim() == "" ? 0 : $(ctrl).closest('tr').find('#txtProfitMarginMAN').val().trim();
            var GST = $(ctrl).closest('tr').find('#txtGSTMAN').val().trim() == "" ? 0 : $(ctrl).closest('tr').find('#txtGSTMAN').val().trim();
            //var GST = $(ctrl).closest('tr').find('#txtGSTMAN').val().trim() == "" ? 0 : $(ctrl).closest('tr').find('#txtGSTMAN').val().trim();
            var PMType = $(ctrl).closest('tr').find('#ddlPMType').val();
            var GSTType = $(ctrl).closest('tr').find('#ddlGSTType').val();
            GST = GSTType == '1' ? GST : parseInt((Cost * GST) / 100);
            var TotalCost = parseInt(Cost);
            ProfitMargin = PMType == '1' ? ProfitMargin : parseInt((TotalCost * ProfitMargin) / 100);
            $(ctrl).closest('tr').find('#txtMRPMAN').val(parseInt(Cost) + parseInt(GST) + parseInt(Freight) + parseInt(Misc) + parseInt(ProfitMargin));
        }

        function ChangeProfitMarginType(ctrl) {
            $(ctrl).next().val('');
            CalculateMRP(ctrl);
        }

        function AddRow(ctrl) {

            var IsValid = true;
            var html = '<tr>';
            $(ctrl).closest('tr').find('input[type=text]').each(function (index) {
                if ($(this).val().trim() == "") {
                    IsValid = false;
                }
                if (index == 5) {
                    if ($(this).prev().val() == "1") {
                        html += '<td> Rs.' + $(this).val() + '</td>';

                    } else
                        html += '<td>' + $(this).val() + '%</td>';
                }
                else if (index == 8) {
                    if ($(this).prev().val() == "1") {
                        html += '<td> Rs.' + $(this).val() + '</td>';

                    } else
                        html += '<td>' + $(this).val() + '%</td>';
                }
                else {
                    html += '<td>' + $(this).val() + '</td>';
                }
            });
            html += '<td></td></tr>';
            if (IsValid) {
                $('#tblData').prepend(html);
                $(ctrl).closest('tr').find('input[type=text]').val('');

            } else {
                alert('All Fields are mandatory!');
            }
        }

        function ChangeCategory(ctrl) {
            $(ctrl).next().val($(ctrl).val());
        }

        $(document).ready(function () {
            BindCategory();
        });

        function BindCategory() {

            $.ajax({
                url: "ItemImportExport.aspx/BindCategory",
                async: true,
                //data: '{TestId:"' + Test_id + '"}',
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    for (var i = 0; i < data.length; i++) {
                        $('#ddlCategory').append('<option value="' + data[i].Category + '">' + data[i].Category + '</option>');
                    }
                    $('#txtCategoryMAN').val($('#ddlCategory').val());
                }
            });

        }

    </script>
</asp:Content>