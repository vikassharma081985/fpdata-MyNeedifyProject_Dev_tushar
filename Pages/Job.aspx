<%@ Page Language="C#" ResponseEncoding="utf-8" AutoEventWireup="true" CodeFile="Job.aspx.cs" Inherits="WSBillingMaster.Pages.Job" %>

  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="Search and hire trusted local labour including plumbers, electricians, carpenters, painters, cleaners, and other skilled workers near your location." />
    <meta name="keywords" content="labour near me, plumber, electrician, carpenter, painter, workers" />
    <title>Job / Card UI</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
      @media (max-width: 768px) {

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
        min-height: 260px;
        padding: 1.5rem 1rem 5.5rem;
        background-size: cover;
        background-position: center;
        color: white;
      }

      .banner h2 {
        width: 100%;
        max-width: 56rem;
        margin: 0;
      }

      .banner-copy {
        display: block;
        margin-top: .5rem;
        font-size: 1rem;
        line-height: 1.5;
      }

      .search-box {
        max-width: 660px;
        margin-top: -70px;
        margin-inline: auto;
        background: white;
        border: 1px solid #e2e8f0;
        border-radius: 24px;
        padding: 20px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
      }

      .job-filter-label {
        color: #1e293b;
        font-size: .95rem;
        font-weight: 700;
        margin-bottom: .45rem;
      }

      .job-filter-label small, .job-category-grid small {
        color: #475569;
        font-weight: 500;
      }

      .search-box summary { cursor: pointer; }

      .job-date-options {
        display: flex;
        flex-wrap: wrap;
        gap: .4rem;
      }

      .job-date-options input {
        position: absolute;
        opacity: 0;
      }

      .job-date-options label {
        cursor: pointer;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        background: #f1f5f9;
        color: #334155;
        padding: .35rem .6rem;
        font-size: .85rem;
        font-weight: 600;
      }

      .job-date-options input:checked + label {
        background: #2563eb;
        border-color: #2563eb;
        color: #fff;
      }

      .job-date-options input:focus-visible + label {
        outline: 2px solid #1e3557;
        outline-offset: 2px;
      }

      .job-category-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: .5rem;
      }

      .job-category-grid button {
        display: flex;
        flex-direction: column;
        align-items: center;
        min-width: 0;
        gap: .2rem;
        padding: .55rem .25rem;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        background: #f8fafc;
        color: #1e293b;
        font-size: .85rem;
        font-weight: 700;
        overflow-wrap: anywhere;
      }

      .job-category-grid i {
        color: #2563eb;
        font-size: 1.1rem;
      }

      .job-category-grid button:hover,
      .job-category-grid button[aria-pressed="true"] {
        border-color: #2563eb;
        background: #eff6ff;
      }

      .job-search-button {
        border-radius: 12px;
        background: #7cb342;
        color: #14253e;
        font-weight: 700;
      }

      .job-search-button:hover, .job-search-button:focus-visible {
        background: #689f38;
        color: #14253e;
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
    <form id="form1" runat="server">
      <!-- Banner -->
      <section class="banner d-flex align-items-center justify-content-center">
        <h2 class="fw-bold display-6 text-center">ONLINE Job Search Portal

          <span class="banner-copy" lang="hi">अपने आस-पास के लोगों को काम दें।
            हम वह मंच हैं जहाँ हम एक-दूसरे की मदद करते हुए लोगों को जोड़ते हैं।
            निस्वार्थ सेवा और राष्ट्र निर्माण के संकल्प के साथ कदम बढ़ा रहे हैं।</span>
        </h2>
      </section>

      <div class="container">
        <asp:Panel ID="pnlJobSearch" runat="server" DefaultButton="btnSearch" CssClass="search-box"
          role="region" aria-label="Search local service workers">
          <fieldset class="mb-3">
            <legend class="job-filter-label float-none w-auto">किस काम के लिए चाहिए? <small>(Service Category)</small></legend>
            <asp:HiddenField ID="selectedJobCategory" runat="server" ClientIDMode="Static" />
            <div class="job-category-grid" id="jobCategoryGrid">
              <button type="button" data-service="Plumber" aria-pressed="false">
                <i class="fa-solid fa-wrench" aria-hidden="true"></i> प्लंबर <small>Plumber</small>
              </button>
              <button type="button" data-service="Electrician" aria-pressed="false">
                <i class="fa-solid fa-bolt" aria-hidden="true"></i> इलेक्ट्रीशियन <small>Electrician</small>
              </button>
              <button type="button" data-service="Carpenter" aria-pressed="false">
                <i class="fa-solid fa-hammer" aria-hidden="true"></i> बढ़ई <small>Carpenter</small>
              </button>
              <button type="button" data-service="Painter" aria-pressed="false">
                <i class="fa-solid fa-paint-roller" aria-hidden="true"></i> पेंटर <small>Painter</small>
              </button>
              <button type="button" data-service="Mason" aria-pressed="false">
                <i class="fa-solid fa-trowel-bricks" aria-hidden="true"></i> राजमिस्त्री <small>Mason</small>
              </button>
              <button type="button" data-service="" aria-pressed="true">
                <i class="fa-solid fa-table-cells-large" aria-hidden="true"></i> सभी सेवाएं <small>All / More</small>
              </button>
            </div>
            <asp:Label runat="server" AssociatedControlID="txtSearchSkill" CssClass="visually-hidden"
              Text="काम लिखें (Search by skill)" />
            <asp:TextBox ID="txtSearchSkill" runat="server" ClientIDMode="Static" CssClass="form-control mt-2"
              placeholder="या काम लिखें (e.g. Plumber)" />
          </fieldset>

          <div class="border-top pt-3 mb-3">
            <asp:Label runat="server" AssociatedControlID="txtSearchLocation" CssClass="job-filter-label"
              Text="स्थान (Location)" />
            <div class="input-group">
              <span class="input-group-text text-danger"><i class="fa-solid fa-location-dot" aria-hidden="true"></i></span>
              <asp:TextBox ID="txtSearchLocation" runat="server" CssClass="form-control"
                placeholder="अपना शहर या क्षेत्र लिखें (e.g. Pune)" />
            </div>
          </div>

          <fieldset class="border-top pt-3 mb-3" aria-describedby="jobDateHelp">
            <legend class="job-filter-label float-none w-auto pe-2">कब चाहिए? <small>(When Needed)</small></legend>
            <asp:RadioButtonList ID="jobWhenNeeded" runat="server" ClientIDMode="Static"
              CssClass="job-date-options" RepeatLayout="Flow" RepeatDirection="Horizontal">
              <asp:ListItem Value="today">आज (Today)</asp:ListItem>
              <asp:ListItem Value="tomorrow">कल (Tomorrow)</asp:ListItem>
              <asp:ListItem Value="any" Selected="True">किसी भी दिन (Any Day)</asp:ListItem>
            </asp:RadioButtonList>
            <div id="jobDateHelp" class="form-text">Choose a preferred joining date for the Hire form.</div>
          </fieldset>

          <details id="jobMoreFilters" class="border-top pt-3 mb-3">
            <summary class="job-filter-label">फ़िल्टर <small>(More Filters)</small></summary>
            <div class="row g-2">
              <div class="col-sm-6">
                <asp:Label runat="server" AssociatedControlID="ddlSearchExperience" CssClass="job-filter-label mt-2"
                  Text="अनुभव (Experience)" />
                <asp:DropDownList ID="ddlSearchExperience" runat="server" ClientIDMode="Static" CssClass="form-select">
                  <asp:ListItem Value="All">All</asp:ListItem>
                  <asp:ListItem Value="0-1 year">0-1 year</asp:ListItem>
                  <asp:ListItem Value="1-3 years">1-3 years</asp:ListItem>
                  <asp:ListItem Value="3-5 years">3-5 years</asp:ListItem>
                  <asp:ListItem Value="5+ years">5+ years</asp:ListItem>
                </asp:DropDownList>
              </div>
              <div class="col-sm-6">
                <asp:Label runat="server" AssociatedControlID="jobCustomDate" CssClass="job-filter-label mt-2"
                  Text="तारीख चुनें (Custom Date)" />
                <asp:TextBox ID="jobCustomDate" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Date" />
              </div>
            </div>
          </details>

          <asp:Button ID="btnSearch" runat="server" ClientIDMode="Static" CssClass="btn job-search-button w-100"
            Text="कामगार खोजें (Find Workers)" OnClick="btnSearch_Click" />
        </asp:Panel>
      </div>

      <!-- Cards Section -->
      <div class="container my-4">
        <div class="row g-4">
          <asp:PlaceHolder ID="jobSearchEmpty" runat="server" Visible="false">
            <p class="col-12 text-center text-muted" role="status">No workers match these filters.</p>
          </asp:PlaceHolder>
          <asp:Repeater ID="rptJobs" runat="server" OnItemCommand="rptJobs_ItemCommand">
            <ItemTemplate>
              <div class="col-md-4 col-sm-6">
                <div class="bus-card h-100 d-flex flex-column">
                  <div class="d-flex align-items-center mb-3">
                    <img
                      src='<%# string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ? "https://i.pravatar.cc/100?img=12" : ResolveUrl(Eval("PhotoPath").ToString()) %>'
                      class="profile-pic me-3" alt="Profile" />
                    <div>
                      <div class="company-name">
                        <%# Eval("FirstName") %>
                          <%# Eval("LastName") %>
                      </div>
                      <small class="text-muted">Hiring: <%# Eval("Skill") %></small>
                    </div>
                    <span class="availability ms-auto">● Available</span>
                  </div>

                  <div class="d-flex justify-content-between align-items-center mb-2">
                    <div>
                      <h5 class="fw-bold mb-0">₹<%# Eval("Amount") %>
                      </h5>
                      <small class="text-muted">
                        <%# Eval("ExperienceType") %>
                      </small>
                    </div>
                    <div class="text-end">
                      <span class="rating-box">
                        <i class="fa-solid fa-star"></i> 4.6
                      </span>
                      <br>
                      <small class="text-muted">Verified</small>
                    </div>
                  </div>

                  <h6 class="fw-bold mt-3">
                    <%# Eval("Skill") %> <i class="fa-solid fa-laptop-code ms-1"></i>
                  </h6>
                  <p class="text-muted small">Location: <%# Eval("CityName") %>, <%# Eval("StateName") %>
                  </p>

                  <div class="d-flex justify-content-between align-items-center mt-auto">
                    <div class="status">
                      <span class="status-chip"><i class="fa-solid fa-clock"></i> Immediate Joining</span>
                    </div>
                    <asp:LinkButton ID="btnHire" runat="server"
                      PostBackUrl='<%# "~/Pages/Hire.aspx?RegId=" + Eval("RegId") %>'
                      CssClass="btn btn-sm text-white px-3" Style="background:#F48B1E; border-radius:40px;"
                      Visible='<%# !IsCandidateHired(Convert.ToInt32(Eval("RegId"))) %>'>
                      Hire Now
                    </asp:LinkButton>
                    <span class="btn btn-sm text-white px-3"
                      style="background:#28a745; border-radius:40px; cursor:default;" runat="server"
                      visible='<%# IsCandidateHired(Convert.ToInt32(Eval("RegId"))) %>'>
                      <i class="fa-solid fa-check"></i> Selected
                    </span>
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </form>

    <script>
      (function () {
        const category = document.getElementById('selectedJobCategory');
        const keyword = document.getElementById('txtSearchSkill');
        const search = document.getElementById('btnSearch');

        document.querySelectorAll('#jobCategoryGrid button').forEach(function (button) {
          button.setAttribute('aria-pressed', String(button.dataset.service === category.value));
          button.addEventListener('click', function () {
            category.value = button.dataset.service;
            if (category.value === '') {
              keyword.value = '';
            }
            search.click();
          });
        });

        const customDate = document.getElementById('jobCustomDate');
        const anyDay = document.querySelector('#jobWhenNeeded input[value="any"]');
        document.getElementById('jobWhenNeeded').addEventListener('change', function () {
          customDate.value = '';
        });
        customDate.addEventListener('change', function () {
          anyDay.checked = true;
        });

        document.getElementById('jobMoreFilters').open = customDate.value !== '' ||
          document.getElementById('ddlSearchExperience').selectedIndex > 0;
      }());
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </body>

  </html>
