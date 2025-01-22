<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasa Online Store Admin Panel</title>
    <!-- Bootstrap CSS from CDN -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.1/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-shop me-2"></i>
            Hasa Online Store
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>

<div class="container py-4">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h1 class="card-title h3 mb-4">Admin Dashboard</h1>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="bi bi-people display-4 text-primary mb-3"></i>
                                    <h5 class="card-title">Customer Management</h5>
                                    <p class="card-text">Manage customer accounts and information</p>
                                    <a href="customerManagement.jsp" class="btn btn-primary">Access</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="bi bi-box-seam display-4 text-primary mb-3"></i>
                                    <h5 class="card-title">Item Management</h5>
                                    <p class="card-text">Manage products and inventory</p>
                                    <a href="ItemManagement.jsp" class="btn btn-primary">Access</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="bi bi-cart-check display-4 text-primary mb-3"></i>
                                    <h5 class="card-title">Order Management</h5>
                                    <p class="card-text">Track and manage customer orders</p>
                                    <a href="" class="btn btn-primary">Access</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-end">
                <button class="btn btn-danger">
                    <i class="bi bi-box-arrow-right me-2"></i>
                    Logout from Admin Panel
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>