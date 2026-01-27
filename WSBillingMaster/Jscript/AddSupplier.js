function AddAnnualTurnover() {
    var ddlFiancialYear = $('[id$=ddlFiancialYear] option:selected').val();
    var txtAnnualTurnover = $('[id$=txtAnnualTurnover]').val();
    var trcount = $('[id$=tblAnnualTurnover] tr').length;
    if (txtAnnualTurnover == "") {
        alert("Annual turnover can't blank.");
    }
    else {
        trcount = (trcount - 1) + 1;
        var html = "";
        html += "<tr>";
        html += "<td>";
        html += trcount;
        html += "</td>";
        html += "<td id='FiancialYear'>";
        html += ddlFiancialYear;
        html += "</td>";
        html += "<td id='AnnualTurnover'>";
        html += txtAnnualTurnover;
        html += "</td>";
        html += "<td>";
        html += "<a href='#' onclick='return RemoveAnnualTurnover(this);'>Remove </a>";
        html += "</td>";

        html += "</tr>";

        $('[id$=tblAnnualTurnover]').append(html);
    }
    return false;
}

function RemoveAnnualTurnover(ctrl) {
    debugger;
    $(ctrl).parent().parent().remove();
    return false;
}

function AddGstDetails() {
    //$('[id$=hdnAddAnnualTurnover]').val() = '';
    var ddlFiancialYear = $('[id$=ddlGStState] option:selected').val();
    var ddlFiancialYeart = $('[id$=ddlGStState] option:selected').text();
    var txtGstAddress = $('[id$=txtGstAddress]').val();
    var txtGstNumber = $('[id$=txtGstNumber]').val();
    var trcount = $('[id$=tblGstDetails] tr').length;
    if (txtGstAddress == "" || txtGstNumber == "" || ddlFiancialYear == "--Select State--") {
        alert("Please all field.");
    }
    else {
        trcount = (trcount - 1) + 1;
        var html = "";
        html += "<tr>";
        html += "<td>";
        html += trcount;
        html += "</td>";
        html += "<td>";
        html += "<input type='hidden' value='" + ddlFiancialYear + "' id='hdnGstState' />";
        html += ddlFiancialYeart;
        html += "</td>";
        html += "<td>";
        html += txtGstAddress;
        html += "</td>";
        html += "<td>";
        html += txtGstNumber;
        html += "</td>";
        html += "<td>";
        html += "<a href='#' onclick='return RemoveAnnualTurnover(this);'>Remove </a>";
        html += "</td>";
        html += "</tr>";
        $('[id$=tblGstDetails]').append(html);
    }
    return false;
}

