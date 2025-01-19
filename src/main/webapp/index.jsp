<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasa Online Store</title>
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

        .carousel-item img {
            height: 400px;
            object-fit: cover;
        }

        .product-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            margin-bottom: 25px;
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .product-card img {
            border-radius: 10px;
            margin-bottom: 15px;
            height: 200px;
            object-fit: cover;
            width: 100%;
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

        .features-section {
            padding: 40px 0;
            background: white;
            margin: 40px 0;
        }

        .feature-box {
            text-align: center;
            padding: 20px;
        }

        .feature-box i {
            font-size: 2.5rem;
            color: var(--secondary-color);
            margin-bottom: 15px;
        }

        .categories-section {
            margin: 40px 0;
        }

        .category-card {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .category-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .category-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0,0,0,0.7);
            color: white;
            padding: 10px;
            text-align: center;
        }
        .nav-item {
            font-style: italic;
            font-weight: bolder;
        }

        .alert {
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#"><i class="fas fa-store me-2"></i>Hasa Online Store</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i>Home</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="productsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-box me-1"></i>Products
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="productsDropdown">
                        <li><a class="dropdown-item" href="product.jsp"><i class="fas fa-laptop me-2"></i>Electronics</a></li>
                        <li><a class="dropdown-item" href="fashion.jsp"><i class="fas fa-tshirt me-2"></i>Fashion</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-couch me-2"></i>Home & Living</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-spa me-2"></i>Beauty</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.jsp"><i class="fas fa-shopping-cart me-1"></i>Cart</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle me-1"></i>Account
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="login.jsp"><i class="fas fa-sign-in-alt me-2"></i>Login</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                    </ul>
                </li>
            </ul>
            <!-- Search Bar -->
            <form class="d-flex">
                <div class="input-group">
                    <input class="form-control" type="search" placeholder="Search products" aria-label="Search">
                    <button class="btn btn-outline-light" type="submit"><i class="fas fa-search"></i></button>
                </div>
            </form>
        </div>
    </div>
</nav>



<!-- Carousel/Slideshow -->
<div id="dealCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#dealCarousel" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#dealCarousel" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#dealCarousel" data-bs-slide-to="2"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 400">
                <g id="banner1">
                    <!-- Background -->
                    <rect width="1200" height="400" fill="#3498db"/>
                    <path d="M0 100 Q 300 0 600 200 T 1200 100 L 1200 400 L 0 400 Z" fill="#2980b9" opacity="0.7"/>

                    <!-- Decorative elements -->
                    <circle cx="100" cy="100" r="40" fill="#fff" opacity="0.2"/>
                    <circle cx="1100" cy="300" r="60" fill="#fff" opacity="0.2"/>

                    <!-- Text -->
                    <text x="600" y="150" text-anchor="middle" font-family="Arial" font-size="48" fill="white" font-weight="bold">SUMMER MEGA SALE</text>
                    <text x="600" y="220" text-anchor="middle" font-family="Arial" font-size="32" fill="white">Up to 50% OFF</text>
                </g>
            </svg>
        </div>
        <div class="carousel-item">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 400">
                <g id="banner2">
                    <!-- Background -->
                    <rect width="1200" height="400" fill="#2ecc71"/>
                    <path d="M0 300 Q 300 200 600 300 T 1200 200 L 1200 400 L 0 400 Z" fill="#27ae60" opacity="0.7"/>

                    <!-- Decorative elements -->
                    <rect x="100" y="50" width="60" height="60" fill="#fff" opacity="0.2" transform="rotate(45 130 80)"/>
                    <rect x="1000" y="250" width="80" height="80" fill="#fff" opacity="0.2" transform="rotate(45 1040 290)"/>

                    <!-- Text -->
                    <text x="600" y="150" text-anchor="middle" font-family="Arial" font-size="48" fill="white" font-weight="bold">NEW ARRIVALS</text>
                    <text x="600" y="220" text-anchor="middle" font-family="Arial" font-size="32" fill="white">Check Out Latest Products</text>
                </g>
            </svg>
        </div>
        <div class="carousel-item">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 400">
                <g id="banner3">
                    <!-- Background -->
                    <rect width="1200" height="400" fill="#e74c3c"/>
                    <path d="M0 200 Q 300 300 600 200 T 1200 300 L 1200 400 L 0 400 Z" fill="#c0392b" opacity="0.7"/>

                    <!-- Decorative elements -->
                    <polygon points="100,100 130,150 70,150" fill="#fff" opacity="0.2"/>
                    <polygon points="1100,250 1130,300 1070,300" fill="#fff" opacity="0.2"/>

                    <!-- Text -->
                    <text x="600" y="150" text-anchor="middle" font-family="Arial" font-size="48" fill="white" font-weight="bold">FLASH SALE</text>
                    <text x="600" y="220" text-anchor="middle" font-family="Arial" font-size="32" fill="white">24 Hours Only - Don't Miss Out!</text>
                </g>
            </svg>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#dealCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#dealCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>

<!-- Main Content -->
<div class="container">
    <!-- Features Section -->
    <div class="features-section">
        <div class="row">
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-shipping-fast"></i>
                    <h4>Free Shipping</h4>
                    <p>On orders over $50</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-undo"></i>
                    <h4>Easy Returns</h4>
                    <p>30-day return policy</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-headset"></i>
                    <h4>24/7 Support</h4>
                    <p>Always here to help</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Categories Section -->
    <div class="categories-section">
        <h2 class="text-center mb-4">Shop by Category</h2>
        <div class="row">
            <div class="col-md-3">
                <div class="category-card">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 150">
                        <rect width="300" height="150" fill="#e74c3c"/>
                        <text x="150" y="75" text-anchor="middle" font-family="Arial" font-size="24" fill="white">Electronics</text>

                    </svg>
                    <div class="category-overlay">
                        <h5>Electronics</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="category-card">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 150">
                        <rect width="300" height="150" fill="#8e44ad"/>

                        <!-- Dress -->
                        <path d="M150 20 L180 40 L170 120 L130 120 L120 40 Z" fill="#9b59b6"/>
                        <path d="M140 20 L160 20 L165 30 L135 30 Z" fill="#ecf0f1"/>

                    </svg>
                    <div class="category-overlay">
                        <h5>Fashion</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="category-card">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 150">
                        <rect width="300" height="150" fill="#3498db"/>
                        <circle cx="150" cy="75" r="50" fill="#2980b9"/>
                    </svg>
                    <div class="category-overlay">
                        <h5>Home & Living</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="category-card">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 150">
                        <rect width="300" height="150" fill="#2ecc71"/>
                        <path d="M150 20 L180 40 L170 120 L130 120 L120 40 Z" fill="#27ae60"/>
                    </svg>
                    <div class="category-overlay">
                        <h5>Beauty</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Featured Products -->
    <h2 class="text-center mb-4">Featured Products</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="product-card">
                <img src="./assets/images/trimmer.jpg" alt="Trimmer">
                <h5>Hair & Beard Trimmer</h5>
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <p class="text-muted mb-0">$99.99</p>
                    <span class="text-warning">★★★★☆</span>
                </div>
                <button class="btn btn-primary w-100">
                    <i class="fas fa-cart-plus me-2"></i>Add to Cart
                </button>
            </div>
        </div>
        <div class="col-md-4">
            <div class="product-card">
                <img src="./assets/images/jbl2.jpg" alt="JBL Handfree">
                <h5>JBL Handfree</h5>
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <p class="text-muted mb-0">$89.99</p>
                    <span class="text-warning">★★★★★</span>
                </div>
                <button class="btn btn-primary w-100"><i class="fas fa-cart-plus me-2"></i>Add to Cart</button>
            </div>
        </div>
        <div class="col-md-4">
            <div class="product-card">
                <img src="./assets/images/cool2.jpg" alt="Laptop Cooling Fan">
                <h5>Laptop Cooling Fan</h5>
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <p class="text-muted mb-0">$79.99</p>
                    <span class="text-warning">★★★★☆</span>
                </div>
                <button class="btn btn-primary w-100"><i class="fas fa-cart-plus me-2"></i>Add to Cart</button>
            </div>
        </div>
    </div>
</div>
<script>
    // Add this to your item.jsp
    function addToCart(productCard) {
        // Get product details from the card
        const product = {
            id: Date.now(), // Generate a unique ID for the item
            name: productCard.querySelector('h5').textContent,
            price: parseFloat(productCard.querySelector('.text-muted').textContent.replace('$', '')),
            image: productCard.querySelector('img').src,
            quantity: 1
        };

        // Get existing cart items from localStorage
        let cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

        // Check if item already exists in cart
        const existingItemIndex = cartItems.findIndex(item => item.name === product.name);

        if (existingItemIndex !== -1) {
            // If item exists, increment quantity
            cartItems[existingItemIndex].quantity += 1;
        } else {
            // If item doesn't exist, add it to cart
            cartItems.push(product);
        }

        // Save updated cart back to localStorage
        localStorage.setItem('cartItems', JSON.stringify(cartItems));

        // Show success message
        showNotification('Product added to cart successfully!');

        // Update cart count in the navigation
        updateCartCount();
    }

    function showNotification(message) {
        // Create notification element
        const notification = document.createElement('div');
        notification.className = 'alert alert-success position-fixed top-0 end-0 m-3';
        notification.style.zIndex = '1000';
        notification.textContent = message;

        // Add to document
        document.body.appendChild(notification);

        // Remove after 3 seconds
        setTimeout(() => {
            notification.remove();
        }, 3000);
    }

    function updateCartCount() {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        const totalItems = cartItems.reduce((sum, item) => sum + item.quantity, 0);

        // Update cart count in navigation if element exists
        const cartLink = document.querySelector('.nav-link i.fa-shopping-cart');
        if (cartLink) {
            // Create or update cart badge
            let badge = cartLink.nextElementSibling;
            if (!badge || !badge.classList.contains('badge')) {
                badge = document.createElement('span');
                badge.className = 'badge bg-danger ms-1';
                cartLink.parentNode.appendChild(badge);
            }
            badge.textContent = totalItems;

            // Hide badge if cart is empty
            badge.style.display = totalItems > 0 ? 'inline' : 'none';
        }
    }

    // Add this to your document ready function
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize cart count
        updateCartCount();

        // Add click event listeners to all "Add to Cart" buttons
        const addToCartButtons = document.querySelectorAll('.btn-primary');
        addToCartButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                const productCard = e.target.closest('.product-card');
                if (productCard) {
                    addToCart(productCard);
                }
            });
        });
    });
</script>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>