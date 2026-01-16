<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppointmentMaster.aspx.cs" Inherits="WSBillingMaster.Pages.AppointmentMaster" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Master</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
        }

        .section {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .section:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.1);
        }

        h3 {
            color: #0d6efd;
            margin-bottom: 20px;
            font-weight: 600;
        }

        table th {
            background: #0d6efd;
            color: #fff;
            text-align: center;
        }

        table td, table th {
            vertical-align: middle;
        }

        /* Custom button colors from your image */
        .btn-admin {
            background-color: #00a2ff;
            color: white;
            border-radius: 50px;
            transition: background 0.3s, transform 0.2s;
        }
        .btn-admin:hover {
            background-color: #008ecc;
            transform: translateY(-3px);
        }

        .btn-seller {
            background-color: #f7941d;
            color: white;
            border-radius: 50px;
            transition: background 0.3s, transform 0.2s;
        }
        .btn-seller:hover {
            background-color: #d17a00;
            transform: translateY(-3px);
        }

        .btn-login {
            background-color: #9ccc3f;
            color: white;
            border-radius: 50px;
            transition: background 0.3s, transform 0.2s;
        }
        .btn-login:hover {
            background-color: #7aa62f;
            transform: translateY(-3px);
        }

        @media (max-width: 576px) {
            table th, table td {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>

<div class="container my-5">

    <h1 class="mb-4 text-center text-primary">Appointment Master</h1>

    <form id="form1">

        <!-- 🔹 SLOT CREATION -->
        <div class="section">
            <h3>Slot Creation</h3>
            <div class="row g-3">
                <div class="col-md-3 col-6">
                    <label class="form-label">Date</label>
                    <input type="date" class="form-control" id="txtDate" />
                </div>
                <div class="col-md-3 col-6">
                    <label class="form-label">Start Time</label>
                    <input type="time" class="form-control" id="txtStartTime" />
                </div>
                <div class="col-md-3 col-6">
                    <label class="form-label">End Time</label>
                    <input type="time" class="form-control" id="txtEndTime" />
                </div>
                <div class="col-md-3 col-6 d-flex align-items-center">
                    <div class="form-check mt-3">
                        <input class="form-check-input" type="checkbox" id="chkAvailable" checked>
                        <label class="form-check-label" for="chkAvailable">
                            Available
                        </label>
                    </div>
                </div>
                <div class="col-12">
                    <button type="button" class="btn btn-admin w-100" id="btnAddSlot">Add Slot</button>
                </div>
            </div>
        </div>

        <!-- 🔹 SERVICE CREATION -->
        <div class="section">
            <h3>Service & Price</h3>
            <div class="row g-3">
                <div class="col-md-6 col-12">
                    <label class="form-label">Service Name</label>
                    <input type="text" class="form-control" id="txtServiceName" />
                </div>
                <div class="col-md-6 col-12">
                    <label class="form-label">Price</label>
                    <input type="text" class="form-control" id="txtPrice" />
                </div>
                <div class="col-12">
                    <button type="button" class="btn btn-seller w-100" id="btnAddService">Add Service</button>
                </div>
            </div>
        </div>

        <!-- 🔹 EXISTING SLOTS -->
        <div class="section">
            <h3>Existing Slots</h3>
            <div class="table-responsive">
                <table class="table table-bordered table-hover text-center align-middle">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Available</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sample row -->
                        <tr>
                            <td>2026-01-14</td>
                            <td>10:00</td>
                            <td>11:00</td>
                            <td>Yes</td>
                            <td>
                                <button type="button" class="btn btn-login btn-sm">Toggle</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 🔹 EXISTING SERVICES -->
        <div class="section">
            <h3>Services List</h3>
            <div class="table-responsive">
                <table class="table table-bordered table-hover text-center align-middle">
                    <thead>
                        <tr>
                            <th>Service</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sample row -->
                        <tr>
                            <td>Hair Cut</td>
                            <td>200</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </form>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
