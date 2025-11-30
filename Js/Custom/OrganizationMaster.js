$(document).ready(function () {
    //$('#tblOrganization').dataTable({
    //sorting: true
    //});
    debugger;
    BindCategory();
    debugger;
    BindOrganizationDetails();
});
$('#btnDisplayOrgPopup').click(function () {
    $('#organizationPopup').modal('show');
    //return;
});
$('#btnclosepopup').click(function () {
    $('#txtEmailid').prop('disabled', false);
    $('input[type=text]').val('');
});
function BindCategory() {
    $.ajax({
        url: "OrganizationMaster.aspx/BindCategory",
        async: false,
        contentType: "application/json; charset=utf-8",
        type: "POST", // data has to be Posted 
        timeout: 120000,
        dataType: "json",
        success: function (result) {
            //debugger;
            var data = $.parseJSON(result.d);
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    $('#ddlCategory').append('<option value="' + data[i].CategoryId + '">' + data[i].Category + '</option>');
                }
            } else {
                alert('Technical issue occured. Try again!');
            }

            return false;
        },
        error: function (result) {
            alert('Some Error Occured, Please try again later!');
        }
    });
}
function BindOrganizationDetails() {
    //$('#tblOrganization').dataTable().fnDestory();
    var trforappend = '';
    $.ajax({
        url: "OrganizationMaster.aspx/BindOrganizationMasterDetails",
        async: false,
        contentType: "application/json; charset=utf-8",
        type: "POST", // data has to be Posted 
        timeout: 120000,
        dataType: "json",
        success: function (result) {
            var data = $.parseJSON(result.d);
            if (data.length > 0) {
                var count = 0;
                for (var i = 0; i < data.length; i++) {
                    debugger;
                    count++;
                    trforappend += '<tr>';
                    trforappend += '<td>' + count + '</td>';
                    trforappend += '<td style="display: none;">' + data[i].SellerId + '</td>';
                    trforappend += '<td>' + data[i].FirstName + '</td>';
                    trforappend += '<td>' + data[i].LastName + '</td>';
                    trforappend += '<td>' + data[i].BrandName + '</td>';
                    trforappend += '<td>' + data[i].DisplayName + '</td>';
                    trforappend += '<td>' + data[i].GST + '</td>';
                    trforappend += '<td>' + data[i].SellerAddress + '</td>';
                    trforappend += '<td>' + data[i].MobileNumber + '</td>';
                    trforappend += '<td>' + data[i].LandlineNumber + '</td>';
                    trforappend += '<td>' + data[i].EmailId + '</td>';
                    trforappend += '<td>' + data[i].Website + '</td>';
                    trforappend += '<td style="display: none;">' + data[i].BusinessId + '</td>';
                    trforappend += '<td style="display: none;">' + data[i].Password + '</td>';
                    trforappend += '<td style="display: block;"><img id="" alt="View Image" style="width: 50px;" src="../../' + data[i].ProfileImage + '" />';
                    if (data[i].ProfileImage != null) { 
                        trforappend += '<a href="../../' + data[i].ProfileImage + '" class="" download>Download</a>';
                    }
                    trforappend += '</td > ';
                    trforappend += '<td><a  style="cursor: pointer;" class="clsedit" onclick=EditDetails(' + data[i].SellerId + ',this)><i class="fa fa-edit"></i></a>&emsp;';
                    trforappend += '<a  style="cursor: pointer;" style="cursor: pointer;" class="clsdelete" onclick=DeleteDetails(' + data[i].SellerId + ','+data[i].IsActive+',this)>';
                    if (data[i].IsActive == true) {
                        trforappend += '<i class="fa fa-check" aria-hidden="true" style="color: green;"></i>';
                    } else {
                        trforappend += '<i class="fa fa-ban" aria-hidden="true" style="color: red;"></i>';
                    }
                    trforappend += '</a></td > ';
                    trforappend += '</tr>';
                }
                $('#tbdetails').append(trforappend);
                $('#tblOrganization').DataTable();
                //debugger;
                //$('#tbdetails').html(rec);
            } else {
                alert('Technical issue occured. Try again!');
            }
            //$('#tblOrganization').dataTable({
            //});
            return false;
        },
        error: function (result) {
            alert('Some Error Occured, Please try again later!');
        }
    });
}
$('#txtMobile,#txtLandline').keypress(function (e) {
    var charCode = (e.which) ? e.which : event.keyCode
    if (String.fromCharCode(charCode).match(/[^0-9]/g)) {
        return false;
    }
});
function sendFile(file) {
    debugger;
    var model = new FormData();
    model.append('file', file.files[0]);
    $.ajax({
        type: 'POST',
        url: '../AjaxResponsePages/FileUploader.ashx',
        data: model,
        contentType: false,
        processData: false,
        success: function (result) {
            debugger;
            alert('file uploaded');
            var mypath = '../../Images/OrgImages/' + result;
            $('#myuploadImg').attr('src', mypath);
        },
        error: function (err) {
            alert('error occured');
        }
    })
}
$('#btnSaveDetails').click(function () {
    debugger;
    if ($('#txtFirstName').val().trim() == '') {
        $('#txtFirstName').css('border-color', 'red');
        return false;
    } else {
        $('#txtFirstName').css('border-color', '');
    }
    if ($('#txtBrandName').val().trim() == '') {
        $('#txtBrandName').css('border-color', 'red');
        return false;
    } else {
        $('#txtBrandName').css('border-color', '');
    }
    //if ($('#txtDisplayName').val().trim() == '') {
    //    $('#txtDisplayName').val($('#txtBrandName').val());
    //}
    if ($('#txtGST').val().trim() == '') {
        $('#txtGST').css('border-color', 'red');
        return false;
    } else {
        $('#txtGST').css('border-color', '');
    }
    var ddllength = $('#ddlCategory > option').length;
    if (ddllength == 0) {
        alert('Bind Category prior filling organization details');
        return false;
    }
    if ($('#txtMobile').val().trim() == '') {
        $('#txtMobile').css('border-color', 'red');
        return false;
    } else {
        $('#txtMobile').css('border-color', '');
    }
    if (ValidateMobile($('#txtMobile').val()) == false) {
        //alert('Kindly enter proper mobile number');
        return false;
    }
    if ($('#txtEmailid').val().trim() == '') {
        $('#txtEmailid').css('border-color', 'red');
        return false;
    } else {
        $('#txtEmailid').css('border-color', '');
    }
    if (IsEmail($('#txtEmailid').val()) == false) {
        alert('Kindly enter proper email address');
        return false;
    }
    if ($('#txtpassword').val().trim() == '') {
        $('#txtpassword').css('border-color', 'red');
        return false;
    } else {
        $('#txtpassword').css('border-color', '');
    }
    if ($('#txtpassword').val().trim() != $('#txtconfirmpassword').val().trim()) {
        alert('Password and confirm password should match!')
        return false;
    }
    //return false;
    var sellerId = 0;
    if ($('#btnSaveDetails').text() == 'Update') {
        sellerId = $('#hdnSellerId').val();
    }
    var sellername = $('#txtFirstName').val();
    var lastname = $('#txtLastName').val();
    var brandname = $('#txtBrandName').val();
    var displayname = $('#txtDisplayName').val();
    var gst = $('#txtGST').val();
    var selleraddress = $('#txtSelleraddress').val();
    var mobile = $('#txtMobile').val();
    var landline = $('#txtLandline').val();
    var emailid = $('#txtEmailid').val();
    var website = $('#txtwebsite').val();
    var password = $('#txtpassword').val();
    var businessid = parseInt($('#ddlCategory').val());
    var username = '';
    if ($('#chkmobile').is(':checked')) {
        username = $('#txtMobile').val();
    } else if ($('#chkemail').is(':checked')) {
        username = $('#txtEmailid').val();
    }
    //var file = $('#flUpload')[0];
    debugger;
    var getpath = $('#myuploadImg').attr('src');
    if (getpath != 'undefined') {
        getpath = getpath.split('..')[2];
    } else {
        getpath = null;
    }
    debugger;
    $.ajax({
        url: "OrganizationMaster.aspx/AddOrganizationMaster",
        async: false,
        data: JSON.stringify({ SellerName: sellername, LastName: lastname, BrandName: brandname, DisplayName: displayname, GST: gst, SellerAddress: selleraddress, Mobile: mobile, LandLineNumber: landline, Email: emailid, Website: website, Password: password, BusinessId: businessid, SellerId: sellerId, Username: username, ProfileImage: getpath }),
        contentType: "application/json; charset=utf-8",
        type: "POST", // data has to be Posted 
        timeout: 120000,
        dataType: "json",
        success: function (result) {
            debugger;
            if (result.d > 0) {
                if ($('#btnSaveDetails').text() == 'Update') {
                    alert('Organization details updated successfully!');
                } else {
                    alert('Organization details inserted successfully!');
                }
                $('input[type=text]').val('');
                $('input[type=password]').val('');
                $('#txtEmailid').prop('disabled', false);
                $('#ddlCategory').prop('selectedIndex', 0);
                $('#organizationPopup').modal('hide');
                $('#flUpload').val(null);
                window.location.reload();

            } else {
                alert('Technical issue occured. Try again!');
            }

            return false;
        },
        error: function (result) {
            alert('Some Error Occured, Please try again later!');
        }
    });
});
function IsEmail(email) {
    var regex =
        /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if (!regex.test(email)) {
        return false;
    }
    else {
        return true;
    }
}
$('#txtBrandName').on('blur', function () {
    if ($('#txtDisplayName').val().trim() == '') {
        $('#txtDisplayName').val($('#txtBrandName').val());
    }
});
function ValidateMobile(mobNum) {
    var filter = /^\d*(?:\.\d{1,2})?$/;
    if (filter.test(mobNum)) {
        if (mobNum.length == 10) {
            return true;
        } else {
            alert('Please enter 10 digit mobile number');
            return false;
        }
    } else {
        alert('Invalid mobile number');
        return false;
    }

}

