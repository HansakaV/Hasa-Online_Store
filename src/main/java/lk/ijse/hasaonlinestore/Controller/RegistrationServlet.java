package lk.ijse.hasaonlinestore.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.hasaonlinestore.dao.AccountDao;
import lk.ijse.hasaonlinestore.model.Account;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private AccountDao accountDAO = new AccountDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("tel");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input
        if (name == null || address == null || phoneNumber == null ||
                email == null || username == null || password == null ||
                name.trim().isEmpty() || address.trim().isEmpty() ||
                phoneNumber.trim().isEmpty() || email.trim().isEmpty() ||
                username.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if username exists
        if (accountDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create account object
        Account account = new Account(name, address, phoneNumber, email, username, password);

        // Attempt registration
        try {
            if (accountDAO.registerAccount(account)) {
                request.getSession().setAttribute("message", "Registration successful! Please login.");
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
