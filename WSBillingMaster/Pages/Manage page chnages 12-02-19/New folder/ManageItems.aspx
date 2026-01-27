<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ManageItems.aspx.cs" Inherits="WSBillingMaster.Pages.ManageItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="Header" style="height: 204px;">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                Manage Items
            </div>
            <asp:TextBox runat="server" class="form-control" ID="txtSearch" Style="width: 250px; font-weight: 500; float: left; margin-top: 15px;" placeholder="Item Name/ Barcode No"></asp:TextBox>
            <asp:Button runat="server" class="btn btn-primary" Text="Search" Style="float: left; margin-left: 15px; margin-top: 15px;" OnClick="btnSearch_Click" />
        
        <div class="Content" style="margin-top:7%;">
            <table style="width: 100%">
                <tr>
                    <td style="width: 25%;">From Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">To Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;"></td>
                </tr>
                <tr>
                    <td style="width: 25%;">
                        <asp:TextBox runat="server" class="form-control datepicker" id="txtFromDate" runat="server" style="cursor:pointer"  ></asp:TextBox>

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:TextBox runat="server" class="form-control datepicker" id="txtToDate" runat="server"  style="cursor:pointer;" />

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:Button ID="btnSearch" runat="server" class="btn-danger" Text="Search" OnClick="btnSearch_Click"/>
                    </td>
                    
                </tr>
            </table>
            </div>
        </div> 
        </div>
        <div class="col-md-12" style="padding: 5px; background-color: #f1f1f1; border: 1px solid #000; color: #000">
            <div class="col-md-2" style="padding: 5px; padding-left: 15px; text-align: center;">
                Item
            </div>
            <div class="col-md-2" style="padding: 5px; padding-left: 15px; text-align: center;">
                Barcode
            </div>
            <div class="col-md-1" style="padding: 5px; padding-left: 15px; text-align: center;">
                Stock
            </div>
            <div class="col-md-2" style="padding: 5px; padding-left: 15px; text-align: center;">
                Print Barcode
            </div>
            <div class="col-md-2" style="padding: 5px; padding-left: 15px; text-align: center;">
                Upload Image
            </div>
            <div class="col-md-3" style="padding: 5px; padding-left: 15px; text-align: center;">
                Image
            </div>

        </div>
        <div class="Content" style="max-height: 400px; overflow: auto;">
            <asp:Repeater ID="rptItems" runat="server">
                <ItemTemplate>

                    <div class="col-md-12" style="padding: 0px;">
                        <div class="col-md-2" style="padding: 15px;padding-left: 0px;">
                            <img src="../Images/Edit.png" style="float:left;width:15px;cursor:pointer;" onclick="EditItem('<%#Eval("ItemId") %>',this);" />
                            <asp:Label ID="lblItemName" runat="server"  style="float:left;margin-left:15px;" Text='<%#Eval("ItemName") %>'></asp:Label>
                            <asp:TextBox ID="txtItemName" runat="server"  style="float:left;margin-left:15px;display:none;width:80%;" Text='<%#Eval("ItemName") %>'  onblur='EditItemName(this);'></asp:TextBox>
                            <input type="hidden" id="hdnUpdateId" value='<%#Eval("ItemId") %>' />
                        </div>
                        <div class="col-md-2" style="padding: 15px;">
                            <asp:Label ID="lblBarcode" runat="server" Text='<%#Eval("Barcode") %>'></asp:Label>
                        </div>
                        <div class="col-md-1" style="padding: 15px; text-align: center;">
                            <asp:Label ID="lblStock" runat="server" Style='<%#"font-weight:bold;color:"+ Eval("StockColor") %>' Text='<%#Eval("Stock") %>'></asp:Label>
                        </div>
                        <div id="MyDiv" class="col-md-2" style="padding: 5px; padding-left: 15px; text-align: center;">
                            <input type="number" max="99" value="1" id="txtBarcodeNo" style="width: 50px;" />
                            

                            <input type="button" id="btnPrint" onclick="Print(this);" value="Print" />
                            <asp:HiddenField ID="hdnBarcode" runat="server" Value='<%#Eval("Barcode") %>'></asp:HiddenField>
                            <select id="ddlBarcodeSize" style="width: 50px; height: 35px;">
                                <option value="1">2x1</option>
                                <option value="2">4x1</option>
                            </select>
                             <asp:HiddenField ID="hdnItemName" runat="server" Value='<%#Eval("ItemName") %>'></asp:HiddenField>
                             <asp:HiddenField ID="hdnMRP" runat="server" Value='<%#Eval("MRP") %>'></asp:HiddenField>
                            <asp:HiddenField ID="hdnProfitMargin" runat="server" Value='<%#Eval("ProfitMargin") %>'></asp:HiddenField>

                        </div>
                        <div class="col-md-2" style="padding: 5px; padding-left: 15px; text-align: center;">
                            <asp:FileUpload ID="fuImage" runat="server" onchange="FileChange(this);" />
                            <input type="hidden" id="hdnItemId" value='<%#Eval("ItemId") %>' />
                        </div>
                        <div class="col-md-3" style="padding: 5px; padding-left: 15px; text-align: center;">
                            <img id="ImgPreView" style="height: 50px; width: 50px;" src='<%#Eval("ItemImage") %>' />

                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
   <link href="../Css/jquery-ui.css" rel="stylesheet" />
    <script src="../Js/jquery-ui.js"></script>

    <script>

        $(function () {
            $(".datepicker").datepicker(
                { dateFormat: 'dd-M-yy' }
            );
        });

        function Print(ctrl) {
            var Barcode = $(ctrl).next().val();
            var Copies = $(ctrl).prev().val();
            var ItemName = $(ctrl).parent().find('input[type=hidden]').eq(1).val();
            var MRP = $(ctrl).parent().find('input[type=hidden]').eq(2).val();
            var Size = $(ctrl).parent().find('select').eq(0).val();
            var ProfitMargin = $(ctrl).parent().find('input[type=hidden]').eq(3).val();
            if (Copies != "")
                window.open('PrintBarcode.aspx?Barcode=' + Barcode + '&Copies=' + Copies + '&Size=' + Size + '&ItemName=' + ItemName + '&MRP=' + MRP + '&ProfitMargin=' + ProfitMargin.replace(".00",""));
            else
                alert('Please enter valid barcode numbers.');

        }

        function FileChange(ctrl) {
            var ItemId = $(ctrl).next().val();
            ImgPreview(ctrl.files, ItemId, ctrl);
        }

        function ImgPreview(input, ItemId, ctrl) {
            debugger
            var file = input[0];
            //if (file.size > 2097152) {
            //    alert('File size is greater than 2 MB')
            //    input.value = null;
            //    $('#ImgPreView').attr('src', 'ORImages/Add-Image.jpg');
            //    return false;
            //}
            var fileType = file["type"];
            var ValidImageTypes = ["image/gif", "image/jpeg", "image/png", "image/jpg"];
            if ($.inArray(fileType, ValidImageTypes) < 0) {
                alert("Only '.jpeg', '.jpg', '.png', '.gif' formats are allowed");
                // $('#ImgPreView').attr('src', '../images/drag-drop-upload.gif');
                return false;
            }
            else {
                debugger;
                if (input && input[0]) {
                    var filerdr = new FileReader();
                    filerdr.onload = function (e) {

                        // $('#divImages').append("<div style='position:relative;float:left;display:flex;'><img src='../images/System/Delete.gif' style='position: absolute;right: 0;top: 0;background-color: #fff;border-radius: 100%;padding: 3px;' onclick='Delete(this);' /><img id='imgPackImage' src='" + e.target.result + "' style='max-height:100px;float:left;display:flex;' class='img-responsive img-thumbnail PackageImage' /><input type='hidden' id='hdnUploadedImage' value='" + input[0].name.replace('^', '') + "'></div>");
                        $(ctrl).parent().parent().find('#ImgPreView').attr('src', e.target.result);
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
                        url: "../AjaxResponsePages/AsyAttachement_HandlerFile.ashx?callFor=Items&ItemId=" + ItemId,
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

        function EditItem(ItemId,ctrl) {
            $(ctrl).closest('div').find('input[type=text]').val($(ctrl).closest('div').find('span').text());
            $(ctrl).closest('div').find('input[type=text]').show();
            $(ctrl).closest('div').find('span').hide();
            $(ctrl).closest('div').find('input[type=text]').focus();

            
        }

        function EditItemName(ctrl)
        {
            if ($(ctrl).closest('div').find('input[type=text]').val().trim() == "") {
                alert("Item Name cannot be blank");
                $(ctrl).closest('div').find('input[type=text]').val($(ctrl).closest('div').find('span').text());
                $(ctrl).closest('div').find('input[type=text]').focus();
              
            } else {
                $(ctrl).closest('div').find('span').text($(ctrl).closest('div').find('input[type=text]').val());
                $(ctrl).closest('div').find('input[type=text]').hide();
                $(ctrl).closest('div').find('span').show();

                var ItemId = $(ctrl).closest('div').find('input[type=hidden]').val();
                var ItemName = $(ctrl).closest('div').find('span').text();
                $.ajax({
                    url: "ManageItems.aspx/EditItemName",
                    async: true,
                    data: JSON.stringify({ ItemId: ItemId, ItemName: ItemName }),
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {

                    }
                });
            }
        }
    </script>

</asp:Content>
