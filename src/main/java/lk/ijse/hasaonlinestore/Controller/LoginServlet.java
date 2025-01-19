package lk.ijse.hasaonlinestore.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.hasaonlinestore.dao.AccountDao;
import lk.ijse.hasaonlinestore.model.Account;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AccountDao accountDAO = new AccountDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Validate input
        if (username == null || password == null ||
                username.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        try {
            Account account = accountDAO.login(username, password);

            if (account != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", account);
                session.setAttribute("username", account.getUsername());
                session.setAttribute("name", account.getName());

                // Handle remember me
                if ("on".equals(rememberMe)) {
                    session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
                } else {
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes
                }

                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }


}
