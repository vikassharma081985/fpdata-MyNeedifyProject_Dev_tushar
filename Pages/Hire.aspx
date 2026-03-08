<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Hire.aspx.cs" Inherits="WSBillingMaster.Pages.Hire" %>

    <!DOCTYPE html>
    <html lang="en">

    <head runat="server">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hire Candidate</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <style>
            .banner {
                background: linear-gradient(135deg, #203864 0%, #4466a3 100%);
                padding: 40px 0;
                color: white;
                margin-bottom: 30px;
            }

            .candidate-summary {
                background: #f8f9fa;
                border-left: 4px solid #F48B1E;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
            }

            .form-label {
                font-weight: 500;
            }

            .invalid-feedback {
                font-size: 0.875em;
            }

            .text-orange {
                color: #F48B1E !important;
            }
        </style>
        <script>
            function validateHireForm() {
                let isValid = true;
                const form = document.getElementById('form1');
                const requiredFields = form.querySelectorAll('[required]');

                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        field.classList.add('is-invalid');
                        isValid = false;
                    } else {
                        field.classList.remove('is-invalid');
                    }
                });

                return isValid;
            }

            function allowOnlyNumbers(e) {
                let char = e.which ? e.which : e.keyCode;
                if (char < 48 || char > 57) e.preventDefault();
            }
        </script>
    </head>

    <body class="bg-light">
        <form id="form1" runat="server">
            <header class="banner">
                <div class="container text-center">
                    <h1 class="fw-bold"><i class="fa-solid fa-briefcase me-2"></i>Hire Candidate</h1>
                    <p class="lead">Complete the details below to hire the selected candidate.</p>
                </div>
            </header>

            <div class="container pb-5">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <!-- Candidate Summary Section -->
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0 text-primary"><i class="fa-solid fa-user-check me-2"></i>Candidate
                                    Selected</h5>
                            </div>
                            <div class="card-body">
                                <div class="row candidate-summary gx-3">
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <div class="small text-muted">Candidate Name</div>
                                        <div class="fw-bold fs-5">
                                            <asp:Literal ID="ltCandidateName" runat="server" Text="N/A"></asp:Literal>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="small text-muted">Skill / Role</div>
                                        <div class="fw-bold fs-5 text-orange">
                                            <asp:Literal ID="ltSkill" runat="server" Text="N/A"></asp:Literal>
                                        </div>
                                    </div>
                                    <div class="col-12 mt-3 pt-3 border-top">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="small text-muted">Experience</div>
                                                <div class="fw-medium">
                                                    <asp:Literal ID="ltExperience" runat="server" Text="N/A">
                                                    </asp:Literal>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="small text-muted">Location</div>
                                                <div class="fw-medium">
                                                    <asp:Literal ID="ltLocation" runat="server" Text="N/A">
                                                    </asp:Literal>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="small text-muted">Expected Amount</div>
                                                <div class="fw-medium">₹<asp:Literal ID="ltAmount" runat="server"
                                                        Text="0.00"></asp:Literal>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Hiring Details Form -->
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0 text-primary"><i class="fa-solid fa-file-contract me-2"></i>Hiring
                                    Details</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="row g-4">
                                    <div class="col-md-12">
                                        <label for="txtCompanyName" class="form-label">Company / Organization Name <span
                                                class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control"
                                            placeholder="Enter company name" required="required"></asp:TextBox>
                                        <div class="invalid-feedback">Company name is required.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="txtContactPerson" class="form-label">Contact Person <span
                                                class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtContactPerson" runat="server" CssClass="form-control"
                                            placeholder="Enter contact name" required="required"></asp:TextBox>
                                        <div class="invalid-feedback">Contact person is required.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="txtContactPhone" class="form-label">Contact Phone <span
                                                class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtContactPhone" runat="server" CssClass="form-control"
                                            placeholder="Enter phone number" MaxLength="15"
                                            onkeypress="allowOnlyNumbers(event)" required="required"></asp:TextBox>
                                        <div class="invalid-feedback">Valid contact phone is required.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="txtSalaryOffered" class="form-label">Salary Offered (₹)</label>
                                        <asp:TextBox ID="txtSalaryOffered" runat="server" CssClass="form-control"
                                            placeholder="0.00" onkeypress="allowOnlyNumbers(event)"></asp:TextBox>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="txtHireDate" class="form-label">Anticipated Joining Date</label>
                                        <asp:TextBox ID="txtHireDate" runat="server" CssClass="form-control"
                                            TextMode="Date"></asp:TextBox>
                                    </div>

                                    <div class="col-12">
                                        <label for="txtRemarks" class="form-label">Special Remarks /
                                            Instructions</label>
                                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"
                                            TextMode="MultiLine" Rows="3" placeholder="Additional details...">
                                        </asp:TextBox>
                                    </div>

                                    <div class="col-12 mt-4 pt-3 border-top d-flex gap-2">
                                        <asp:Button ID="btnSaveHire" runat="server" Text="Confirm Hiring"
                                            CssClass="btn btn-primary px-5 py-2 fw-bold"
                                            Style="background-color: #8EC243; border-color: #8EC243;"
                                            OnClientClick="return validateHireForm();" OnClick="btnSaveHire_Click" />

                                        <asp:HyperLink ID="btnBack" runat="server" NavigateUrl="~/Pages/Job.aspx"
                                            CssClass="btn btn-outline-secondary px-4 py-2">
                                            Cancel
                                        </asp:HyperLink>
                                    </div>

                                    <div class="col-12">
                                        <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <asp:HiddenField ID="hdnRegId" runat="server" />
        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>