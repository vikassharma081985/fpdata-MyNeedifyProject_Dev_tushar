<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Hire.aspx.cs" Inherits="WSBillingMaster.Pages.Hire" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hire Now</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">

            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Hire Service Professional</h4>
                </div>

                <div class="card-body">

                    <form method="post" action="/Hire/SubmitRequest">

                        <!-- Auto Selected Service Type -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Service Type</label>
                            <input type="text" class="form-control" value="Plumber" readonly>
                            <input type="hidden" name="ServiceType" value="Plumber">
                        </div>

                        <!-- Service Description -->
                        <div class="mb-3">
                            <label class="form-label">Service Description</label>
                            <textarea class="form-control" name="Description" rows="3"
                                placeholder="Describe your issue (e.g., pipe leakage, AC not cooling)" required></textarea>
                        </div>

                        <!-- Schedule -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">From Date</label>
                                <input type="date" class="form-control" name="FromDate" required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">To Date</label>
                                <input type="date" class="form-control" name="ToDate" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Preferred Time</label>
                            <select class="form-select" name="TimeSlot">
                                <option value="Morning">Morning (9 AM – 12 PM)</option>
                                <option value="Afternoon">Afternoon (12 PM – 4 PM)</option>
                                <option value="Evening">Evening (4 PM – 8 PM)</option>
                            </select>
                        </div>

                        <!-- Location -->
                        <hr>
                        <h5 class="mb-3">Service Location</h5>

                        <div class="mb-3">
                            <label class="form-label">City</label>
                            <input type="text" class="form-control" name="City" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Full Address</label>
                            <textarea class="form-control" name="Address" rows="2" required></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Pincode</label>
                                <input type="text" class="form-control" name="Pincode" required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Landmark (Optional)</label>
                                <input type="text" class="form-control" name="Landmark">
                            </div>
                        </div>

                        <!-- Contact Details -->
                        <hr>
                        <h5 class="mb-3">Your Contact Details</h5>

                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="ClientName" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" name="PhoneNumber" required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="Email">
                            </div>
                        </div>

                        <!-- Submit -->
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-success btn-lg">
                                Hire Now
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
