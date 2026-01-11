 <%@ Page Title="" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="AppointmentMaster.aspx.cs" Inherits="FaduPrice.Front.AppointmentMaster" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Appointment Master</title>
    <style>
        body { font-family: Arial; }
        .section { border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; }
        .section h3 { margin-top: 0; }
        table { width: 100%; }
        td { padding: 5px; }
    </style>
</head>
<body>
<form id="form1" runat="server">

<!-- 🔹 SLOT CREATION -->
<div class="section">
    <h3>Slot Creation</h3>
    <table>
        <tr>
            <td>Date</td>
            <td><asp:TextBox ID="txtDate" runat="server" TextMode="Date" /></td>
        </tr>
        <tr>
            <td>Start Time</td>
            <td><asp:TextBox ID="txtStartTime" runat="server" TextMode="Time" /></td>
        </tr>
        <tr>
            <td>End Time</td>
            <td><asp:TextBox ID="txtEndTime" runat="server" TextMode="Time" /></td>
        </tr>
        <tr>
            <td>Available</td>
            <td>
                <asp:CheckBox ID="chkAvailable" runat="server" Checked="true" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnAddSlot" runat="server" Text="Add Slot" OnClick="btnAddSlot_Click" />
            </td>
        </tr>
    </table>
</div>

<!-- 🔹 SERVICE CREATION -->
<div class="section">
    <h3>Service & Price</h3>
    <table>
        <tr>
            <td>Service Name</td>
            <td><asp:TextBox ID="txtServiceName" runat="server" /></td>
        </tr>
        <tr>
            <td>Price</td>
            <td><asp:TextBox ID="txtPrice" runat="server" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnAddService" runat="server" Text="Add Service" OnClick="btnAddService_Click" />
            </td>
        </tr>
    </table>
</div>

<!-- 🔹 EXISTING SLOTS -->
<div class="section">
    <h3>Existing Slots</h3>
    <asp:GridView ID="gvSlots" runat="server" AutoGenerateColumns="False"
        OnRowCommand="gvSlots_RowCommand">
        <Columns>
            <asp:BoundField DataField="SlotDate" HeaderText="Date" />
            <asp:BoundField DataField="StartTime" HeaderText="Start" />
            <asp:BoundField DataField="EndTime" HeaderText="End" />
            <asp:BoundField DataField="IsAvailable" HeaderText="Available" />
            <asp:ButtonField Text="Toggle Availability" CommandName="Toggle" />
        </Columns>
    </asp:GridView>
</div>

<!-- 🔹 EXISTING SERVICES -->
<div class="section">
    <h3>Services List</h3>
    <asp:GridView ID="gvServices" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="ServiceName" HeaderText="Service" />
            <asp:BoundField DataField="Price" HeaderText="Price" />
        </Columns>
    </asp:GridView>
</div>

</form>
</body>
</html>
