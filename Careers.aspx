<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System" %>
<script runat="server">
    protected int CurrentYear
    {
        get { return DateTime.UtcNow.AddMinutes(330).Year; } // India Standard Time
    }
</script>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Explore careers, hiring areas, and internships at My Needify in Delhi NCR." />
    <title>Careers | My Needify</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; background: #f5f7fb; color: #273244; font-family: Arial, Helvetica, sans-serif; font-size: 16px; line-height: 1.75; }
        .brand { background: #153653; color: #fff; padding: 20px 24px; }
        .brand div { max-width: 1040px; margin: auto; font-size: 22px; font-weight: 700; }
        main { max-width: 1040px; margin: 32px auto; padding: 36px 44px; background: #fff; border: 1px solid #e1e6ed; border-radius: 12px; }
        h1 { margin: 0 0 8px; color: #153653; font-size: 32px; line-height: 1.25; }
        .updated { color: #607086; margin: 0 0 26px; }
        h2 { color: #153653; font-size: 21px; line-height: 1.45; margin: 0 0 12px; }
        h3 { color: #153653; font-size: 18px; margin: 20px 0 10px; }
        section { margin-top: 30px; padding-top: 24px; border-top: 1px solid #e7ebf0; scroll-margin-top: 20px; }
        p { margin: 0 0 14px; overflow-wrap: anywhere; }
        ul, ol { padding-left: 24px; margin: 10px 0 18px; }
        li { margin-bottom: 10px; overflow-wrap: anywhere; }
        a { color: #17608c; text-underline-offset: 3px; overflow-wrap: anywhere; }
        a:focus-visible, .table-wrap:focus-visible { outline: 3px solid #17608c; outline-offset: 3px; }
        .intro { font-size: 21px; color: #52677c; margin: 14px 0 24px; line-height: 1.5; }
        .table-wrap { overflow-x: auto; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        caption { text-align: left; font-weight: bold; margin-bottom: 10px; }
        th, td { padding: 14px; border: 1px solid #dfe6ee; vertical-align: top; }
        thead th { background: #153653; color: white; }
        tbody th { width: 32%; background: #f5f7fb; }
        footer { text-align: center; padding: 0 20px 28px; color: #607086; font-size: 14px; }
        @media (max-width: 640px) { main { margin: 16px 12px; padding: 24px 20px; } h1 { font-size: 27px; } h2 { font-size: 19px; } .brand { padding: 16px 20px; } }
        @media print { body { background: #fff; color: #000; } .brand { background: none; color: #000; padding: 0; } main { margin: 0; padding: 20px 0; border: 0; } h2 { break-after: avoid; } footer { padding: 10px 0; } }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="brand"><div>My Needify</div></header>
        <main>
            <h1>Careers at My Needify</h1>
<p class="intro">Build the platform that brings India's everyday needs onto one screen</p>
<p>My Needify is a Delhi-based, multi-category marketplace and services platform — bringing together everyday shopping (electronics, grocery, medicine, apparel, home décor, car parts) and on-demand local services (salon bookings, and job/manpower matching) into a single app. We're building for how India actually shops and hires: through trusted local sellers, service professionals, and neighbourhood connections, made simple online.</p>
<p>If you want to build products that get used by real people for real, everyday needs — we'd like to hear from you.</p>
<section><h2>Life at My Needify</h2>
<ul><li><strong>Ownership from day one.</strong> Small teams, real responsibility, fast decisions.</li>
<li><strong>Close to the ground.</strong> We work directly with sellers, salon professionals, delivery partners, and customers — not just dashboards.</li>
<li><strong>Built in Delhi, for Bharat.</strong> We're solving for Tier 1–3 India, not just metro assumptions.</li></ul>
<%-- Add real team photos, a founder note, or a day-in-the-life section when available. --%>
</section>
<section><h2>Open Positions</h2>
<%-- Replace the indicative hiring areas below with live roles from your ATS/job board when available. --%>
<p>The following are indicative hiring areas, rather than confirmed current vacancies.</p>
<div class="table-wrap" tabindex="0" role="region" aria-label="Teams and typical roles">
<table><caption>Teams and roles we typically hire for</caption><thead><tr><th scope="col">Team</th><th scope="col">Roles we typically hire for</th></tr></thead><tbody>
<tr><th scope="row">Engineering &amp; Product</th><td>Full-Stack Developers (.NET/ASP.NET), QA Engineers, Product Managers</td></tr>
<tr><th scope="row">Category &amp; Vendor Management</th><td>Category Managers (Electronics, Grocery, Medicine, Apparel), Seller Onboarding &amp; Success</td></tr>
<tr><th scope="row">Operations &amp; Supply Chain</th><td>City Operations, Logistics &amp; Delivery Partnerships, Salon/Service Professional Onboarding</td></tr>
<tr><th scope="row">Customer Experience</th><td>Customer Support Executives, Grievance Redressal (Trust &amp; Safety)</td></tr>
<tr><th scope="row">Sales &amp; Business Development</th><td>Local Seller Acquisition, B2B Partnerships</td></tr>
<tr><th scope="row">Marketing</th><td>Performance Marketing, Content, Regional/Vernacular Marketing</td></tr>
<tr><th scope="row">Compliance &amp; Legal</th><td>Regulatory Compliance (e-commerce, drug licensing for the Medicine category, GST)</td></tr>
</tbody></table></div>
<p>No current openings in a team you're interested in? Send us your resume anyway at <a href="mailto:careers@myneedify.com">careers@myneedify.com</a> — we keep applications on file for 12 months and reach out when a relevant role opens.</p></section>
<section><h2>How to Apply</h2><ol>
<li>Find a role above (or on our jobs board, once linked) that matches your experience.</li>
<li>Send your resume and a short note on why you're interested to <a href="mailto:careers@myneedify.com">careers@myneedify.com</a> with the role name in the subject line, or apply directly if we've linked an ATS.</li>
<li>Our team will review applications and reach out to shortlisted candidates within <strong>[X business days]</strong>.</li>
<li>Typical process: Application review → Screening call → Role-specific interview(s) → Offer.</li>
</ol></section>
<section><h2>Internships</h2><p>We periodically open internship positions across Engineering, Operations, and Marketing for students/recent graduates based in Delhi NCR. Write to <a href="mailto:internships@myneedify.com">internships@myneedify.com</a> with your resume and area of interest.</p></section>
<section><h2>A Note on Recruitment Fraud</h2>
<p><strong>My Needify never asks candidates to pay any money — for registration, interviews, offer letters, training, or &quot;guaranteed placement&quot; — at any stage of recruitment</strong>, whether for a role at the Company or for job listings sourced through our platform's &quot;Looking for Job&quot; / &quot;Manpower Required&quot; sections. All official communication from our recruitment team will come from an <strong>@myneedify.com</strong> email address. If you receive a request for payment, or a job offer that seems suspicious, please do not respond with personal or financial information, and report it immediately to <a href="mailto:grievance@myneedify.com">grievance@myneedify.com</a>.</p></section>
<section><h2>Equal Opportunity</h2><p>My Needify is an equal-opportunity employer. We evaluate candidates on merit, skills, and role fit, and do not discriminate on the basis of religion, caste, gender, marital status, disability, or any other status protected under applicable Indian law.</p></section>
<section><h2>Your Data, When You Apply</h2><p>Information you submit as part of a job application (resume, contact details, work history) is collected and used solely for recruitment purposes, in line with our <a href="PrivacyPolicy.aspx">Privacy Policy</a>, and retained only for as long as reasonably necessary to evaluate your candidacy or as permitted by you for future opportunities.</p></section>
<section><h2>Questions?</h2><p><strong>Questions about a role or our hiring process?</strong> Write to us at <a href="mailto:careers@myneedify.com">careers@myneedify.com</a>.</p></section>
        </main>
        <footer>&copy; <%= CurrentYear %> My Needify. All rights reserved.</footer>
    </form>
</body>
</html>
