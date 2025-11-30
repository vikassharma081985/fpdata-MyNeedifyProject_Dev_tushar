

function UpdatePreview(evt, callfor) {
    debugger
    $('#ContentPlaceHolder1_lblalertmsg').css('display', 'none');
    var name = evt.id;
    var filename = $('#' + name).val();
    var fileExtension = ['jpeg', 'jpg', 'png', 'pdf'];
    if ($.inArray(filename.split('.').pop().toLowerCase(), fileExtension) == -1) {
        $('#ContentPlaceHolder1_lblalertmsg').css('display', 'block');
        $('#ContentPlaceHolder1_lblalertmsg').css('font-size', '13px');
        $('#ContentPlaceHolder1_lblalertmsg').text("Only formats are allowed : 'jpeg', 'jpg', 'png', 'pdf' ");
        $('#ContentPlaceHolder1_lblalertmsg').css('color', 'red');
        $('#ContentPlaceHolder1_txtDisplay').val("");
        $("#ContentPlaceHolder1_flUpload").val("");
        return false;
    }
    $('#lblalertmsg').css('display', 'none');
    $("#imgLoad").css("display", "block");
    var html = "";
    if (callfor == "MoudLetter") {
        var fileUpload = $('[id$=flUpload]').get(0);
    }
    var files = fileUpload.files;
    var data = new FormData();
    for (var i = 0; i < files.length; i++) {
        data.append(files[i].name, files[i]);
    }
    console.log(data)
    $.ajax({
        url: "../AjaxResponsePages/AsyAttachement_HandlerFile.ashx?callFor=" + callfor,
        type: "POST",
        async: true,
        data: data,
        contentType: false,
        processData: false,
        success: function (result) {
            debugger
            var name = result.split('|');
            $("#imgLoad").css("display", "none");

            var displayName = '';
            if ($('#ContentPlaceHolder1_txtDisplay').val() != '') {
                displayName = $('#ContentPlaceHolder1_txtDisplay').val();

                html += '<tr><td><span>' + displayName + '</span></td>';
                html += '<td style="padding-left:5%;"> <input type="hidden" id="DisplayName"  value= "' + displayName + '"> <input type="hidden" id="AttachementName"  value="' + files[0].name + '"> <a style="color:#09f;" href="#" onclick="return RemoveFile(this);"><img src="../../Images/delete.gif" /></a></td></tr>';
            }
            else {
                displayName = (files[0].name).split('.');
                if (displayName.length == 2) {

                    html += '<tr><td><span> ' + displayName[0] + ' </span></td>';
                    html += '<td style="padding-left:5%;"> <input type="hidden" id="DisplayName"  value= "' + displayName[0] + '"> <input type="hidden" id="AttachementName"  value="' + files[0].name + '"> <a style="color:#09f;" href="#" onclick="return RemoveFile(this);"><img src="../../Images/delete.gif" /></a></td></tr>';
                }
                if (displayName.length > 2) {
                    //var imgname = "";
                    var disname = "";
                    for (i = 0; i < displayName.length - 1; i++) {
                        disname += displayName[i] + ".";

                    }
                    disname = disname.substring(0, (disname.length - 1));
                    html += '<tr><td><span> ' + disname + ' </span></td>';
                    html += '<td style="padding-left:5%;"> <input type="hidden" id="DisplayName"  value= "' + disname + '"> <input type="hidden" id="AttachementName"  value="' + files[0].name + '"> <a style="color:#09f;" href="#" onclick="return RemoveFile(this);"><img src="../../Images/Item/delete.jpg" /></a></td></tr>';
                }
            }
            $('#ContentPlaceHolder1_divAttachement').css('display', 'block');
            $('#ContentPlaceHolder1_divAttachement').find('table').append(html);
            $('#ContentPlaceHolder1_flUpload').css("border", "1px solid #ccc");
            $('#ContentPlaceHolder1_txtDisplay').val("");
            $("#ContentPlaceHolder1_flUpload").val("");
        },
        error: function (err) {
            console.log(err)
        }
    });

    return false;
}

function RemoveFile(ctrl) {
    debugger
    var i = 0;
    var count = 2;
    $('#tblAttachment tr').each(function () {
        i++;
    });
    if (i > count) {
        $(ctrl).parent().parent().remove();
    }
    else
        $(ctrl).parent().parent().parent().remove();

    return false;
}

