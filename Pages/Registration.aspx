<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="WSBillingMaster.Pages.Registration" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Job Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server" class="container py-4">
        <div class="card">
            <div class="card-header bg-primary text-white">Job Registration</div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label>Aadhar No</label>
                        <asp:TextBox ID="txtAadhar" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Upload Aadhar</label>
                        <input type="file"
                            class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label>Skill</label>
                        <asp:DropDownList ID="ddlSkills" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label>Phone No</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>

                    <div class="col-md-12">
                        <label>Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>


                    <div class="col-md-4 mb-3">
                        <label class="form-label">Father's Name</label>
                        <input type="text"
                            class="form-control">
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Gender</label>
                    <select class="form-select">
                        <option>Male</option>
                        <option>Female</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Birth Place</label>
                    <input type="text"
                        class="form-control" placeholder="Enter area name">
                </div>
                <div class="mb-3">
                    <label class="form-label">Marital Status</label>
                    <select class="form-select">
                        <option>Single</option>
                        <option>Married</option>
                        <option>Divorced</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Upload Photo</label>
                    <input type="file"
                        class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <textarea class="form-control"
                        rows="2"></textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Height</label>
                        <input type="text"
                            class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Weight</label>
                        <input type="text"
                            class="form-control">
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Emergency Contact Details</label>
                    <input type="text"
                        class="form-control mb-2" placeholder="Contact Number">
                    <input type="text"
                        class="form-control mb-2" placeholder="Name">
                    <input type="text" class="form-control mb-2"
                        placeholder="Relationship">
                    <button class="btn btn-outline-secondary btn-sm">
                        Send
                            OTP</button>
                </div>
                <div class="mb-3">
                    <label class="form-label">Languages Known</label>
                    <input type="text"
                        class="form-control" placeholder="e.g., Hindi, English">
                </div>
                <div class="mb-3">
                    <label class="form-label">Experience</label>
                    <textarea class="form-control"
                        rows="2"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Education Details (Upload Certificates)</label>
                    <input
                        type="file" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">Bank Details</label>
                    <input type="text"
                        class="form-control mb-2" placeholder="Account Number">
                    <input type="text"
                        class="form-control mb-2" placeholder="IFSC Code">
                    <input type="text" class="form-control"
                        placeholder="Bank Name">
                </div>
                <div class="mb-3">
                    <label class="form-label">Phone Number (used as Login ID)</label>
                    <input
                        type="text" class="form-control" placeholder="Enter mobile number">
                </div>
                <h5 class="mt-4">Login Options</h5>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="login" id="otpLogin"
                        checked>
                    <label class="form-check-label" for="otpLogin">OTP</label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="login"
                        id="passwordLogin">
                    <label class="form-check-label" for="passwordLogin">Password</label>
                </div>
                <div class="mb-3">
                    <label class="form-label">Set Password (if applicable)</label>
                    <input
                        type="password" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">Expected Demand</label>
                    <select class="form-select">
                        <option>Per Day</option>
                        <option>Monthly</option>
                    </select>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="consent">
                    <label
                        class="form-check-label" for="consent">
                        I hereby give my consent for data verification and
                            job placement.
                    </label>
                </div>
                <div class="text-center">
                    <button class="btn btn-success btn-lg px-4">Submit Registration</button>
                </div>
            </div>
        </div>



        <div class="col-md-12 text-end">
            <asp:Button ID="btnSubmit" runat="server" Text="Register" CssClass="btn btn-success" OnClick="btnSubmit_Click" />
            &nbsp;
                       
            <asp:Label ID="lblStatus" runat="server" CssClass="text-danger"></asp:Label>
        </div>
     
   
    </form>
</body>
</html>
--%>



