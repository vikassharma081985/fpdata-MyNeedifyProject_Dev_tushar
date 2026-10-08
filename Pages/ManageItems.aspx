<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ManageItems.aspx.cs" Inherits="WSBillingMaster.Pages.ManageItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="Header" style="height: 204px;">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                Manage Items
            </div>
            <div class="row " > 
                <div style="Border :1px solid; " class="col-sm-6">
                   <asp:TextBox runat="server" class="form-control" ID="txtSearch" Style="width: 250px; font-weight: 500; margin-left: 160px; margin-top: 15px;" placeholder="Item Name/ Barcode No"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" class="btn btn-primary" Text="Search" Style=" margin-left: 15px; margin-top: 15px;" OnClick="btnSearch_Click" />
                </div>
                <div style="Border :1px solid; height:100px; "  class="col-sm-6">
                    <table style="width: 100%">
                <tr>
                    <td style="width: 25%;">From Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">To Date</td>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;"></td>
                </tr>
                <tr>
                    <td style="width: 32%;">
                        <asp:TextBox runat="server" class="form-control datepicker" id="txtFromDate"  style="cursor:pointer" ></asp:TextBox>

                    </td>
                    <td style="width: 5%;"></td>
                    <td style="width: 32%;">
                        <asp:TextBox runat="server" class="form-control datepicker" id="txtToDate"   style="cursor:pointer;" />

                    </td></tr>
                    <tr>
                    <td style="width: 5%;"></td>
                    <td style="width: 25%;">
                        <asp:Button ID="btnSearch" class="btn btn-primary" runat="server" Style="margin-top:4px" Text="Search" OnClick="btnSearch2_Click"/>
                    </td>
                    
                </tr>
            </table>
                </div>
            </div>
            
        
        <div class="Content" style="margin-top:7%;">
            
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
        <div class="Content" id="Grid_ManageItems" style="max-height: 400px; overflow: auto;">
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
                            <asp:FileUpload ID="fuImage" runat="server" AllowMultiple="true" accept="image/jpeg,image/png,image/gif" onchange="FileChange(this);" />
                            <input type="hidden" id="hdnItemId" value='<%#Eval("ItemId") %>' />
                        </div>
                        <div class="col-md-3" style="padding: 5px; padding-left: 15px; text-align: center;">
                            <div class="item-images" data-item-id='<%#Eval("ItemId") %>' data-images='<%#GetItemImages(Eval("ItemId")) %>'>
                                <img style="height: 50px; width: 50px;" src='<%#Eval("ItemImage") %>' />
                            </div>
                            <span class="item-image-status" role="status"></span>

                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <asp:Label ID="lblItemEmpty" runat="server" Text="No items found." Visible="false" Style="display: block; padding: 10px;" />
        <asp:Panel ID="pnlItemPager" runat="server" Visible="false" Style="clear: both; padding: 10px; text-align: center;">
            <asp:Button ID="btnItemFirst" runat="server" Text="First" CommandArgument="First" OnCommand="ItemPage_Command" CausesValidation="false" CssClass="btn btn-default" />
            <asp:Button ID="btnItemPrevious" runat="server" Text="Previous" CommandArgument="Previous" OnCommand="ItemPage_Command" CausesValidation="false" CssClass="btn btn-default" />
            <asp:Label ID="lblItemPage" runat="server" Style="margin: 0 10px;" />
            <asp:Button ID="btnItemNext" runat="server" Text="Next" CommandArgument="Next" OnCommand="ItemPage_Command" CausesValidation="false" CssClass="btn btn-default" />
            <asp:Button ID="btnItemLast" runat="server" Text="Last" CommandArgument="Last" OnCommand="ItemPage_Command" CausesValidation="false" CssClass="btn btn-default" />
        </asp:Panel>
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

        function ImageRequest(gallery, action, data) {
            return $.ajax({
                url: "../AjaxResponsePages/AsyAttachement_HandlerFile.ashx?callFor=ItemImages&ItemId=" +
                    encodeURIComponent(gallery.attr('data-item-id')) + "&action=" + action,
                type: "POST", data: data, dataType: "json", contentType: false, processData: false,
                timeout: 60000, global: false
            });
        }
        function ImageControls(gallery, disabled) {
            gallery.closest('.col-md-12').find('input[type=file], .item-images button').prop('disabled', disabled);
        }
        function ShowItemImages(gallery, images) {
            gallery.empty();
            $.each(images, function (_, image) {
                var card = $('<div>').css({ position: 'relative', display: 'inline-block', margin: '4px', verticalAlign: 'top' });
                $('<img>').attr({ src: image.Url, alt: 'Item image' }).css({ display: 'block', height: '50px', width: '50px' }).appendTo(card);
                $('<button type="button">').text('×').attr({ title: 'Remove image', 'aria-label': 'Remove image' }).css({
                    position: 'absolute', top: '0', right: '0', width: '18px', height: '18px',
                    padding: '0', border: '1px solid #ccc', borderRadius: '50%',
                    backgroundColor: '#fff', color: '#c00', fontSize: '16px', lineHeight: '14px', cursor: 'pointer'
                }).on('click', function () {
                    ImageControls(gallery, true);
                    var data = new FormData();
                    data.append('ImageName', image.ImageName);
                    ImageRequest(gallery, 'Remove', data).done(function (images) {
                        ShowItemImages(gallery, images);
                        gallery.siblings('.item-image-status').text('Image removed.');
                    }).fail(function () {
                        gallery.siblings('.item-image-status').text('Unable to remove image. Please retry.');
                    }).always(function () { ImageControls(gallery, false); });
                }).appendTo(card);
                card.appendTo(gallery);
            });
        }
        $(function () {
            $('.item-images').each(function () {
                var gallery = $(this);
                ShowItemImages(gallery, JSON.parse(gallery.attr('data-images') || '[]'));
            });
        });
        function FileChange(ctrl) {
            var files = Array.prototype.slice.call(ctrl.files || []);
            if (!files.length) return;
            for (var i = 0; i < files.length; i++) {
                if (!/\.(jpe?g|png|gif)$/i.test(files[i].name)) {
                    alert("Only '.jpeg', '.jpg', '.png', '.gif' formats are allowed");
                    ctrl.value = '';
                    return;
                }
            }
            var gallery = $(ctrl).closest('.col-md-12').find('.item-images');
            var status = gallery.siblings('.item-image-status');
            ImageControls(gallery, true);
            var uploaded = 0;
            function uploadNext() {
                if (uploaded === files.length) {
                    status.text(uploaded + ' image(s) uploaded.');
                    ctrl.value = '';
                    ImageControls(gallery, false);
                    return;
                }
                status.text('Uploading image ' + (uploaded + 1) + ' of ' + files.length + '...');
                var data = new FormData();
                data.append('image', files[uploaded]);
                ImageRequest(gallery, 'Add', data).done(function (images) {
                    ShowItemImages(gallery, images);
                    ImageControls(gallery, true);
                    uploaded++;
                    uploadNext();
                }).fail(function () {
                    status.text(uploaded + ' image(s) uploaded. Upload failed; select remaining files to retry.');
                    ctrl.value = '';
                    ImageControls(gallery, false);
                });
            }
            uploadNext();
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
                if (txtSearch.Text == "") {
                    alert("Please entre text")
                }
            }
        }
    </script>
    


</asp:Content>
