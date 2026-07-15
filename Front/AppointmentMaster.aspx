<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8">
<title>Barber Appointment Booking</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

:root {
    --primary:#d88a1d;
    --bg:#faf7f2;
    --card:#ffffff;
    --success:#d9f5e3;
}

body {
    background:var(--bg);
    font-family:'Segoe UI',sans-serif;
}

.header {
    background:linear-gradient(180deg,#fff3e0,#faf7f2);
    padding:20px;
    border-radius:18px;
    margin-bottom:20px;
}

.header h1 span {
    color:var(--primary);
}

.card-box {
    background:var(--card);
    border-radius:16px;
    padding:16px;
    box-shadow:0 10px 25px rgba(0,0,0,.06);
    margin-bottom:16px;
}

.barber {
    border:2px solid transparent;
    padding:14px;
    border-radius:14px;
    display:flex;
    align-items:center;
    gap:12px;
    cursor:pointer;
    width:100%;
    transition:.2s;
}

.barber.active {
    border-color:var(--primary);
    background:#fff8ef;
}

.barber img {
    width:48px;
    height:48px;
    border-radius:50%;
    object-fit:cover;
}

.calendar-header {
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:10px;
}

.calendar {
    display:grid;
    grid-template-columns:repeat(7,1fr);
    gap:8px;
    justify-items:center;
}

.calendar div {
    width:40px;
    height:40px;
    line-height:40px;
    border-radius:50%;
    text-align:center;
    cursor:pointer;
}

.calendar div.active {
    background:var(--primary);
    color:#fff;
}

.slots-grid {
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(120px,1fr));
    gap:10px;
}

.slot {
    background:var(--success);
    padding:10px;
    border-radius:12px;
    text-align:center;
    cursor:pointer;
    transition:.2s;
}

.slot.active {
    background:var(--primary);
    color:#fff;
}

.btn-primary {
    background:var(--primary);
    border:none;
    border-radius:12px;
}

.btn-primary:hover,
.btn-primary:focus,
.btn-primary:active {
    background:var(--primary)!important;
    box-shadow:none!important;
}

.loading {
    text-align:center;
    padding:20px;
    color:#888;
}

</style>
</head>

<body>

<form id="form1" runat="server">

<div class="container my-3">

    <div class="header">
        <div>
            <h4 class="mb-1">
                Book Your <span>Perfect Cut</span>
            </h4>

            <small class="text-muted">
                Choose barber, date & time
            </small>
        </div>
    </div>

    <div class="card-box">

        <h6 class="mb-3">✨ Choose Your Barber</h6>

        <div class="row g-2" id="barberList">
            <div class="loading">Loading barbers...</div>
        </div>

    </div>

<div id="manageSettings" class="card mt-3" style="display:none;">

    <div class="card-header">
        <strong>Barber Preferences</strong>
    </div>

    <div class="card-body">

        <!-- Slot Duration -->
        <div class="form-group">
            <label><strong>Slot Duration</strong></label>

            <div>

                <label class="radio-inline">
                    <input type="radio"
                           name="slotDuration"
                           value="20">
                    20 Minutes
                </label>

                <label class="radio-inline">
                    <input type="radio"
                           name="slotDuration"
                           value="30"
                           checked>
                    30 Minutes
                </label>

                <label class="radio-inline">
                    <input type="radio"
                           name="slotDuration"
                           value="40">
                    40 Minutes
                </label>

                <label class="radio-inline">
                    <input type="radio"
                           name="slotDuration"
                           value="60">
                    60 Minutes
                </label>

            </div>

        </div>

        <hr />

        <!-- Working Hours -->

        <div class="row">

            <div class="col-md-4">

                <label>From</label>

                <input type="time"
                       id="workingFrom"
                       class="form-control"
                       value="09:00" />

            </div>

            <div class="col-md-4">

                <label>To</label>

                <input type="time"
                       id="workingTo"
                       class="form-control"
                       value="18:00" />

            </div>

       

        </div>

    </div>

</div>
    <div class="card-box">

        <div class="calendar-header">
            <button type="button"
                    class="btn btn-light btn-sm"
                    onclick="changeMonth(-1)">
                ‹
            </button>

            <strong id="monthLabel"></strong>

            <button type="button"
                    class="btn btn-light btn-sm"
                    onclick="changeMonth(1)">
                ›
            </button>
        </div>

        <div id="calendar" class="calendar"></div>

    </div>

    <div class="card-box">

        <h6 class="mb-2" id="lblSlotsTitle">⏰ Available Times</h6>

        <div id="slots" class="slots-grid">
            <div class="text-muted">
                Select date first
            </div>
        </div>

    </div>

    <div class="text-center">

        <button type="button"
                id="btnConfirmBooking"
                class="btn btn-primary w-100"
                data-bs-toggle="modal"
                data-bs-target="#confirmModal">

            Confirm Booking

        </button>
        <button id="btnSaveOOO" class="btn btn-danger" type="button">
            Save Changes
        </button>

    </div>

