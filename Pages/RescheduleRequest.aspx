<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reschedulrequest.aspx.cs" Inherits="WSBillingMaster.Pages.RescheduleRequest" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reschedule Service</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    background:#f5f7fb;
}

.card{
    border-radius:12px;
}

.card-header{
    border-radius:12px 12px 0 0;
}

.btn-primary{
    padding:12px;
    font-weight:600;
}
</style>

</head>

<body>

<div class="container py-5">

<div class="row justify-content-center">

<div class="col-lg-6 col-md-8 col-sm-12">

<div class="card shadow">

<div class="card-header bg-info text-white">
<h5 class="mb-0">
<i class="bi bi-arrow-repeat"></i> Reschedule Service Request
</h5>
</div>

<div class="card-body">

<form>

<input type="hidden" name="RequestId">

<div class="mb-3">
<label class="form-label fw-semibold">New From Date</label>
<input type="date" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label fw-semibold">New To Date</label>
<input type="date" class="form-control" required>
</div>

<div class="mb-4">
<label class="form-label fw-semibold">Preferred Time</label>

<select class="form-select">
<option>Morning (9 AM – 12 PM)</option>
<option>Afternoon (12 PM – 4 PM)</option>
<option>Evening (4 PM – 8 PM)</option>
</select>

</div>

<div class="row g-2">

<div class="col-md-6 col-12">
<button type="submit" class="btn btn-primary w-100">
<i class="bi bi-check-circle"></i> Update Schedule
</button>
</div>

<div class="col-md-6 col-12">
<button type="submit" class="btn btn-primary w-100">
<i class="bi bi-x-circle"></i> Cancel
</button>
</div>

</div>

</form>

</div>

</div>

</div>

</div>

</div>

</body>
</html>