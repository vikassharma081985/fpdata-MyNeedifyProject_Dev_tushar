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


     <div class="row">

    <div class="col-md-1">
        Supplier<font color="red">*</font>
    </div>
    <div class="col-md-2">
        <asp:DropDownList ID="ddlSupplier" onchange="bindcategory1()" CssClass="BoxText" runat="server" />
    </div>

    <div class="col-md-1">
        Category<font color="red">*</font>
    </div>
    <div class="col-md-2">
        <asp:DropDownList ID="ddlCategory" onchange="bindSubcategory()" CssClass="BoxText" runat="server" />
    </div>

    <div class="col-md-1">
        Sub Category<font color="red">*</font>
    </div>
    <div class="col-md-2">
        <asp:DropDownList ID="ddlSubCatgeory" onchange="bindSubSubcategory()" CssClass="BoxText" runat="server" />
    </div>

    <div class="col-md-1">
         Sub Category<font color="red">*</font>
    </div>
    <div class="col-md-2">
        <asp:DropDownList ID="ddlSubSubCategory" CssClass="BoxText" runat="server" />
    </div>

</div>
  <br />
    
        <div style="width:100%; overflow-x:auto;">

                <table style="width:100%; border-collapse:collapse;" border="1" cellpadding="5">

    <!-- HEADER -->
    <tr style="background:#2f4f6f; color:#fff;">
        <th>Product Code</th>
        <th>Product Name</th>
        <th>Brand</th>
        <th>Model</th>
        <th>Department</th>
        <th>Color</th>
        <th>MRP</th>
        <th>Amount</th>
        <th>Cashback %</th>
        <th>Vendor</th>
          <th>Volume</th>
  <th>Length</th>
  <th>Width</th>
  <th>Height</th>
  <th>Shipping Weight</th>
  <th>Shipping Price</th>
  <th>HSN Code</th>
  <th>COD</th>
        <th>SKU</th>
<th>Size</th>
<th>Color</th>
<th>Stock</th>
        <th>Image</th>
                <th>Select</th>

    </tr>

    <!-- ROW -->
    <tr>
        <td><asp:TextBox ID="txtItemCode" runat="server" CssClass="form-control" /></td>
        <td><asp:TextBox ID="txtItemName" runat="server" CssClass="form-control" /></td>
        <td><asp:TextBox ID="txtBrand" runat="server" CssClass="form-control" /></td>
        <td><asp:TextBox ID="txtModel" runat="server" CssClass="form-control" /></td>
        <td><asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" /></td>
        <td><asp:DropDownList ID="ddlColor" runat="server" CssClass="form-control" /></td>
        <td><asp:TextBox ID="txtMRP" runat="server" CssClass="form-control" /></td>
        <td><asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" /></td>
        <td><asp:TextBox ID="txtCashback" runat="server" CssClass="form-control" /></td>
        <td><asp:TextBox ID="txtVendor" runat="server" CssClass="form-control" /></td>
         <td><asp:TextBox ID="txtVolume" runat="server" CssClass="form-control" /></td>
 <td><asp:TextBox ID="txtLength" runat="server" CssClass="form-control" /></td>
 <td><asp:TextBox ID="txtWidth" runat="server" CssClass="form-control" /></td>
 <td><asp:TextBox ID="txtHeight" runat="server" CssClass="form-control" /></td>
 <td><asp:TextBox ID="txtShippingWeight" runat="server" CssClass="form-control" /></td>
 <td><asp:TextBox ID="txtShippingPrice" runat="server" CssClass="form-control" /></td>
 <td><asp:TextBox ID="txtHSNCode" runat="server" CssClass="form-control" /></td>
 <td>
     <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
         <asp:ListItem>Yes</asp:ListItem>
         <asp:ListItem>No</asp:ListItem>
     </asp:DropDownList>
 </td>

        <td colspan="4">
    <asp:Repeater ID="rptSizenStock" runat="server" OnItemDataBound="rptSizenStock_ItemDataBound">
        <ItemTemplate>
            <table >
                <tr>
                    <td>
                        <asp:TextBox ID="txtBatchNo" runat="server"
                            Text='<%#Eval("BatchNo") %>' CssClass="form-control" />
                    </td>
                    <td>
                        <asp:HiddenField ID="hdnSizeId" runat="server"
                            Value='<%#Eval("SizeId") %>' />
                        <asp:DropDownList ID="ddlSize" runat="server" CssClass="form-control" />
                    </td>
                    <td>
                        <asp:HiddenField ID="hdnColorId" runat="server"
                            Value='<%#Eval("ColorId") %>' />
                        <asp:DropDownList ID="ddlColor" runat="server" CssClass="form-control" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtStock" runat="server"
                            Text='<%#Eval("Stock") %>' CssClass="form-control" />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:Repeater>
</td>

         <td><asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" /></td>
 <td><asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" /></td>


    </tr>

</table>

            </div>


 <%--  <div id="divUploadAttac" runat="server">
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
   </div>--%>


<!-- BUTTON -->
<asp:Button ID="btnSubmitData" runat="server"
    Text="Save"
    OnClick="btnSubmitData_Click"
    OnClientClick="return ValidateSave();" />

<script>
    function AddRow() {
        var row = $('#tblSizenStock tr:eq(1)').clone();
        $('#tblSizenStock').append(row);
        return false;
    }
</script>

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