function AttachmentXML() {
    debugger
    var hdnImgDisplayName = "";
    hdnImgDisplayName += '<data>';
    $('#tblAttachment').find('tr:not(:first-child)').each(function (index) {
        var row = $(this);
        debugger;
        if (row.find('span').text() != "") {

            if (row.find('#AttachementName').val().indexOf('_') > 0) {
                var Tempattachment = row.find('#AttachementName').val();
                var attachment = "00" + (index + 1);
                var title = row.find('span').text();
            }
            else {
                var Tempattachment = row.find('#AttachementName').val();
                var attachment = "00" + (index + 1);
                var title = row.find('span').text();
            }

            hdnImgDisplayName += '<rows>';
            hdnImgDisplayName += '<Attachment>' + Tempattachment + '</Attachment>';
            hdnImgDisplayName += '<Title>' + title + '</Title>';
            hdnImgDisplayName += '<Tempattachment>' + Tempattachment + '</Tempattachment>';
            hdnImgDisplayName += '</rows>';
        }
    });
    hdnImgDisplayName += '</data>';
    $("#ContentPlaceHolder1_hdnAttachmentXML").val(hdnImgDisplayName);
    return this;
}


function OpenAttachment(ctrl) {
    debugger
    var id = ctrl.id;
    var AttachmentName = $(('#' + id).replace('lnkAttName', 'hdnAttachmentId')).val();
    var Extention = $(('#' + id).replace('lnkAttName', 'hdnTempAttachment')).val();
    var Ext = Extention.split('.').pop();
    var Name = $('#' + id).text();
    // $("#myModal").modal("show");
    var ImgName = $('#hdnPhysicalPath').val();
    var FormId = $('#hdnFormId').val();
    var FinalPath = "../Attachment/DirAttachments/" + FormId + "_" + AttachmentName + "." + Ext;

    $('#ifattach').attr('src', FinalPath)
    $("#myModal").modal("show");
    return false;
}


function ValidateSave() {

    var counttr = 0;
    var msg = "";
    var ItemName = $('[id$=txtItemName]').val();
    var Itemdescription = $('[id$=txtItemDescription]').val();
    var Amount = $('[id$=txtAmount]').val();
    var MRP = $('[id$=txtMRP]').val();
    $('[id$=hdnSupplier]').val($('[id$=ddlSupplier]').val());
    $('[id$=hdnCategory]').val($('[id$=ddlCategory]').val());
    $('[id$=hdnSubCategory]').val($('[id$=ddlSubCatgeory]').val());
    $('[id$=hdnSubSubCategory]').val($('[id$=ddlSubSubCategory]').val());

    $('#tblAttachment').find('tr:not(:first-child)').each(function (index) {
        counttr++;
    });

    if (ItemName.trim() == "") {
        msg += '-Enter Item name.\n';
        $('[id$=txtItemName]').css("border", "1px solid red");
    }
    else {
        $('[id$=txtItemName]').css("border", "1px solid #ccc");
    }
    if (Itemdescription.trim() == "") {
        //msg += '-Enter Item description .\n';
        //$('[id$=txtItemDescription]').css("border", "1px solid red");
    }
    else {
        $('[id$=txtItemDescription]').css("border", "1px solid #ccc");

    }
    if (Amount == "") {
        msg += '-Select Category.\n';
        $('[id$=txtAmount]').css("border", "1px solid red");
    }
    else {
        $('[id$=txtAmount]').css("border", "1px solid #ccc");

    }

    if (MRP == "") {
        msg += '-Select Category.\n';
        $('[id$=txtMRP]').css("border", "1px solid red");
    }
    else {
        $('[id$=txtMRP]').css("border", "1px solid #ccc");

    }


    //if (counttr == 0) {
    //    msg += '-Select Category.\n';
    //    $('#ContentPlaceHolder1_flUpload').css("border", "1px solid red");
    //}
    //else {
    //    $('#ContentPlaceHolder1_flUpload').css("border", "1px solid #ccc");

    //}
    if (msg.length > 0) {
        return false;
    }
    else {
        AttachmentXML();
        Size();
    }

}

function Validate(ctrl) {
    debugger
    var txtID = $('#' + ctrl.id).val().trim();
    if (txtID.length == '0') {
        var ID = $('#' + ((ctrl.id).replace('txt', 'Err'))).css('display', 'block');
        var ID1 = $('#' + ((ctrl.id).replace('txt', 'txt'))).css("border", "1px solid Red");
    }
    else {
        var ID = $('#' + ((ctrl.id).replace('txt', 'Err'))).css('display', 'none');
        var ID1 = $('#' + ((ctrl.id).replace('txt', 'txt'))).css("border", "1px solid #ccc");
    }
    return false;
}


//===========================================================


