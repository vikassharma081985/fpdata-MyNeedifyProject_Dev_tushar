<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="AddItem.aspx.cs" Inherits="WSBillingMaster.Pages.AddItem" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Jscript/AddItem.js"></script>
    <script src="../Js/Combobox.js"></script>
    <style>
        body{
            color:black;
        }        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 1170px; margin: 0 auto; margin-top: 3%; background-color: #fff; padding: 30px; min-height: 1300px;">
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

        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2">
            Supplier<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2">
            <asp:DropDownList ID="ddlSupplier" onchange="bindcategory1()" CssClass="BoxText" runat="server">
            </asp:DropDownList>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 ">
            Category<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2">
            <asp:DropDownList ID="ddlCategory" onchange="bindSubcategory()" CssClass="BoxText" runat="server">
            </asp:DropDownList>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2">
            Sub Category<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2">
            <asp:DropDownList ID="ddlSubCatgeory" onchange="bindSubSubcategory()" CssClass="BoxText" runat="server">
            </asp:DropDownList>
        </div>

        <%--<div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">--%>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Sub Sub Category<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:DropDownList ID="ddlSubSubCategory" CssClass="BoxText" runat="server">
            </asp:DropDownList>
        </div>        
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Product Code <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtItemCode" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Product Name <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtItemName" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>

        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Brand <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtBrand" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>

        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Model No <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtModel" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>

        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Department <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtDepartment" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>        

        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace ">
            Product Description<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <%--<asp:TextBox runat="server" onblur="return Validate(this);" class=" BoxText" ID="txtItemDescription"></asp:TextBox>--%>
            <CKEditor:CKEditorControl ID="txtItemDescription" BasePath="/ckeditor/" runat="server">
            </CKEditor:CKEditorControl>
        </div>        
        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace ">
            Product Size & Available Stock<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <%-- <asp:CheckBoxList ID="chkSizeList" RepeatColumns="2" CssClass="BoxText" runat="server">
                </asp:CheckBoxList>--%>

            <table id="tblSizenStock" width="80%">
                <tr>
                    <th>SKU(Batch No)
                    </th>
                    <th>Size
                    </th>
                    <th>Color
                    </th>
                    <th>Stock
                    </th>

                </tr>
                <asp:Repeater ID="rptSizenStock" runat="server" OnItemDataBound="rptSizenStock_ItemDataBound">
                    <ItemTemplate>
                        <tr>
                            <td style="width: 25%">
                                <asp:TextBox ID="txtBatchNo" runat="server" Width="100px" CssClass="form-control" Text='<%#Eval("BatchNo") %>'></asp:TextBox>
                            </td>
                            <td style="width: 25%">
                                <asp:HiddenField ID="hdnSizeId" runat="server" Value='<%#Eval("SizeId") %>' />
                                <asp:DropDownList ID="ddlSize" runat="server" CssClass="form-control" />
                            </td>
                            <td style="width: 25%">
                                <asp:HiddenField ID="hdnColorId" runat="server" Value='<%#Eval("ColorId") %>' />
                                <asp:DropDownList ID="ddlColor" CssClass="form-control" runat="server" />
                            </td>
                            <td style="width: 25%">
                                <asp:TextBox ID="txtStock" runat="server" Width="50px" CssClass="form-control" Text='<%#Eval("Stock") %>'></asp:TextBox>
                            </td>

                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12">
                <a href="#" onclick="return AddRow();" style="color: #09f; text-decoration: none;">Add More</a>
                <script>
                    function AddRow() {
                        var MyRow = $('#tblSizenStock').find('tr').eq(1).clone();
                        $('#tblSizenStock').append(MyRow);
                        return false;
                    }
                </script>
            </div>
        </div>


        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace ">
            Product Color<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:DropDownList ID="ddlColor" CssClass="BoxText" runat="server">
            </asp:DropDownList>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            MRP<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtMRP" MaxLength="15" onblur="return Validate(this);" runat="server" class="BoxText"></asp:TextBox>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Online Amount<font color="red"> *</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtAmount" MaxLength="15" onblur="return Validate(this);" runat="server" class="BoxText"></asp:TextBox>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Cashback in % 
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtCashback" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>
        <%--<div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace">
                Stock<font color="red"> *</font>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <asp:TextBox ID="txtStock" MaxLength="15" onblur="return Validate(this);" runat="server" class="BoxText"></asp:TextBox>
            </div>--%>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Vendor <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtVendor" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Cash on Delivery 
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:DropDownList ID="ddlCOD" CssClass="form-control" runat="server">
                <asp:ListItem>Yes</asp:ListItem>
                <asp:ListItem>No</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Product Volume <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtVolume" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Product Length <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtLength" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Product Width <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtWidth" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>

        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Product Height <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtHeight" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Shipping Weight <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtShippingWeight" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>
        <div class="col-xs-12 col-md-2 col-sm-2 col-lg-2 TopSpace">
            Shipping Price <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 TopSpace">
            <asp:TextBox ID="txtShippingPrice" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>

        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace">
            HSN Code <font color="red">*</font>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <asp:TextBox ID="txtHSNCode" onblur="return Validate(this);" CssClass="BoxText" runat="server"></asp:TextBox>
        </div>
        <div id="divUploadAttac" runat="server">
            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace">
                Upload Images<font color="red"> *</font>
            </div>
            <div class="col-xs-12 col-sm-7 col-md-7 col-lg-7">
                <div style="float: left; width: 100%; margin-bottom: 10px;">
                    <asp:TextBox ID="txtDisplay" runat="server" Style="float: left; margin-right: 10px;" placeholder="Attachment Title" CssClass="BoxText" Width="211"></asp:TextBox>
                    <asp:FileUpload ID="flUpload" runat="server" Style="margin-top: 5px; width: 230px; border-radius: 5px; padding: 4px; margin-top: 0px;"
                        onchange="UpdatePreview(this,'MoudLetter')" />
                    <asp:Label ID="lblalertmsg" runat="server"></asp:Label><br />
                    <div style="font-size: 13px; color: #ccc; margin-top: -10px;">(only jpeg, jpg, png, pdf files are allowed)</div>
                    <div style="font-size: 13px; color: #ccc">(max size 5MB)</div>
                    <img id="imgLoad" src="../Images/Loding1.gif" style="display: none;" />
                </div>
                <div id="divAttachement" runat="server" style="display: none; text-align: left;">
                    <table id="tblAttachment" class="table" style="width: 86%; border: 1px solid #ccc; margin-top: 2%; margin-bottom: 1%;">
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
                        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4" style="font-size: 15px; margin-bottom: 20px; border-radius: 2px; padding: 0px;">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <asp:Image ID="Image2" ImageUrl='<%#Eval("ImagePath") %>' runat="server" Height="150px" Width="150px" />
                                <asp:HiddenField ID="hdnItemId" runat="server" Value='<%#Eval("ItemId") %>' />
                            </div>

                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                                <img src="../Images/Delete.gif" onclick="DeleteImage('<%#Eval("ImageId") %>')" />'
                            </div>
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
        </div>


        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 TopSpace">
            <div class="col-xs-6 col-md-6 col-sm-6 col-lg-6" style="padding-left: 0px;">
                <asp:Button runat="server" class="btnPrimary" OnClick="btnSubmitData_Click" OnClientClick="return ValidateSave();" Style="width: 120px; border-radius: 5px; margin-right: 10px; border: none; float: left; height: 35px;" ID="btnSubmitData" Text="Save " />
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
