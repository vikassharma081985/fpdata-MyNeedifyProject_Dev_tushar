<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ItemImportExport.aspx.cs" ValidateRequest="false" Inherits="WSBillingMaster.Pages.ItemImportExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="Header">
            Import/Export Items
        </div>

        <div class="Content">
            <table style="width: 100%">
                <tr>
                    <td style="width: 25%;">Step 1</td>
                    <td style="width: 25%;">Step 2</td>
                    <td style="width: 25%;">Step 3</td>
                    <td style="width: 25%;">Step 4</td>
                </tr>
                <tr>
                    <td style="width: 25%;">
                        <asp:Button ID="btnDownload" runat="server" CssClass="btn btn-danger" OnClick="btnDownload_Click" OnClientClick="return GetTemplate();" Text="Download Template" />
                    </td>
                    <td style="width: 25%;">

                        <asp:FileUpload ID="fpUpload" runat="server"></asp:FileUpload>

                    </td>
                    <td style="width: 25%;">
                        <asp:Button ID="btnUpload" runat="server" OnClick="btnupload_Click" CssClass="btn btn-warning" Text="Upload File" />
                    </td>
                    <td style="width: 25%;">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" OnClientClick="return Save();" OnClick="btnSave_Click" Text="Save to Database" />
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 10px;" colspan="4">Seller<font style="color: red;">*</font> :
                        <select id="ddlSeller" runat="server" onchange="onSellerChange();" placeholder="Seller" style="height: 33px; width: 250px;">
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <asp:HiddenField ID="hdnXML" runat="server" />
        <asp:HiddenField ID="hdnSellerId" runat="server" />
        <div id="divContentManual" runat="server" class="Content" style="padding: 0px; min-height: 50px; max-height: 300px; overflow: auto; overflow-x: scroll;">
            <table id="tblHeader" style="width: 1370px;">
                <tr id="header">
                    <th style="width: 100px;">Item Name</th>
                    <th style="width: 100px;">Category</th>
                    <th style="width: 100px;">Sub Category</th>
                    <th style="width: 100px;">Sub Sub Category</th>
                    <th style="width: 80px;">Batch No</th>
                    <%--<th style="width: 50px;">Size</th>--%>
                    <th style="width: 200px;">Stock <font style="font-size: 9px;">(Size-Color-Stock) for multiple use comma(Ex:- L-Red-5,M-Black-2)</font></th>
                    <%--<th style="width: 100px;">Color</th>--%>
                    <th style="width: 60px;">Cost</th>
                    <th style="width: 124px;">GST</th>
                    <th style="width: 75px;">Freight</th>
                    <th style="width: 50px;">Misc</th>
                    <th style="width: 150px;">Profit Margin</th>
                    <th style="width: 50px;">MRP</th>
                    <%--<th style="width: 80px;">Stock</th>--%>
                    <th style="width: 100px;">Expire On</th>
                    <th style="width: 150px;">Remarks</th>
                    <th></th>
                </tr>
            </table>
            <table id="tblData">
                <tr>

                    <td style="width: 100px">
                        <input type="text" id="txtItemNameMAN" placeholder="Item Name" style="width: 100px" />
                    </td>
                    <td style="width: 100px">
                        <select id="ddlCategory" onchange="ChangeCategory(this);" style="height: 33px; width: 100px;">
                        </select>
                        <input type="text" id="txtCategoryMAN" placeholder="Category" style="width: 80px; display: none;" />
                    </td>
                    <td style="width: 100px">
                        <select id="ddlSubCategory" onchange="ChangeSubCategory(this);" placeholder="Sub Category" style="height: 33px; width: 100px;">
                        </select>
                        <input type="text" id="txtSubCategoryMAN" placeholder="Sub Category" style="width: 80px; display: none;" />
                    </td>
                    <td style="width: 100px">
                        <select id="ddlSubSubCategory" onchange="ChangeSubSubCategory(this);" placeholder="Sub Sub Category" style="height: 33px; width: 100px;">
                        </select>
                        <input type="text" id="txtSubSubCategoryMAN" placeholder="Sub Sub Category" style="width: 80px; display: none;" />
                    </td>
                    <td style="width: 80px">
                        <input type="text" id="txtBatchNoMAN" placeholder="Batch No" style="width: 80px" />
                    </td>
                    <td style="width: 200px">
                        <input type="text" id="txtSizeMAN" placeholder="Size" style="width: 200px" />
                    </td>
                    <%--<td style="width: 100px">
                        <input type="text" id="txtColor" placeholder="Size" style="width: 100px" />
                    </td>--%>
                    <td style="width: 50px">
                        <input type="text" id="txtCostMAN" maxlength="8" class="NumberOnly" placeholder="Cost" onkeyup="CalculateMRP(this);" style="width: 50px" />
                    </td>
                    <td style="width: 130px">
                        <div style="width: 130px; float: left;">
                            <div style="width: 50px; float: left;">
                                <select id="ddlGSTType" style="float: left; width: 50px; height: 34px;" onchange="ChangeProfitMarginType(this);">
                                    <option value="1">Rs.</option>
                                    <option value="2">Per(%)</option>
                                </select>
                            </div>
                            <div style="width: 80px; float: left;">
                                <input type="text" id="txtGSTMAN" maxlength="4" class="NumberOnly" placeholder="GST" onkeyup="CalculateMRP(this);" style="width: 80px; float: left;" />
                            </div>
                        </div>
                    </td>
                    <td style="width: 100px">
                        <input type="text" id="txtFreightMAN" maxlength="4" class="NumberOnly" placeholder="Freight" onkeyup="CalculateMRP(this);" style="width: 80px" />
                    </td>
                    <td>
                        <input type="text" id="txtMiscMAN" maxlength="4" class="NumberOnly" placeholder="MISC" onkeyup="CalculateMRP(this);" style="width: 50px" />
                    </td>
                    <td style="width: 150px">
                        <div style="width: 150px; float: left;">
                            <div style="width: 60px; float: left;">
                                <select id="ddlPMType" style="width: 60px; height: 34px;" onchange="ChangeProfitMarginType(this);">
                                    <option value="1">Rs.</option>
                                    <option value="2">Per(%)</option>
                                </select>
                            </div>
                            <div style="width: 90px; float: left;">
                                <input type="text" id="txtProfitMarginMAN" maxlength="4" class="NumberOnly" placeholder="Profit Margin" onkeyup="CalculateMRP(this);" style="width: 90px" />
                            </div>
                        </div>
                    </td>
                    <td>
                        <input type="text" id="txtMRPMAN" placeholder="MRP" readonly="readonly" style="width: 50px" />
                    </td>
                    <%--<td>
                        <input type="text" id="txtStockMAN" class="NumberOnly" placeholder="Stock" style="width: 80px" />
                    </td>--%>
                    <td>
                        <input type="text" id="txtExpiryOn" class="form-control datepicker" placeholder="Expiry On" style="width: 100px" />
                    </td>
                    <td>
                        <input type="text" id="txtRemarksMAN" placeholder="Remarks" style="width: 100px" />
                    </td>
                    <td>
                        <input type="button" value="Add" onclick="AddRow(this);" />
                    </td>
                </tr>
            </table>
        </div>

        <div id="divContent" runat="server" class="Content" visible="false" style="padding: 0px; height: 300px; overflow: auto;">
            <asp:GridView Width="100%" ID="grd" runat="server" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" AutoGenerateColumns="False" OnRowDataBound="grd_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="SNo." ControlStyle-ForeColor="Blue" ControlStyle-Width="2%">
                        <ItemTemplate>
                            <%-- <asp:CheckBox ID="chk" Checked="true" runat="server" />--%>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                        <ControlStyle ForeColor="Blue"></ControlStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ItemName" HeaderText="ItemName" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="SubCategory" HeaderText="Sub Category" />
                    <asp:BoundField DataField="SubSubCategory" HeaderText="Sub Sub Category" />
                    <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" />
                    <asp:BoundField DataField="Size" HeaderText="Size" />
                    <%--<asp:BoundField DataField="Color" HeaderText="Color" />--%>
                    <asp:BoundField DataField="Cost" HeaderText="Cost" />
                    <asp:BoundField DataField="GST" HeaderText="GST" />
                    <asp:BoundField DataField="Freight" HeaderText="Freight" />
                    <asp:BoundField DataField="Misc" HeaderText="Misc" />
                    <asp:BoundField DataField="ProfitMargin" HeaderText="ProfitMargin" />
                    <asp:BoundField DataField="MRP" HeaderText="MRP" />
                    <%--<asp:BoundField DataField="Stock" HeaderText="Stock" />--%>
                    <asp:BoundField DataField="ExpireOn" HeaderText="Expire On" />
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
    <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".datepicker").datepicker(
                { dateFormat: 'dd-M-yy' }
            );
        });
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
                    var SubCategory = $(this).find('td').eq(3).html();
                    var SubSubCategory = $(this).find('td').eq(4).html();
                    var BatchNo = $(this).find('td').eq(5).html();
                    var Size = $(this).find('td').eq(6).html();
                    //var Color = $(this).find('td').eq(7).html();
                    var Cost = $(this).find('td').eq(7).html();
                    var GST = $(this).find('td').eq(8).html();
                    var Freight = $(this).find('td').eq(9).html();
                    var Misc = $(this).find('td').eq(10).html();
                    var ProfitMargin = $(this).find('td').eq(11).html();
                    var MRP = $(this).find('td').eq(12).html();
                    //var Stock = $(this).find('td').eq(14).html();
                    var ExpireOn = $(this).find('td').eq(13).html();
                    var Remarks = $(this).find('td').eq(14).html();

                    XML += '<Node>';
                    XML += '<ItemName>' + ItemName + '</ItemName>';
                    XML += '<Category>' + Category + '</Category>';
                    XML += '<SubCategory>' + SubCategory + '</SubCategory>';
                    XML += '<SubSubCategory>' + SubSubCategory + '</SubSubCategory>';
                    XML += '<BatchNo>' + BatchNo + '</BatchNo>';
                    XML += '<Size>' + Size + '</Size>';
                    //XML += '<Color>' + Color + '</Color>';
                    XML += '<Cost>' + Cost + '</Cost>';
                    XML += '<GST>' + GST + '</GST>';
                    XML += '<Freight>' + Freight + '</Freight>';
                    XML += '<Misc>' + Misc + '</Misc>';
                    XML += '<ProfitMargin>' + ProfitMargin + '</ProfitMargin>';
                    XML += '<MRP>' + MRP + '</MRP>';
                    //XML += '<Stock>' + Stock + '</Stock>';
                    XML += '<ExpireOn>' + ExpireOn + '</ExpireOn>';
                    XML += '<Remarks>' + Remarks + '</Remarks>';
                    XML += '</Node>';
                }
            });

            $('#tblData tr').each(function (index) {
                if (index != ($('#tblData tr').length - 1)) {
                    IsValid = true;

                    var ItemName = $(this).find('td').eq(0).html();
                    var Category = $(this).find('td').eq(1).html();
                    var SubCategory = $(this).find('td').eq(2).html();
                    var SubSubCategory = $(this).find('td').eq(3).html();
                    var BatchNo = $(this).find('td').eq(4).html();
                    var Size = $(this).find('td').eq(5).html();
                    //var Color = $(this).find('td').eq(6).html();
                    var Cost = $(this).find('td').eq(6).html();
                    var GST = $(this).find('td').eq(7).html();
                    var Freight = $(this).find('td').eq(8).html();
                    var Misc = $(this).find('td').eq(9).html();
                    var ProfitMargin = $(this).find('td').eq(10).html();
                    var MRP = $(this).find('td').eq(11).html();
                    //var Stock = $(this).find('td').eq(13).html();
                    var ExpireOn = $(this).find('td').eq(12).html();
                    var Remarks = $(this).find('td').eq(13).html();

                    var TotalCost = parseInt(Cost);

                    var ChkPMType = ProfitMargin.split('%');
                    ProfitMargin = ChkPMType.length > 1 ? parseInt((TotalCost * parseInt(ProfitMargin.replace('%', '').trim())) / 100) : ProfitMargin.replace('Rs.', '').trim();

                    var ChkGSTType = GST.split('%');
                    GST = ChkGSTType.length > 1 ? parseInt((Cost * parseInt(GST.replace('%', '').trim())) / 100) : GST.replace('Rs.', '').trim();


                    XML += '<Node>';
                    XML += '<ItemName>' + ItemName + '</ItemName>';
                    XML += '<Category>' + Category + '</Category>';
                    XML += '<SubCategory>' + SubCategory + '</SubCategory>';
                    XML += '<SubSubCategory>' + SubSubCategory + '</SubSubCategory>';
                    XML += '<BatchNo>' + BatchNo + '</BatchNo>';
                    XML += '<Size>' + Size + '</Size>';
                    //XML += '<Color>' + Color + '</Color>';
                    XML += '<Cost>' + Cost + '</Cost>';
                    XML += '<GST>' + GST + '</GST>';
                    XML += '<Freight>' + Freight + '</Freight>';
                    XML += '<Misc>' + Misc + '</Misc>';
                    XML += '<ProfitMargin>' + ProfitMargin + '</ProfitMargin>';
                    XML += '<MRP>' + MRP + '</MRP>';
                    //XML += '<Stock>' + Stock + '</Stock>';
                    XML += '<ExpireOn>' + ExpireOn + '</ExpireOn>';
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
            $('#txtCategoryMAN').val('');
            $('#txtSubCategoryMAN').val('');
            $('#txtSubSubCategoryMAN').val('');

            $('#txtCategoryMAN').val($('#ddlCategory').val());
            $('#txtSubCategoryMAN').val($('#ddlSubCategory').val());
            $('#txtSubSubCategoryMAN').val($('#ddlSubSubCategory').val());
            var html = '<tr>';
            $(ctrl).closest('tr').find('input[type=text]').each(function (index) {
                if ($(this).val().trim() == "") {
                    IsValid = false;
                }
                if (index == 5) {
                    if ($(this).prev().val() == "1") {
                        html += '<td> Rs.' + $(this).val() + '</td>';

                    } else
                        html += '<td>' + $(this).val() + '</td>';
                }
                else if (index == 8) {
                    if ($(this).prev().val() == "1") {
                        html += '<td> Rs.' + $(this).val() + '</td>';

                    } else
                        html += '<td>' + $(this).val() + '</td>';
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
            $('#ddlSubSubCategory option').remove();
            $('#ddlSubCategory option').remove();
            $('#txtCategoryMAN').val($('#ddlCategory').val());
            BindSubCategory();
        }

        function ChangeSubCategory(ctrl) {
            //$(ctrl).next().val($(ctrl).val());
            $('#ddlSubSubCategory option').remove();
            BindSubSubCategory();
        }

        function ChangeSubSubCategory(ctrl) {
            //$(ctrl).next().val($(ctrl).val());
            //BindSubSubCategory()
        }

        $(document).ready(function () {
            var sellerid = $('[id$=ddlSeller] option:selected').val();
            $('[id$=hdnSellerId]').val(sellerid);
            BindCategory(sellerid);
        });
        function onSellerChange() {
            var sellerid = $('[id$=ddlSeller] option:selected').val();
            $('[id$=hdnSellerId]').val(sellerid);
            $('#ddlCategory option').remove();
            $('#ddlSubSubCategory option').remove();
            $('#ddlSubCategory option').remove();
            BindCategory(sellerid);
        }
        function BindCategory(sellerid) {
            $.ajax({
                url: "ItemImportExport.aspx/BindCategory",
                async: true,
                data: '{sellerid:"' + sellerid + '"}',
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    for (var i = 0; i < data.length; i++) {
                        $('#ddlCategory').append('<option value="' + data[i].CategoryId + '">' + data[i].Category + '</option>');
                    }
                    $('#txtCategoryMAN').val($('#ddlCategory').val());
                    BindSubCategory();
                }
            });

        }

        function BindSubCategory() {
            var Category = $('#ddlCategory').val();
            $.ajax({
                url: "ItemImportExport.aspx/BindSubCategory",
                async: true,
                data: '{CategoryId:"' + Category + '"}',
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    for (var i = 0; i < data.length; i++) {
                        $('#ddlSubCategory').append('<option value="' + data[i].SubCategoryId + '">' + data[i].SubCategory + '</option>');
                    }
                    $('#txtSubCategoryMAN').val($('#ddlSubCategory').val());
                    BindSubSubCategory();
                }
            });

        }

        function BindSubSubCategory() {
            var SubCategory = $('#ddlSubCategory').val();
            $.ajax({
                url: "ItemImportExport.aspx/BindSubSubCategory",
                async: true,
                data: '{SubCategoryId:"' + SubCategory + '"}',
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var data = $.parseJSON(result.d);
                    for (var i = 0; i < data.length; i++) {
                        $('#ddlSubSubCategory').append('<option value="' + data[i].SubSubCategoryId + '">' + data[i].SubSubCategory + '</option>');
                    }
                    $('#txtSubSubCategoryMAN').val($('#ddlSubSubCategory').val());
                }
            });

        }
    </script>
</asp:Content>
