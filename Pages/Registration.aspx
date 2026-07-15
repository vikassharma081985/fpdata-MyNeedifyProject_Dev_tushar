<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs"
    Inherits="WSBillingMaster.Pages.Registration" %>

    <!DOCTYPE html>
    <html lang="en">



    <head runat="server">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Job Registration</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            .invalid-feedback {
                display: none;
                font-size: 14px;
            }

            .hidden {
                display: none;
            }
        </style>

        <script>


            //for toggle bar
            document.addEventListener("DOMContentLoaded", function () {
                const toggles = document.querySelectorAll("button[data-bs-toggle='collapse']");

                toggles.forEach(btn => {
                    const icon = btn.querySelector(".toggle-icon");
                    const target = document.querySelector(btn.getAttribute("data-bs-target"));

                    target.addEventListener("show.bs.collapse", () => icon.textContent = "−");
                    target.addEventListener("hide.bs.collapse", () => icon.textContent = "+");
                });
            });








        // validations

        document.addEventListener("DOMContentLoaded", function () {

            const inputs = document.querySelectorAll("input, select, textarea");

            // Auto-add validation div if missing
            inputs.forEach(el => {
                if (el.nextElementSibling == null || !el.nextElementSibling.classList.contains("invalid-feedback")) {
                    let div = document.createElement("div");
                    div.className = "invalid-feedback";
                    el.insertAdjacentElement("afterend", div);
                }
            });


            // Allow only numbers
            function allowOnlyNumbers(e) {
                let char = e.which ? e.which : e.keyCode;
                if (char < 48 || char > 57) e.preventDefault();
            }

            // Allow only letters
            function allowOnlyLetters(e) {
                let char = e.which ? e.which : e.keyCode;
                if (!((char >= 65 && char <= 90) || (char >= 97 && char <= 122) || char === 32)) {
                    e.preventDefault();
                }
            }

            // Show error
            function showError(element, message) {
                let feedback = element.nextElementSibling;

                if (feedback) {
                    feedback.innerHTML = message;
                    feedback.style.display = "block";
                    element.classList.add("is-invalid");
                }
            }

            // FORM VALIDATION
            function validateForm() {
                let isValid = true;
                let firstInvalid = null;

                const inputs = document.querySelectorAll("input, select, textarea");
                inputs.forEach(el => {
                    if (!el.id.includes("btn") && el.id !== "hdnUserId") {
                        if (!validateField(el)) {
                            isValid = false;
                            if (!firstInvalid) firstInvalid = el;
                        }
                    }
                });

                if (!isValid && firstInvalid) {
                    firstInvalid.focus();
                    // If in collapse, open it
                    let collapse = firstInvalid.closest(".collapse");
                    if (collapse && !collapse.classList.contains("show")) {
                        let bsCollapse = new bootstrap.Collapse(collapse);
                        bsCollapse.show();
                    }
                }

                return isValid;
            }

        </script>
    </head>

    <body class="bg-light">
        <form id="form1" runat="server" enctype="multipart/form-data" class="container py-4">
            <asp:HiddenField ID="hdnUserId" runat="server" />

            <div class="card">
                <div class="card-header text-white d-flex justify-content-between align-items-center"
                    style="background-color: #F48B1E">

                    <span>Job Registration</span>

                    <!-- Three Line Menu -->
                    <button type="button" class="btn text-white" data-bs-toggle="offcanvas" data-bs-target="#editPanel"
                        style="font-size: 22px; border: none;">
                        &#9776;
                    </button>

            // Education File
          <%--  let fuEdu = document.getElementById('<%= fuEducation.ClientID %>');
            if (fuEdu.files.length === 0) {
                showError(fuEdu, "Upload Educational Certificate");
                isValid = false;
            }--%>

            // Phone Number
            let phone = document.getElementById('<%= txtLoginPhone.ClientID %>');
            if (phone.value.trim().length !== 10) {
                showError(phone, "Enter 10-digit Phone Number");
                isValid = false;
            }

            // If Valid → Show Success Message
            if (isValid) {
                document.getElementById("successMessage").style.display = "block";
                window.scrollTo(0, 0);
            }

            return isValid;
        }

    </script>
</head>

<body class="bg-light">
    <form id="form1" runat="server" enctype="multipart/form-data" class="container py-4">

        <div class="card">
<div class="card-header text-white d-flex justify-content-between align-items-center"
     style="background-color: #F48B1E">

    <span>Job Registration</span>

    <!-- Three Line Menu -->
    <button type="button"
            class="btn text-white"
            data-bs-toggle="offcanvas"
            data-bs-target="#editPanel"
            style="font-size:22px; border:none;">
        &#9776;
    </button>

</div>            <div class="card-body">
                <div id="successMessage" class="alert alert-success" style="display: none;">
                    Registration submitted successfully!
                </div>
                <div class="card-body">
                    <%--<div id="successMessage" class="alert alert-success" style="display: none;">
                        Registration submitted successfully!
                </div>--%>

                <div class="row g-3">

                    <!-- Aadhaar Number -->
                    <div class="col-md-4">
                        <label>Aadhar Number</label>
                        <asp:TextBox ID="txtAadhar" runat="server" CssClass="form-control" MaxLength="12"
                            placeholder="Enter 12-digit Aadhaar number" onkeypress="allowOnlyNumbers(event)"
                            required="required" />
                    </div>

                    <!-- Upload Aadhaar -->
                    <div class="col-md-4">
                        <label>Upload Aadhar</label>
                        <asp:FileUpload ID="fuAadhar" runat="server" CssClass="form-control" />
                        <div class="mt-1">
                            <asp:HyperLink ID="hlAadhar" runat="server" Visible="false" Target="_blank"
                                CssClass="text-primary small" Text="View File"></asp:HyperLink>
                            <asp:LinkButton ID="btnRemoveAadhar" runat="server" Visible="false"
                                CssClass="text-danger ms-2 small" OnClick="btnRemoveFile_Click"
                                CommandArgument="AadharPath">Remove</asp:LinkButton>
                        </div>
                    </div>

                    <!-- Skilled In -->
                    <div class="col-md-4">
                        <label>Skilled In</label>
                        <asp:DropDownList ID="ddlSkills" runat="server" CssClass="form-select" required="required">
                            <asp:ListItem Text="Select your skill" Value="" />
                        </asp:DropDownList>
                    </div>

                    <!-- First Name -->
                    <div class="col-md-4">
                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"
                            onkeypress="allowOnlyLetters(event)" required="required" />
                    </div>

                    <!-- Last Name -->
                    <div class="col-md-4">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"
                            onkeypress="allowOnlyLetters(event)" required="required" />
                    </div>

                    <!-- Father's Name -->
                    <div class="col-md-4">
                        <label>Father's Name</label>
                        <asp:TextBox ID="txtFatherName" runat="server" CssClass="form-control"
                            placeholder="Enter Father's Name" onkeypress="allowOnlyLetters(event)"
                            required="required" />
                    </div>

                    <!-- Phone Number -->
                    <div class="col-md-4">
                        <label>Phone Number </label>
                        <asp:TextBox ID="txtLoginPhone" runat="server" CssClass="form-control" MaxLength="10"
                            placeholder="Enter mobile number" onkeypress="allowOnlyNumbers(event)"
                            required="required" />
                    </div>





                    <!-- Gender -->
                    <div class="col-md-4">
                        <label>Gender</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select" required="required">
                            <asp:ListItem Text="Select" Value="" />
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Birth Place -->
                    <div class="col-md-4">
                        <label>Birth Place</label>
                        <asp:TextBox ID="txtBirthPlace" runat="server" CssClass="form-control"
                            placeholder="Enter area name" onkeypress="allowOnlyLetters(event)" />
                    </div>

                    <!-- Marital Status -->
                    <div class="col-md-4">
                        <label>Marital Status</label>
                        <asp:DropDownList ID="ddlMarital" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Select" Value="" />
                            <asp:ListItem>Single</asp:ListItem>
                            <asp:ListItem>Married</asp:ListItem>
                            <asp:ListItem>Divorced</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Upload Photo -->
                    <div class="col-md-4">
                        <label>Upload Photo</label>
                        <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                        <div class="mt-1">
                            <asp:HyperLink ID="hlPhoto" runat="server" Visible="false" Target="_blank"
                                CssClass="text-primary small" Text="View File"></asp:HyperLink>
                            <asp:LinkButton ID="btnRemovePhoto" runat="server" Visible="false"
                                CssClass="text-danger ms-2 small" OnClick="btnRemoveFile_Click"
                                CommandArgument="PhotoPath">Remove</asp:LinkButton>
                        </div>
                    </div>












                    <!-- Address -->
                    <div class="col-md-4">
                        <label>Age</label>
                        <asp:TextBox ID="txtAge" runat="server" CssClass="form-control"
                            onkeypress="allowOnlyNumbers(event)"></asp:TextBox>
                    </div>


                    <!-- Languages Known -->
                    <div class="col-md-4">
                        <label>Languages Known</label>
                        <asp:TextBox ID="txtLanguages" runat="server" CssClass="form-control"
                            placeholder="e.g., Hindi, English" />
                    </div>




                    <!-- Expected Demand -->
                    <div class="col-md-4">
                        <label>Expected Demand</label>
                        <asp:DropDownList ID="ddlDemand" runat="server" CssClass="form-select" required="required">
                            <asp:ListItem>Per Day</asp:ListItem>
                            <asp:ListItem>Monthly</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label>Amount</label>
                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" MaxLength="10"
                            placeholder="Enter Amount" onkeypress="allowOnlyNumbers(event)" required="required" />
                    </div>





                <!-- Height -->
<div class="row g-3 align-items-center">

    <div class="col-md-2">
        <label>Height</label>
        <div class="input-group">
            <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control" />
            <span class="input-group-text">cm</span>
        </div>
    </div>

    <!-- Weight -->
    <div class="col-md-2">
        <label>Weight</label>
        <div class="input-group">
            <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control" />
            <span class="input-group-text">kg</span>
        </div>
    </div>

    <!-- Candidate Experience -->
    <div class="col-md-4">
        <label class="form-label">Experience Type</label>
        <select id="experienceType" class="form-select">
            <option value="" selected disabled>Select</option>
            <option value="fresher">Fresher</option>
            <option value="experienced">Experienced</option>
            <option value="exservice">Ex-Service</option>
        </select>
    </div>

    <!-- Experience Duration -->
    <div class="col-md-4 hidden" id="experienceDuration">
        <label class="form-label">Duration</label>
        <div class="input-group">
            <input type="number" class="form-control" id="experienceYears" placeholder="Enter number" min="0">
            <select class="form-select" id="experienceUnit">
                <option value="months">Months</option>
                <option value="years">Years</option>
            </select>
        </div>
    </div>

    
     <div class="col-md-4">
     <label>Upload Resume</label>
     <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
 </div>

</div>

<script>
    const expType = document.getElementById("experienceType");
    const expDuration = document.getElementById("experienceDuration");

                        <div class="col-md-2">
                            <label>Height</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control" />
                                <span class="input-group-text">cm</span>
                            </div>
                        </div>

                        <!-- Weight -->
                        <div class="col-md-2">
                            <label>Weight</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control" />
                                <span class="input-group-text">kg</span>
                            </div>
                        </div>

                        <!-- Candidate Experience -->
                        <div class="col-md-4">
                            <label class="form-label">Experience Type</label>
                            <asp:DropDownList ID="ddlExperienceType" runat="server" CssClass="form-select"
                                ClientIDMode="Static">
                                <asp:ListItem Text="Select" Value="" Selected="True" />
                                <asp:ListItem Text="Fresher" Value="fresher" />
                                <asp:ListItem Text="Experienced" Value="experienced" />
                                <asp:ListItem Text="Ex-Service" Value="exservice" />
                            </asp:DropDownList>
                        </div>

                        <!-- Experience Duration -->
                        <div class="col-md-4 hidden" id="experienceDuration">
                            <label class="form-label">Duration</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtExpDuration" runat="server" CssClass="form-control"
                                    TextMode="Number" placeholder="Enter number" min="0" />
                                <asp:DropDownList ID="ddlExpUnit" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="months">Months</asp:ListItem>
                                    <asp:ListItem Value="years">Years</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>


                        <div class="col-md-4">
                            <label>Upload Resume</label>
                            <asp:FileUpload ID="fuResume" runat="server" CssClass="form-control" />
                            <div class="mt-1">
                                <asp:HyperLink ID="hlResume" runat="server" Visible="false" Target="_blank"
                                    CssClass="text-primary small" Text="View File"></asp:HyperLink>
                                <asp:LinkButton ID="btnRemoveResume" runat="server" Visible="false"
                                    CssClass="text-danger ms-2 small" OnClick="btnRemoveFile_Click"
                                    CommandArgument="ResumePath">Remove</asp:LinkButton>
                            </div>
                        </div>

                    </div>

                    <script>
                        const expType = document.getElementById("ddlExperienceType");
                        const expDuration = document.getElementById("experienceDuration");

                        expType.addEventListener("change", function () {

                            if (this.value === "experienced" || this.value === "exservice") {
                                expDuration.classList.remove("hidden");
                            } else {
                                expDuration.classList.add("hidden");
                            }

                        });
                    </script>







                    <div class="col-md-12 mt-2">
                        <button class="btn btn-info w-100 d-flex justify-content-between align-items-center"
                            type="button" data-bs-toggle="collapse" data-bs-target="#address" aria-expanded="false"
                            aria-controls="address">
                            <span>Address Details</span>
                            <span class="toggle-icon">+</span>
                        </button>

                        <div class="collapse mt-2" id="address">

                            <!-- Full Address -->
                            <div class="mb-3">
                                <label for="txtFullAddress" class="form-label">Full Address</label>
                                <asp:TextBox ID="txtFullAddress" runat="server" CssClass="form-control"
                                    TextMode="MultiLine" Rows="3" placeholder="House no., street, colony, area..." />
                            </div>

                            <div class="row">
                                <!-- State -->
                                <div class="col-md-4 mb-3">
                                    <label for="txtState" class="form-label">State</label>
                                    <asp:TextBox ID="txtState" runat="server" CssClass="form-control" list="states-list"
                                        placeholder="Select or type state" />
                                    <datalist id="states-list">
                                        <option value="Andaman and Nicobar Islands">
                                            <option value="Andhra Pradesh">
                                            <option value="Arunachal Pradesh">
                                            <option value="Assam">
                                            <option value="Bihar">
                                            <option value="Chandigarh">
                                            <option value="Chhattisgarh">
                                            <option value="Dadra and Nagar Haveli and Daman and Diu">
                                            <option value="Delhi">
                                            <option value="Goa">
                                            <option value="Gujarat">
                                            <option value="Haryana">
                                            <option value="Himachal Pradesh">
                                            <option value="Jammu and Kashmir">
                                            <option value="Jharkhand">
                                            <option value="Karnataka">
                                            <option value="Kerala">
                                            <option value="Ladakh">
                                            <option value="Lakshadweep">
                                            <option value="Madhya Pradesh">
                                            <option value="Maharashtra">
                                            <option value="Manipur">
                                            <option value="Meghalaya">
                                            <option value="Mizoram">
                                            <option value="Nagaland">
                                            <option value="Odisha">
                                            <option value="Puducherry">
                                            <option value="Punjab">
                                            <option value="Rajasthan">
                                            <option value="Sikkim">
                                            <option value="Tamil Nadu">
                                            <option value="Telangana">
                                            <option value="Tripura">
                                            <option value="Uttar Pradesh">
                                            <option value="Uttarakhand">
                                            <option value="West Bengal">
                                            <option value="Other">
                                    </datalist>
                                </div>

                                <!-- City -->
                                <div class="col-md-4 mb-3">
                                    <label for="txtCity" class="form-label">City / District</label>
                                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"
                                        placeholder="City or district" />
                                </div>

                                <!-- Location -->
                                <div class="col-md-4 mb-3">
                                    <label for="txtLocation" class="form-label">Location / Locality</label>
                                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"
                                        placeholder="Area, ward, sector..." />
                                </div>
                            </div>

                            <div class="row">
                                <!-- Landmark -->
                                <div class="col-md-6 mb-3">
                                    <label for="txtLandmark" class="form-label">Nearby Landmark</label>
                                    <asp:TextBox ID="txtLandmark" runat="server" CssClass="form-control"
                                        placeholder="e.g., Near Park, Opposite Mall" />
                                </div>

                                <!-- Pincode -->
                                <div class="col-md-6 mb-3">
                                    <label for="txtPincode" class="form-label">Pincode</label>
                                    <small class="text-muted">(Enter 6 digits)</small>
                                    <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control"
                                        placeholder="6-digit PIN" MaxLength="6" onkeypress="allowOnlyNumbers(event)" />
                                </div>
                            </div>

                        </div>
                    </div>











                    <!-- Emergency Contact Details -->
                    <div class="col-md-12 mt-2">
                        <button class="btn btn-info w-100 d-flex justify-content-between align-items-center"
                            type="button" data-bs-toggle="collapse" data-bs-target="#contactSection"
                            aria-expanded="false" aria-controls="contactSection">
                            <span>Emergency Contact Details</span>
                            <span class="toggle-icon">+</span>
                        </button>
                        <div class="collapse mt-2" id="contactSection">
                            <div class="card card-body">
                                <div class="row g-2 align-items-end">
                                    <!-- Contact Number -->
                                    <div class="col-md-3">
                                        <label>Contact Number</label>
                                        <asp:TextBox ID="txtEmergencyPhone" runat="server" CssClass="form-control"
                                            placeholder="Contact Number" onkeypress="allowOnlyNumbers(event)" />
                                    </div>

                                    <!-- Name -->
                                    <div class="col-md-3">
                                        <label>Name</label>
                                        <asp:TextBox ID="txtEmergencyName" runat="server" CssClass="form-control"
                                            placeholder="Name" onkeypress="allowOnlyLetters(event)" />
                                    </div>

                                    <!-- Relationship -->
                                    <div class="col-md-3">
                                        <label>Relationship</label>
                                        <asp:TextBox ID="txtEmergencyRelation" runat="server" CssClass="form-control"
                                            placeholder="Relationship" onkeypress="allowOnlyLetters(event)" />
                                    </div>

                                    <!-- Send OTP Button -->

                                </div>
                            </div>
                        </div>
                    </div>






                    <!-- EDUCATION DETAILS TOGGLE -->
                    <div class="col-md-12 mt-3">
                        <button class="btn btn-info w-100 d-flex justify-content-between align-items-center"
                            type="button" data-bs-toggle="collapse" data-bs-target="#educationSection"
                            aria-expanded="false" aria-controls="educationSection">
                            <span>Education Details</span>
                            <span class="toggle-icon">+</span>
                        </button>
                        <div class="collapse mt-2" id="educationSection">
                            <div class="card card-body">
                                <asp:TextBox ID="txtSchoolUniversity" runat="server" CssClass="form-control mb-2"
                                    placeholder="School/University Name" onkeypress="allowOnlyLetters(event)" />
                                <label>Qualification</label>
                                <asp:DropDownList ID="ddlQualification" runat="server" CssClass="form-select mb-2">
                                    <asp:ListItem>Select Qualification</asp:ListItem>
                                    <asp:ListItem>10th</asp:ListItem>
                                    <asp:ListItem>12th</asp:ListItem>
                                    <asp:ListItem>Graduate</asp:ListItem>
                                    <asp:ListItem>Post Graduate</asp:ListItem>
                                </asp:DropDownList>
                                <label>(Upload Certificates)</label>
                                <asp:FileUpload ID="fuEducation" runat="server" CssClass="form-control" />
                                <div class="mt-1">
                                    <asp:HyperLink ID="hlEducation" runat="server" Visible="false" Target="_blank"
                                        CssClass="text-primary small" Text="View File"></asp:HyperLink>
                                    <asp:LinkButton ID="btnRemoveEducation" runat="server" Visible="false"
                                        CssClass="text-danger ms-2 small" OnClick="btnRemoveFile_Click"
                                        CommandArgument="EducationPath">Remove</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- BANK DETAILS TOGGLE -->
                    <div class="col-md-12 mt-3">
                        <button class="btn btn-info w-100 d-flex justify-content-between align-items-center"
                            type="button" data-bs-toggle="collapse" data-bs-target="#bankSection" aria-expanded="false"
                            aria-controls="bankSection">
                            <span>Bank Details</span>
                            <span class="toggle-icon">+</span>
                        </button>
                        <div class="collapse mt-2" id="bankSection">
                            <div class="card card-body">
                                <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control mb-2"
                                    placeholder="Account Number" onkeypress="allowOnlyNumbers(event)" />
                                <asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control mb-2"
                                    placeholder="IFSC Code" />
                                <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control"
                                    placeholder="Bank Name" onkeypress="allowOnlyLetters(event)" />
                            </div>
                        </div>
                    </div>





                    <!-- Consent -->
                    <div class="form-check mt-3">
                        <asp:CheckBox ID="chkConsent" runat="server" required="required" />
                        <label class="form-check-label" for="chkConsent">
                            I hereby give my consent for data verification and job placement.
                        </label>
                        <div class="invalid-feedback"></div>
                    </div>

                    <!-- Submit -->
                    <div class="text-left mt-3">
                        <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold d-block mb-2"></asp:Label>

                        <asp:Button ID="btnSubmit" Style="background-color: #8EC243" runat="server"
                            Text="Submit Registration" CssClass="btn btn-lg px-4" OnClientClick="return validateForm();"
                            OnClick="btnSubmit_Click" />

                        <asp:Button ID="btnBack" runat="server" Text="Back to List"
                            CssClass="btn btn-secondary btn-lg px-4 ms-2" OnClick="btnBack_Click"
                            CausesValidation="false" />
                    </div>


                </div>



                <!-- ================= MY PROFILE SECTION ================= -->
                <asp:Panel ID="pnlMyDetails" runat="server" Visible="false" CssClass="card mt-4">
                    <div class="card-header bg-success text-white">
                        My Submitted Details
                    </div>
                    <div class="card-body">

                        <p><b>Aadhar:</b>
                            <asp:Label ID="lblViewAadhar" runat="server" />
                        </p>
                        <p><b>Name:</b>
                            <asp:Label ID="lblViewName" runat="server" />
                        </p>
                        <p><b>Phone:</b>
                            <asp:Label ID="lblViewPhone" runat="server" />
                        </p>
                        <p><b>Gender:</b>
                            <asp:Label ID="lblViewGender" runat="server" />
                        </p>
                        <p><b>Birth Place:</b>
                            <asp:Label ID="lblViewBirthPlace" runat="server" />
                        </p>
                        <p><b>Marital Status:</b>
                            <asp:Label ID="lblViewMarital" runat="server" />
                        </p>
                        <p><b>Height:</b>
                            <asp:Label ID="lblViewHeight" runat="server" />
                        </p>
                        <p><b>Weight:</b>
                            <asp:Label ID="lblViewWeight" runat="server" />
                        </p>
                        <p><b>Emergency Phone:</b>
                            <asp:Label ID="lblViewEmergencyPhone" runat="server" />
                        </p>

                        <%--<asp:Button ID="btnEditDetails" runat="server" Text="Edit Details"
                            CssClass="btn btn-warning" OnClick="btnEditDetails_Click" />--%>
                    </div>
                </asp:Panel>
                <!-- ======================================================= -->






                <!-- ================= OFFCANVAS PANEL ================= -->
                <div class="offcanvas offcanvas-end" tabindex="-1" id="editPanel" style="width: 450px;">

                    <div class="offcanvas-header bg-light">
                        <h5>Edit Your Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="offcanvas">
                        </button>
                    </div>

                    <div class="offcanvas-body">

                        <asp:Label ID="lblEditMessage" runat="server" CssClass="text-success fw-bold"></asp:Label>

                        <div class="container-fluid">
                            <div class="row g-3">

                                <!-- Aadhaar Number -->
                                <div class="col-12">
                                    <label class="form-label">Aadhar Number</label>
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" MaxLength="12"
                                        placeholder="Enter 12-digit Aadhaar number"
                                        onkeypress="allowOnlyNumbers(event)" />
                                </div>

                                <!-- Skilled In -->
                                <div class="col-12">
                                    <label class="form-label">Skilled In</label>
                                    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Select your skill" Value="" />
                                    </asp:DropDownList>
                                </div>

                                <!-- First Name -->
                                <div class="col-md-6">
                                    <label class="form-label">First Name</label>
                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"
                                        onkeypress="allowOnlyLetters(event)" />
                                </div>

                                <!-- Last Name -->
                                <div class="col-md-6">
                                    <label class="form-label">Last Name</label>
                                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control"
                                        onkeypress="allowOnlyLetters(event)" />
                                </div>

                                <!-- Father's Name -->
                                <div class="col-12">
                                    <label class="form-label">Father's Name</label>
                                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control"
                                        placeholder="Enter Father's Name" onkeypress="allowOnlyLetters(event)" />
                                </div>

                                <!-- Phone -->
                                <div class="col-md-6">
                                    <label class="form-label">Phone Number</label>
                                    <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control" MaxLength="10"
                                        placeholder="Enter mobile number" onkeypress="allowOnlyNumbers(event)" />
                                </div>

                                <!-- Gender -->
                                <div class="col-md-6">
                                    <label class="form-label">Gender</label>
                                    <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Select" Value="" />
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <!-- Birth Place -->
                                <div class="col-12">
                                    <label class="form-label">Birth Place</label>
                                    <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control"
                                        placeholder="Enter area name" onkeypress="allowOnlyLetters(event)" />
                                </div>

                                <!-- Age -->
                                <div class="col-md-6">
                                    <label class="form-label">Age</label>
                                    <asp:TextBox ID="TextBox9" runat="server" CssClass="form-control" />
                                </div>

                                <!-- Experience Type -->
                                <div class="col-md-6">
                                    <label class="form-label">Experience Type</label>
                                    <select id="experienceType" class="form-select">
                                        <option value="" selected disabled>Select</option>
                                        <option value="fresher">Fresher</option>
                                        <option value="experienced">Experienced</option>
                                        <option value="exservice">Ex-Service</option>
                                    </select>
                                </div>

                                <!-- Experience Duration -->
                                <div class="col-12 hidden" id="experienceDuration">
                                    <label class="form-label">Duration</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="experienceYears"
                                            placeholder="Enter number" min="0">
                                        <select class="form-select" id="experienceUnit">
                                            <option value="months">Months</option>
                                            <option value="years">Years</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Upload Resume -->
                                <div class="col-12">
                                    <label class="form-label">Upload Resume</label>
                                    <asp:FileUpload ID="fuResumeEdit" runat="server" CssClass="form-control" />
                                </div>

                            </div>



                <!-- ================= MY PROFILE SECTION ================= -->
<asp:Panel ID="pnlMyDetails" runat="server" Visible="false" CssClass="card mt-4">
    <div class="card-header bg-success text-white">
        My Submitted Details
    </div>
    <div class="card-body">

        <p><b>Aadhar:</b> <asp:Label ID="lblViewAadhar" runat="server" /></p>
        <p><b>Name:</b> <asp:Label ID="lblViewName" runat="server" /></p>
        <p><b>Phone:</b> <asp:Label ID="lblViewPhone" runat="server" /></p>
        <p><b>Gender:</b> <asp:Label ID="lblViewGender" runat="server" /></p>
        <p><b>Birth Place:</b> <asp:Label ID="lblViewBirthPlace" runat="server" /></p>
        <p><b>Marital Status:</b> <asp:Label ID="lblViewMarital" runat="server" /></p>
        <p><b>Height:</b> <asp:Label ID="lblViewHeight" runat="server" /></p>
        <p><b>Weight:</b> <asp:Label ID="lblViewWeight" runat="server" /></p>
        <p><b>Emergency Phone:</b> <asp:Label ID="lblViewEmergencyPhone" runat="server" /></p>

        <%--<asp:Button ID="btnEditDetails" runat="server"
            Text="Edit Details"
            CssClass="btn btn-warning"
            OnClick="btnEditDetails_Click" />--%>
    </div>
</asp:Panel>
<!-- ======================================================= -->



  


    <!-- ================= OFFCANVAS PANEL ================= -->
<div class="offcanvas offcanvas-end"
     tabindex="-1"
     id="editPanel"
     style="width:450px;">

    <div class="offcanvas-header bg-light">
        <h5>Edit Your Details</h5>
        <button type="button"
                class="btn-close"
                data-bs-dismiss="offcanvas"></button>
    </div>

    <div class="offcanvas-body">

    <asp:Label ID="lblEditMessage" runat="server" CssClass="text-success fw-bold"></asp:Label>

    <div class="container-fluid">
        <div class="row g-3">

            <!-- Aadhaar Number -->
            <div class="col-12">
                <label class="form-label">Aadhar Number</label>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"
                    MaxLength="12" placeholder="Enter 12-digit Aadhaar number"
                    onkeypress="allowOnlyNumbers(event)" />
            </div>

            <!-- Skilled In -->
            <div class="col-12">
                <label class="form-label">Skilled In</label>
                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Select your skill" Value="" />
                </asp:DropDownList>
            </div>

            <!-- First Name -->
            <div class="col-md-6">
                <label class="form-label">First Name</label>
                <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"
                    onkeypress="allowOnlyLetters(event)" />
            </div>

            <!-- Last Name -->
            <div class="col-md-6">
                <label class="form-label">Last Name</label>
                <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control"
                    onkeypress="allowOnlyLetters(event)" />
            </div>

            <!-- Father's Name -->
            <div class="col-12">
                <label class="form-label">Father's Name</label>
                <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control"
                    placeholder="Enter Father's Name"
                    onkeypress="allowOnlyLetters(event)" />
            </div>

            <!-- Phone -->
            <div class="col-md-6">
                <label class="form-label">Phone Number</label>
                <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control"
                    MaxLength="10" placeholder="Enter mobile number"
                    onkeypress="allowOnlyNumbers(event)" />
            </div>

            <!-- Gender -->
            <div class="col-md-6">
                <label class="form-label">Gender</label>
                <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Select" Value="" />
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Birth Place -->
            <div class="col-12">
                <label class="form-label">Birth Place</label>
                <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control"
                    placeholder="Enter area name"
                    onkeypress="allowOnlyLetters(event)" />
            </div>

            <!-- Age -->
            <div class="col-md-6">
                <label class="form-label">Age</label>
                <asp:TextBox ID="TextBox9" runat="server" CssClass="form-control" />
            </div>

            <!-- Experience Type -->
            <div class="col-md-6">
                <label class="form-label">Experience Type</label>
                <select id="experienceType" class="form-select">
                    <option value="" selected disabled>Select</option>
                    <option value="fresher">Fresher</option>
                    <option value="experienced">Experienced</option>
                    <option value="exservice">Ex-Service</option>
                </select>
            </div>

            <!-- Experience Duration -->
            <div class="col-12 hidden" id="experienceDuration">
                <label class="form-label">Duration</label>
                <div class="input-group">
                    <input type="number" class="form-control" id="experienceYears"
                        placeholder="Enter number" min="0">
                    <select class="form-select" id="experienceUnit">
                        <option value="months">Months</option>
                        <option value="years">Years</option>
                    </select>
                </div>
            </div>

            <!-- Upload Resume -->
            <div class="col-12">
                <label class="form-label">Upload Resume</label>
                <asp:FileUpload ID="FileUpload4" runat="server" CssClass="form-control" />
            </div>

        </div>

  
    </div>

    <button type="button"
        class="btn btn-lg px-4 text-white"
        style="background-color:#8EC243;">
    Save
</button>

</div>
<!-- =================================================== -->
      </form>

    </body>

    </html>