</div>

<div class="modal fade" id="confirmModal">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content">

            <div class="modal-header">

                <h6 class="modal-title">
                    Confirm Booking
                </h6>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                </button>

            </div>

            <div class="modal-body">

                <p id="summary"></p>

                <input id="customerName"
                       class="form-control mb-2"
                       placeholder="Your Name">

                <input id="phoneNumber"
                       class="form-control mb-3"
                       placeholder="Phone Number">

                <button type="button"
                        class="btn btn-primary w-100"
                        onclick="bookAppointment()">

                    Confirm

                </button>

            </div>

        </div>

    </div>

</div>

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

const API_BASE = "http://localhost:5150/api/Appointment";

const PAGE_MODE =
    window.location.href.indexOf("ManageBarber") >= 0
        ? "MANAGE"
        : "BOOKING";

let barbers = [];

let selectedBarberId = '';
let selectedBarberName = '';
let selectedBarberOrgId = '';
let selectedDate = '';
let selectedTime = '';

let selectedMonth = '';
let selectedYear = '';

let selectedOOOToAdd = [];
let selectedOOOToRemove = [];

let currentDate = new Date();

window.onload = function () {

    initializePageMode();

};
function loadBarberPreferences(barber) {

    if (!barber)
        return;

    // Slot Duration
    document.querySelector(
        'input[name="slotDuration"][value="' +
        barber.slotDuration +
        '"]'
    ).checked = true;

    // Working Hours
    document.getElementById("workingFrom").value =
        barber.workingFrom.substring(0, 5);

    document.getElementById("workingTo").value =
        barber.workingTo.substring(0, 5);

loadAvailability();
}
function initializePageMode() {

    if (PAGE_MODE === "MANAGE") {
        document.getElementById("btnConfirmBooking").style.display = "none";
        document.getElementById("btnSaveOOO").style.display = "block";
        document.getElementById("manageSettings").style.display = "block";

        document.getElementById("lblSlotsTitle").innerHTML = "🚫 Unavailability Times";
        document.getElementById("btnSaveOOO").addEventListener("click", saveSchedule);


        

    } else {

        document.getElementById("btnConfirmBooking").style.display = "block";
        document.getElementById("btnSaveOOO").style.display = "none";
        document.getElementById("manageSettings").style.display = "none";

        document.getElementById("lblSlotsTitle").innerHTML = "⏰ Available Times";

    }
}

async function saveSchedule() {

    if (!selectedBarberId) {
        alert("Please select a barber.");
        return;
    }

    const selectedBarber = barbers.find(x => x.barberId == selectedBarberId);

    const request = {

        barberId: selectedBarberId,

        orgId: selectedBarber.orgId,

        slotDuration: getSlotDuration(),

        workingFrom: getWorkingFrom(),

        workingTo: getWorkingTo(),

        date: selectedDate,

        addSlots: selectedOOOToAdd,

        removeSlots: selectedOOOToRemove
    };

    try {

        const response = await fetch(
            API_BASE + "/SaveSchedule",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(request)
            });

        const result = await response.json();

        if (!response.ok)
            throw new Error(result.message || "Unable to save schedule.");

        alert(result.message || "Schedule saved successfully.");

        // Clear pending changes
        selectedOOOToAdd = [];
        selectedOOOToRemove = [];

        // Reload latest data
        await loadAvailability();

    }
    catch (ex) {

        console.error(ex);
        alert(ex.message);

    }
}

function getSlotDuration() {

    return parseInt(
        document.querySelector(
            'input[name="slotDuration"]:checked'
        ).value
    );

}

function getWorkingFrom() {

    return document.getElementById("workingFrom").value;

}

function getWorkingTo() {

    return document.getElementById("workingTo").value;

}

