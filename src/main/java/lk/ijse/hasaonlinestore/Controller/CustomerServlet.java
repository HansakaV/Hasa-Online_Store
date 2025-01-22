package lk.ijse.hasaonlinestore.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.hasaonlinestore.model.Account;
import lk.ijse.hasaonlinestore.util.DataBaseUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomerServlet", value = "/customers")
public class CustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Account> customerList = new ArrayList<>();

        try {
            Connection connection = DataBaseUtil.getConnection();
            String sql = "SELECT * FROM accounts";
            ResultSet rst = connection.createStatement().executeQuery(sql);
            while (rst.next()) {
                Account customer = new Account(
                        rst.getString(1),
                        rst.getString(2),
                        rst.getString(3),
                        rst.getString(4),
                        rst.getString(5),
                        rst.getString(6)
                );
                customerList.add(customer);
                System.out.println(customerList+"blaaaaaaaa");
            }

            req.setAttribute("customers", customerList);
            String name = "Hasa";
            req.setAttribute("name", name); // Setting the attribute
            System.out.println("Name set in servlet: " + name); // Debugging

            RequestDispatcher dispatcher = req.getRequestDispatcher("customerManagement.jsp");
            dispatcher.forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("message", "Error fetching customers: " + e.getMessage());
            req.setAttribute("messageType", "error");
            RequestDispatcher dispatcher = req.getRequestDispatcher("customerManagement.jsp");
            dispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            String customerId = req.getParameter("customerId");
            try {
                Connection connection = DataBaseUtil.getConnection();
                String sql = "DELETE FROM accounts WHERE name = ?";
                var pstmt = connection.prepareStatement(sql);
                pstmt.setString(1, customerId);
                int result = pstmt.executeUpdate();

                if (result > 0) {
                    req.setAttribute("message", "Customer deleted successfully");
                    req.setAttribute("messageType", "success");
                } else {
                    req.setAttribute("message", "Customer not found");
                    req.setAttribute("messageType", "warning");
                }
            } catch (SQLException e) {
                req.setAttribute("message", "Error deleting customer: " + e.getMessage());
                req.setAttribute("messageType", "error");
            }
        }

        // Redirect back to the customer list
        doGet(req, resp);
    }
}