function ValidateSave() {
    debugger;
    var errmsg = "";

    var txtSupplierName = $('[id$=txtSupplierName]').val();
    if (txtSupplierName === "")
        errmsg += "Please enter Supplier name.\n";
    var txtSupplierCode = $('[id$=txtSupplierCode]').val();
    if (txtSupplierCode === "")
        errmsg += "Please enter Supplier code.\n";
    var ddlSupplierType = $('[id$=ddlSupplierType]').val();
    if (ddlSupplierType === "" || ddlSupplierType === "0")
        errmsg += "Please select Supplier type.\n";    
    var ddlItemCategory = $('[id$=ddlItemCategory]').val();
    if (ddlItemCategory === "" || ddlItemCategory === "0")
        errmsg += "Please select item category.\n";
    var txtHouseOfficeNo = $('[id$=txtHouseOfficeNo]').val();
    if (txtHouseOfficeNo === "")
        errmsg += "Please enter house office no.\n";
    var txtStreetBuildingLocality = $('[id$=txtStreetBuildingLocality]').val();
    if (txtStreetBuildingLocality === "")
        errmsg += "Please enter Street Building name.\n";
    var ddlCountry = $('[id$=ddlCountry]').val();
    if (ddlCountry === "" || ddlCountry === "0")
        errmsg += "Please select country name.\n";
    var ddlState = $('[id$=ddlState]').val();
    if (ddlState === "" || ddlState === "0")
        errmsg += "Please select state name.\n";
    var txtPinCode = $('[id$=txtPinCode]').val();
    if (txtPinCode === "")
        errmsg += "Please enter pin code.\n";
    var txtLandline = $('[id$=txtLandline]').val();
    if (txtLandline === "")
        errmsg += "Please enter landline.\n";
    var txtFaxNo = $('[id$=txtFaxNo]').val();
    if (txtFaxNo === "")
        errmsg += "Please enter fax no.\n";
    var txtEmailid = $('[id$=txtEmailid]').val();
    if (txtEmailid === "")
        errmsg += "Please enter email id.\n";
    var txtWebSite = $('[id$=txtWebSite]').val();
    if (txtWebSite === "")
        errmsg += "Please enter website.\n";
    var txtPrimaryContactPerson = $('[id$=txtPrimaryContactPerson]').val();
    if (txtPrimaryContactPerson === "")
        errmsg += "Please enter primary contact person.\n";
    var txtPrimaryDestination = $('[id$=txtPrimaryDestination]').val();
    if (txtPrimaryDestination === "")
        errmsg += "Please enter primary contact destination.\n";
    var txtPrimaryMobile = $('[id$=txtPrimaryMobile]').val();
    if (txtPrimaryMobile === "")
        errmsg += "Please enter primary contact mobile.\n";
    var txtPrimaryEmail = $('[id$=txtPrimaryEmail]').val();
    if (txtPrimaryEmail === "")
        errmsg += "Please enter primary email.\n";
    var txtSecondaryContactPerson = $('[id$=txtSecondaryContactPerson]').val();
    if (txtSecondaryContactPerson  === "")
        errmsg += "Please enter secondary contact person.\n";
    var txtsecondaryDestination = $('[id$=txtsecondaryDestination]').val();
    if (txtsecondaryDestination === "")
        errmsg += "Please enter secondary contact person destination.\n";
    var txtSecondaryMobile = $('[id$=txtSecondaryMobile]').val();
    if (txtSecondaryMobile === "")
        errmsg += "Please enter secondary person mobile.\n";
    var txtSecondaryEmail = $('[id$=txtSecondaryEmail]').val();
    if (txtSecondaryEmail === "")
        errmsg += "Please enter secondary person email.\n";
    var txtTANno = $('[id$=txtTANno]').val();
    if (txtTANno === "")
        errmsg += "Please enter tan no.\n";
    var txtPFRegistrationNo = $('[id$=txtPFRegistrationNo]').val();
    if (txtPFRegistrationNo === "")
        errmsg += "Please enter PF Registration No.\n";
    var txtNameOnPAN = $('[id$=txtNameOnPAN]').val();
    if (txtNameOnPAN === "")
        errmsg += "Please enter name on pan.\n";
    var txtPANNo = $('[id$=txtPANNo]').val();
    if (txtPANNo === "")
        errmsg += "Please enter pan no.\n";
    var txtROCNo = $('[id$=txtROCNo]').val();
    if (txtROCNo === "")
        errmsg += "Please enter ROC no.\n";
    var txtESIRegistrationNo = $('[id$=txtESIRegistrationNo]').val();
    if (txtESIRegistrationNo === "")
        errmsg += "Please enter ESI Registration no.\n";
    var txtISOCertificateNo = $('[id$=txtISOCertificateNo]').val();
    if (txtISOCertificateNo === "")
        errmsg += "Please enter ISO Certificate no.\n";
    var txtISOValidUpTo = $('[id$=txtISOValidUpTo]').val();
    if (txtISOValidUpTo === "")
        errmsg += "Please enter ISO Valid Up To.\n";
    var txtPollutionCB = $('[id$=txtPollutionCB]').val();
    if (txtPollutionCB === "")
        errmsg += "Please enter pollution CB.\n";
    var txtPollutionValidUpTo = $('[id$=txtPollutionValidUpTo]').val();
    if (txtPollutionValidUpTo === "")
        errmsg += "Please enter pollution valid up to.\n";    
    var txtMSMEValidUpTo = $('[id$=txtMSMEValidUpTo]').val();
    if (txtMSMEValidUpTo === "")
        errmsg += "Please enter MSME valid up to.\n";
    var txtBank1 = $('[id$=txtBank1]').val();
    if (txtBank1 === "")
        errmsg += "Please enter bank.\n";
    var txtBankBranch = $('[id$=txtBankBranch]').val();
    if (txtBankBranch === "")
        errmsg += "Please enter bank branch.\n";
    var txtBankAccNo = $('[id$=txtBankAccNo]').val();
    if (txtBankAccNo === "")
        errmsg += "Please enter bank account no.\n";
    var txtRtgsIfsc = $('[id$=txtRtgsIfsc]').val();
    if (txtRtgsIfsc === "")
        errmsg += "Please enter rtgs ifsc.\n";
    var txtAddress1bank = $('[id$=txtAddress1bank]').val();
    if (txtAddress1bank === "")
        errmsg += "Please enter bank 1 address.\n";
    //var txtAddress2bank = $('[id$=txtAddress2bank]').val();
    //if (txtAddress2bank === "")
    //    errmsg += "Please enter bank 1 address 2.\n";
    var txtCitybank = $('[id$=txtCitybank]').val();
    if (txtCitybank === "")
        errmsg += "Please enter city of bank.\n";
    var txtStateBank = $('[id$=txtStateBank]').val();
    if (txtStateBank=== "")
        errmsg += "Please enter state of bank.\n";
    var txtBanker2 = $('[id$=txtBanker2]').val();
    if (txtBanker2 === "")
        errmsg += "Please enter bank 2.\n";
    var txtBank2Branch = $('[id$=txtBank2Branch]').val();
    if (txtBank2Branch=== "")
        errmsg += "Please enter bank 2 branch.\n";
    var txtBank2BankaccNo = $('[id$=txtBank2BankaccNo]').val();
    if (txtBank2BankaccNo === "")
        errmsg += "Please enter bank 2 account no.\n";
    var txtBank2RtgsIfsc = $('[id$=txtBank2RtgsIfsc]').val();
    if (txtBank2RtgsIfsc=== "")
        errmsg += "Please enter bank 2 ifsc.\n";
    var txtBank2Address1 = $('[id$=txtBank2Address1]').val();
    if (txtBank2Address1 === "")
        errmsg += "Please enter bank 2 address.\n";
    //var txtBank2Address2 = $('[id$=txtBank2Address2]').val();
    //if (txtBank2Address2 === "")
    //    errmsg += "Please enter bank 2 address 2.\n";
    var txtBank2City = $('[id$=txtBank2City]').val();
    if (txtBank2City === "")
        errmsg += "Please enter bank 2 city.\n";
    var txtBank2State = $('[id$=txtBank2State]').val();
    if (txtBank2State === "")
        errmsg += "Please enter bank 2 state.\n";
    var txtPaymentTerms = $('[id$=txtPaymentTerms]').val();
    if (txtPaymentTerms=== "")
        errmsg += "Please enter payment terms.\n";
    var txtTaxes = $('[id$=txtTaxes]').val();
    if (txtTaxes=== "")
        errmsg += "Please enter taxes.\n";
    var txtDeliveryTerms = $('[id$=txtDeliveryTerms]').val();
    if (txtDeliveryTerms=== "")
        errmsg += "Please enter delivery terms.\n";
    var txtVendorToNote = $('[id$=txtVendorToNote]').val();
    if (txtVendorToNote=== "")
        errmsg += "Please enter vender to note.\n";
    var txtCreditLimit = $('[id$=txtCreditLimit]').val();
    if (txtCreditLimit === "")
        errmsg += "Please enter credit limit.\n";
    var txtSellerUserName = $('[id$=txtSellerUserName]').val();
    if (txtSellerUserName === "")
        errmsg += "Please enter seller user name.\n";
    var txtSellerPassword = $('[id$=txtSellerPassword]').val();
    if (txtSellerPassword=== "")
        errmsg += "Please enter seller password.\n";
    var txtsellerConfirmPassword = $('[id$=txtsellerConfirmPassword]').val();
    if (txtsellerConfirmPassword === "")
        errmsg += "Please enter seller confirm password.\n";    
    if (txtSellerPassword != txtsellerConfirmPassword) {
        errmsg += "Password and confirm password mismatch.\n";
    }
    var txtClosePoAfter = $('[id$=txtClosePoAfter]').val();
    if (txtClosePoAfter === "")
        errmsg += "Please enter close PO after.\n";
    if ($('[id$=tblAnnualTurnover] tr').length < 1) {
        errmsg += "Please enter annual turnover.";
    }
    if ($('[id$=tblGstDetails] tr').length < 1) {
        errmsg += "Please enter GST details.";
    }

    if (errmsg.length > 0) {
        alert(errmsg);
        return false;
    }
    else {
        $('[id$=hdnAddAnnualTurnover]').val('');
        $('[id$=hdnGstDetails]').val('');
        var financialdata = '';
        var gstdetails = '';
        financialdata = '<data>';
        gstdetails = '<data>';
        if ($('[id$=tblAnnualTurnover] tr').length > 1) {
            $('[id$=tblAnnualTurnover] tr:not(:first-child)').each(function () {
                var row = $(this);
                var FinancialYear = row.find('td').eq(1).text();
                var AnnualTurnover = row.find('td').eq(2).text();
                financialdata += '<rows>';
                financialdata += '<FinancialYear>';
                financialdata += FinancialYear;
                financialdata += '</FinancialYear>';
                financialdata += '<AnnualTurnover>';
                financialdata += AnnualTurnover;
                financialdata += '</AnnualTurnover>';
                financialdata += '</rows>';
            });
        }

        if ($('[id$=tblGstDetails] tr').length > 1) {
            $('[id$=tblGstDetails] tr:not(:first-child)').each(function () {
                var row = $(this);
                var gststate = row.find('td').find('#hdnGstState').val();
                var address = $(this).find('td').eq(2).text();
                var gstno = $(this).find('td').eq(3).text();

                gstdetails += '<row>';
                gstdetails += '<gststate>';
                gstdetails += gststate;
                gstdetails += '</gststate>';
                gstdetails += '<address>';
                gstdetails += address;
                gstdetails += '</address>';
                gstdetails += '<gstno>';
                gstdetails += gstno;
                gstdetails += '</gstno>';
                gstdetails += '</row>';
            });
        }
        financialdata += '</data>';
        gstdetails += '</data>';
        $('[id$=hdnAddAnnualTurnover]').val(financialdata);
        $('[id$=hdnGstDetails]').val(gstdetails);
        return true;
    }
}

