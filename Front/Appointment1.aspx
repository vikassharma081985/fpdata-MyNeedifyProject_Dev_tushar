<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Appointment1.aspx.cs" Inherits="WSBillingMaster.Pages.Appointment1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Master</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        h2 {
            margin-bottom: 30px;
        }
        .card-header {
            background-color: #0d6efd;
            color: white;
            font-weight: 500;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        @media (max-width: 576px) {
            .form-inline input {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container py-5">
    <h2 class="text-center">Appointment Master</h2>

    <!-- STAFF -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header">Add Barber</div>
        <div class="card-body">
            <div class="row g-2 align-items-center">
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="txtStaffName" placeholder="Enter barber name">
                </div>
                <div class="col-sm-4">
                    <button class="btn btn-primary w-100" type="button">Add</button>
                </div>
            </div>
        </div>
    </div>

    <!-- SLOT -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header">Create Slot (Multiple Barbers)</div>
        <div class="card-body">
            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <label for="txtDate" class="form-label">Date</label>
                    <input type="date" class="form-control" id="txtDate">
                </div>
                <div class="col-md-4">
                    <label for="txtStart" class="form-label">Start Time</label>
                    <input type="time" class="form-control" id="txtStart">
                </div>
                <div class="col-md-4">
                    <label for="txtEnd" class="form-label">End Time</label>
                    <input type="time" class="form-control" id="txtEnd">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Select Barbers</label>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="1" id="barber1">
                    <label class="form-check-label" for="barber1">Barber 1</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="2" id="barber2">
                    <label class="form-check-label" for="barber2">Barber 2</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="3" id="barber3">
                    <label class="form-check-label" for="barber3">Barber 3</label>
                </div>
            </div>

            <button class="btn btn-success" type="button">Create Slot</button>
        </div>
    </div>

    <!-- SLOTS -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header">Slots</div>
        <div class="card-body table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Barber</th>
                        <th>Date</th>
                        <th>Start</th>
                        <th>End</th>
                        <th>Available</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Barber 1</td>
                        <td>2026-01-14</td>
                        <td>10:00</td>
                        <td>11:00</td>
                        <td><span class="badge bg-success">Yes</span></td>
                        <td><button class="btn btn-sm btn-warning">Toggle</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- SERVICES -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header">Add Service</div>
        <div class="card-body">
            <div class="row g-2 mb-3">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="txtService" placeholder="Service Name">
                </div>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="txtPrice" placeholder="Price">
                </div>
                <div class="col-md-2">
                    <button class="btn btn-primary w-100" type="button">Add Service</button>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-bordered" id="gvServices">
                    <thead class="table-light">
                        <tr>
                            <th>Service</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- dynamically added services -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
