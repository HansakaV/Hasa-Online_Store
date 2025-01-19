<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 1/18/2025
  Time: 10:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Market Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .content-section {
            display: none;
            margin-top: 80px;
        }
        .active-section {
            display: block;
        }
    </style>
</head>
<body>
<!-- Fixed Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">
            <i class="bi bi-shop me-2"></i>
            Hasa Online Store Admin Panel
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="customerSection">
                        <i class="bi bi-people-fill me-1"></i>
                        Customers
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="itemSection">
                        <i class="bi bi-box-seam-fill me-1"></i>
                        Items
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="orderSection">
                        <i class="bi bi-cart-fill me-1"></i>
                        Order History
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="index.jsp" data-section="logoutSection">
                        <i class="bi bi-box-arrow-right me-1"></i>
                        Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <!-- Customer Section -->
    <div id="customerSection" class="content-section active-section">
        <h2 class="mb-4">Customer Management</h2>
        <form id="customerForm" class="mb-4" action="CustomerController" method="post">
            <div class="row g-3">
                <div class="col-md-4">
                    <label for="customerId" class="form-label">Customer ID</label>
                    <input type="text" class="form-control" id="customerId" name="customerId" placeholder="Enter ID">
                </div>
                <div class="col-md-4">
                    <label for="customerName" class="form-label">Name</label>
                    <input type="text" class="form-control" id="customerName" name="customerName" placeholder="Enter Name">
                </div>
                <div class="col-md-4">
                    <label for="customerAddress" class="form-label">Address</label>
                    <input type="text" class="form-control" id="customerAddress" name="customerAddress" placeholder="Enter Address">
                </div>
            </div>
            <div class="mt-3">
                <button type="submit" class="btn btn-warning me-2" name="action" value="update">Block</button>
                <button type="submit" class="btn btn-danger" name="action" value="delete">Delete</button>
            </div>
        </form>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead class="table-dark">
                <tr>
                    <th>Customer ID</th>
                    <th>Name</th>
                    <th>Address</th>
                </tr>
                </thead>
                <tbody id="customerTableBody">
                <!-- Populate this dynamically -->
                <c:forEach var="customer" items="${customerList}">
                    <tr>
                        <td>${customer.customerId}</td>
                        <td>${customer.customerName}</td>
                        <td>${customer.customerAddress}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Item Section -->
    <div id="itemSection" class="content-section">
        <h2 class="mb-4">Item Management</h2>
        <form id="itemForm" action="ItemController" method="post" enctype="multipart/form-data">
            <div class="row g-4">
                <!-- Basic Information -->
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-header bg-primary bg-opacity-10">
                            <h5 class="card-title mb-0">Basic Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label for="itemName" class="form-label">Item Name*</label>
                                <input type="text" class="form-control" id="itemName" name="itemName" required>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="itemCategory" class="form-label">Category*</label>
                                    <select class="form-select" id="itemCategory" name="itemCategory" required>
                                        <option value="">Select Category</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="itemBrand" class="form-label">Brand*</label>
                                    <input type="text" class="form-control" id="itemBrand" name="itemBrand" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="itemDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="itemDescription" name="itemDescription" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Pricing and Stock -->
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-primary bg-opacity-10">
                                <h5 class="card-title mb-0">Pricing & Stock</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="itemPrice" class="form-label">Price (Rs.)*</label>
                                        <div class="input-group">
                                            <span class="input-group-text">Rs.</span>
                                            <input type="number" class="form-control" id="itemPrice"
                                                   name="itemPrice" step="0.01" value="${item.price}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="itemQty" class="form-label">Stock Quantity*</label>
                                        <input type="number" class="form-control" id="itemQty"
                                               name="itemQty" value="${item.quantity}" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="itemImage" class="form-label">Product Image</label>
                                    <div class="d-flex gap-3 align-items-center">
                                        <div class="image-preview border rounded p-2" style="width: 100px; height: 100px;">
                                            <img id="imagePreview"
                                                 src="${not empty item.imagePath ? item.imagePath : '/placeholder.jpg'}"
                                                 class="${empty item.imagePath ? 'd-none' : ''}"
                                                 alt="Product preview">
                                            <div id="uploadPlaceholder"
                                                 class="w-100 h-100 d-flex align-items-center justify-content-center text-muted ${not empty item.imagePath ? 'd-none' : ''}">
                                                <i class="bi bi-image fs-1"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <input type="file" class="form-control" id="itemImage"
                                                   name="itemImage" accept="image/*" onchange="previewImage(this)">
                                            <div class="form-text">Recommended size: 500x500px, Max size: 2MB</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4 d-flex gap-2">
                    <button type="submit" class="btn btn-primary" name="action" value="save"
                    ${not empty item.id ? 'disabled' : ''}>
                        <i class="bi bi-save me-2"></i>Save Item
                    </button>
                    <button type="submit" class="btn btn-warning" name="action" value="update"
                    ${empty item.id ? 'disabled' : ''}>
                        <i class="bi bi-pencil-square me-2"></i>Update
                    </button>
                    <button type="submit" class="btn btn-danger" name="action" value="delete"
                    ${empty item.id ? 'disabled' : ''}
                            onclick="return confirm('Are you sure you want to delete this item?');">
                        <i class="bi bi-trash me-2"></i>Delete
                    </button>
                    <button type="reset" class="btn btn-secondary ms-auto">
                        <i class="bi bi-arrow-counterclockwise me-2"></i>Reset
                    </button>
                </div>
            </form>
        </div>

    </div>

    <script>
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            const placeholder = document.getElementById('uploadPlaceholder');

            if (input.files && input.files[0]) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.classList.remove('d-none');
                    placeholder.classList.add('d-none');
                }

                reader.readAsDataURL(input.files[0]);
            } else {
                preview.classList.add('d-none');
                placeholder.classList.remove('d-none');
            }
        }

        // Form validation
        document.getElementById('itemForm').addEventListener('submit', function(event) {
            const fileInput = document.getElementById('itemImage');
            if (fileInput.files.length > 0) {
                const fileSize = fileInput.files[0].size / 1024 / 1024; // in MB
                if (fileSize > 2) {
                    alert('File size exceeds 2MB limit');
                    event.preventDefault();
                }
            }
        });
    </script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Get all navigation links
            const navLinks = document.querySelectorAll('.nav-link');

            // Add event listener to each navigation link
            navLinks.forEach(link => {
                link.addEventListener('click', function (event) {
                    event.preventDefault(); // Prevent default anchor behavior

                    // Get the target section from the data-section attribute
                    const targetSectionId = this.getAttribute('data-section');

                    // Hide all sections
                    const allSections = document.querySelectorAll('.content-section');
                    allSections.forEach(section => section.classList.remove('active-section'));

                    // Show the target section
                    const targetSection = document.getElementById(targetSectionId);
                    if (targetSection) {
                        targetSection.classList.add('active-section');
                    }
                });
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
