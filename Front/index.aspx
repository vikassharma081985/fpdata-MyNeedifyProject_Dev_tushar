<%@ Page Title="MyNeedify | Everyday needs" Language="C#" MasterPageFile="~/Front/Home.master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="FaduPrice.Front.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<main class="mn-home" id="main-content">
<div class="mn-welcome"><span><i class="bi bi-geo-alt" aria-hidden="true"></i> Your neighbourhood marketplace</span><a href="#local-services">Discover local services &nearr;</a></div>

    <%--Remove this section and implement slider--%>
<section class="mn-hero-grid" aria-label="Discover MyNeedify">
<div class="mn-hero">
<div>
<p class="mn-eyebrow">YOUR EVERYDAY, MADE EASIER</p>
<h1>Everyday needs.<br />All in one place.</h1>
<p>Shop local finds, discover services<br />and make more time for what matters.</p>
<a class="mn-cta" href="#popular-products">Shop now &rarr;</a>
<small>Local discoveries. Everyday possibilities.</small>
</div>
<div class="mn-hero-art"><span class="mn-art-orbit" aria-hidden="true"></span><img src="../Images/System/products.png" alt="Everyday products from local shops" width="280" height="280" fetchpriority="high" /><span class="mn-art-label"><i class="bi bi-shop" aria-hidden="true"></i> A little more local.</span></div>
</div>
<aside class="mn-offer">
<p class="mn-eyebrow">CLOSE TO HOME</p>
<div class="mn-offer-icon"><i class="bi bi-basket2" aria-hidden="true"></i></div>
<h2>Daily essentials,<br />sorted.</h2>
<p>Explore groceries and everyday favourites.</p>
<a href="Search.aspx?Search=Grocery">Explore groceries &rarr;</a>
</aside>
</section>


