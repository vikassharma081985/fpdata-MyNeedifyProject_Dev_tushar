<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Job.aspx.cs" Inherits="WSBillingMaster.Pages.Job" %>

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
    <form id="form1" runat="server">
      <!-- Banner -->
      <section class="banner d-flex align-items-center justify-content-center">
        <h2 class="fw-bold display-6 text-center">ONLINE Job Search Portal<br />

          <span style="font-size:16px;">अपने आस-पास के लोगों को काम दें।
            हम वह मंच हैं जहाँ हम एक-दूसरे की मदद करते हुए लोगों को जोड़ते हैं।
            निस्वार्थ सेवा और राष्ट्र निर्माण के संकल्प के साथ कदम बढ़ा रहे हैं।</span>
        </h2>
      </section>

      <!-- Search Box -->
      <div class="container">
        <div class="search-box">
          <div class="row g-3">
            <div class="col-md-3">
              <label class="form-label">Skills</label>
              <asp:TextBox ID="txtSearchSkill" runat="server" CssClass="form-control"
                placeholder="e.g. Software Developer"></asp:TextBox>
            </div>

            <div class="col-md-3">
              <label class="form-label">Location</label>
              <asp:TextBox ID="txtSearchLocation" runat="server" CssClass="form-control"
                placeholder="e.g. Pune, Mumbai"></asp:TextBox>
            </div>

            <div class="col-md-2">
              <label class="form-label">Experience</label>
              <asp:DropDownList ID="ddlSearchExperience" runat="server" CssClass="form-select">
                <asp:ListItem Value="All">All</asp:ListItem>
                <asp:ListItem Value="0-1 year">0-1 year</asp:ListItem>
                <asp:ListItem Value="1-3 years">1-3 years</asp:ListItem>
                <asp:ListItem Value="3-5 years">3-5 years</asp:ListItem>
                <asp:ListItem Value="5+ years">5+ years</asp:ListItem>
              </asp:DropDownList>
            </div>

            <div class="col-md-2">
              <label class="form-label">Apply Date</label>
              <asp:TextBox ID="txtSearchDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>

            <div class="col-md-2 d-flex align-items-end">
              <asp:Button ID="btnSearch" runat="server" CssClass="btn w-100" Text="Search Jobs"
                Style="background-color: #8EC243; color: white;" OnClick="btnSearch_Click" />
            </div>

            <div class="col-md-12 d-flex mt-2 justify-content-end">
              <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" id="womenOnly" />
                <label class="form-check-label" for="womenOnly">Near By Jobs</label>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Cards Section -->
      <div class="container my-4">
        <div class="row g-4">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </body>

  </html>