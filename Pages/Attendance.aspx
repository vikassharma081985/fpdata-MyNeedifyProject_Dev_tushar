<%@ Page Title="Attendance" Language="C#" MasterPageFile="~/Pages/SiteMaster.Master" AutoEventWireup="true" EnableEventValidation="true" CodeBehind="Attendance.aspx.cs" Inherits="WSBillingMaster.Pages.Attendance" %>
<asp:Content ID="AttendanceHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .attendance-page { max-width: 1160px; margin: 0 auto; padding: 24px 20px 48px; color: #192739; }
        .attendance-page h1 { font-size: 32px; font-weight: 700; margin: 0 0 16px; }
        .attendance-page h2 { font-size: 24px; margin: 24px 0 12px; }
        .attendance-page h3 { font-size: 17px; font-weight: 700; margin: 0 0 12px; }
        .attendance-nav { display: flex; flex-wrap: wrap; gap: 4px; padding: 0; border-bottom: 1px solid #dce3ed; }
        .attendance-nav a { padding: 10px 12px; color: #344660; text-decoration: none; border-bottom: 3px solid transparent; }
        .attendance-nav a:hover { background: #edf4fc; }
        .attendance-nav a[aria-current="page"] { color: #145496; border-color: #1768b2; font-weight: 700; }
        .attendance-card { margin: 14px 0; padding: 18px; background: #fff; border: 1px solid #dce3ed; border-radius: 8px; }
        .attendance-fields { display: grid; grid-template-columns: repeat(auto-fit, minmax(190px, 1fr)); gap: 0 16px; }
        .attendance-fields .form-group { min-width: 0; }
        .attendance-page .attendance-switch { display: flex; align-items: center; gap: 8px; padding: 7px 0; }
        .attendance-switch input { margin: 0; width: 16px; height: 16px; }
        .attendance-switch label { margin: 0; }
        .attendance-page .btn + .btn { margin-left: 8px; }
        .attendance-page .table { margin: 0; }
        .attendance-page .table th { background: #f2f6fa; white-space: nowrap; }
        .attendance-table { overflow-x: auto; margin: 16px 0; border: 1px solid #dce3ed; border-radius: 8px; }
        .attendance-page .alert { margin: 14px 0; }
        .attendance-page .form-inline .form-control { max-width: 100%; }
        .attendance-page .attendance-hint { color: #495d75; margin-bottom: 10px; }
        .attendance-location-action { margin: 4px 0 14px; }
        .attendance-location-action span { display: inline-block; margin-left: 8px; }
        @media (max-width: 560px) {
            .attendance-page { padding: 16px 12px 32px; }
            .attendance-nav a { padding: 8px; }
            .attendance-fields { grid-template-columns: 1fr; }
        }
    </style>
</asp:Content>
<asp:Content ID="AttendanceContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="attendance-page">
        <h1>Attendance</h1>
        <asp:PlaceHolder ID="AttendanceBody" runat="server" />
    </main>
    <script>
        document.addEventListener("click", function (event) {
            var button = event.target.closest("[data-attendance-location]");
            if (!button) return;

            var status = document.getElementById("att_location_status");
            if (!window.isSecureContext || !navigator.geolocation) {
                status.textContent = "Location detection requires HTTPS or localhost and a supported browser.";
                return;
            }

            button.disabled = true;
            status.textContent = "Waiting for your browser to share its location…";
            navigator.geolocation.getCurrentPosition(function (position) {
                document.getElementById("att_lat").value = position.coords.latitude.toFixed(6);
                document.getElementById("att_lon").value = position.coords.longitude.toFixed(6);
                status.textContent = "Coordinates filled. Estimated accuracy: " +
                    Math.round(position.coords.accuracy) + " m. Check the radius before saving.";
                button.disabled = false;
            }, function (error) {
                status.textContent = error.code === 1
                    ? "Location access was denied. Allow it in your browser or enter the coordinates manually."
                    : "Location could not be detected. Try again or enter the coordinates manually.";
                button.disabled = false;
            }, { enableHighAccuracy: true, timeout: 15000, maximumAge: 0 });
        });
    </script>
</asp:Content>

