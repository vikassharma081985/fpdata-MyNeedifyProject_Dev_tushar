<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Jobtusharmain.aspx.cs" Inherits="WSBillingMaster.Pages.Jobtusharmain" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Job / Card UI</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>

  <!-- Font Awesome for icons -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    @media (max-width: 768px){ 

      .availability {
        font-size: 12px;
      }
      .text-muted {
        font-size: 12px;
      }
    }

    .banner {
      background: linear-gradient(#4466a3bb, #203864),
                  url('https://images.unsplash.com/photo-1521737604893-d14cc237f11d');
      height: 260px;
      background-size: cover;
      background-position: center;
      color: white;
    }

    .search-box {
      margin-top: -70px;
      background: white;
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }

    .bus-card {
      border-radius: 18px;
      padding: 20px;
      background: #ffffff;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.10);
      margin-bottom: 1.5rem;
    }

    .rating-box {
      background: #8EC243;
      color: white;
      padding: 5px 12px;
      border-radius: 8px;
      font-size: 14px;
      font-weight: bold;
      display: inline-flex;
      align-items: center;
      gap: 4px;
    }

    .status-chip {
      background: #0AA6BF20;
      color: #0AA6BF;
      display: inline-block;
      padding: 5px 14px;
      border-radius: 12px;
      font-size: 13px;
      font-weight: 500;
    }

    .profile-pic {
      width: 55px;
      height: 55px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid #0AA6BF;
    }

    .company-name {
      font-weight: 600;
      font-size: 15px;
    }

    .availability {
      color: #F48B1E;
      font-weight: bold;
      margin-left: 10px;
    }
     .primo-tag {
      font-weight: bold;
      color: #F48B1E;
      font-size: 16px;
      display: inline-flex;
      align-items: center;
      gap: 5px;
      margin-bottom: 8px;
    }
  </style>
</head>
<body class="bg-light">

  <!-- Banner -->
  <section class="banner d-flex align-items-center justify-content-center">
    <h2 class="fw-bold display-6 text-center">India’s No.1 Online Job Portal</h2>
  </section>

  <!-- Search Box -->
  <div class="container">
    <div class="search-box">
      <div class="row g-3">
        <div class="col-md-3">
          <label class="form-label">Skills</label>
          <input type="text" class="form-control" placeholder="e.g. Software Developer"/>
        </div>

        <div class="col-md-3">
          <label class="form-label">Location</label>
          <input type="text" class="form-control" placeholder="e.g. Pune, Mumbai"/>
        </div>

        <div class="col-md-2">
          <label class="form-label">Experience</label>
          <select class="form-select">
            <option>0-1 year</option>
            <option>1-3 years</option>
            <option>3-5 years</option>
            <option>5+ years</option>
          </select>
        </div>

        <div class="col-md-2">
          <label class="form-label">Apply Date</label>
          <input type="date" class="form-control"/>
        </div>

        <div class="col-md-2 d-flex align-items-end">
          <button class="btn  w-100" style="background-color: #8EC243;">Search Jobs</button>
        </div>

        <div class="col-md-12 d-flex mt-2 justify-content-end">
          <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" id="womenOnly"/>
            <label class="form-check-label" for="womenOnly">Near By Jobs</label>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Cards Section -->
  <div class="container my-4">
    <div class="row g-4">

      <!-- CARD 1 -->
      <div class="col-md-4 col-sm-6">
        <div class="bus-card h-100 d-flex flex-column">

          <div class="d-flex align-items-center mb-3">
            <img src="https://i.pravatar.cc/100?img=12" class="profile-pic me-3" alt="Company Logo or Profile"/>
            <div>
              <div class="company-name">Goldline</div>
              <small class="text-muted">Hiring: Software Dev.</small>
            </div>
            <span class="availability ms-auto">● Available</span>
          </div>

          <div class="d-flex justify-content-between align-items-center mb-2">
            <div>
              <h5 class="fw-bold mb-0">₹25,000</h5>
              <small class="text-muted">Full Time</small>
            </div>
            <div class="text-end">
              <span class="rating-box">
                <i class="fa-solid fa-star"></i> 4.6
              </span>
              <br>
              <small class="text-muted">94 Reviews</small>
            </div>
          </div>

          <h6 class="fw-bold mt-3">Software Developer <i class="fa-solid fa-laptop-code ms-1"></i></h6>
          <p class="text-muted small">Skills: HTML, CSS</p>

          <div class="d-flex justify-content-between align-items-center mt-auto">
            <div class="status">
              <span class="status-chip"><i class="fa-solid fa-clock"></i> Immediate Joining</span>
            </div>
            <button class="btn btn-sm text-white px-3" 
            style="background:#F48B1E; border-radius:40px;">
              Hire Now
            </button>
          </div>

        </div>
      </div>

      <!-- CARD 2 -->
      <div class="col-md-4 col-sm-6">
        <div class="bus-card h-100 d-flex flex-column">

          <div class="primo-tag">
            <i class="fa-solid fa-medal"></i> Featured Job
          </div>

          <div class="d-flex align-items-center mb-3">
            <img src="https://i.pravatar.cc/100?img=32" class="profile-pic me-3" alt="Company Logo or Profile"/>
            <div>
              <div class="company-name">Raju Bhai</div>
              <small class="text-muted">Hiring: Senior UI/UX Dev.</small>
            </div>
            <span class="availability ms-auto">● Offline</span>
          </div>

          <div class="d-flex justify-content-between align-items-center mb-2">
            <div>
              <h5 class="fw-bold mb-0">₹35,000</h5>
              <small class="text-muted">Hybrid · 6 Days/Week</small>
            </div>
            <div class="text-end">
              <span class="rating-box">
                <i class="fa-solid fa-star"></i> 4.2
              </span>
              <br>
              <small class="text-muted">82 Reviews</small>
            </div>
          </div>

          <h6 class="fw-bold mt-3">Designer <i class="fa-solid fa-pen-ruler ms-1"></i></h6>
          <p class="text-muted small">Skills: Figma, Wireframing, User Research</p>

          <div class="d-flex justify-content-between align-items-center mt-auto">
            <div class="status">
              <span class="status-chip"><i class="fa-solid fa-clock"></i> Immediate Joining</span>
            </div>
            <button class="btn btn-sm text-white px-3" 
            style="background:#F48B1E; border-radius:20px;">
              Hire Now
            </button>
          </div>

        </div>
      </div>

      <!-- CARD 3 -->
      <div class="col-md-4 col-sm-6">
        <div class="bus-card h-100 d-flex flex-column">

          <div class="primo-tag">
            <i class="fa-solid fa-medal"></i> Featured Job
          </div>

          <div class="d-flex align-items-center mb-3">
            <img src="https://i.pravatar.cc/100?img=32" class="profile-pic me-3" alt="Company Logo or Profile"/>
            <div>
              <div class="company-name">Raju Bhai</div>
              <small class="text-muted">Hiring: Senior UI/UX Dev.</small>
            </div>
            <span class="availability ms-auto">● Offline</span>
          </div>

          <div class="d-flex justify-content-between align-items-center mb-2">
            <div>
              <h5 class="fw-bold mb-0">₹35,000</h5>
              <small class="text-muted">Hybrid · 6 Days/Week</small>
            </div>
            <div class="text-end">
              <span class="rating-box">
                <i class="fa-solid fa-star"></i> 4.2
              </span>
              <br>
              <small class="text-muted">82 Reviews</small>
            </div>
          </div>

          <h6 class="fw-bold mt-3">Designer <i class="fa-solid fa-pen-ruler ms-1"></i></h6>
          <p class="text-muted small">Skills: Figma, Wireframing, User Research</p>

          <div class="d-flex justify-content-between align-items-center mt-auto">
            <div class="status">
              <span class="status-chip"><i class="fa-solid fa-clock"></i> Immediate Joining</span>
            </div>
            <button class="btn btn-sm text-white px-3" 
            style="background:#F48B1E; border-radius:20px;">
              Hire Now
            </button>
          </div>

        </div>
      </div>

    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
