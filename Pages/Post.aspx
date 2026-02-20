<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Community Post</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    background:#f5f7fb;
    font-family:'Segoe UI',sans-serif;
}
.card{border-radius:14px;border:none;}
.shadow-soft{box-shadow:0 2px 10px rgba(0,0,0,0.05);}

.category-wrapper{
    display:flex;
    gap:15px;
    overflow-x:auto;
    padding-bottom:10px;
}
.category-card{
    min-width:200px;
    border-radius:12px;
    padding:12px 18px;
    background:#fff;
    border:1px solid #eee;
    cursor:pointer;
    transition:.2s;
    white-space:nowrap;
}
.category-card.active{
    background:#e8f0ff;
    border-color:#0d6efd;
}
.category-card:hover{background:#f0f4ff;}

.post-card{
    border-radius:14px;
    background:#fff;
    padding:16px;
}
.profile-img{
    width:40px;height:40px;border-radius:50%;
}
.badge-pill{border-radius:50px;}
.submit-btn{
    background:#17a34a;border:none;
}
.submit-btn:hover{background:#14843c;}
.urgent-badge{
    background:#dc3545;
}
.small-muted{
    font-size:13px;color:#777;
}
.hidden{display:none;}
</style>
</head>

<body>

<div class="container py-4">

<div class="card shadow-soft p-3 mb-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0">
            <i class="bi bi-plus-square"></i> Create a New Post
        </h5>
    </div>

    <form id="postForm">
        <div class="row g-3">

            <div class="col-md-6">
                <input type="text" id="name" class="form-control" placeholder="Enter your full name" required>
            </div>

            <div class="col-md-6">
                <select id="category" class="form-select" required>
                    <option value="">Select Category</option>
                    <option>Job Required</option>
                    <option>For Sale</option>
                    <option>Rent/PG</option>
                    <option>Services</option>
                    <option>Others</option>
                </select>
            </div>

            <div class="col-12">
                <textarea id="description" class="form-control" rows="2"
                placeholder="Write your post..." required></textarea>
            </div>

            <div class="col-md-4">
                <input type="text" id="location" class="form-control" placeholder="Location">
            </div>

            <div class="col-md-4">
                <input type="tel" id="contact" class="form-control" placeholder="Contact Number">
            </div>

            <div class="col-md-4">
                <input type="file" id="image" class="form-control" accept="image/*">
            </div>

            <div class="col-12 d-flex justify-content-between align-items-center">
                <div>
                    <input type="checkbox" id="urgent">
                    <label class="text-danger fw-bold">Urgent</label>
                </div>

                <button class="btn submit-btn text-white px-4">
                    Submit Post
                </button>
            </div>

        </div>
    </form>
</div>

<h6 class="fw-bold mb-3">Browse Categories</h6>

<div class="category-wrapper mb-4" id="categoryContainer"></div>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h6 class="fw-bold mb-0">Latest Posts</h6>

    <select id="locationFilter" class="form-select form-select-sm w-auto">
        <option value="All">All Locations</option>
    </select>
</div>

<div id="postContainer"></div>

</div>

<script>

    let posts = JSON.parse(localStorage.getItem("posts")) || [];
    let activeCategory = "All";

    function savePosts() {
        localStorage.setItem("posts", JSON.stringify(posts));
    }

    function renderCategories() {
        const categories = ["All", "Job Required", "For Sale", "Rent/PG", "Services", "Others"];
        const container = document.getElementById("categoryContainer");
        container.innerHTML = "";

        categories.forEach(cat => {
            const count = cat === "All" ? posts.length :
                posts.filter(p => p.category === cat).length;

            container.innerHTML += `
        <div class="category-card ${activeCategory === cat ? 'active' : ''}"
             onclick="filterCategory('${cat}')">
            <strong>${cat}</strong><br>
            <small class="small-muted">${count} Posts</small>
        </div>`;
        });
    }

    function filterCategory(cat) {
        activeCategory = cat;
        renderCategories();
        renderPosts();
    }

    function renderLocationFilter() {
        const select = document.getElementById("locationFilter");
        const locations = [...new Set(posts.map(p => p.location).filter(Boolean))];
        select.innerHTML = `<option value="All">All Locations</option>`;
        locations.forEach(loc => {
            select.innerHTML += `<option value="${loc}">${loc}</option>`;
        });
    }

    function renderPosts() {
        const container = document.getElementById("postContainer");
        container.innerHTML = "";
        const locationValue = document.getElementById("locationFilter").value;

        posts
            .filter(p => (activeCategory === "All" || p.category === activeCategory))
            .filter(p => (locationValue === "All" || p.location === locationValue))
            .sort((a, b) => b.id - a.id)
            .forEach(p => {
                container.innerHTML += `
        <div class="post-card shadow-soft mb-3">
            <div class="d-flex justify-content-between">
                <div>
                    <strong>${p.name}</strong><br>
                    <small class="small-muted">${p.time}</small>
                </div>
            </div>

            <div class="mt-2">
                <span class="badge bg-primary badge-pill">${p.category}</span>
                ${p.urgent ? '<span class="badge urgent-badge ms-2">URGENT</span>' : ''}
            </div>

            <p class="mt-2">${p.description}</p>

            ${p.image ? `<img src="${p.image}" class="img-fluid rounded mb-2">` : ''}

            <div class="d-flex justify-content-between align-items-center">
                <div class="small-muted">
                    <i class="bi bi-geo-alt text-danger"></i>
                    ${p.location || ''}
                </div>

                <div class="d-flex gap-2">
                    <button class="btn btn-outline-primary btn-sm"
                        onclick="toggleContact(${p.id})">
                        <i class="bi bi-telephone"></i> Contact
                    </button>

                    <button class="btn btn-outline-secondary btn-sm"
                        onclick="reply(${p.id})">
                        <i class="bi bi-chat"></i> ${p.replies} Replies
                    </button>
                </div>
            </div>

            <div id="contact-${p.id}" class="hidden mt-2 text-success">
                📞 ${p.contact}
            </div>
        </div>`;
            });
    }

    function toggleContact(id) {
        const div = document.getElementById("contact-" + id);
        div.classList.toggle("hidden");
    }

    function reply(id) {
        const post = posts.find(p => p.id === id);
        post.replies++;
        savePosts();
        renderPosts();
    }

    document.getElementById("postForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const file = document.getElementById("image").files[0];
        const reader = new FileReader();

        reader.onload = function () {
            const newPost = {
                id: Date.now(),
                name: name.value,
                category: category.value,
                description: description.value,
                location: location.value,
                contact: contact.value,
                urgent: urgent.checked,
                image: file ? reader.result : null,
                replies: 0,
                time: new Date().toLocaleString()
            };

            posts.push(newPost);
            savePosts();
            renderCategories();
            renderLocationFilter();
            renderPosts();
            postForm.reset();
        };

        if (file) reader.readAsDataURL(file);
        else reader.onload();
    });

    document.getElementById("locationFilter").addEventListener("change", renderPosts);

    renderCategories();
    renderLocationFilter();
    renderPosts();

</script>

</body>
</html>
