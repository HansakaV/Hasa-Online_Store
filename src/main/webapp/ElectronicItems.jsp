<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.hasaonlinestore.dto.ItemDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Item Display</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .item-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .item-card:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .item-image {
            height: 250px;
            object-fit: cover;
        }
    </style>
</head>
<body class="bg-light">
<div class="container-fluid py-4">
    <div class="row mb-3">
        <div class="col">
            <a href="index.jsp" class="btn btn-secondary">
                <i class="bi bi-arrow-left me-2"></i>Back to Home
            </a>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
            List<ItemDTO> datalist = (List<ItemDTO>) request.getAttribute("items");
            if (datalist == null) {
                response.sendRedirect("item-display");
                return;
            }

            if (!datalist.isEmpty()) {
                for (ItemDTO item : datalist) {
        %>
        <div class="col">
            <div class="card item-card h-100 shadow-sm">
                <img src="${pageContext.request.contextPath}<%=item.getImagePath()%>"
                     class="card-img-top item-image"
                     alt="<%=item.getItemName()%>">
                <div class="card-body">
                    <h5 class="card-title"><%=item.getItemName()%></h5>
                    <p class="card-text">
                        <strong>Brand:</strong> <%=item.getBrand()%><br>
                        <strong>Price:</strong> LKR <%=item.getUnitPrice()%><br>
                        <strong>Available:</strong> <%=item.getQtyOnHand()%>
                    </p>
                    <p class="text-muted small"><%=item.getDescription()%></p>
                </div>
                <div class="card-footer">
                    <button onclick="addToCart('<%=item.getItemCode()%>')"
                            class="btn btn-primary w-100">
                        Add to Cart
                    </button>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="col-12">
            <div class="alert alert-info text-center" role="alert">
                No items available at the moment.
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="./assets/js/jquery-3.7.1.min.js"></script>
<script>
    function addToCart(itemCode) {
        $.ajax({
            url: "new-add-cart",
            method: "POST",
            data: {
                itemCode: itemCode
            },
            success: function(response) {
                if (response.status === 'success') {
                    // Show success toast/alert
                    alert('Item added to cart successfully!', 'success');

                    // Optionally update cart count
/*
                    updateCartCount();
*/
                } else {
                    // Show error toast/alert
                    alert(response.message || 'Failed to add item to cart.', 'danger');
                }
            },
            error: function() {
                // Show error toast/alert
                alert('Failed to add item to cart.', 'danger');
                    }
        });


    }


</script>
</body>
</html>