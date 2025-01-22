
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Hasa Online Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<!-- Include your navigation bar here -->

<div class="container my-5">
    <h2>Checkout</h2>
    <div class="row">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-body">
                    <h3 class="card-title">Shipping Address</h3>
                    <form id="checkoutForm">
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Place Order</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h3 class="card-title">Order Summary</h3>
                    <div id="orderSummary">
                        <!-- Order summary will be populated by JavaScript -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="assets/js/jquery-3.7.1.min.js"></script>
<script>
    function displayOrderSummary() {
        // Retrieve cart items from localStorage
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

        // Debugging information
        console.log('Cart Items:', cartItems);

        // Reference to the summary container
        const summaryContainer = document.getElementById('orderSummary');

        // Check if cartItems is valid and has items
        if (!Array.isArray(cartItems) || cartItems.length === 0) {
            summaryContainer.innerHTML = '<p>Your cart is empty</p>';
            console.log('Cart is empty');
            return;
        }

        // Initialize variables
        let subtotal = 0;
        let html = '<ul class="list-unstyled">';

        // Generate HTML for each item
        cartItems.forEach(item => {
            const name = item.name;
            console.log('name',name)
            const price = parseFloat(item.price) || 0;
            const quantity = parseInt(item.quantity) || 0;
            console.log(price,quantity,'weda')
            const itemTotal = price * quantity;

            subtotal += itemTotal;
            console.log(subtotal,'sub')

            html += `
            <li class="mb-2 d-flex justify-content-between">
                <span>${name} x ${quantity}</span>
                <span>$${itemTotal.toFixed(2)}</span>
            </li>
        `;
        });

        // Add summary details
        const shipping = subtotal > 50 ? 0 : 10;
        const tax = subtotal * 0.1;
        const total = subtotal + shipping + tax;
        console.log(total,'total',subtotal,'subtotal',shipping,'shipping',tax,'tax')

        html += `
        <hr>
        <li class="d-flex justify-content-between">
            <span>Subtotal:</span>
            <span>$${subtotal.toFixed(2)}</span>
        </li>
        <li class="d-flex justify-content-between">
            <span>Shipping:</span>
            <span>$${shipping.toFixed(2)}</span>
        </li>
        <li class="d-flex justify-content-between">
            <span>Tax:</span>
            <span>$${tax.toFixed(2)}</span>
        </li>
        <li class="fw-bold d-flex justify-content-between">
            <span>Total:</span>
            <span>$${total.toFixed(2)}</span>
        </li>
    </ul>`;

        // Update the HTML in the container
        summaryContainer.innerHTML = html;
    }



    // Make sure to call this function when the page loads
    document.addEventListener('DOMContentLoaded', function() {
        displayOrderSummary();
        setupCheckoutForm();
    });
    function setupCheckoutForm() {
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const orderData = {
                fullName: document.getElementById('fullName').value,
                address: document.getElementById('address').value,
                phone: document.getElementById('phone').value,
                items: JSON.parse(localStorage.getItem('cartItems')) || []
            };

            submitOrder(orderData);
        });
    }

    function submitOrder(orderData) {
        fetch('process-order', {  // Note: changed URL to match servlet mapping
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(orderData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    Swal.fire({
                        title: 'Success!',
                        text: 'Your order has been placed successfully!',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        localStorage.removeItem('cartItems');
                        window.location.href = 'order-confirmation.jsp?orderId=' + data.orderId;
                    });
                } else {
                    Swal.fire({
                        title: 'Error!',
                        text: data.error || 'There was an error processing your order. Please try again.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            })
            .catch(error => {
                console.error('Error:', error);
                Swal.fire({
                    title: 'Error!',
                    text: 'There was an error processing your order. Please try again.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            });
    }


</script>

</body>
</html>