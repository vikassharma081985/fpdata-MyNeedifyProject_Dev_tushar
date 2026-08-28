<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true"
    ValidateRequest="false" CodeBehind="AddItem.aspx.cs" Inherits="WSBillingMaster.Pages.AddItem" %>

    <%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <script src="../Jscript/AddItem.js"></script>
            <script src="../Js/Combobox.js"></script>
            <style>
                body {
                    color: black;
                }
            </style>
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div style=" margin: 0 auto; margin-top: 3%; background-color: #fff; padding: 30px; min-height: 1300px;">
                <asp:HiddenField ID="hdnAttachmentXML" runat="server" />
                <asp:HiddenField ID="hdnPhysicalPath" runat="server" />

                <asp:HiddenField ID="hdnMemberDetails" runat="server" />
                <asp:HiddenField ID="hdnsize" runat="server" />
                <asp:HiddenField ID="hdnCategory" runat="server" />
                <asp:HiddenField ID="hdnSupplier" runat="server" />
                <asp:HiddenField ID="hdnSubCategory" runat="server" />
                <asp:HiddenField ID="hdnSubSubCategory" runat="server" />
                <asp:HiddenField ID="hdnItemId" Value="0" runat="server" />

                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-right: 0px; padding-left: 0px;">
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6"
                            style="font-size: 20px; font-family: Arial; color: #000; font-weight: bold; padding-left: 0px;">
                            Add item</div>

                    </div>
                </div>


                <div class="row">

                    <div class="col-md-1">
                        Supplier<font color="red">*</font>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlSupplier" onchange="bindcategory1()" CssClass="BoxText"
                            runat="server" />
                    </div>

                    <div class="col-md-1">
                        Category<font color="red">*</font>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlCategory" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" CssClass="BoxText"
                            runat="server" />
                    </div>

                    <div class="col-md-1">
                        Sub Category<font color="red">*</font>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlSubCatgeory" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlSubCatgeory_SelectedIndexChanged" CssClass="BoxText"
                            runat="server" />
                    </div>

                    <div class="col-md-1">
                        Sub Category<font color="red">*</font>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlSubSubCategory" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlSubSubCategory_SelectedIndexChanged" CssClass="BoxText"
                            runat="server" />
                    </div>

                </div>
                <br />

                <div style="width:100%; overflow-x:auto;">

                    <table style="width:100%; border-collapse:collapse;" border="1" cellpadding="5">

                        <!-- HEADER -->
                        <tr style="background:#2f4f6f; color:#fff;">
                            <th>Product Code</th>
                            <th>Product Name <font color="red">*</font>
                            </th>
                            <th>Brand</th>
                            <th>Model</th>
                            <th>Department</th>
                            <th>Color</th>
                            <th>MRP</th>
                            <th>Amount <font color="red">*</font>
                            </th>
                            <th>Cashback %</th>
                            <th>Vendor</th>
                            <th>Volume</th>
                            <th>Length</th>
                            <th>Width</th>
                            <th>Height</th>
                            <th>Shipping Weight</th>
                            <th>Shipping Price</th>
                            <th>HSN Code</th>
                            <th>Image <font color="red">*</font>
                            </th>
                            <th>COD</th>
                            <th>Batch No</th>
                            <th>Size</th>
                            <th>Stock</th>
                            <th>Select <br />
                                <input type="checkbox" id="chkSelectAll" onclick="toggleSelectAll(this)" />
                            </th>

                        </tr>

                        <!-- ROW -->
                        <asp:Repeater ID="rptItems" runat="server" OnItemDataBound="rptItems_ItemDataBound">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:HiddenField ID="hdnItemId" runat="server"
                                            Value='<%# Eval("ProductCode") %>' />
                                        <asp:TextBox ID="txtItemCode" runat="server" CssClass="form-control"
                                            Text='<%# Eval("ProductCode") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtItemName" runat="server" CssClass="form-control"
                                            Text='<%# Eval("ProductName") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBrand" runat="server" Text='<%# Eval("Brand") %>' CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtModel" runat="server" Text='<%# Eval("Model") %>' CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDepartment" Text='<%# Eval("Department") %>' runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtColor" runat="server" CssClass="form-control"
                                            Text='<%# Eval("Color1") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMRP" runat="server" CssClass="form-control"
                                            Text='<%# Eval("Price") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control"
                                            Text='<%# Eval("Amount") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCashback" runat="server" CssClass="form-control"
                                            Text='<%# Eval("Cashback") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVendor" runat="server" CssClass="form-control"
                                            Text='<%# Eval("Vendor") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVolume" runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLength" runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWidth" runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtShippingWeight" runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtShippingPrice" runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtHSNCode" runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <div id="divImg" runat="server">
                                            <asp:Image ID="imgItem" runat="server"
                                                ImageUrl='<%# string.IsNullOrEmpty(Eval("ItemImage").ToString()) ? "" : "~/Images/Items/" + Eval("ItemImage") %>'
                                                Width="50" Height="50"
                                                Visible='<%# !string.IsNullOrEmpty(Eval("ItemImage").ToString()) %>' />
                                            <asp:FileUpload ID="fuItemImage" runat="server" />
                                            <asp:HiddenField ID="hdnExistingImage" runat="server"
                                                Value='<%# Eval("ItemImage") %>' />
                                        </div>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                            <asp:ListItem>Yes</asp:ListItem>
                                            <asp:ListItem>No</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtBatchNo" Text='<%# Eval("BatchNo") %>' runat="server" CssClass="form-control" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSize" runat="server" CssClass="form-control"
                                            Text='<%# Eval("Size1") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtStock" runat="server" CssClass="form-control"
                                            Text='<%# Eval("Stock") %>' />
                                    </td>

                                    <td>
                                        <asp:CheckBox ID="chkSelect" Checked="true" runat="server" CssClass="rowCheckbox" />
                                    </td>


                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>

                    </table>

                </div>
                
                <div style="margin-top: 10px; display: flex; align-items: center; justify-content: center;">
                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" CausesValidation="false" CssClass="btn btn-default" />
                    <asp:Label ID="lblPageInfo" runat="server" Style="margin: 0 15px; font-weight: bold;"></asp:Label>
                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CausesValidation="false" CssClass="btn btn-default" />
                </div>


                <%-- <div id="divUploadAttac" runat="server">
                    <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace">
                        Upload Images<font color="red"> *</font>
                    </div>
                    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-7">
                        <div style="float: left; width: 100%; margin-bottom: 10px;">
                            <asp:TextBox ID="txtDisplay" runat="server" Style="float: left; margin-right: 10px;"
                                placeholder="Attachment Title" CssClass="BoxText" Width="211"></asp:TextBox>
                            <asp:FileUpload ID="flUpload" runat="server"
                                Style="margin-top: 5px; width: 230px; border-radius: 5px; padding: 4px; margin-top: 0px;"
                                onchange="UpdatePreview(this,'MoudLetter')" />
                            <asp:Label ID="lblalertmsg" runat="server"></asp:Label><br />
                            <div style="font-size: 13px; color: #ccc; margin-top: -10px;">(only jpeg, jpg, png, pdf
                                files are allowed)</div>
                            <div style="font-size: 13px; color: #ccc">(max size 5MB)</div>
                            <img id="imgLoad" src="../Images/Loding1.gif" style="display: none;" />
                        </div>
                        <div id="divAttachement" runat="server" style="display: none; text-align: left;">
                            <table id="tblAttachment" class="table"
                                style="width: 86%; border: 1px solid #ccc; margin-top: 2%; margin-bottom: 1%;">
                                <tr style="background-color: #f5f5f5;">
                                    <th class="td" style="text-align: left;">Attachment Name</th>
                                    <th class="td" style="text-align: left;">Remove</th>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="border: 1px solid #ccc; padding: 10px;">
                        <asp:Repeater ID="rptAttachment" runat="server">
                            <ItemTemplate>
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"
                                    style="font-size: 15px; margin-bottom: 20px; border-radius: 2px; padding: 0px;">
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                        <asp:Image ID="Image2" ImageUrl='<%#Eval("ImagePath") %>' runat="server"
                                            Height="150px" Width="150px" />
                                        <asp:HiddenField ID="hdnItemId" runat="server" Value='<%#Eval("ItemId") %>' />
                                    </div>

                                    <img src="../Images/Delete.gif"
                                        onclick='<%# Eval("ImageId", "DeleteImage({0});") %>' style="cursor:pointer;" />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
            </div>

            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12">
                <asp:CheckBox ID="chkIscoupan" runat="server" Text="IsCoupanAppplicable" />
            </div>

            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12">
                <asp:CheckBox ID="chkIsActive" runat="server" Text="Is Active" />
            </div>--%>


            <!-- BUTTON -->
            <asp:Button ID="btnSubmitData" runat="server" Text="Save" OnClick="btnSubmitData_Click"
                OnClientClick="return ValidateSave();" />

            <script>
                function AddRow() {
                    var row = $('#tblSizenStock tr:eq(1)').clone();
                    $('#tblSizenStock').append(row);
                    return false;
                }

                function toggleSelectAll(selectAllCheckbox) {
                    $('.rowCheckbox input[type="checkbox"]').prop('checked', selectAllCheckbox.checked);
                }

                function updateHeaderCheckbox() {
                    var $allCheckboxes = $('.rowCheckbox input[type="checkbox"]');
                    var $checkedCheckboxes = $allCheckboxes.filter(':checked');
                    var $headerCheckbox = $('#chkSelectAll');
                    if ($headerCheckbox.length > 0) {
                        $headerCheckbox.prop('checked', $allCheckboxes.length > 0 && $allCheckboxes.length === $checkedCheckboxes.length);
                    }
                }

                $(document).on('change', '.rowCheckbox input[type="checkbox"]', function() {
                    updateHeaderCheckbox();
                });
            </script>

            </div>




            <script>
                $(document).ready(function () {
                    updateHeaderCheckbox();
                });

                function FileChange(ctrl) {
                    ImgPreview(ctrl.files);
                    $('#divSign').css('display', '');
                }
                function ImgPreview(input) {

                    var file = input[0];
                    if (file.size > 2097152) {
                        showInfo('File size is greater than 2 MB')
                        input.value = null;
                        $('#ImgPreView').val('');
                        $('#flUpload').val('');

                        //$('#ImgPreView').attr('src', 'ORImages/Add-Image.jpg');
                        return false;
                    }
                    var fileType = file["type"];
                    var ValidImageTypes = ["image/gif", "image/jpeg", "image/png", "image/jpg"];
                    if ($.inArray(fileType, ValidImageTypes) < 0) {
                        showInfo("Only '.jpeg', '.jpg', '.png', '.gif' formats are allowed");
                        $('#ImgPreView').val('');
                        $('#flUpload').val('');


                        return false;
                    }
                    else {
                        if (input && input[0]) {
                            var filerdr = new FileReader();
                            filerdr.onload = function (e) {
                                $('#ImgPreView').attr('src', e.target.result);

                            }
                            filerdr.readAsDataURL(input[0]);
                            var data = new FormData();
                            data.append(input[0].name, input[0]);

                        }
                    }
                }

            </script>
        </asp:Content>