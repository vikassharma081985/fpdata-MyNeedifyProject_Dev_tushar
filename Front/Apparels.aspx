<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Apparels.aspx.cs" Inherits="WSBillingMaster.Pages.Apparels" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Apparels Store</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body { background:#f5f5f5; }

        .carousel-item img{
            height:450px;
            object-fit:cover;
        }

        @media(max-width:768px){
            .carousel-item img{
                height:200px;
            }
        }

        .category-scroll{
            overflow-x:auto;
            white-space:nowrap;
        }
        .category-box{
            display:inline-block;
            width:130px;
            margin-right:15px;
            text-align:center;
            cursor:pointer;
        }
        .category-box img{
            width:100px;
            height:100px;
            border-radius:50%;
            object-fit:cover;
        }

        .category-box.active{
            border-bottom:3px solid #0d6efd;
        }

        .filter-sidebar{
            background:white;
            padding:20px;
            border-radius:10px;
        }

        .product-card{
            background:white;
            border-radius:10px;
            padding:15px;
            transition:0.3s;
            height:100%;
        }
        .product-card:hover{
            transform:translateY(-5px);
            box-shadow:0 4px 10px rgba(0,0,0,0.1);
        }
        .product-card img{
            height:220px;
            object-fit:cover;
        }

        @media(max-width:991px){
            .filter-sidebar{
                display:none;
            }
        }
    </style>
</head>
<body>

<form id="form1" runat="server">

<div class="container-fluid p-0">

    <!-- BANNER -->
    <div id="mainSlider" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://picsum.photos/1400/500?random=1" class="d-block w-100" />
            </div>
            <div class="carousel-item">
                <img src="https://picsum.photos/1400/500?random=2" class="d-block w-100" />
            </div>
        </div>
    </div>

    <!-- CATEGORIES -->
    <div class="container my-4">
        <h4>Shop by Category</h4>

        <div class="category-scroll">

            <div class="category-box" data-category="men">
                <img src="https://picsum.photos/200?random=4" />
                <p>Men</p>
            </div>

            <div class="category-box" data-category="women">
                <img src="https://picsum.photos/200?random=5" />
                <p>Women</p>
            </div>

            <div class="category-box" data-category="kids">
                <img src="https://picsum.photos/200?random=6" />
                <p>Kids</p>
            </div>

            <div class="category-box" data-category="footwear">
                <img src="https://picsum.photos/200?random=7" />
                <p>Footwear</p>
            </div>

        </div>
    </div>

    <!-- PRODUCTS SECTION -->
    <div class="container">
        <div class="row">

            <!-- FILTER -->
            <div class="col-lg-3">
                <div class="filter-sidebar">

                    <h5>Filters</h5>
                    <hr />

                    <h6>Price</h6>
                    <div class="form-check">
                        <input class="form-check-input price-filter" type="checkbox" value="500">
                        <label class="form-check-label">Under ₹500</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input price-filter" type="checkbox" value="1000">
                        <label class="form-check-label">Under ₹1000</label>
                    </div>

                    <hr />

                    <h6>Brand</h6>
                    <div class="form-check">
                        <input class="form-check-input brand-filter" type="checkbox" value="nike">
                        <label class="form-check-label">Nike</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input brand-filter" type="checkbox" value="adidas">
                        <label class="form-check-label">Adidas</label>
                    </div>

                </div>
            </div>

            <!-- PRODUCTS -->
            <div class="col-lg-9">
                <div class="row" id="productContainer">

                    <div class="col-md-4 mb-4 product-item" data-price="499" data-brand="nike" data-category="men">
                        <div class="product-card">
                            <img src="https://picsum.photos/300?random=9" class="img-fluid w-100" />
                            <h6 class="mt-2">Men T-Shirt</h6>
                            <p>₹499</p>
                        </div>
                    </div>

                    <div class="col-md-4 mb-4 product-item" data-price="999" data-brand="adidas" data-category="women">
                        <div class="product-card">
                            <img src="https://picsum.photos/300?random=10" class="img-fluid w-100" />
                            <h6 class="mt-2">Women Dress</h6>
                            <p>₹999</p>
                        </div>
                    </div>

                    <div class="col-md-4 mb-4 product-item" data-price="799" data-brand="nike" data-category="footwear">
                        <div class="product-card">
                            <img src="https://picsum.photos/300?random=11" class="img-fluid w-100" />
                            <h6 class="mt-2">Sports Shoes</h6>
                            <p>₹799</p>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>

</div>

<script>
    const priceFilters = document.querySelectorAll('.price-filter');
    const brandFilters = document.querySelectorAll('.brand-filter');
    const categoryBoxes = document.querySelectorAll('.category-box');
    const products = document.querySelectorAll('.product-item');

    let selectedCategory = null;

    function filterProducts(){

        let selectedPrices = Array.from(priceFilters)
            .filter(c=>c.checked)
            .map(c=>parseInt(c.value));

        let selectedBrands = Array.from(brandFilters)
            .filter(c=>c.checked)
            .map(c=>c.value);

        products.forEach(product=>{

            let price = parseInt(product.dataset.price);
            let brand = product.dataset.brand;
            let category = product.dataset.category;

            let priceMatch = selectedPrices.length === 0 || selectedPrices.some(p=>price<=p);
            let brandMatch = selectedBrands.length === 0 || selectedBrands.includes(brand);
            let categoryMatch = !selectedCategory || category === selectedCategory;

            if(priceMatch && brandMatch && categoryMatch){
                product.style.display='block';
            } else {
                product.style.display='none';
            }

        });
    }

    // Price & Brand filter
    priceFilters.forEach(c=>c.addEventListener('change',filterProducts));
    brandFilters.forEach(c=>c.addEventListener('change',filterProducts));

    // Category filter
    categoryBoxes.forEach(box=>{
        box.addEventListener('click',function(){

            categoryBoxes.forEach(b=>b.classList.remove('active'));

            if(selectedCategory === this.dataset.category){
                selectedCategory = null;
            } else {
                selectedCategory = this.dataset.category;
                this.classList.add('active');
            }

            filterProducts();
        });
    });
</script>

</form>
</body>
</html>