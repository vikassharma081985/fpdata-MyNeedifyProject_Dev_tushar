<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="DiscountMaster.aspx.cs" Inherits="WSBillingMaster.Pages.DiscountMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <style>
            th {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
                font-weight: 100;
            }

            td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
                font-weight: 100;
            }
        </style>
        <div class="Header" style="height: 400px;">
            <div style="font-weight: bold; color: #000; font-size: 16px; text-align: center; float: left; width: 100%; border-bottom: 1px solid #ccc;">
                Discount Master
            </div>
            <div class="col-md-6 col-lg-6 col-xs-12" style="text-align: left; border-right: 1px solid #ccc;">

                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    Discount Name
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12">
                    <asp:TextBox ID="txtDiscountName" Style="padding-left: 10px; width: 90%;" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    Discount %
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12">
                    <asp:TextBox ID="txtDiscountPer" Style="padding-left: 10px; width: 90%;" MaxLength="3" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    <asp:RadioButtonList ID="rdoActive" runat="server" RepeatColumns="2">
                        <asp:ListItem Text="Active" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="InActive" Value="0">

                        </asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    <asp:Button ID="btnSave" runat="server" Style="width: 42%;" OnClientClick="return Save();" Text="Save" CssClass="btn btn-primary" />
                    <asp:HiddenField ID="hdnDiscountId" runat="server" Value="0" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xs-12" style="text-align: left; font-weight: 100;">
                <div class="col-md-12 col-lg-12 col-xs-12" style="font-weight: bold; padding-top: 20px;">
                    <table id="tblData" style="width: 100%;">
                        <tr>
                            <th>SNo. </th>
                            <th>Name </th>
                            <th>Discount%</th>
                            <th>IsActive </th>
                            <th>Edit </th>
                            <th>Remove </th>
                        </tr>
                    </table>
                </div>
            </div>
        </div>


    </div>
    <script>
        $(document).ready(function () {
            BindData();
        });

        function BindData() {

            $('#tblData tr').slice(1).remove();

            $.ajax({
                url: "DiscountMaster.aspx/BindDiscountData",
                async: true,
                //data: JSON.stringify({ DiscountId: DiscountId, DiscountName: DiscountName, DiscountPer: DiscountPer, IsActive: IsActive }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    var Data = $.parseJSON(result.d);
                    if (Data.length > 0)
                    {
                        for (var i = 0; i < Data.length; i++)
                        {
                            var html = '';
                            html += '<tr>';
                            html += '<td>' + (i + 1) + '</td>';
                            html += '<td id="tdDiscountName">' + Data[i].DiscountName + '</td>';
                            html += '<td id="tdDiscountPer">' + Data[i].DiscountPer + '</td>';
                            html += '<td id="tdStatus">' + Data[i].Status + '</td>';
                            html += '<td> <a href="#" onclick="Edit(this);">Edit</a> </td>';
                            html += '<td> <a href="#" onclick="Remove(this);">Remove</a> <input type="hidden" id="hdnDiscId" value="' + Data[i].DiscountId + '"  /><input type="hidden" id="hdnIsActive" value="' + Data[i].IsActive + '"  /> </td>';
                            html += '</tr>';
                            $('#tblData').append(html);
                        }
                    }
                }
            });

        }

        function Edit(ctrl)
        {
            $('[id$=txtDiscountName]').val($(ctrl).closest('tr').find('#tdDiscountName').text());
            $('[id$=txtDiscountPer]').val($(ctrl).closest('tr').find('#tdDiscountPer').text());
            $('[id$=rdoActive]').val($(ctrl).closest('tr').find('#hdnIsActive').val());
            $('[id$=hdnDiscountId]').val($(ctrl).closest('tr').find('#hdnDiscId').val());

        }

        function Remove(ctrl) {
            var IsConfirmed = confirm('Are you sure?');
            if (IsConfirmed)
            {
                var DiscountId = $(ctrl).closest('tr').find('#hdnDiscId').val();
                $.ajax({
                    url: "DiscountMaster.aspx/RemoveDiscount",
                    async: true,
                    data: JSON.stringify({ DiscountId: DiscountId }),
                    contentType: "application/json; charset=utf-8",
                    type: "POST", // data has to be Posted 
                    timeout: 120000,
                    dataType: "json",
                    success: function (result) {
                        BindData();
                    }
                });
            }

        }

        function isNumberKey(evt) {
            debugger
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            else {
                alert($(this).val());
                return true;
            }
        }



        function Save() {
            var DiscountId = $('[id$=hdnDiscountId]').val();
            var DiscountName = $('[id$=txtDiscountName]').val().trim();
            var DiscountPer = $('[id$=txtDiscountPer]').val().trim();
            var IsActive = $('[id$=rdoActive] input:checked').val()

            if (DiscountName == "") {
                alert('Enter Discount Name');
                return false;
            }
            if (DiscountPer == "") {
                alert('Enter Discount Percentage');
                return false;
            }

            $.ajax({
                url: "DiscountMaster.aspx/ManageDiscount",
                async: true,
                data: JSON.stringify({ DiscountId: DiscountId, DiscountName: DiscountName, DiscountPer: DiscountPer, IsActive: IsActive }),
                contentType: "application/json; charset=utf-8",
                type: "POST", // data has to be Posted 
                timeout: 120000,
                dataType: "json",
                success: function (result) {
                    alert('Record Saved Successfully !');
                    $('[id$=txtDiscountName]').val('');
                    $('[id$=txtDiscountPer]').val('');
                    BindData();

                }
            });
            return false;
        }
    </script>
</asp:Content>
