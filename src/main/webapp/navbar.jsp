<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 1/19/2025
  Time: 10:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>navbar</title>
    <style>
        .nav-item {
            font-style: italic;
            font-weight: bolder;
        }
        .navbar {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color)) !important;
            padding: 1rem 0;
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
                    <a class="nav-link" href="#"><i class="fas fa-shopping-cart me-1"></i>Cart</a>
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


</body>
</html>