<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="WSBillingMaster.Pages.Registration" %>

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




        //for experience

        



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

            // real-time validation
            inputs.forEach(el => {
                el.addEventListener("input", validateField);
                el.addEventListener("change", validateField);
                el.addEventListener("blur", validateField);
            });

            function validateField(e) {
                let element = e.target;
                let feedback = element.nextElementSibling;

                if (!feedback || !feedback.classList.contains("invalid-feedback"))
                    return;

                let value = element.value.trim();

                if (value === "") {
                    feedback.style.display = "block";
                    element.classList.add("is-invalid");
                } else {
                    feedback.style.display = "none";
                    element.classList.remove("is-invalid");
                }
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

            document.querySelectorAll('.invalid-feedback').forEach(f => f.style.display = 'none');

            // Aadhaar
            let aadhar = document.getElementById('<%= txtAadhar.ClientID %>');
            if (aadhar.value.trim().length !== 12) {
                showError(aadhar, "Enter 12-digit Aadhaar Number");
                isValid = false;
            }

            // File Aadhaar
           <%-- let fuAadhar = document.getElementById('<%= fuAadhar.ClientID %>');
            if (fuAadhar.files.length === 0) {
                showError(fuAadhar, "Upload Aadhaar document");
                isValid = false;
            }--%>

            // Skilled In
            let skill = document.getElementById('<%= ddlSkills.ClientID %>');
            if (skill.value === "") {
                showError(skill, "Please select a skill");
                isValid = false;
            }

            // First Name
            let fname = document.getElementById('<%= txtFirstName.ClientID %>');
            if (fname.value.trim() === "") {
                showError(fname, "Enter First Name");
                isValid = false;
            }

            // Last Name
            let lname = document.getElementById('<%= txtLastName.ClientID %>');
            if (lname.value.trim() === "") {
                showError(lname, "Enter Last Name");
                isValid = false;
            }

            // Father's Name
            let father = document.getElementById('<%= txtFatherName.ClientID %>');
            if (father.value.trim() === "") {
                showError(father, "Enter Father's Name");
                isValid = false;
            }

            // Gender
            let gender = document.getElementById('<%= ddlGender.ClientID %>');
            if (gender.value === "") {
                showError(gender, "Select Gender");
                isValid = false;
            }

            // Birth Place
            let bplace = document.getElementById('<%= txtBirthPlace.ClientID %>');
            if (bplace.value.trim() === "") {
                showError(bplace, "Enter Birth Place");
                isValid = false;
            }

            // Marital Status
            let marital = document.getElementById('<%= ddlMarital.ClientID %>');
            if (marital.value === "") {
                showError(marital, "Select Marital Status");
                isValid = false;
            }

            // Address
            let address = document.getElementById('<%= txtAddress.ClientID %>');
            if (address.value.trim() === "") {
                showError(address, "Enter Age");
                isValid = false;
            }

            // Height
            let height = document.getElementById('<%= txtHeight.ClientID %>');
            if (height.value.trim() === "") {
                showError(height, "Enter Height");
                isValid = false;
            }

            // Weight
            let weight = document.getElementById('<%= txtWeight.ClientID %>');
            if (weight.value.trim() === "") {
                showError(weight, "Enter Weight");
                isValid = false;
            }

            // Emergency Phone
            let ephone = document.getElementById('<%= txtEmergencyPhone.ClientID %>');
            if (ephone.value.trim() === "") {
                showError(ephone, "Enter Emergency Phone");
                isValid = false;
            }






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
            <div class="card-header  text-white" style="background-color: #F48B1E">Job Registration</div>
            <div class="card-body">
                <div id="successMessage" class="alert alert-success" style="display: none;">
                    Registration submitted successfully!
                </div>

                <div class="row g-3">

                    <!-- Aadhaar Number -->
                    <div class="col-md-4">
                        <label>Aadhar Number</label>
                        <asp:TextBox ID="txtAadhar" runat="server" CssClass="form-control"
                            MaxLength="12" placeholder="Enter 12-digit Aadhaar number"
                            onkeypress="allowOnlyNumbers(event)" />
                    </div>

                    <!-- Upload Aadhaar -->
                    <div class="col-md-4">
                        <label>Upload Aadhar</label>
                        <asp:FileUpload ID="fuAadhar" runat="server" CssClass="form-control" />
                    </div>

                    <!-- Skilled In -->
                    <div class="col-md-4">
                        <label>Skilled In</label>
                        <asp:DropDownList ID="ddlSkills" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Select your skill" Value="" />
                        </asp:DropDownList>
                    </div>

                    <!-- First Name -->
                    <div class="col-md-4">
                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"
                            onkeypress="allowOnlyLetters(event)" />
                    </div>

                    <!-- Last Name -->
                    <div class="col-md-4">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"
                            onkeypress="allowOnlyLetters(event)" />
                    </div>

                    <!-- Father's Name -->
                    <div class="col-md-4">
                        <label>Father's Name</label>
                        <asp:TextBox ID="txtFatherName" runat="server" CssClass="form-control"
                            placeholder="Enter Father's Name" onkeypress="allowOnlyLetters(event)" />
                    </div>

                    <!-- Phone Number -->
                    <div class="col-md-4">
                        <label>Phone Number </label>
                        <asp:TextBox ID="txtLoginPhone" runat="server" CssClass="form-control" MaxLength="10"
                            placeholder="Enter mobile number" onkeypress="allowOnlyNumbers(event)" />
                    </div>





                    <!-- Gender -->
                    <div class="col-md-4">
                        <label>Gender</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
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
                    </div>












                    <!-- Address -->
                    <div class="col-md-4">
                        <label>Age</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"
                            Rows="2"></asp:TextBox>
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
                        <asp:DropDownList ID="ddlDemand" runat="server" CssClass="form-select">
                            <asp:ListItem>Per Day</asp:ListItem>
                            <asp:ListItem>Monthly</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label>Amount</label>
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" MaxLength="10"
                            placeholder="Enter Amount" onkeypress="allowOnlyNumbers(event)" />
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

</div>

<script>
    const expType = document.getElementById("experienceType");
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
        type="button" data-bs-toggle="collapse" data-bs-target="#address"
        aria-expanded="false" aria-controls="address">
        <span>Address Details</span>
        <span class="toggle-icon">+</span>
    </button>

    <div class="collapse mt-2" id="address">
        
        <!-- Full Address -->
        <div class="mb-3">
            <label for="fullAddress" class="form-label">Full Address</label>
            <textarea id="fullAddress" name="fullAddress" class="form-control" rows="3"
                placeholder="House no., street, colony, area..." required></textarea>
        </div>

        <div class="row">
            <!-- State -->
            <div class="col-md-4 mb-3">
                <label for="state" class="form-label">State</label>
                <input id="state" name="state" class="form-control" list="states-list"
                    placeholder="Select or type state" required>
                <datalist id="states-list">
                    <option value="Andhra Pradesh">
                    <option value="Assam">
                    <option value="Bihar">
                    <option value="Delhi">
                    <option value="Gujarat">
                    <option value="Karnataka">
                    <option value="Maharashtra">
                    <option value="Tamil Nadu">
                    <option value="Uttar Pradesh">
                    <option value="West Bengal">
                    <option value="Other">
                </datalist>
            </div>

            <!-- City -->
            <div class="col-md-4 mb-3">
                <label for="city" class="form-label">City / District</label>
                <input id="city" name="city" type="text" class="form-control"
                    placeholder="City or district" required>
            </div>

            <!-- Location -->
            <div class="col-md-4 mb-3">
                <label for="location" class="form-label">Location / Locality</label>
                <input id="location" name="location" type="text" class="form-control"
                    placeholder="Area, ward, sector...">
            </div>
        </div>

        <div class="row">
            <!-- Landmark -->
            <div class="col-md-6 mb-3">
                <label for="landmark" class="form-label">Nearby Landmark</label>
                <input id="landmark" name="landmark" type="text" class="form-control"
                    placeholder="e.g., Near Park, Opposite Mall">
            </div>

            <!-- Pincode -->
            <div class="col-md-6 mb-3">
                <label for="pincode" class="form-label">Pincode</label>                <small class="text-muted">(Enter 6 digits)</small>

                <input id="pincode" name="pincode" type="text" class="form-control"
                    inputmode="numeric" maxlength="6" pattern="\d{6}" placeholder="6-digit PIN" required>
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
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control mb-2"
                            placeholder="School/University Name" onkeypress="allowOnlyLetters(event)" />
                        <label>Qualification</label>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select mb-2">
                            <asp:ListItem>10th</asp:ListItem>
                            <asp:ListItem>12th</asp:ListItem>
                            <asp:ListItem>Graduate</asp:ListItem>
                            <asp:ListItem>Post Graduate</asp:ListItem>
                        </asp:DropDownList>
                        <label>(Upload Certificates)</label>
                        <asp:FileUpload ID="fuEducation" runat="server" CssClass="form-control" />
                    </div>
                </div>
            </div>

            <!-- BANK DETAILS TOGGLE -->
            <div class="col-md-12 mt-3">
                <button class="btn btn-info w-100 d-flex justify-content-between align-items-center"
                    type="button" data-bs-toggle="collapse" data-bs-target="#bankSection"
                    aria-expanded="false" aria-controls="bankSection">
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
                <input class="form-check-input" type="checkbox" id="consent" />
                <label class="form-check-label" for="consent">
                    I hereby give my consent for data verification and job placement.
                </label>
            </div>

            <!-- Submit -->
            <div class="text-left mt-3">
                <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold d-block mb-2"></asp:Label>

                <asp:Button ID="btnSubmit" Style="background-color: #8EC243" runat="server" Text="Submit Registration"
                    CssClass="btn btn-lg px-4"
                    OnClientClick="return validateForm();"
                    OnClick="btnSubmit_Click" />
            </div>


            </div>


    </form>


</body>

</html>