async function loadBarbers() {

    try {

        const response = await fetch(`${API_BASE}/barbers`);

        if (!response.ok) {
            throw new Error("Failed to fetch barbers");
        }

        barbers = await response.json();

        barberList.innerHTML = '';

        barbers.forEach((b, i) => {

            let col = document.createElement('div');

            col.className = 'col-12';

            const image =
                b.profileImagePath &&
                b.profileImagePath !== "string"
                    ? b.profileImagePath
                    : 'https://i.pravatar.cc/100?img=' + (i + 10);

            col.innerHTML = `
                <div class="barber ${i === 0 ? 'active' : ''}"
                     onclick="selectBarber(this, ${b.barberId}, '${b.fullName}')">

                    <img src="${image}" alt="${b.fullName}">

                    <div>
                        <strong>${b.fullName}</strong><br>

                        <small class="text-muted">
                            ${b.specialization || ''}
                        </small>
                    </div>

                </div>
            `;

            barberList.appendChild(col);
        });

        if (barbers.length > 0) {

    selectedBarberId = barbers[0].barberId;
    selectedBarberName = barbers[0].fullName;
    selectedBarberOrgId = barbers[0].orgId;
loadBarberPreferences(barbers[0]);
}

    }
    catch (err) {

        console.error(err);

        barberList.innerHTML = `
            <div class="text-danger">
                Failed to load barbers
            </div>
        `;
    }
}

function selectBarber(el, id, name) {

    document.querySelectorAll('.barber')
        .forEach(b => b.classList.remove('active'));

    el.classList.add('active');

    selectedBarberId = id;
    selectedBarberName = name;

    const selectedBarber = barbers.find(
        x => x.barberId == id
    );
loadBarberPreferences(selectedBarber)

    selectedBarberOrgId = selectedBarber?.orgId || '';

    if (selectedDate) {
        loadAvailability();
    }
}

function renderCalendar() {

    calendar.innerHTML = '';

    selectedMonth = currentDate.toLocaleString(
        'default',
        { month: 'long' }
    );

    selectedYear = currentDate.getFullYear();

    monthLabel.innerText =
        `${selectedMonth} ${selectedYear}`;

    let y = currentDate.getFullYear();

    let m = currentDate.getMonth();

    let fd = new Date(y, m, 1).getDay();

    let days = new Date(y, m + 1, 0).getDate();

    for (let i = 0; i < fd; i++) {

        calendar.appendChild(
            document.createElement('div')
        );
    }

    for (let d = 1; d <= days; d++) {

        let c = document.createElement('div');

        c.innerText = d;

        c.onclick = () => selectDate(c, d);

        calendar.appendChild(c);
    }
}

function changeMonth(v) {

    currentDate.setMonth(
        currentDate.getMonth() + v
    );

    renderCalendar();
}

function selectDate(el, d) {

    document.querySelectorAll('.calendar div')
        .forEach(x => x.classList.remove('active'));

    el.classList.add('active');

    const month =
        String(currentDate.getMonth() + 1)
            .padStart(2, '0');

    const day =
        String(d).padStart(2, '0');

    selectedDate =
        `${selectedYear}-${month}-${day}`;

    loadAvailability();
}