var NomineeCount = 0;
function AddMemberDetails() {
    debugger
    NomineeCount++;
    var NomineesDetailsClone = $('#Trdivmemberdetails').clone();
    NomineesDetailsClone.find('input[type="text"]').each(function () { $(this).prop('value', ''); });
    NomineesDetailsClone.find('#ContentPlaceHolder1_txtMemberDOB').attr("onclick", "call(this);");
    NomineesDetailsClone.find('#ContentPlaceHolder1_txtMemberDOB').attr("id", "ContentPlaceHolder1_txtMemberDOB_" + NomineeCount);
    $('#divmemberdetails').append(NomineesDetailsClone);
    return false;
}

var ctrForFirst = 0;
function GetAllMemberDetails() {

    if (ValidateMemberDetails() == true) {

        $('#ContentPlaceHolder1_hdnMemberDetails').val('');
        var Name;
        var XML = '<data>'

        $('#divmemberdetails').find('tr').each(function () {
            debugger

            XML += '<rows>'
            XML += '<MembershipType>' + $(this).find('#ContentPlaceHolder1_ddlMembershipType').val() + '</MembershipType>';
            Name = $(this).find('#ContentPlaceHolder1_txtName').val().split(' ');
            if (Name.length > 0)
                XML += '<FirstName>' + Name[0] + '</FirstName>';
            else
                XML += '<FirstName></FirstName>';

            if (Name.length > 1)
                XML += '<MiddleName>' + Name[1] + '</MiddleName>';
            else
                XML += '<MiddleName></MiddleName>';
            if (Name.length > 2)
                XML += '<LastName>' + Name[2] + '</LastName>';
            else
                XML += '<LastName></LastName>';


            //  XML += '<Name>' + $(this).find('#ContentPlaceHolder1_txtName').val() + '</Name>';
            XML += '<Designation>' + $(this).find('#ContentPlaceHolder1_txtDesignation').val() + '</Designation>';
            XML += '<Organisation>' + $(this).find('#ContentPlaceHolder1_txtOrganisation').val() + '</Organisation>';
            if (NomineeCount == 0) {
                XML += '<MemberDOB>' + $(this).find('#ContentPlaceHolder1_txtMemberDOB').val() + '</MemberDOB>';
            }

            else if (NomineeCount > 0) {
                if (ctrForFirst == 0) {
                    ctrForFirst++;
                    XML += '<MemberDOB>' + $(this).find('#ContentPlaceHolder1_txtMemberDOB').val() + '</MemberDOB>';
                }
                else {
                    XML += '<MemberDOB>' + $(this).find('#ContentPlaceHolder1_txtMemberDOB_' + NomineeCount).val() + '</MemberDOB>';
                }
            }
            XML += '<Email>' + $(this).find('#ContentPlaceHolder1_txtEmail').val() + '</Email>';
            XML += '<Mobile>' + $(this).find('#ContentPlaceHolder1_txtMobile').val() + '</Mobile>';
            // XML += '<Action>' + $(this).find('#ContentPlaceHolder1_ddlAction').val() + '</Action>';
            XML += '</rows>'
        });

        XML += '</data>';
        $('#ContentPlaceHolder1_hdnMemberDetails').val(XML);
        //  alert(XML);
        return true;
    }
    else {
        return false;
    }
}

function ShowDDl(ctrl) {
    debugger
    var id = ctrl
    if (id.checked)
        $('#divParentLetterNo').css('display', 'block');
    else
        $('#divParentLetterNo').css('display', 'none');

}

function ChangeButtonText(ctrl) {
    debugger;
    var id = ctrl.id;
    var SelectedValue = $('#' + id).val();
    if (SelectedValue == "1")
        $('#ContentPlaceHolder1_btnSaveMemberDetails').val('Save Member Details');

    else
        $('#ContentPlaceHolder1_btnSaveMemberDetails').val('Deactivate Members');


    return false;
}

$(document).ready(function () {

    //$('[id$=ddlSubCatgeory]').Onchange();

});
var d = new Date(90, 0, 1);
function call(ctrl) {
    $('#' + ctrl.id).datetimepicker({
        timepicker: false,
        mask: '',
        format: "d M Y",
        defaultDate: d,
        //minDate: '-1970/01/02',      

        yearStart: '1900'

    });
    return false;
}

