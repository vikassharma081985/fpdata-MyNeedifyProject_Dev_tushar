<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewHire.aspx.cs" Inherits="WSBillingMaster.Pages.NewHire" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>New Service Request</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">

            <div class="card shadow">
                <div class="card-header bg-warning">
                    <h4 class="mb-0">📢 New Hire Request</h4>
                </div>

                <div class="card-body">

                    <!-- Request Information -->
                    <div class="mb-3">
                        <label class="fw-bold">Service Type:</label>
                        <p class="mb-1">Plumber</p>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold">Client Name:</label>
                        <p class="mb-1">Ravi Kumar</p>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold">Phone Number:</label>
                        <p class="mb-1 text-primary">9876543210</p>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold">Service Description:</label>
                        <p class="mb-1">Kitchen sink pipe leakage.</p>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="fw-bold">From Date:</label>
                            <p class="mb-1">10-Mar-2026</p>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="fw-bold">To Date:</label>
                            <p class="mb-1">10-Mar-2026</p>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold">Preferred Time:</label>
                        <p class="mb-1">Morning (9 AM – 12 PM)</p>
                    </div>

                    <hr>

                    <h5>📍 Service Location</h5>

                    <div class="mb-2">
                        <strong>City:</strong> Bangalore
                    </div>
                    <div class="mb-2">
                        <strong>Address:</strong> 45 MG Road, Near Metro Station
                    </div>
                    <div class="mb-3">
                        <strong>Pincode:</strong> 560001
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 mt-4">
                        <form method="post" action="/Hire/AcceptRequest" class="w-50">
                            <input type="hidden" name="RequestId" value="101">
                            <button type="submit" class="btn btn-success w-100">
                                ✅ Accept Request
                            </button>
                        </form>

                        <form method="post" action="/Hire/RejectRequest" class="w-50">
                            <input type="hidden" name="RequestId" value="101">
                            <button type="submit" class="btn btn-danger w-100">
                                ❌ Reject
                            </button>
                        </form>


                       <div class="w-50">
    <a href="../Pages/RescheduleRequest.aspx" target="_blank"
       class="btn btn-warning w-100">
       🔄 Reschedule Request
    </a>
</div>
</div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>