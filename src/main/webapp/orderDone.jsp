<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .confirmation-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .success-icon {
            color: #28a745;
            font-size: 72px;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="confirmation-container text-center">
        <div class="success-icon">
            &#10004; <!-- Checkmark symbol -->
        </div>
        <h1 class="mb-4">Order Placed Successfully!</h1>

        <%
            // You can replace these with actual order details from your backend
            String orderNumber = "ORD-" + (int)(Math.random() * 100000);
            String estimatedDelivery = java.time.LocalDate.now().plusDays(5).toString();
        %>

        <div class="alert alert-success" role="alert">
            <p>Thank you for your purchase!</p>
            <p>Order Number: <strong><%= orderNumber %></strong></p>
            <p>Estimated Delivery: <strong><%= estimatedDelivery %></strong></p>
        </div>

        <div class="mt-4">
            <a href="index.jsp" class="btn btn-primary btn-lg">
                Continue Shopping
            </a>
            <a href="order-details.jsp" class="btn btn-outline-secondary btn-lg ms-3">
                View Order Details
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap JS (optional, but recommended for full functionality) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>