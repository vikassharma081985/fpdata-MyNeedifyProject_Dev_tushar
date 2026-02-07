<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
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

.header h1 span { color:var(--primary); }

.card-box {
    background:var(--card);
    border-radius:16px;
    padding:16px;
    box-shadow:0 10px 25px rgba(0,0,0,.06);
    margin-bottom:16px;
}

/* BARBERS */
.barber {
    border:2px solid transparent;
    padding:14px;
    border-radius:14px;
    display:flex;
    align-items:center;
    gap:12px;
    cursor:pointer;
    width:100%;
}

.barber.active { border-color:var(--primary); }

.barber img {
    width:48px;
    height:48px;
    border-radius:50%;
}

/* CALENDAR */
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

/* TIME SLOTS */
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
}

.slot.active {
    background:var(--primary);
    color:#fff;
}

/* BUTTON */
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
</style>
</head>

<body>

<div class="container my-3">

    <div class="header d-flex justify-content-between align-items-center flex-wrap gap-2">
        <div>
            <h4 class="mb-1">Book Your <span>Perfect Cut</span></h4>
            <small class="text-muted">Choose barber, date & time</small>
        </div>
        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addBarberModal">
            ➕ Add Barber
        </button>
    </div>

    <div class="card-box">
        <h6 class="mb-3">✨ Choose Your Barber</h6>
        <div class="row g-2" id="barberList"></div>
    </div>

    <div class="card-box">
        <div class="calendar-header">
            <button class="btn btn-light btn-sm" onclick="changeMonth(-1)">‹</button>
            <strong id="monthLabel"></strong>
            <button class="btn btn-light btn-sm" onclick="changeMonth(1)">›</button>
        </div>
        <div id="calendar" class="calendar"></div>
    </div>

    <div class="card-box">
        <h6 class="mb-2">⏰ Available Times</h6>
        <div id="slots" class="slots-grid"></div>
    </div>

    <div class="text-center">
        <button class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#confirmModal">
            Confirm Booking
        </button>
    </div>

</div>

<div class="modal fade" id="addBarberModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
        <div class="modal-header">
            <h6 class="modal-title">Add New Barber</h6>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
            <input id="bName" class="form-control mb-2" placeholder="Barber Name">
            <input id="bSpec" class="form-control mb-2" placeholder="Specialty">
            <input id="bImg" class="form-control mb-3" placeholder="Image URL">
            <button class="btn btn-primary w-100" onclick="addBarber()">Add Barber</button>
        </div>
    </div>
  </div>
</div>

<div class="modal fade" id="confirmModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
        <div class="modal-header">
            <h6 class="modal-title">Confirm Booking</h6>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
            <p id="summary"></p>
            <input class="form-control mb-2" placeholder="Your Name">
            <input class="form-control mb-3" placeholder="Phone Number">
            <button class="btn btn-primary w-100">Confirm</button>
        </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    let barbers = [
        { name: 'James Wilson', spec: 'Classic Cuts & Fades', img: 'https://i.pravatar.cc/100?img=12' },
        { name: 'Michael Chen', spec: 'Modern Styles & Beard', img: 'https://i.pravatar.cc/100?img=32' }
    ];

    let selectedBarber = '', selectedDate = '', selectedTime = '';
    let selectedMonth = '', selectedYear = '';
    let currentDate = new Date();

    function renderBarbers() {
        barberList.innerHTML = '';
        barbers.forEach((b, i) => {
            let col = document.createElement('div');
            col.className = 'col-12';
            col.innerHTML = `
        <div class="barber ${i === 0 ? 'active' : ''}" onclick="selectBarber(this,'${b.name}')">
            <img src="${b.img}">
            <div>
                <strong>${b.name}</strong><br>
                <small class="text-muted">${b.spec}</small>
            </div>
        </div>`;
            barberList.appendChild(col);
        });
        selectedBarber = barbers[0].name;
    }

    function selectBarber(el, name) {
        document.querySelectorAll('.barber').forEach(b => b.classList.remove('active'));
        el.classList.add('active');
        selectedBarber = name;
    }

    function addBarber() {
        barbers.push({ name: bName.value, spec: bSpec.value, img: bImg.value || 'https://via.placeholder.com/100' });
        renderBarbers();
        bootstrap.Modal.getInstance(addBarberModal).hide();
    }

    function renderCalendar() {
        calendar.innerHTML = '';
        selectedMonth = currentDate.toLocaleString('default', { month: 'long' });
        selectedYear = currentDate.getFullYear();
        monthLabel.innerText = `${selectedMonth} ${selectedYear}`;

        let y = currentDate.getFullYear(), m = currentDate.getMonth();
        let fd = new Date(y, m, 1).getDay();
        let days = new Date(y, m + 1, 0).getDate();

        for (let i = 0; i < fd; i++) calendar.appendChild(document.createElement('div'));

        for (let d = 1; d <= days; d++) {
            let c = document.createElement('div');
            c.innerText = d;
            c.onclick = () => selectDate(c, d);
            calendar.appendChild(c);
        }
    }

    function changeMonth(v) {
        currentDate.setMonth(currentDate.getMonth() + v);
        renderCalendar();
    }

    function selectDate(el, d) {
        document.querySelectorAll('.calendar div').forEach(x => x.classList.remove('active'));
        el.classList.add('active');
        selectedDate = `${d} ${selectedMonth} ${selectedYear}`;
        loadSlots();
    }

    function loadSlots() {
        slots.innerHTML = '';
        for (let t = 0; t <= 720; t += 30) {
            let h = Math.floor(t / 60), m = t % 60;
            let ap = h >= 12 ? 'PM' : 'AM';
            let hh = h % 12 || 12;
            let time = `${hh}:${m.toString().padStart(2, '0')} ${ap}`;
            let s = document.createElement('div');
            s.className = 'slot';
            s.innerText = time;
            s.onclick = () => {
                document.querySelectorAll('.slot').forEach(x => x.classList.remove('active'));
                s.classList.add('active');
                selectedTime = time;
                summary.innerHTML = `<b>${selectedBarber}</b><br>${selectedDate} at ${selectedTime}`;
            };
            slots.appendChild(s);
        }
    }

    renderBarbers();
    renderCalendar();
</script>

</body>
</html>
