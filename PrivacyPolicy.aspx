<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Globalization" %>
<script runat="server">
    // Optional Web.config appSettings entry:
    // <add key="PrivacyLastUpdated" value="2026-10-02" />
    // Change this value when the policy is revised; do not use today's date on every visit.
    protected DateTime PolicyRevisionDate
    {
        get
        {
            DateTime revisionDate;
            string configuredDate = ConfigurationManager.AppSettings["PrivacyLastUpdated"];
            if (DateTime.TryParseExact(configuredDate, "yyyy-MM-dd", CultureInfo.InvariantCulture,
                DateTimeStyles.None, out revisionDate))
                return revisionDate;
            return new DateTime(2026, 10, 2);
        }
    }
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
    <meta name="description" content="How My Needify collects, uses, shares, and protects personal information." />
    <title>Privacy Policy | My Needify</title>
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
        footer { text-align: center; padding: 0 20px 28px; color: #607086; font-size: 14px; }
        @media (max-width: 640px) { main { margin: 16px 12px; padding: 24px 20px; } h1 { font-size: 27px; } h2 { font-size: 19px; } .brand { padding: 16px 20px; } }
        @media print { body { background: #fff; color: #000; } .brand { background: none; color: #000; padding: 0; } main { margin: 0; padding: 20px 0; border: 0; } h2 { break-after: avoid; } footer { padding: 10px 0; } }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="brand"><div>My Needify</div></header>
        <main>
            <h1>Privacy Policy</h1>
            <p class="updated">Last Updated: <time datetime="<%= PolicyRevisionDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) %>"><%= PolicyRevisionDate.ToString("dd MMMM yyyy", CultureInfo.GetCultureInfo("en-IN")) %></time></p>
<p>This Privacy Policy describes how [Legal Entity Name of the Company, e.g., &quot;Needify Technologies Private Limited&quot;] (&quot;My Needify&quot;, &quot;Company&quot;, &quot;we&quot;, &quot;us&quot;, &quot;our&quot;), a company incorporated under the Companies Act, 2013 and having its registered office at [Full Registered Address, Delhi, India, PIN], collects, uses, discloses, and protects the personal information of users of the website www.myneedify.com, our mobile applications, and related services (together, the &quot;Platform&quot;).</p>
<p>By accessing or using the Platform, you agree to the collection and use of information in accordance with this Policy. If you do not agree, please do not use the Platform.</p>
<p>This Policy is published in accordance with:</p>
<ul>
<li>Section 43A of the Information Technology Act, 2000 and the Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Data or Information) Rules, 2011 (&quot;SPDI Rules&quot;);</li>
<li>The Information Technology (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021;</li>
<li>The Consumer Protection (E-Commerce) Rules, 2020; and</li>
<li>The Digital Personal Data Protection Act, 2023 and the Digital Personal Data Protection Rules, 2025 (&quot;DPDP Act&quot;), to the extent its provisions are in force from time to time.</li>
</ul>
<p>Note: Core DPDP Act obligations (consent architecture, Data Principal rights, breach notification) are being brought into force by the Government of India in a phased manner, with full enforcement expected by May 2027. Until then, and in parallel thereafter, this Policy is designed to meet both the SPDI Rules and the DPDP Act.</p>
<section id="section-1"><h2>1. Who This Policy Applies To</h2>
<p>This Policy applies to:</p>
<ul>
<li>Buyers/Users browsing or purchasing goods and booking services on the Platform;</li>
<li>Sellers/Vendors who list products (electronics, grocery, medicine, apparel, home décor, car parts, etc.) via the Seller Dashboard;</li>
<li>Service Professionals (e.g., salon, grooming, and other on-demand service providers) who register to offer services;</li>
<li>Job Seekers / Employers using the &quot;Looking for Job&quot; and &quot;Manpower Required&quot; sections; and</li>
<li>Job Applicants applying for employment with the Company itself (see also our Careers Page).</li>
</ul>
</section>
<section id="section-2"><h2>2. Information We Collect</h2>
<h3>2.1 Information You Provide Directly</h3>
<ul>
<li>Identity/contact details: name, email address, mobile number, date of birth, gender, delivery address.</li>
<li>Account credentials: username, password (stored in encrypted/hashed form).</li>
<li>Payment-related information: billing address, and, where applicable, payment instrument details collected and processed directly by our RBI-regulated payment gateway partners (we do not store full card numbers or CVV on our servers).</li>
<li>Seller/business information: business name, GSTIN, PAN, bank account/UPI details for settlements, business address, product catalogues.</li>
<li>Service-professional information: identity proof, address proof, skill/trade certifications, photographs, appointment schedules.</li>
<li>Job listing/registration information: resume/CV, work history, educational qualifications, skill sets, expected salary, and, for employers, company and vacancy details.</li>
<li>Communications: information you provide when contacting customer support, submitting reviews/ratings, or raising a grievance.</li>
<li>Sensitive Personal Data or Information (SPDI) under the SPDI Rules, where applicable: passwords, financial information (bank/UPI/card details), and, in respect of orders placed in the Medicine category, health-related information such as prescriptions, medical history mentioned in a prescription, or physical condition. We collect such health-related information only to the extent necessary to process a medicine order and verify it against applicable prescription requirements.</li>
</ul>
<h3>2.2 Information Collected Automatically</h3>
<ul>
<li>Device information: IP address, browser type, operating system, device identifiers.</li>
<li>Usage data: pages viewed, search queries, click-stream data, time and duration of visit.</li>
<li>Location data: approximate location (via IP) or precise location (if you grant permission), used to show nearby sellers/service providers and estimate delivery.</li>
<li>Cookies and similar tracking technologies (see Section 7).</li>
</ul>
<h3>2.3 Information From Third Parties</h3>
<ul>
<li>Information from payment gateways confirming transaction status (not full payment credentials).</li>
<li>Information from delivery/logistics partners regarding order fulfilment status.</li>
<li>Information from social login providers (if you choose to sign in via a third-party account), limited to the data you authorise them to share.</li>
</ul>
</section>
<section id="section-3"><h2>3. How We Use Your Information</h2>
<p>We use personal information to:</p>
<ol>
<li>Create and manage your account;</li>
<li>Process orders, bookings, payments, refunds, and cancellations;</li>
<li>Connect Buyers with Sellers and Users with Service Professionals;</li>
<li>Facilitate the job-posting and job-seeker matching features;</li>
<li>Verify Seller/Service Professional credentials and, for the Medicine category, verify prescription compliance;</li>
<li>Communicate order updates, service reminders, and appointment confirmations;</li>
<li>Respond to customer support queries and grievances;</li>
<li>Detect, prevent, and investigate fraud, abuse, or violations of our Terms and Conditions;</li>
<li>Improve the Platform, perform analytics, and personalise recommendations;</li>
<li>Send promotional communications, where you have opted in (with an opt-out available at any time); and</li>
<li>Comply with applicable law, regulatory requirements, and lawful requests from government or law enforcement authorities.</li>
</ol>
</section>
<section id="section-4"><h2>4. Legal Basis for Processing</h2>
<p>We process personal data on the basis of:</p>
<ul>
<li>Your consent, obtained at the point of collection (e.g., account creation, order placement, permission-based location access);</li>
<li>Performance of a contract, where processing is necessary to fulfil an order, booking, or service you have requested;</li>
<li>Legitimate uses recognised under the DPDP Act (e.g., fraud prevention, safety, and security of the Platform); and</li>
<li>Compliance with a legal obligation, including retention of transaction records under tax, consumer protection, and drug-control laws.</li>
</ul>
<p>You may withdraw consent at any time (see Section 9), subject to the effect withdrawal may have on your ability to use certain features (e.g., we cannot process a medicine order without prescription-related information).</p>
</section>
<section id="section-5"><h2>5. How We Share Your Information</h2>
<p>We may share your information with:</p>
<ul>
<li>Sellers and Service Professionals, to the extent necessary to fulfil your order or booking (e.g., name, delivery address, contact number, appointment details);</li>
<li>Payment gateway and banking partners, to process payments and refunds;</li>
<li>Logistics and delivery partners, to fulfil deliveries;</li>
<li>Cloud hosting and IT service providers, under contractual confidentiality obligations;</li>
<li>Professional advisors (auditors, legal counsel) where necessary;</li>
<li>Government authorities, regulators, or law enforcement, where required by law, court order, or to protect the rights, property, or safety of the Company, our users, or the public; and</li>
<li>A successor entity, in the event of a merger, acquisition, or sale of business assets, subject to equivalent privacy protections.</li>
</ul>
<p>We do not sell your personal information to third parties for their independent marketing purposes.</p>
<p>Sellers and Service Professionals are independent data controllers/fiduciaries in respect of information you share directly with them beyond what is necessary for order fulfilment (e.g., if you communicate with a salon professional directly), and this Policy does not govern their independent use of your data. Please review their individual policies where available.</p>
</section>
<section id="section-6"><h2>6. Cross-Border Data Transfer</h2>
<p>Our servers and service providers may be located within or outside India. Where personal data is transferred outside India, we take reasonable steps to ensure it is protected in a manner consistent with this Policy and applicable law. As and when the Central Government notifies restricted jurisdictions under the DPDP Act, we will comply with such restrictions.</p>
</section>
<section id="section-7"><h2>7. Cookies and Tracking Technologies</h2>
<p>We use cookies, local storage, and similar technologies to operate the Platform, remember your preferences (e.g., cart, wishlist), authenticate sessions, and analyse usage. You can control cookies through your browser settings; disabling cookies may affect Platform functionality.</p>
</section>
<section id="section-8"><h2>8. Data Retention</h2>
<p>We retain personal information for as long as necessary to fulfil the purposes described in this Policy, including to comply with legal, accounting, tax, and regulatory retention requirements (for example, records relating to Schedule H/H1 medicine sales, GST records, and consumer-dispute records, which may require retention beyond account closure). Upon expiry of the applicable retention period, we securely delete or anonymise the data.</p>
</section>
<section id="section-9"><h2>9. Your Rights</h2>
<p>Subject to applicable law and its phased applicability, you have the right to:</p>
<ul>
<li>Access the personal information we hold about you;</li>
<li>Correct or update inaccurate or incomplete information;</li>
<li>Withdraw consent for processing (where consent is the basis for processing);</li>
<li>Request erasure of your personal information, subject to our legal retention obligations;</li>
<li>Nominate another individual to exercise your rights in the event of death or incapacity (once operative under the DPDP Act); and</li>
<li>Grievance redressal, as set out in Section 12 below.</li>
</ul>
<p>To exercise these rights, write to us at [privacy@myneedify.com]. We will respond within the timelines prescribed by applicable law.</p>
</section>
<section id="section-10"><h2>10. Children&#x27;s Information</h2>
<p>The Platform is not intended for individuals under 18 years of age, and we do not knowingly collect personal information from minors, except where a parent/guardian creates an order on a minor&#x27;s behalf. Job listings and service-professional registration are open only to individuals of legal working age under Indian law. If we become aware that we have inadvertently collected a minor&#x27;s data without appropriate consent, we will delete it promptly.</p>
</section>
<section id="section-11"><h2>11. Data Security</h2>
<p>We implement reasonable security practices and procedures, including encryption of sensitive data in transit (TLS/SSL), access controls, and secure storage, in line with the SPDI Rules and internationally recognised standards (e.g., ISO/IEC 27001-aligned practices) as applicable to our scale of operations. However, no method of transmission or storage is 100% secure, and we cannot guarantee absolute security.</p>
</section>
<section id="section-12"><h2>12. Grievance Officer</h2>
<p>In accordance with the Information Technology Act, 2000, the IT (Intermediary Guidelines) Rules, 2021, and the Consumer Protection (E-Commerce) Rules, 2020, the details of our Grievance Officer are:</p>
<p>Name: [Grievance Officer Name] Designation: Grievance Officer, My Needify Address: [Registered Office Address, Delhi] Email: [grievance@myneedify.com] Contact Number: [+91-XXXXXXXXXX] Working Hours: Monday–Friday, 9:00 AM – 6:00 PM IST</p>
<p>We will acknowledge complaints within 48 hours and endeavour to resolve them within one month from the date of receipt, as required under the E-Commerce Rules.</p>
</section>
<section id="section-13"><h2>13. Changes to This Policy</h2>
<p>We may update this Policy from time to time to reflect changes in law or our practices. The updated version will be posted on this page with a revised &quot;Last Updated&quot; date. Material changes will, where required, be notified to you via email or a Platform notice.</p>
</section>
<section id="section-14"><h2>14. Contact Us</h2>
<p>For any questions about this Privacy Policy, please contact: [Legal Entity Name], [Registered Address, Delhi, India] Email: [privacy@myneedify.com]</p>
</section>
        </main>
        <footer>&copy; <%= CurrentYear %> My Needify. All rights reserved.</footer>
    </form>
</body>
</html>