function bindcategory1() {
    debugger;
    $('[id$=ddlCategory] option').remove();
    $('[id$=ddlSubCatgeory] option').remove();
    $('[id$=ddlSubSubCategory] option').remove();
    jQuery.ajax({
        url: "AddItem.aspx/BindCategory",
        data: '{ Suppplier: "' + $('[id$=ddlSupplier]').val() + '"}',
        type: "POST",
        timeout: 120000,
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $('[id$=ddlCategory]').append(jQuery("<option></option>").val("0").html("---Select---"));
            Subcat = jQuery.parseJSON(result.d);
            if (Subcat.length == 0) {
                $('[id$=ddlCategory]').append(jQuery("<option></option>").val("0").html("---No Data Found---"));
            }
            else {
                for (i = 0; i < Subcat.length; i++) {
                    $('[id$=ddlCategory]').append(jQuery("<option></option>").val(Subcat[i].CategoryId).html(Subcat[i].Category));
                }
                // $('[id$=ddlSubCatgeory]').append(jQuery("<option></option>").val('0').html('All'));
            }
        },
        error: function (xhr, status) {
            alert("Error ");
            $('[id$=ddlSubSubCatgeory]').attr("disabled", false);
        }
    });
}

function bindSubcategory() {
    debugger
    $('[id$=ddlSubCatgeory] option').remove();
    $('[id$=ddlSubSubCategory] option').remove();
    jQuery.ajax({
        url: "AddItem.aspx/BindSubCategory",
        data: '{ CategoryId: "' + $('[id$=ddlCategory]').val() + '"}',
        type: "POST",
        timeout: 120000,
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $('[id$=ddlSubCatgeory]').append(jQuery("<option></option>").val("0").html("---Select---"));
            Subcat = jQuery.parseJSON(result.d);
            if (Subcat.length == 0) {
                $('[id$=ddlSubCatgeory]').append(jQuery("<option></option>").val("0").html("---No Data Found---"));
            }
            else {
                for (i = 0; i < Subcat.length; i++) {
                    $('[id$=ddlSubCatgeory]').append(jQuery("<option></option>").val(Subcat[i].SubCategoryId).html(Subcat[i].SubCategory));
                }
                // $('[id$=ddlSubCatgeory]').append(jQuery("<option></option>").val('0').html('All'));
            }
        },
        error: function (xhr, status) {
            alert("Error ");
            $('[id$=ddlSubSubCatgeory]').attr("disabled", false);
        }
    });
}

function bindSubSubcategory() {
    $('[id$=ddlSubSubCategory] option').remove();
    jQuery.ajax({
        url: "AddItem.aspx/BindSubSubCategory",
        data: '{ SubCategoryId: "' + $('[id$=ddlSubCatgeory]').val() + '"}',
        type: "POST",
        timeout: 120000,
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            debugger
            SubSubCat = jQuery.parseJSON(result.d);
            if (SubSubCat.length == 0) {
                $('[id$=ddlSubSubCategory]').append(jQuery("<option></option>").val("0").html("---No Data Found---"));
            }
            else {
                for (i = 0; i < SubSubCat.length; i++) {
                    $('[id$=ddlSubSubCategory]').append(jQuery("<option></option>").val(SubSubCat[i].SubSubCategoryId).html(SubSubCat[i].SubSubCategory));
                }
                // $('[id$=ddlSubSubCategory]').append(jQuery("<option></option>").val('0').html('All'));
            }
        },
        error: function (xhr, status) {
            alert("Error ");
            $('[id$=ddlSubSubCategory]').attr("disabled", false);
        }
    });
}

function Size() {
    debugger
    var xml = "<data>";
    $('#tblSizenStock').find('tr').each(function (index) {
        if (index > 0) {
            
            //if ($(this).find('input[type=checkbox]').is(':checked')) {
            if ($(this).find('[id*=ddlSize]').val() != "0" && $(this).find('[id*=ddlColor]').val() != "0" && $(this).find('[id*=txtStock]').val() !="" ){
                xml += "<rows>"
                xml += "<SizeId>" + $(this).find('[id*=ddlSize]').val() + "</SizeId>"
                xml += "<Stock>" + $(this).find('[id*=txtStock]').val() + "</Stock>"
                xml += "<BatchNo>" + $(this).find('[id*=txtBatchNo]').val() + "</BatchNo>"
                xml += "<ColorId>" + $(this).find('[id*=ddlColor]').val() + "</ColorId>"

                xml += "</rows>";
            }
        }
    });
    xml += "</data>";
    $('[id$=hdnsize]').val(xml);
    //  alert(xml);
    return true;
}

function DeleteImage(Id) {

    var ImageId = Id;
    var ItemId = $('[id$=hdnItemId]').val();
    jQuery.ajax({
        url: "AddItem.aspx/DeleteImage",
        data: '{ ImageId: "' + Id + '",ItemId: "' + ItemId + '"}',
        type: "POST",
        timeout: 120000,
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            if (result = 1)
                alert('Selected Image Deleted');
            location.reload();
        },
        error: function (xhr, status) {
            alert("Error ");
        }
    });


}