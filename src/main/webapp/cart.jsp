<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="lk.ijse.hasaonlinestore.dto.cartDTO" %>
<%@ page import="lk.ijse.hasaonlinestore.dto.ViewCartDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Hasa Online Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(to right, #2c3e50, #3498db)">
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
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp"><i class="fas fa-shopping-cart me-1"></i>Cart</a>
                    </li>
                    <li class="nav-item">
                        <%
                            String username = (String) session.getAttribute("username");
                            if (username != null) {
                        %>
                        <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
                        <%
                        } else {
                        %>
                        <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt me-1"></i>Login</a>
                        <%
                            }
                        %>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <style>
        /* Your existing styles remain the same */
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
        }

        .cart-item {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .cart-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .cart-item img {
            border-radius: 10px;
            max-width: 100px;
            height: 100px;
            object-fit: cover;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-btn {
            background: var(--secondary-color);
            color: white;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .quantity-btn:hover {
            background: var(--primary-color);
        }

        .cart-summary {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            position: sticky;
            top: 20px;
        }

        .empty-cart {
            text-align: center;
            padding: 50px 0;
        }

        .empty-cart i {
            font-size: 5rem;
            color: var(--secondary-color);
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container my-5">
    <h2 class="mb-4">Shopping Cart</h2>

    <%
        if (session.getAttribute("username") == null) {
    %>
    <div class="alert alert-warning" role="alert">
        Please <a href="login.jsp?redirect=cart.jsp" class="alert-link">login</a> to view your cart.
    </div>
    <%
    } else {
    %>
    <div class="row">
        <div class="col-lg-8">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                    <tr>
                        <th scope="col">Code</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Qty</th>
                        <th scope="col">unitPrice</th>
                        <th scope="col">Brand</th>
                        <th scope="col" class="text-center">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<ViewCartDTO> datalist = (List<ViewCartDTO>) request.getAttribute("cartList");
                        System.out.println("cart list ek  "+datalist);
                        if (datalist == null) {
                            response.sendRedirect("view-cart");
                            return;
                        }

                        String name = (String) request.getAttribute("name");
                        if (datalist != null && !datalist.isEmpty()) {
                            for (ViewCartDTO item : datalist) {
                    %>
                    <tr>
                        <td><%= item.getItemCode() %></td>
                        <td><%= item.getItemName() %></td>
                        <td><%= item.getCategory() %></td>
                        <td><%= item.getQtyOnHand() %></td>
                        <td><%= item.getUnitPrice() %></td>
                        <td><%= item.getBrand() %></td>
                        <td class="text-center">
                            <button class="btn btn-danger btn-sm"
                                    onclick="confirmDelete('<%= item.getItemCode() %>')"
                                    type="button">
                                <i class="bi bi-trash me-1"></i>
                                Delete
                            </button>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center">No Customers found</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cart-summary">
                <h4>Order Summary</h4>
                <hr>
                <%
                    double subtotal = 0;
                    double shippingCost = 350.00;
                    if (datalist != null && !datalist.isEmpty()) {
                        for (ViewCartDTO item : datalist) {
                            subtotal += item.getUnitPrice() * item.getQtyOnHand();
                        }
                    }
                    double total = subtotal + shippingCost;
                %>

                <div class="d-flex justify-content-between mb-2">
                    <span>Subtotal</span>
                    <span id="subtotal">LKR<%= String.format("%.2f", subtotal) %></span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>Shipping</span>
                    <span id="shipping">LKR 350.00</span>
                </div>
                <hr>
                <div class="d-flex justify-content-between mb-4">
                    <strong>Total</strong>
                    <strong id="total">$<%= String.format("%.2f", total) %></strong>
                </div>

                <form action="order-save" method="POST">
                    <input type="hidden" name="subtotal" value="<%= subtotal %>">
                    <input type="hidden" name="shipping" value="<%= shippingCost %>">
                    <input type="hidden" name="total" value="<%= total %>">

                    <button type="submit" class="btn btn-primary w-100">
                        Proceed to Checkout
                    </button>
                </form>

            </div>
        </div>

    <%
        }
    %>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        loadCart();
    });

    function loadCart() {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        const cartContainer = document.getElementById('cartItems');

        if (cartItems.length === 0) {
            cartContainer.innerHTML =
                '<div class="empty-cart">' +
                '<i class="fas fa-shopping-cart"></i>' +
                '<h3>Your cart is empty</h3>' +
                '<p>Browse our products and add items to your cart</p>' +
                '<a href="index.jsp" class="btn btn-primary mt-3">Continue Shopping</a>' +
                '</div>';
            updateCartSummary(0);
            return;
        }

        let cartHTML = '';
        cartItems.forEach(item => {
            const itemTotal = (item.price * item.quantity).toFixed(2);
            cartHTML +=
                '<div class="cart-item" data-id="' + item.id + '">' +
                '<div class="row align-items-center">' +
                '<div class="col-md-2">' +
                '<img src="' + item.image + '" alt="' + item.name + '" class="img-fluid">' +
                '</div>' +
                '<div class="col-md-4">' +
                '<h5>' + item.name + '</h5>' +
                '<p class="text-muted mb-0">$' + item.price + '</p>' +
                '</div>' +
                '<div class="col-md-3">' +
                '<div class="quantity-control">' +
                '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', -1)">-</button>' +
                '<span>' + item.quantity + '</span>' +
                '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', 1)">+</button>' +
                '</div>' +
                '</div>' +
                '<div class="col-md-2">' +
                '<p class="fw-bold">$' + itemTotal + '</p>' +
                '</div>' +
                '<div class="col-md-1">' +
                '<button class="btn btn-link text-danger" onclick="removeItem(' + item.id + ')">' +
                '<i class="fas fa-trash"></i>' +
                '</button>' +
                '</div>' +
                '</div>' +
                '</div>';
        });

        cartContainer.innerHTML = cartHTML;
        updateCartSummary(calculateTotal(cartItems));
    }

    // Rest of your JavaScript functions remain the same
    function updateQuantity(itemId, change) {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        const itemIndex = cartItems.findIndex(item => item.id === itemId);

        if (itemIndex !== -1) {
            cartItems[itemIndex].quantity += change;
            if (cartItems[itemIndex].quantity < 1) {
                cartItems.splice(itemIndex, 1);
            }
            localStorage.setItem('cartItems', JSON.stringify(cartItems));
            loadCart();
        }
    }

    function removeItem(itemId) {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        const updatedItems = cartItems.filter(item => item.id !== itemId);
        localStorage.setItem('cartItems', JSON.stringify(updatedItems));
        loadCart();
    }

    function calculateTotal(items) {
        return items.reduce((total, item) => total + (item.price * item.quantity), 0);
    }

    function updateCartSummary(subtotal) {
        const shipping = subtotal > 50 ? 0 : 10;
        const tax = subtotal * 0.1;
        const total = subtotal + shipping + tax;

        document.getElementById('subtotal').textContent = '$' + subtotal.toFixed(2);
        document.getElementById('shipping').textContent = '$' + shipping.toFixed(2);
        document.getElementById('tax').textContent = '$' + tax.toFixed(2);
        document.getElementById('total').textContent = '$' + total.toFixed(2);
    }

    function proceedToCheckout() {
        <% if (session.getAttribute("username") == null) { %>
        window.location.href = 'login.jsp?redirect=checkout.jsp';
        <% } else { %>
        window.location.href = 'checkout.jsp';
        <% } %>
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>