async function loadAvailability() {

    if (!selectedBarberId || !selectedDate)
        return;

    slots.innerHTML =
        `<div class="loading">Loading slots...</div>`;

    try {

        // FIND SELECTED BARBER OBJECT
        const selectedBarber = barbers.find(
            x => x.barberId == selectedBarberId
        );

        // GET ORG ID FROM BARBER OBJECT
        const orgId = selectedBarber?.orgId;

        if (!orgId) {

            slots.innerHTML = `
                <div class="text-danger">
                    OrgId not found
                </div>
            `;

            return;
        }

        // UPDATED API CALL
        const response = await fetch(
            `${API_BASE}/GetAvailability?employeeId=${selectedBarberId}&date=${selectedDate}&OrgId=${orgId}`
        );

        if (!response.ok) {
            throw new Error("Availability API failed");
        }

        // API RETURNS BOOKED SLOTS
        const availability = await response.json();

        slots.innerHTML = '';

const slotStatusMap = {};
        // BOOKED TIMES ARRAY
        availability.forEach(slot => {
    slotStatusMap[slot.startTime] = slot;
});

        // GENERATE ALL SLOTS
        const allSlots = [];
const slotDuration = getSlotDuration();

const start = getWorkingFrom().split(":");
const end = getWorkingTo().split(":");

const startMinutes =
    parseInt(start[0]) * 60 + parseInt(start[1]);

const endMinutes =
    parseInt(end[0]) * 60 + parseInt(end[1]);
        // 11 AM TO 9 PM
        //for (let minutes = 11 * 60; minutes < 21 * 60; minutes += 30) {
for (
    let minutes = startMinutes;
    minutes < endMinutes;
    minutes += slotDuration
){
            const h = Math.floor(minutes / 60);

            const m = minutes % 60;

            const hh = String(h).padStart(2, '0');

            const mm = String(m).padStart(2, '0');

            const slot24 = `${hh}:${mm}:00`;

            const displayHour = h % 12 || 12;

            const ampm = h >= 12 ? 'PM' : 'AM';

            const display =
                `${displayHour}:${mm.toString().padStart(2, '0')} ${ampm}`;

            allSlots.push({
                value: slot24,
                display: display
            });
        }

        // RENDER SLOTS
allSlots.forEach(slot => {

const bookingInfo = slotStatusMap[slot.value];
const status = bookingInfo?.bookingStatus;
const customerName = bookingInfo?.customerName || 'Customer';

    let s = document.createElement('div');

    s.className = 'slot';

    s.innerText = slot.display;

    if (status === 'Booked' && PAGE_MODE==="BOOKING") {

        s.style.background = '#f8d7da';
        s.style.color = '#842029';
        s.style.cursor = 'not-allowed';
        s.style.textDecoration = 'line-through';

        s.title = `Slot booked for ${customerName}`;

    }
    else if (status === 'Pending' && PAGE_MODE==="BOOKING") {

        s.style.background = '#fff3cd';
        s.style.color = '#856404';
        s.style.cursor = 'not-allowed';

        s.title = `Booking in progress for ${customerName}`;

    }
    else if (status === 'OutOfOffice'  && PAGE_MODE==="BOOKING") {

            s.style.background = '#fff3cd';
            s.style.color = '#856404';
            s.style.cursor = 'not-allowed';

            s.title = `Barber is out of office`;

     }
    else if(PAGE_MODE==="BOOKING" && status === 'OutOfOffice'){
        s.style.background = "#f8d7da";
    s.style.color = "#842029";
    s.style.cursor = "pointer";

    s.title = "Click to make this slot Available";

    s.onclick = () => {

        const idx = selectedOOOToRemove.indexOf(slot.value);

        if (idx >= 0) {

            // User changed mind
            selectedOOOToRemove.splice(idx, 1);

            s.classList.remove("active");
            s.style.opacity = "1";

        } else {

            selectedOOOToRemove.push(slot.value);

            s.classList.add("active");

            // Optional visual cue
            s.style.opacity = "0.5";
        }

        console.log("Slots to Remove:", selectedOOOToRemove);
    };
    }
    else {

        s.onclick = () => {

        if (PAGE_MODE === "BOOKING") {

            document.querySelectorAll(".slot")
                .forEach(x => x.classList.remove("active"));

            s.classList.add("active");

            selectedTime = slot.value;

            summary.innerHTML = `
                <b>${selectedBarberName}</b><br>
                ${selectedDate}<br>
                ${slot.display}
            `;

        } else {

            const idx = selectedOOOToAdd.indexOf(slot.value);

            if (idx >= 0) {

                selectedOOOToAdd.splice(idx, 1);

                s.classList.remove("active");

            } else {

                selectedOOOToAdd.push(slot.value);

                s.classList.add("active");
            }

            console.log("Slots to Add:", selectedOOOToAdd);
        }
    };
    }

    slots.appendChild(s);
});
}
    catch (err) {

        console.error(err);

        slots.innerHTML = `
            <div class="text-danger">
                Failed to load availability
            </div>
        `;
    }
}

async function saveOutOfOffice() {

            const request = {
            barberId: selectedBarberId,
            orgId: selectedOrgId,
            slotDuration: getSlotDuration(),
            workingFrom: getWorkingFrom(),
            workingTo: getWorkingTo(),
            date: selectedDate,
            addSlots: selectedOOOToAdd,
            removeSlots: selectedOOOToRemove
        };

        await fetch(API_BASE + "/api/Appointment/SaveSchedule", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(request)

        });
    selectedOOOToAdd = [];
    selectedOOOToRemove = [];

    loadAvailability();
}

async function bookAppointment() {

    if (!selectedBarberId ||
        !selectedDate ||
        !selectedTime) {

        alert("Please select barber, date and time");

        return;
    }

    const customerName =
        document.getElementById('customerName').value;

    const phoneNumber =
        document.getElementById('phoneNumber').value;

    const payload = {

    orgId: selectedBarberOrgId,

    employeeId: selectedBarberId,

    appointmentDate: selectedDate,

    startTime: selectedTime,

    customerName: customerName,

    customerPhone: phoneNumber
};

    try {

        const response = await fetch(
            `${API_BASE}/BookAppointment`,
            {
                method: 'POST',

                headers: {
                    'Content-Type': 'application/json'
                },

                body: JSON.stringify(payload)
            }
        );

        if (!response.ok) {

            const err = await response.text();

            console.error(err);

            throw new Error("Booking failed");
        }

        alert("Appointment booked successfully!");

        location.reload();
    }
    catch (err) {

        console.error(err);

        alert("Booking failed");
    }
}

loadBarbers();

renderCalendar();

</script>

</body>
</html>