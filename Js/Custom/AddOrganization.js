$(document).ready(function () {
    BindCategory();
});

function BindCategory() {
    $.ajax({
        url: "AddOrganization.aspx/BindCategory",
        async: false,
        contentType: "application/json; charset=utf-8",
        type: "POST", // data has to be Posted 
        timeout: 120000,
        dataType: "json",
        success: function (result) {
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

$('#txtMobile,#txtLandline').keypress(function (e) {
    var charCode = (e.which) ? e.which : event.keyCode
    if (String.fromCharCode(charCode).match(/[^0-9]/g)) {
        return false;
    }
});

function sendFile(file) {
    var model = new FormData();
    model.append('file', file.files[0]);
    $.ajax({
        type: 'POST',
        url: '../AjaxResponsePages/FileUploader.ashx',
        data: model,
        contentType: false,
        processData: false,
        success: function (result) {
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
    var latitude = $('#txtLatitude').val();
    var longitude = $('#txtLongitude').val();
    var username = '';
    if ($('#chkmobile').is(':checked')) {
        username = $('#txtMobile').val();
    } else if ($('#chkemail').is(':checked')) {
        username = $('#txtEmailid').val();
    }
  
    var getpath = $('#myuploadImg').attr('src');
    if (getpath != 'undefined' && getpath != undefined) {
        getpath = getpath.split('..')[2];
    } else {
        getpath = null;
    }

    $.ajax({
        url: "AddOrganization.aspx/AddOrganizationMaster",
        async: false,
        data: JSON.stringify({ SellerName: sellername, LastName: lastname, BrandName: brandname, DisplayName: displayname, GST: gst, SellerAddress: selleraddress, Mobile: mobile, LandLineNumber: landline, Email: emailid, Website: website, Password: password, BusinessId: businessid, SellerId: sellerId, Username: username, ProfileImage: getpath, Latitude: latitude, Longitude: longitude }),
        contentType: "application/json; charset=utf-8",
        type: "POST", // data has to be Posted 
        timeout: 120000,
        dataType: "json",
        success: function (result) {
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

$("body").on('click', '.toggle-password', function () {
    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $("#txtpassword");
    if (input.attr("type") === "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});

$("body").on('click', '.toggle-cfpassword', function () {
    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $("#txtconfirmpassword");
    if (input.attr("type") === "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});
