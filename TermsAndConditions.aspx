<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Globalization" %>
<script runat="server">
    // Optional Web.config appSettings entry:
    // <add key="TermsLastUpdated" value="2026-10-02" />
    // Change this value when the terms are revised; do not use today's date on every visit.
    protected DateTime TermsRevisionDate
    {
        get
        {
            DateTime revisionDate;
            string configuredDate = ConfigurationManager.AppSettings["TermsLastUpdated"];
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
    <meta name="description" content="Terms and Conditions governing the use of the My Needify marketplace and related services." />
    <title>Terms and Conditions | My Needify</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; background: #f5f7fb; color: #273244; font-family: Arial, Helvetica, sans-serif; font-size: 16px; line-height: 1.75; }
        .brand { background: #153653; color: #fff; padding: 20px 24px; }
        .brand div { max-width: 1040px; margin: auto; font-size: 22px; font-weight: 700; }
        main { max-width: 1040px; margin: 32px auto; padding: 36px 44px; background: #fff; border: 1px solid #e1e6ed; border-radius: 12px; }
        h1 { margin: 0 0 8px; color: #153653; font-size: 32px; line-height: 1.25; }
        .updated { color: #607086; margin: 0 0 26px; }
        h2 { color: #153653; font-size: 21px; line-height: 1.45; margin: 0 0 12px; }
        section { margin-top: 30px; padding-top: 24px; border-top: 1px solid #e7ebf0; scroll-margin-top: 20px; }
        p { margin: 0 0 14px; overflow-wrap: anywhere; }
        ul { padding-left: 24px; margin: 10px 0 18px; }
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
            <h1>Terms and Conditions</h1>
            <p class="updated">Last Updated: <time datetime="<%= TermsRevisionDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) %>"><%= TermsRevisionDate.ToString("dd MMMM yyyy", CultureInfo.GetCultureInfo("en-IN")) %></time></p>
<p>These Terms and Conditions (&quot;Terms&quot;) govern access to and use of www.myneedify.com, our mobile applications, and related services (the &quot;Platform&quot;), operated by [Legal Entity Name], a company incorporated in India with its registered office at [Registered Address, Delhi, India, PIN] (&quot;Company&quot;, &quot;My Needify&quot;, &quot;we&quot;, &quot;us&quot;). By accessing or using the Platform, you (&quot;User&quot;) agree to be bound by these Terms, our Privacy Policy, and any category-specific terms referenced herein. If you do not agree, do not use the Platform.</p>
<section id="section-1"><h2>1. Definitions</h2>
<ul>
<li>&quot;Platform&quot; means the My Needify website, apps, and associated services, functioning as a multi-category e-commerce marketplace and services aggregator.</li>
<li>&quot;Seller&quot; means a third party registered on the Platform to list and sell goods.</li>
<li>&quot;Service Professional&quot; means an independent individual or business registered on the Platform to offer services (e.g., salon, grooming, or other on-demand services) bookable by Users.</li>
<li>&quot;Buyer&quot;/&quot;User&quot; means any person browsing, registering on, or transacting through the Platform.</li>
<li>&quot;Listing&quot; means any product, service, or job posting made available on the Platform.</li>
</ul>
</section>
<section id="section-2"><h2>2. Nature of the Platform — Intermediary Disclosure</h2>
<p>My Needify is an online marketplace and aggregator. Except where expressly identified as sold or fulfilled directly by My Needify, we do not manufacture, own, stock, or provide the products and services listed on the Platform. We act as an &quot;intermediary&quot; as defined under Section 2(1)(w) of the Information Technology Act, 2000, and avail of the safe-harbour protections under Section 79 thereof, subject to compliance with the IT (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021.</p>
<ul>
<li>Products are sold by independent, third-party Sellers. The contract of sale is between the Buyer and the Seller.</li>
<li>Services (e.g., salon appointments) are rendered by independent Service Professionals, who are not employees or agents of My Needify. The contract for services is between the User and the Service Professional.</li>
<li>Job/Manpower listings are posted by independent employers/individuals for informational and matching purposes only; My Needify is not the employer, and is not a party to any employment or engagement arising from such listings.</li>
</ul>
<p>My Needify does not endorse, guarantee, or assume liability for the quality, safety, legality, or fitness for purpose of any product, service, or job listing offered by a third party through the Platform, except where mandated by law.</p>
</section>
<section id="section-3"><h2>3. Eligibility</h2>
<p>You must be at least 18 years of age and competent to contract under the Indian Contract Act, 1872, to register on or transact through the Platform. By using the Platform, you represent that you meet these requirements.</p>
</section>
<section id="section-4"><h2>4. Account Registration</h2>
<p>You are responsible for maintaining the confidentiality of your login credentials and for all activities under your account. You agree to notify us immediately of any unauthorised use. We reserve the right to suspend or terminate accounts that provide false, inaccurate, or fraudulent information, or that violate these Terms.</p>
</section>
<section id="section-5"><h2>5. Mandatory Disclosures (Consumer Protection (E-Commerce) Rules, 2020)</h2>
<p>In compliance with the Consumer Protection (E-Commerce) Rules, 2020, we disclose:</p>
<ul>
<li>Legal name and principal geographic address of the Platform operator: [Legal Entity Name], [Registered Address, Delhi, India];</li>
<li>Grievance Officer details: as set out in our Privacy Policy and Section 16 below;</li>
<li>For each Listing, Sellers are required to disclose: legal name of the Seller, principal geographic address, customer-care contact, GSTIN (where applicable), the country of origin of the goods, and details necessary for exercise of consumer rights (returns, refunds, exchange, warranty, and delivery/shipment).</li>
<li>We do not manipulate the ranking of Listings in a manner that is not based on fair and objective criteria, and any advertised or paid Listing is clearly identified as such.</li>
<li>We do not discriminate between Sellers of the same category in a manner inconsistent with our published policies.</li>
<li>All Sellers on the Platform are required, at the time of onboarding, to provide a self-declaration of compliance with all applicable laws for the goods/services they list.</li>
</ul>
</section>
<section id="section-6"><h2>6. Product Listings, Pricing, and Payment</h2>
<ul>
<li>Prices displayed are inclusive of applicable taxes (GST) unless stated otherwise, and are subject to change without prior notice until an order is confirmed.</li>
<li>Payments are processed through RBI-authorised, third-party payment gateway partners. My Needify does not store your complete card details.</li>
<li>In case of failed transactions where an amount has been debited, refunds (if applicable) will be processed to the original payment method within the timeline specified in our Refund Policy / as communicated at checkout.</li>
<li>My Needify reserves the right to cancel any order in case of pricing errors, unavailability of stock, or suspected fraud, with a full refund of any amount paid.</li>
</ul>
</section>
<section id="section-7"><h2>7. Cancellation, Return, and Refund Policy</h2>
<ul>
<li>Cancellation, return, and refund windows and conditions vary by product category and Seller and will be clearly displayed on the relevant product/order page at the time of purchase, in accordance with the Consumer Protection (E-Commerce) Rules, 2020.</li>
<li>Perishable goods (e.g., groceries, fruits &amp; vegetables) and, subject to Section 10 below, medicines, may be non-returnable once delivered, except in case of damaged, defective, or incorrect items, as further detailed in the category-specific policy.</li>
<li>Refunds, once approved, will be processed to the original mode of payment within the timeline specified at checkout (typically 5–10 business days, subject to bank/payment-partner processing times).</li>
</ul>
</section>
<section id="section-8"><h2>8. Service Bookings (Salon and Other On-Demand Services)</h2>
<ul>
<li>Service bookings made through the Platform are subject to the availability of the relevant Service Professional.</li>
<li>Cancellation or rescheduling of appointments is subject to the notice period displayed at the time of booking; late cancellations may attract a cancellation fee where disclosed.</li>
<li>My Needify facilitates the booking and payment for services but is not responsible for the manner, quality, or outcome of the service rendered, or for any injury, damage, or loss arising from the service, except to the extent such loss arises directly from our own negligence in facilitating the booking. Users are encouraged to raise any service-quality grievance through the Platform&#x27;s support channel, and we will make reasonable efforts to mediate with the Service Professional.</li>
<li>Service Professionals are independently responsible for holding any licences, certifications, or registrations required by law to render their services.</li>
</ul>
</section>
<section id="section-9"><h2>9. Job Postings and Manpower Requirements</h2>
<ul>
<li>The &quot;Looking for Job&quot; and &quot;Manpower Required&quot; sections are provided as an information-matching facility only. My Needify does not verify, and does not guarantee, the accuracy of job listings, the bona fides of employers, or the outcome of any application.</li>
<li>My Needify does not charge job seekers any fee for registration, applications, or &quot;guaranteed placement.&quot; Users should treat any request for payment by a purported employer or recruiter through the Platform as suspicious and report it immediately to our Grievance Officer.</li>
<li>Employers/job-posters are solely responsible for ensuring their listings comply with applicable labour, wage, and anti-discrimination laws, and do not seek unlawful fees from candidates.</li>
</ul>
</section>
<section id="section-10"><h2>10. Medicine Category — Special Terms</h2>
<p>Products listed under &quot;Medicine&quot; (tablets, syrups, medical devices) are subject to the following additional conditions:</p>
<ul>
<li>Prescription drugs (Schedule H, H1, and X, and any narcotic/psychotropic substance under the NDPS Act, 1985) will be dispensed only against a valid prescription issued by a Registered Medical Practitioner, verified by a Registered Pharmacist engaged by the relevant licensed Seller/fulfilment partner, in accordance with the Drugs and Cosmetics Act, 1940 and Drugs and Cosmetics Rules, 1945.</li>
<li>My Needify does not itself manufacture, stock, or dispense medicines. All medicine Listings are fulfilled by Sellers holding a valid drug licence issued by the competent State/Central Licensing Authority, whose licence details will be made available on request.</li>
<li>Regulatory notice: India does not, as of the date of these Terms, have a dedicated, finally notified regulatory framework exclusively for e-pharmacies; the online sale of medicines continues to be governed by the general provisions of the Drugs and Cosmetics Act, 1940/Rules, 1945, and is an area of ongoing regulatory and judicial development. My Needify will update this Category&#x27;s operating terms and, where required, suspend the Category, to remain compliant with any binding notification or court order.</li>
<li>My Needify does not provide medical advice. Users must consult a qualified physician before use of any medicine and must not rely on Platform content as a substitute for professional medical advice.</li>
</ul>
</section>
<section id="section-11"><h2>11. Seller Obligations</h2>
<p>Sellers registering on the Platform agree to:</p>
<ul>
<li>Provide accurate product descriptions, pricing, and legally mandated disclosures (including country of origin, expiry dates for perishables/medicines, and applicable warranties);</li>
<li>Hold all licences, registrations, and permissions required by law for the goods they sell (including, without limitation, FSSAI licences for food/grocery items and drug licences for medicines);</li>
<li>Comply with the Legal Metrology Act, 2009 and Consumer Protection Act, 2019 disclosure norms; and</li>
<li>Indemnify My Needify against any claim, penalty, or liability arising from their non-compliance with applicable law.</li>
</ul>
</section>
<section id="section-12"><h2>12. User Conduct</h2>
<p>You agree not to:</p>
<ul>
<li>Post false, misleading, defamatory, obscene, or unlawful content or reviews;</li>
<li>Use the Platform for any fraudulent, unlawful, or unauthorised purpose;</li>
<li>Attempt to reverse-engineer, scrape, or interfere with the Platform&#x27;s operation or security;</li>
<li>Impersonate any person or entity; or</li>
<li>Violate any applicable law, including but not limited to the IT Act, 2000, and Consumer Protection Act, 2019.</li>
</ul>
<p>We reserve the right to remove content and suspend or terminate accounts that violate this Section.</p>
</section>
<section id="section-13"><h2>13. Intellectual Property</h2>
<p>All trademarks, logos, content, and software on the Platform (excluding third-party Seller/Service Professional content) are owned by or licensed to My Needify and may not be used without prior written consent.</p>
</section>
<section id="section-14"><h2>14. Limitation of Liability</h2>
<p>To the maximum extent permitted by law, My Needify shall not be liable for any indirect, incidental, special, or consequential damages arising from use of the Platform, including but not limited to loss of profits, data, or goodwill, or from the acts/omissions of any Seller, Service Professional, employer, delivery partner, or other third party. Nothing in these Terms excludes or limits liability that cannot be excluded under the Consumer Protection Act, 2019, or any other mandatory applicable law.</p>
</section>
<section id="section-15"><h2>15. Governing Law and Dispute Resolution</h2>
<ul>
<li>These Terms are governed by the laws of India.</li>
<li>Subject to the mandatory jurisdiction of Consumer Disputes Redressal Commissions under the Consumer Protection Act, 2019 (which Users retain the right to approach and which cannot be excluded by agreement), any other dispute arising out of or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts at Delhi, India.</li>
<li>Where the parties agree, disputes may first be referred to arbitration under the Arbitration and Conciliation Act, 1996, seated in Delhi, conducted in English, before a sole arbitrator appointed by the Company.</li>
</ul>
</section>
<section id="section-16"><h2>16. Grievance Redressal</h2>
<p>In accordance with the Information Technology Act, 2000, the IT (Intermediary Guidelines) Rules, 2021, and the Consumer Protection (E-Commerce) Rules, 2020:</p>
<p>Grievance Officer: [Name] Address: [Registered Address, Delhi, India] Email: [grievance@myneedify.com] Phone: [+91-XXXXXXXXXX]</p>
<p>Complaints will be acknowledged within 48 hours and resolved within one month, as required by applicable law.</p>
</section>
<section id="section-17"><h2>17. Force Majeure</h2>
<p>My Needify shall not be liable for any failure or delay in performance due to causes beyond its reasonable control, including natural disasters, strikes, government action, internet or telecom failures, or pandemics.</p>
</section>
<section id="section-18"><h2>18. Amendment</h2>
<p>We may revise these Terms from time to time. Continued use of the Platform after changes take effect constitutes acceptance of the revised Terms.</p>
</section>
<section id="section-19"><h2>19. Severability</h2>
<p>If any provision of these Terms is held invalid or unenforceable, the remaining provisions shall continue in full force and effect.</p>
</section>
<section id="section-20"><h2>20. Contact</h2>
<p>[Legal Entity Name], [Registered Address, Delhi, India] Email: [support@myneedify.com]</p>
</section>
        </main>
        <footer>&copy; <%= CurrentYear %> My Needify. All rights reserved.</footer>
    </form>
</body>
</html>
