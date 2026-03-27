<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="AddItem.aspx.cs" Inherits="WSBillingMaster.Pages.AddItem" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Jscript/AddItem.js"></script>
    <script src="../Js/Combobox.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body{
            color:black;
        }        
        .container-fluid {
     padding: 0px 0px; 
    width: 100%;
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
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6" style="font-size: 20px; font-family: Arial; color: #000; font-weight: bold; padding-left: 0px;">Add item</div>

            </div>
        </div>

        <%--<div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace">
                Supplier<font color="red"> *</font>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <asp:DropDownList ID="ddlSupplier" onchange="bindcategory1()" CssClass="BoxText" runat="server">
                </asp:DropDownList>
            </div>
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace ">
                Category<font color="red"> *</font>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <asp:DropDownList ID="ddlCategory" onchange="bindSubcategory()" CssClass="BoxText" runat="server">
                </asp:DropDownList>
            </div>
            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace ">
                Sub Category<font color="red"> *</font>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <asp:DropDownList ID="ddlSubCatgeory" onchange="bindSubSubcategory()" CssClass="BoxText" runat="server">
                </asp:DropDownList>

            </div>--%>

   <div class="container-fluid">

   <div class="row">

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Supplier <font color="red">*</font></label>
        <asp:DropDownList ID="ddlSupplier" onchange="bindcategory1()" CssClass="form-control BoxText" runat="server"></asp:DropDownList>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Category <font color="red">*</font></label>
        <asp:DropDownList ID="ddlCategory" onchange="bindSubcategory()" CssClass="form-control BoxText" runat="server"></asp:DropDownList>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Sub Category <font color="red">*</font></label>
        <asp:DropDownList ID="ddlSubCatgeory" onchange="bindSubSubcategory()" CssClass="form-control BoxText" runat="server"></asp:DropDownList>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Sub Sub Category <font color="red">*</font></label>
        <asp:DropDownList ID="ddlSubSubCategory" CssClass="form-control BoxText" runat="server"></asp:DropDownList>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Product Code <font color="red">*</font></label>
        <asp:TextBox ID="txtItemCode" onblur="return Validate(this);" CssClass="form-control BoxText" runat="server"></asp:TextBox>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Product Name <font color="red">*</font></label>
        <asp:TextBox ID="txtItemName" onblur="return Validate(this);" CssClass="form-control BoxText" runat="server"></asp:TextBox>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Brand <font color="red">*</font></label>
        <asp:TextBox ID="txtBrand" onblur="return Validate(this);" CssClass="form-control BoxText" runat="server"></asp:TextBox>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Model No <font color="red">*</font></label>
        <asp:TextBox ID="txtModel" onblur="return Validate(this);" CssClass="form-control BoxText" runat="server"></asp:TextBox>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Department <font color="red">*</font></label>
        <asp:TextBox ID="txtDepartment" onblur="return Validate(this);" CssClass="form-control BoxText" runat="server"></asp:TextBox>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>MRP <font color="red">*</font></label>
        <asp:TextBox ID="TextBox1" MaxLength="15" onblur="return Validate(this);" runat="server" class="form-control BoxText"></asp:TextBox>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 form-group">
        <label>Online Amount <font color="red">*</font></label>
        <asp:TextBox ID="txtAmount" MaxLength="15" onblur="return Validate(this);" runat="server" class="form-control BoxText"></asp:TextBox>
    </div>

    <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 form-group">
        <label>Product Description <font color="red">*</font></label>
        <CKEditor:CKEditorControl ID="CKEditorControl1" BasePath="/ckeditor/" runat="server"></CKEditor:CKEditorControl>
    </div>

</div>


    <!-- Size and Stock -->
    <div class="row TopSpace">

        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <label>Product Size & Available Stock <font color="red">*</font></label>

            <table id="tblSizenStock" class="table table-bordered" width="80%">
                <tr>
                    <th>SKU (Batch No)</th>
                    <th>Size</th>
                    <th>Color</th>
                    <th>Stock</th>
                </tr>

                <asp:Repeater ID="rptSizenStock" runat="server" OnItemDataBound="rptSizenStock_ItemDataBound">
                    <ItemTemplate>
                        <tr>

                            <td>
                                <asp:TextBox ID="txtBatchNo" runat="server"
                                    CssClass="form-control"
                                    Text='<%#Eval("BatchNo") %>'>
                                </asp:TextBox>
                            </td>

                            <td>
                                <asp:HiddenField ID="hdnSizeId" runat="server"
                                    Value='<%#Eval("SizeId") %>' />
                                <asp:DropDownList ID="ddlSize"
                                    runat="server"
                                    CssClass="form-control" />
                            </td>

                            <td>
                                <asp:HiddenField ID="hdnColorId"
                                    runat="server"
                                    Value='<%#Eval("ColorId") %>' />
                                <asp:DropDownList ID="ddlColor"
                                    runat="server"
                                    CssClass="form-control" />
                            </td>

                            <td>
                                <asp:TextBox ID="txtStock"
                                    runat="server"
                                    CssClass="form-control"
                                    Text='<%#Eval("Stock") %>'>
                                </asp:TextBox>
                            </td>

                        </tr>
                    </ItemTemplate>
                </asp:Repeater>

            </table>

            <a href="#" onclick="return AddRow();" style="color:#09f; text-decoration:none;">
                Add More
            </a>

        </div>

    </div>

</div>


<script>
    function AddRow() {
        var MyRow = $('#tblSizenStock').find('tr').eq(1).clone();
        $('#tblSizenStock').append(MyRow);
        return false;
    }
</script>

<!-- Toggle Button -->


<!-- Collapsible Section -->
<div id="productDetails" style="display:block;">
    <div class="card card-body">

        <div class="row TopSpace">

            <!-- Row 1 -->
            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Product Color</label>
                <asp:DropDownList ID="ddlColor" CssClass="form-control" runat="server"></asp:DropDownList>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Cashback in %</label>
                <asp:TextBox ID="txtCashback" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Vendor</label>
                <asp:TextBox ID="txtVendor" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Cash on Delivery</label>
                <asp:DropDownList ID="ddlCOD" CssClass="form-control" runat="server">
                    <asp:ListItem>Yes</asp:ListItem>
                    <asp:ListItem>No</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Row 2 -->
            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Product Volume</label>
                <asp:TextBox ID="txtVolume" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Product Length</label>
                <asp:TextBox ID="txtLength" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Product Width</label>
                <asp:TextBox ID="txtWidth" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Product Height</label>
                <asp:TextBox ID="txtHeight" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <!-- Row 3 -->
            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Shipping Weight</label>
                <asp:TextBox ID="txtShippingWeight" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Shipping Price</label>
                <asp:TextBox ID="txtShippingPrice" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>HSN Code</label>
                <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Attachment Title</label>
                <asp:TextBox ID="txtDisplay" CssClass="form-control" placeholder="Attachment Title" runat="server"></asp:TextBox>
            </div>

            <!-- Row 4 -->
            <div class="col-lg-3 col-md-4 col-sm-6 form-group">
                <label>Select File</label>
                <asp:FileUpload ID="flUpload" runat="server" CssClass="form-control" />
            </div>

            <div class="col-lg-5 col-md-6 col-sm-12 form-group">
                <label>Info</label>
                <div style="font-size:13px;color:#888;">
                    (only jpeg, jpg, png, pdf files are allowed)<br>
                    (max size 5MB)
                </div>
                <asp:Label ID="lblalertmsg" runat="server"></asp:Label>
            </div>

            <!-- Row 5 -->
            <div class="col-lg-2 col-md-3 col-sm-6 form-group mt-4">
                <asp:CheckBox ID="chkIscoupan" runat="server" Text="Is Coupon Applicable" />
            </div>

            <div class="col-lg-2 col-md-3 col-sm-6 form-group mt-4">
                <asp:CheckBox ID="chkIsActive" runat="server" Text="Is Active" />
            </div>

            <div class="col-lg-3 col-md-6 col-sm-6 form-group mt-3">
                <asp:Button runat="server"
                    CssClass="btn btn-primary w-100"
                    OnClick="btnSubmitData_Click"
                    OnClientClick="return ValidateSave();"
                    ID="btnSubmitData"
                    Text="Save" />
            </div>

        </div>

    </div>
</div>
        <%--</div>--%>
    </div>

    <script>
        //$(document).ready(function () {
        //    alert('this value save');
        //});

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
