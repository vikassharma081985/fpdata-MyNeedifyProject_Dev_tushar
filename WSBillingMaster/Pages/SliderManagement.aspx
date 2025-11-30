<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="SliderManagement.aspx.cs" Inherits="WSBillingMaster.Pages.SliderManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Jscript/Slider.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 1170px; margin: 0 auto; margin-top: 3%; background-color: #fff; padding: 30px; min-height: 1300px;">
        <asp:HiddenField ID="hdnAttachmentXML" runat="server" />
        <asp:HiddenField ID="hdnPhysicalPath" runat="server" />
        <asp:HiddenField ID="hdnMemberDetails" runat="server" />
        <asp:HiddenField ID="hdnsize" runat="server" />
        <asp:HiddenField ID="hdnCategory" runat="server" />

        <asp:HiddenField ID="hdnSubCategory" runat="server" />
        <asp:HiddenField ID="hdnSubSubCategory" runat="server" />
        <asp:HiddenField ID="hdnItemId" Value="0" runat="server" />

        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-right: 0px; padding-left: 0px;">
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6" style="font-size: 20px; font-family: Arial; color: #000; font-weight: bold; padding-left: 0px;">
                    Banner Management

                </div>
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6" style="text-align: right; font-weight: 600;">
                    <a href="http://trendzshopping.in//Pages/ManageSlider.aspx">Manage Slider</a>
                </div>

            </div>
        </div>


        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 row top-buffer">
            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace">
                Banner Name <font color="red">*</font>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <asp:TextBox ID="txtItemName" CssClass="BoxText" runat="server"></asp:TextBox>
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

            </div>
            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace ">
                Sub Sub Category<font color="red"> *</font>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <asp:DropDownList ID="ddlSubSubCategory" CssClass="BoxText" runat="server">
                </asp:DropDownList>

            </div>

            <div id="divUploadAttac" runat="server">

                <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 TopSpace">
                    Upload Images<font color="red"> *</font><br />
                    (Best Size Width=1350 px, Height=500 px)
                </div>
                <div class="col-xs-12 col-sm-7 col-md-7 col-lg-7">
                    <div style="float: left; width: 100%; margin-bottom: 10px;">
                        <asp:TextBox ID="txtDisplay" runat="server" Style="float: left; margin-right: 10px;" placeholder="Attachment Title" CssClass="BoxText" Width="211"></asp:TextBox>
                        <asp:FileUpload ID="flUpload" runat="server" Style="margin-top: 5px; width: 230px; border-radius: 5px; padding: 4px; margin-top: 0px;" />
                        <asp:Label ID="lblalertmsg" runat="server"></asp:Label><br />
                        <div style="font-size: 13px; color: #ccc; margin-top: -10px;">(only jpeg, jpg, png, pdf files are allowed)</div>
                        <div style="font-size: 13px; color: #ccc">(max size 5MB)</div>

                        <img id="imgLoad" src="../Images/Loding1.gif" style="display: none;" />
                    </div>
                    <div id="divAttachement" runat="server" style="display: none; text-align: left;">
                        <table id="tblAttachment" class="table" style="width: 86%; border: 1px solid transparent; margin-top: 2%; margin-bottom: 1%;">
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
                                    <asp:HiddenField ID="hdnItemId" runat="server" Value='<%#Eval("Id") %>' />
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                                    <%--//  <img src="../Images/Item/delete.jpg"  onclick="DeleteImage('<%#Eval("ImageId") %>')" />'--%>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 TopSpace">
                <div class="col-xs-6 col-md-6 col-sm-6 col-lg-6" style="padding-left: 0px;">
                    <asp:Button runat="server" class="btnPrimary" OnClick="btnSubmitData_Click" OnClientClick="ValidateSave();" Style="width: 120px; border-radius: 5px; margin-right: 10px; border: none; float: left; height: 35px;" ID="btnSubmitData" Text="Save " />
                </div>

            </div>
        </div>

    </div>
</asp:Content>
