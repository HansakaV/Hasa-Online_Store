<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasa Online Store - Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }
        .background-wave {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.9);
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            margin-bottom: 15px;
        }
        .btn-primary {
            border-radius: 10px;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            transition: transform 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .toggle-forms {
            cursor: pointer;
            color: #667eea;
            text-decoration: underline;
        }
        .card-header {
            background: transparent;
            border-bottom: none;
            padding-bottom: 0;
        }
        .input-group-text {
            border-radius: 10px 0 0 10px;
            background: transparent;
        }
        .input-group .form-control {
            border-radius: 0 10px 10px 0;
            margin-bottom: 0;
        }
        .exit-button {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.9);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            z-index: 1000;
        }
        .exit-button:hover {
            transform: rotate(90deg);
            background: #ff4444;
            color: white;
        }
        .error-message {
            color: #dc3545;
            background-color: rgba(220, 53, 69, 0.1);
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .form-transition {
            transition: all 0.3s ease;
        }
        .form-container {
            position: relative;
            min-height: 400px;
        }
    </style>
</head>
<body>
<!-- Exit Button -->
<a href="index.jsp" class="exit-button">
    <i class="fas fa-times"></i>
</a>

<!-- Background Wave -->
<div class="background-wave">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
        <defs>
            <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" style="stop-color:#667eea;stop-opacity:0.2" />
                <stop offset="100%" style="stop-color:#764ba2;stop-opacity:0.1" />
            </linearGradient>
        </defs>
        <path fill="url(#gradient)" d="M0,64L48,80C96,96,192,128,288,128C384,128,480,96,576,90.7C672,85,768,107,864,128C960,149,1056,171,1152,165.3C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
        </path>
    </svg>
</div>

<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
        <div class="col-md-6">
            <div class="card">
                <div class="form-container">
                    <!-- Login Form -->
                    <div id="loginForm" class="form-transition">
                        <div class="card-header text-center pt-4">
                            <h4 class="mb-0">Welcome Back!</h4>
                            <p class="text-muted">Sign in to continue</p>
                        </div>
                        <div class="card-body">
                            <% if(request.getAttribute("error") != null) { %>
                            <div class="error-message">
                                <%= request.getAttribute("error") %>
                            </div>
                            <% } %>
                            <form action="login" method="post">
                                <div class="input-group mb-3">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" name="username" placeholder="Username" required>
                                </div>
                                <div class="input-group mb-4">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" name="password" placeholder="Password" required>
                                </div>
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="rememberMe">
                                    <label class="form-check-label" for="rememberMe">Remember me</label>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 mb-3">Login</button>
                                <p class="text-center mb-0">
                                    Don't have an account?
                                    <span class="toggle-forms" onclick="toggleForms()">Create Account</span>
                                </p>
                            </form>
                        </div>
                    </div>

                    <!-- Registration Form -->
                    <div id="registrationForm" class="form-transition" style="display: none;">
                        <div class="card-header text-center pt-4">
                            <h4 class="mb-0">Create Account</h4>
                            <p class="text-muted">Join Hasa Online Store</p>
                        </div>
                        <div class="card-body">
                            <form action="register" method="post" onsubmit="return validateForm()">
                                <div class="input-group mb-3">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" name="name" placeholder="Full Name" required>
                                </div>

                                <div class="input-group mb-3">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    <input type="email" class="form-control" name="email" placeholder="Email Address" required>
                                </div>

                                <div class="input-group mb-3">
                                    <span class="input-group-text"><i class="fas fa-user-circle"></i></span>
                                    <input type="text" class="form-control" name="username" placeholder="Username" required>
                                </div>

                                <div class="input-group mb-3">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                    <textarea class="form-control" name="address" placeholder="Address" required></textarea>
                                </div>

                                <div class="input-group mb-3">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                    <input type="tel" class="form-control" name="tel" placeholder="Phone Number" required>
                                </div>

                                <div class="input-group mb-3">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
                                </div>

                                <div class="input-group mb-4">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" required>
                                </div>

                                <button type="submit" class="btn btn-primary w-100 mb-3">Create Account</button>
                                <p class="text-center mb-0">
                                    Already have an account?
                                    <span class="toggle-forms" onclick="toggleForms()">Login</span>
                                </p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleForms() {
        const loginForm = document.getElementById('loginForm');
        const registrationForm = document.getElementById('registrationForm');

        if (loginForm.style.display === 'none') {
            registrationForm.style.display = 'none';
            loginForm.style.display = 'block';
        } else {
            loginForm.style.display = 'none';
            registrationForm.style.display = 'block';
        }
    }

    function validateForm() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;

        if (password !== confirmPassword) {
            alert("Passwords do not match!");
            return false;
        }

        if (password.length < 6) {
            alert("Password must be at least 6 characters long!");
            return false;
        }

        return true;
    }
</script>
</body>
</html>