<div class="mn-value-strip" aria-label="Explore the marketplace"><span><i class="bi bi-shop" aria-hidden="true"></i> Shop your neighbourhood</span><span><i class="bi bi-tools" aria-hidden="true"></i> Discover skilled professionals</span><span><i class="bi bi-bag-check" aria-hidden="true"></i> Everyday needs, together</span></div>
<section class="mn-section" id="categories">
<div class="mn-section-head">
<div>
<h2>What are you looking for?</h2>
<p>Explore products and services near you</p>
</div>
<button type="button" class="mn-text-button" data-mn-drawer>View all &rarr;</button>
</div>
<div class="mn-category-grid" id="mn-category-grid">
</div>
</section>
<%--<div class="mn-service-banner">
<i class="bi bi-tools" aria-hidden="true">
</i>
<div>
<strong>A helping hand, right around the corner.</strong>
<p>Find skilled people for your everyday needs.</p>
</div>
<a href="../Pages/Job.aspx">Find professionals &rarr;</a>
</div>--%>
<section class="mn-section">
<div class="mn-section-head">
<div>
<h2>Daily essentials</h2>
<p>The little things that keep your day going</p>
</div>
<a href="Search.aspx?Search=Grocery">View all &rarr;</a>
</div>
<div class="mn-quick-row" data-mn-group="essentials">
</div>
</section>
<section class="mn-section" id="popular-products" style="display:none;">
<div class="mn-section-head">
<h2>Popular products</h2>
<a href="Search.aspx?Search=Products">View all &rarr;</a>
</div>
<div class="mn-product-grid">
<asp:Repeater ID="rptWomenCollection" runat="server">
<ItemTemplate>
<article class="mn-product">
<a class="mn-product-image" href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
<img loading="lazy" decoding="async" width="240" height="200" onerror="this.onerror=null;this.src='../Images/System/products.png';" src='<%# "../Images/Items/" + HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ImageName"))) %>' alt='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ItemName"))) %>' />
</a>
<div class="mn-product-info">
<h3>
<a href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
<%#: Eval("ItemName") %>
</a>
</h3>
<p>Explore available options</p>
<div class="mn-product-action">
<div>
<strong>&#8377; <%#: Eval("OfferPrice") %>
</strong>
<del>&#8377; <%#: Eval("ItemPrice") %>
</del>
</div>
<a class="mn-add" href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>' aria-label='<%# "Choose options for " + HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ItemName"))) %>'>View options</a>
</div>
</div>
</article>
</ItemTemplate>
</asp:Repeater>
</div>
<div id="divWomenCollNoRecord" runat="server" class="mn-empty">More finds are on their way. Please check back soon.</div>
</section>
<section class="mn-section" id="more-products">
<div class="mn-section-head">
<h2>More to discover</h2>
<a href="front/Search.aspx?Search=Apparels">View all &rarr;</a>
</div>
<div class="mn-product-grid">
<asp:Repeater ID="rptMenCollection" runat="server">
<ItemTemplate>
<article class="mn-product">
<a class="mn-product-image" href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
<img loading="lazy" decoding="async" width="240" height="200" onerror="this.onerror=null;this.src='../Images/System/products.png';" src='<%# "../Images/Items/" + HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ImageName"))) %>' alt='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ItemName"))) %>' />
</a>
<div class="mn-product-info">
<h3>
<a href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
<%#: Eval("ItemName") %>
</a>
</h3>
<p>Explore available options</p>
<div class="mn-product-action">
<div>
<strong>&#8377; <%#: Eval("OfferPrice") %>
</strong>
<del>&#8377; <%#: Eval("ItemPrice") %>
</del>
</div>
<a class="mn-add" href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>' aria-label='<%# "Choose options for " + HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ItemName"))) %>'>View options</a>
</div>
</div>
</article>
</ItemTemplate>
</asp:Repeater>
</div>
<div id="divMenCollNoRecord" runat="server" class="mn-empty">More finds are on their way. Please check back soon.</div>
</section>
<section class="mn-section" id="electronics" style="display:none;">
<div class="mn-section-head">
<h2>Electronics &amp; appliances</h2>
<a href="Search.aspx?Search=Electronics">View all &rarr;</a>
</div>
<div class="mn-product-grid">
<asp:Repeater ID="rptElectronics" runat="server">
<ItemTemplate>
<article class="mn-product">
<a class="mn-product-image" href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
<img loading="lazy" decoding="async" width="240" height="200" onerror="this.onerror=null;this.src='../Images/System/products.png';" src='<%# "../Images/Items/" + HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ImageName"))) %>' alt='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ItemName"))) %>' />
</a>
<div class="mn-product-info">
<h3>
<a href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>'>
<%#: Eval("ItemName") %>
</a>
</h3>
<p>Explore available options</p>
<div class="mn-product-action">
<div>
<strong>&#8377; <%#: Eval("OfferPrice") %>
</strong>
<del>&#8377; <%#: Eval("ItemPrice") %>
</del>
</div>
<a class="mn-add" href='<%# "ItemDescription.aspx?ItemId=" + Eval("ItemId") %>' aria-label='<%# "Choose options for " + HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("ItemName"))) %>'>View options</a>
</div>
</div>
</article>
</ItemTemplate>
</asp:Repeater>
</div>
<div id="divElectronicsNoRecord" runat="server" class="mn-empty">More finds are on their way. Please check back soon.</div>
</section>
<section class="mn-section" id="local-services">
<div class="mn-section-head">
<div>
<h2>Local services</h2>
<p>Less on your to-do list. More time for you.</p>
</div>
<a href="../Pages/Job.aspx">View all &rarr;</a>
</div>
<div class="mn-quick-row" data-mn-group="services">
</div>
</section>
<section class="mn-section" style="display:none;">
<div class="mn-section-head">
<div>
<h2>Discover local</h2>
<p>Meet the people and places around you</p>
</div>
<a href="Search.aspx?Search=Local">View all &rarr;</a>
</div>
<div class="mn-quick-row" data-mn-group="local">
</div>
</section>
<section class="mn-business">
<div>
<p class="mn-eyebrow">GROW WITH MYNEEDIFY</p>
<h2>Your neighbourhood. Your next opportunity.</h2>
<p>Bring your business online, find work or stay on top of your day.</p>
</div>
<div>
<a href="../Pages/AddOrganization.aspx">Register your business &nearr;</a>
<a href="../Pages/RegistrationList.aspx">Find a job &nearr;</a>
<a href="../Pages/ExpenseManager.aspx">Manage daily expenses &nearr;</a>
<a href="indexShubh.aspx">Explore apparel collections &nearr;</a>
</div>
</section>
<asp:Repeater ID="rptSlider" runat="server" Visible="false">
<ItemTemplate>
</ItemTemplate>
</asp:Repeater>
<asp:Literal ID="litBullets" runat="server" Visible="false" />
</main>
</asp:Content>