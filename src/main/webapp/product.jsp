<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details - Hasa Online Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color)) !important;
            padding: 1rem 0;
        }

        .product-container {
            margin: 50px auto;
            padding: 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .product-image {
            border-radius: 15px;
            overflow: hidden;
        }

        .product-title {
            color: var(--primary-color);
        }

        .btn-primary {
            background: var(--secondary-color);
            border: none;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: var(--primary-color);
            transform: scale(1.05);
        }

        .product-price {
            font-size: 1.5rem;
            color: var(--secondary-color);
            font-weight: bold;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#"><i class="fas fa-store me-2"></i>Hasa Online Store - Electronic Items</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i>Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-box me-1"></i>Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-shopping-cart me-1"></i>Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-user me-1"></i>Login</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Product Details Section -->
<div class="container product-container">
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-6">
            <div class="product-image">
                <img src="./assets/images/trimmer.jpg" alt="Product Image" class="img-fluid">
            </div>
        </div>
        <!-- Product Details -->
        <div class="col-md-6">
            <h2 class="product-title">Hair & Beard Trimmer</h2>
            <p class="text-muted">Brand: XYZ</p>
            <p class="product-price">$99.99</p>
            <p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in mi eros. Integer id suscipit eros.</p>
            <div class="d-flex align-items-center mb-3">
                <span class="text-warning me-2">★★★★☆</span>
                <p class="mb-0">(120 reviews)</p>
            </div>
            <div class="d-flex">
                <button class="btn btn-primary me-3"><i class="fas fa-cart-plus me-2"></i>Add to Cart</button>
                <button class="btn btn-outline-secondary"><i class="fas fa-heart me-2"></i>Add to Wishlist</button>
            </div>
        </div>
    </div>
</div>

<!-- Product Details Section -->
<div class="container product-container">
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-6">
            <div class="product-image">
                <img src="./assets/images/cool2.jpg" alt="Product Image" class="img-fluid">
            </div>
        </div>
        <!-- Product Details -->
        <div class="col-md-6">
            <h2 class="product-title">Laptop Cooling Fan</h2>
            <p class="text-muted">Brand: Cooler Master</p>
            <p class="product-price">$99.99</p>
            <p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in mi eros. Integer id suscipit eros.</p>
            <div class="d-flex align-items-center mb-3">
                <span class="text-warning me-2">★★★★☆</span>
                <p class="mb-0">(120 reviews)</p>
            </div>
            <div class="d-flex">
                <button class="btn btn-primary me-3"><i class="fas fa-cart-plus me-2"></i>Add to Cart</button>
                <button class="btn btn-outline-secondary"><i class="fas fa-heart me-2"></i>Add to Wishlist</button>
            </div>
        </div>
    </div>
</div>

<!-- Product Details Section -->
<div class="container product-container">
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-6">
            <div class="product-image">
                <img src="./assets/images/jbl2.jpg" alt="Product Image" class="img-fluid">
            </div>
        </div>
        <!-- Product Details -->
        <div class="col-md-6">
            <h2 class="product-title">JBL Sounds</h2>
            <p class="text-muted">Brand: XYZ</p>
            <p class="product-price">$99.99</p>
            <p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in mi eros. Integer id suscipit eros.</p>
            <div class="d-flex align-items-center mb-3">
                <span class="text-warning me-2">★★★★☆</span>
                <p class="mb-0">(120 reviews)</p>
            </div>
            <div class="d-flex">
                <button class="btn btn-primary me-3"><i class="fas fa-cart-plus me-2"></i>Add to Cart</button>
                <button class="btn btn-outline-secondary"><i class="fas fa-heart me-2"></i>Add to Wishlist</button>
            </div>
        </div>
    </div>
</div>

<!-- Product Details Section -->
<div class="container product-container">
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-6">
            <div class="product-image">
                <img src="./assets/images/speaker.jpg" alt="Product Image" class="img-fluid">
            </div>
        </div>
        <!-- Product Details -->
        <div class="col-md-6">
            <h2 class="product-title">Computer Sound System</h2>
            <p class="text-muted">Brand: XYZ</p>
            <p class="product-price">$99.99</p>
            <p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in mi eros. Integer id suscipit eros.</p>
            <div class="d-flex align-items-center mb-3">
                <span class="text-warning me-2">★★★★☆</span>
                <p class="mb-0">(120 reviews)</p>
            </div>
            <div class="d-flex">
                <button class="btn btn-primary me-3"><i class="fas fa-cart-plus me-2"></i>Add to Cart</button>
                <button class="btn btn-outline-secondary"><i class="fas fa-heart me-2"></i>Add to Wishlist</button>
            </div>
        </div>
    </div>
</div>



<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