function financedata(finyear, annualturnover) {
    var arr_finyear = finyear.split('@');
    var arr_annualturnover = annualturnover.split('@');
    var trcount = $('[id$=tblAnnualTurnover] tr').length;
    trcount = (trcount - 1);
    var html = "";
    for (var i = 0; i < arr_finyear.length; i++) {
        html += "<tr>";
        html += "<td>";
        html += i + 1;
        html += "</td>";
        html += "<td id='FiancialYear'>";
        html += arr_finyear[i];
        html += "</td>";
        html += "<td id='AnnualTurnover'>";
        html += arr_annualturnover[i];
        html += "</td>";
        html += "<td>";
        html += "<a href='#' onclick='return RemoveAnnualTurnover(this);'>Remove </a>";
        html += "</td>";
        html += "</tr>";
    }
    $('[id$=tblAnnualTurnover]').append(html);
}

function gstdata(Supplier, StateId, State, GST_No, Address) {
    var arr_Supplier = Supplier.split('@');
    var arr_StateId = StateId.split('@');
    var arr_State = State.split('@');
    var arr_GST_No = GST_No.split('@');
    var arr_Address = Address.split('@');
    var trcount = $('[id$=tblGstDetails] tr').length;
    var html = "";
    for (var i = 0; i < arr_Supplier.length; i++) {
        html += "<tr>";
        html += "<td>";
        html += i + 1;
        html += "</td>";
        html += "<td>";
        html += "<input type='hidden' value='" + arr_StateId[i] + "' id='hdnGstState' />";
        html += arr_State[i];
        html += "</td>";
        html += "<td>";
        html += arr_Address[i];
        html += "</td>";
        html += "<td>";
        html += arr_GST_No[i];
        html += "</td>";
        html += "<td>";
        html += "<a href='#' onclick='return RemoveAnnualTurnover(this);'>Remove </a>";
        html += "</td>";
        html += "</tr>";
    }
    $('[id$=tblGstDetails]').append(html);
}