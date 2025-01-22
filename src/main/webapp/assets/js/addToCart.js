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