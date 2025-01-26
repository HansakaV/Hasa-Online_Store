<%@ page import="lk.ijse.hasaonlinestore.model.Account" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<%
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Market Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.min.css">

    <style>
        .content-section {
            margin-top: 80px;
        }
        .image-preview {
            width: 100px;
            height: 100px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
    </style>
</head>
<body>
<div class="container">
    <div id="itemSection" class="content-section">
        <h2 class="mb-4">Add New Item</h2>
        <form id="itemForm" action="item-save" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
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
                                <div class="invalid-feedback">Please enter an item name.</div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="itemCategory" class="form-label">Category*</label>
                                    <select class="form-select" id="itemCategory" name="itemCategory" required>
                                        <option value="">Select Category</option>
                                        <!-- Categories will be populated dynamically -->
                                    </select>
                                    <div class="invalid-feedback">Please select a category.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="itemBrand" class="form-label">Brand*</label>
                                    <input type="text" class="form-control" id="itemBrand" name="itemBrand" required>
                                    <div class="invalid-feedback">Please enter a brand name.</div>
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
                                        <input type="number" class="form-control" id="itemPrice" name="itemPrice"
                                               step="0.01" min="0" required>
                                        <div class="invalid-feedback">Please enter a valid price.</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="itemQty" class="form-label">Stock Quantity*</label>
                                    <input type="number" class="form-control" id="itemQty" name="itemQty"
                                           min="0" required>
                                    <div class="invalid-feedback">Please enter a valid quantity.</div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="itemImage" class="form-label">Product Image</label>
                                <div class="d-flex gap-3 align-items-center">
                                    <div class="image-preview border rounded p-2">
                                        <img id="imagePreview" src="#" alt="Product preview" style="display: none;">
                                        <div id="uploadPlaceholder" class="text-muted">
                                            <i class="bi bi-image fs-1"></i>
                                        </div>
                                    </div>
                                    <div class="flex-grow-1">
                                        <input type="file" class="form-control" id="itemImage" name="itemImage"
                                               accept="image/*" onchange="previewImage(this)">
                                        <div class="form-text">Recommended size: 500x500px, Max size: 2MB</div>
                                        <% System.out.println();%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-4 d-flex gap-2">
                <button type="submit" class="btn btn-primary" name="action" value="save" id="saveBtn">
                    <i class="bi bi-save me-2"></i>Save Item
                </button>
                <button type="submit" class="btn btn-warning" name="action" value="update" id="updateBtn">
                    <i class="bi bi-pencil-square me-2"></i>Update
                </button>
                <button type="submit" class="btn btn-danger" name="action" value="delete" id="deleteBtn">
                    <i class="bi bi-trash me-2"></i>Delete
                </button>
                <button type="reset" class="btn btn-secondary ms-auto" id="resetBtn">
                    <i class="bi bi-arrow-counterclockwise me-2"></i>Reset
                </button>
            </div>
        </form>
    </div>
</div>

<%--Alerts for success and error messages--%>
<script>
    document.addEventListener('DOMContentLoaded', function() { //dom ek load wenn oni
        <% if (message != null) { %>
        Swal.fire({
            title: "Item Saved Successfully!",
            icon: "success",
            draggable: true
        });
        <% } %>

        <% if (error != null) { %>
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "<%= request.getParameter("error").replace("\"", "\\\"") %>",
            confirmButtonColor: "#3085d6"
        });
        <% } %>
    });
</script>

<script>
    // Form validation
    (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');

        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();

    // Image preview functionality
    function previewImage(input) {
        const preview = document.getElementById('imagePreview');
        const placeholder = document.getElementById('uploadPlaceholder');
        const maxSize = 10 * 1024 * 1024; // 2MB in bytes

        if (input.files && input.files[0]) {
            if (input.files[0].size > maxSize) {
                Swal.fire({
                    icon: 'error',
                    title: 'File too large',
                    text: 'Please select an image less than 2MB'
                });
                input.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
                placeholder.style.display = 'none';
            }
            reader.readAsDataURL(input.files[0]);
        } else {
            preview.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }

    // Reset form handler
    document.getElementById('resetBtn').addEventListener('click', function() {
        const form = document.getElementById('itemForm');
        form.classList.remove('was-validated');
        document.getElementById('imagePreview').style.display = 'none';
        document.getElementById('uploadPlaceholder').style.display = 'block';
    });

    // Delete confirmation
    document.getElementById('deleteBtn').addEventListener('click', function(event) {
        event.preventDefault();
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('itemForm').submit();
            }
        });
    });
</script>

<script>
    // Category initialization
    const categories = [
        {
            id: 'electronic',
            name: 'Electronic Items',
        },
        {
            id: 'fashion',
            name: 'Fashion Items',
        },
        {
            id: 'beauty',
            name: 'Beauty Items',
        },
        {
            id: 'living',
            name: 'Living Items',
        }
    ];

    // Function to populate category select
    function populateCategories() {
        const categorySelect = document.getElementById('itemCategory');

        // Clear existing options except the first one
        while (categorySelect.options.length > 1) {
            categorySelect.remove(1);
        }

        // Add categories
        categories.forEach(category => {
            const optgroup = document.createElement('optgroup');
            optgroup.label = category.name;

            // Add main category
            const mainOption = document.createElement('option');
            mainOption.value = category.id;
            mainOption.textContent = category.name;
            optgroup.appendChild(mainOption);

            categorySelect.appendChild(optgroup);
        });
    }

    // Call the function when the page loads
    document.addEventListener('DOMContentLoaded', function() {
        populateCategories();
    });

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.all.min.js"></script>
</body>
</html>