function EditDetails(sellerId, ctrl) {
    //debugger;
    var confirmstatus = confirm('Are you sure want to edit');
    if (confirmstatus == true) {
        $('#hdnSellerId').val(sellerId);
        $('#txtFirstName').val($(ctrl).closest('tr').find('td:eq(2)').text());
        $('#txtLastName').val($(ctrl).closest('tr').find('td:eq(3)').text());
        $('#txtBrandName').val($(ctrl).closest('tr').find('td:eq(4)').text());
        $('#txtDisplayName').val($(ctrl).closest('tr').find('td:eq(5)').text());
        $('#txtGST').val($(ctrl).closest('tr').find('td:eq(6)').text());
        $('#txtSelleraddress').val($(ctrl).closest('tr').find('td:eq(7)').text());
        $('#ddlCategory').val($(ctrl).closest('tr').find('td:eq(12)').text());
        $('#txtMobile').val($(ctrl).closest('tr').find('td:eq(8)').text());
        $('#txtLandline').val($(ctrl).closest('tr').find('td:eq(9)').text());
        $('#txtEmailid').val($(ctrl).closest('tr').find('td:eq(10)').text());
        $('#txtwebsite').val($(ctrl).closest('tr').find('td:eq(11)').text());
        $('#txtpassword').val($(ctrl).closest('tr').find('td:eq(13)').text());
        $('#txtconfirmpassword').val($(ctrl).closest('tr').find('td:eq(13)').text());
        var mypath = $(ctrl).closest('tr').find('td:eq(14)').find('img').attr('src');
        $('#myuploadImg').attr('src', mypath);
        $('#txtEmailid').prop('disabled', true);
        $('#btnSaveDetails').text('Update');
        $('#organizationPopup').modal('show');
    }
}
$("body").on('click', '.toggle-password', function () {
    debugger;
    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $("#txtpassword");
    if (input.attr("type") === "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }

});
$("body").on('click', '.toggle-cfpassword', function () {
    debugger;
    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $("#txtconfirmpassword");
    if (input.attr("type") === "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }

});
function DeleteDetails(sellerId, Status) {
    debugger;
    var updatedStatus;
    if (Status == true) {
        updatedStatus = false;
    } else {
        updatedStatus = true;
    }
    $.ajax({
        url: "OrganizationMaster.aspx/DeleteOrganizationMaster",
        async: false,
        data: JSON.stringify({ Id: sellerId, IsActive: updatedStatus  }),
        contentType: "application/json; charset=utf-8",
        type: "POST", // data has to be Posted 
        timeout: 120000,
        dataType: "json",
        success: function (result) {
            debugger;
            if (result.d > 0) {
                alert('Organization status updated successfully');
                window.location.reload();

            } else {
                alert('Technical issue occured. Try again!');
            }

            return false;
        },
        error: function (result) {
            alert('Some Error Occured, Please try again later!');
        }
    });
}