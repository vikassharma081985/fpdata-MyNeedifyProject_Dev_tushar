<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AppointmentMaster.aspx.cs"
    Inherits="UI.Seller.AppointmentMaster" %>

<form runat="server">

<h2>Appointment Master</h2>

<!-- STAFF -->
<h3>Add Barber</h3>
<asp:TextBox ID="txtStaffName" runat="server" />
<asp:Button Text="Add" runat="server" OnClick="AddStaff" />

<hr />

<!-- SLOT -->
<h3>Create Slot (Multiple Barbers)</h3>
Date <asp:TextBox ID="txtDate" runat="server" TextMode="Date" /><br />
Start <asp:TextBox ID="txtStart" runat="server" TextMode="Time" /><br />
End <asp:TextBox ID="txtEnd" runat="server" TextMode="Time" /><br />

<asp:CheckBoxList ID="chkStaff" runat="server" />

<asp:Button Text="Create Slot" runat="server" OnClick="CreateSlot" />

<hr />

<!-- SLOTS -->
<h3>Slots</h3>
<asp:GridView ID="gvSlots" runat="server"
    AutoGenerateColumns="False"
    DataKeyNames="SlotId"
    OnRowCommand="ToggleSlot">
    <Columns>
        <asp:BoundField DataField="StaffName" HeaderText="Barber" />
        <asp:BoundField DataField="SlotDate" HeaderText="Date" />
        <asp:BoundField DataField="StartTime" HeaderText="Start" />
        <asp:BoundField DataField="EndTime" HeaderText="End" />
        <asp:BoundField DataField="IsAvailable" HeaderText="Available" />
        <asp:ButtonField Text="Toggle" CommandName="Toggle" />
    </Columns>
</asp:GridView>

<hr />

<!-- SERVICES -->
<h3>Add Service</h3>
<asp:TextBox ID="txtService" runat="server" />
<asp:TextBox ID="txtPrice" runat="server" />
<asp:Button Text="Add Service" runat="server" OnClick="AddService" />

<asp:GridView ID="gvServices" runat="server" />

</form>
