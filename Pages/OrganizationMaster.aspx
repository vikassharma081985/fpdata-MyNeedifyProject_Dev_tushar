<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" CodeBehind="OrganizationMaster.aspx.cs" Inherits="WSBillingMaster.OrganizationMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link href="../Css/jquery.dataTables.min.css" rel="stylesheet" />--%>
    <link href="//cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        .OrganizationHeader {
            border: 1px solid #ccc;
            margin-top: 0.5%;
            text-align: center;
            font-weight: bold;
            padding: 15px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="OrganizationHeader">
            Organization Master
        </div>
        <div style="padding-top: 1em;"></div>
        <div>
            <div class="row">
                <div class="col-sm-12">
                    <button type="button" class="btn btn-primary text-uppercase" id="btnDisplayOrgPopup">Add Organization</button>
                </div>
            </div>
            <div style="padding-top: 1em;"></div>
            <div class="row">
                <table class="table table-bordered" id="tblOrganization" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>S. No</th>
                            <th style="display: none;">Id</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Brand Name</th>
                            <th>Display Name</th>
                            <th>GST</th>
                            <th>Seller Address</th>
                            <th>Mobile Number</th>
                            <th>Landline Number</th>
                            <th>Email ID</th>
                            <th>Website</th>
                            <th style="display: none;">CategoryId</th>
                            <th style="display: none;">Password</th>
                            <th>Image</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="tbdetails">
                        
                    </tbody>
                </table>
                <%--<asp:GridView ID="grdOrganizations" class="table table-bordered" runat="server" Width="100%" AutoGenerateColumns="true" EmptyDataText="No Record Found" >

                </asp:GridView>--%>
            </div>
        </div>
       <div class="modal fade" tabindex="-1" role="dialog" id="organizationPopup">
    <div class="modal-dialog" role="document" style="width: 100%; padding-top: 2em;">
        <div class="modal-content">

            <div class="modal-header">
                <h3 class="modal-title" style="font-weight: bold;">Organization Master</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="margin-top: -25px;">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">

                <!-- Row 1 -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Seller Name</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtFirstName" class="form-control" placeholder="Enter Your First name" tabindex="1" autocomplete="off" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" id="txtLastName" class="form-control" placeholder="Enter Your Last name" tabindex="2" autocomplete="off" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Brand Name</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtBrandName" class="form-control" placeholder="Enter Organization Brand name" tabindex="3" autocomplete="off" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Display Name</label>
                            <span style="color:saddlebrown; font-size: xx-small;">(*display same as brand name by default)</span>
                            <input type="text" id="txtDisplayName" class="form-control" placeholder="Enter Organization display name" tabindex="4" autocomplete="off" />
                        </div>
                    </div>
                </div>

                <!-- Row 2 -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>GST Number</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtGST" class="form-control text-uppercase" placeholder="Enter Your GST name" tabindex="5" autocomplete="off" />
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Seller Address</label>
                            <input type="text" id="txtSelleraddress" class="form-control" placeholder="Enter Your Address" tabindex="6" autocomplete="off" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Select Category</label>&nbsp;<span style="color: red;">*</span>
                            <select id="ddlCategory" class="form-control" tabindex="7"></select>
                        </div>
                    </div>
                </div>

                <!-- Row 3 -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Mobile Number</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtMobile" class="form-control" placeholder="Enter Your Mobile number" tabindex="8" maxlength="10" autocomplete="off" />
                            <span><input type="radio" name="rdo" id="chkmobile" /></span>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Landline number</label>
                            <input type="text" id="txtLandline" class="form-control" placeholder="Enter Your Landline number" tabindex="9" autocomplete="off" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Email Id</label>&nbsp;<span style="color: red;">*</span>
                            <input type="text" id="txtEmailid" class="form-control" tabindex="10" placeholder="noreply@yourdomain.com" autocomplete="off" />
                            <span><input type="radio" name="rdo" id="chkemail" /></span>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Website</label>
                            <input type="text" id="txtwebsite" class="form-control" placeholder="www.yourdomain.com" tabindex="11" autocomplete="off" />
                        </div>
                    </div>
                </div>

                <!-- Row 4 -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>State</label>
                            <input type="text" id="txtstste" class="form-control" placeholder="state" tabindex="11" autocomplete="off" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>City</label>
                            <input type="text" id="txtcity" class="form-control" placeholder="city" tabindex="11" autocomplete="off" />
                        </div>
                    </div>

                      <div class="col-md-3">
      <div class="form-group">
          <label>Location</label>
          <input type="text" id="txtloc" class="form-control" placeholder="location" tabindex="11" autocomplete="off" />
      </div>
  </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Pincode</label>
                            <input type="text" id="txtpin" class="form-control" placeholder="pincode" tabindex="11" autocomplete="off" />
                        </div>
                    </div>
                </div>

                <!-- Row 5 -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Password</label>&nbsp;<span style="color: red;">*</span>
                            <input type="password" id="txtpassword" class="form-control" placeholder="Enter Your Password" tabindex="12" autocomplete="off" maxlength="15" />
                            <span toggle="#password-field" class="fa fa-fw fa-eye field_icon toggle-password"></span>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Confirm Password</label>&nbsp;<span style="color: red;">*</span>
                            <input type="password" id="txtconfirmpassword" class="form-control" placeholder="Confirm your password" tabindex="13" autocomplete="off" maxlength="15" />
                            <span toggle="#confpassword-field" class="fa fa-fw fa-eye field_icon toggle-cfpassword"></span>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Upload Image</label><span style="color: red;"> (.jpg, .jpeg, .png) </span>
                            <input type="file" id="flUpload" class="form-control" onchange="sendFile(this);" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <img id="myuploadImg" alt="View Image" style="width: 180px;" />
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="btnSaveDetails">Save</button>
                        <input type="hidden" id="hdnSellerId" value="" />
                        <button type="button" class="btn btn-secondary" id="btnclosepopup" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--<script src="../Js/jquery.dataTables.min.js"></script>--%>
    <script src="//cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="../Js/Custom/OrganizationMaster.js"></script>
</asp:Content>
