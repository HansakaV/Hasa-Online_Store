package lk.ijse.hasaonlinestore.Controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.hasaonlinestore.model.OrderItem;
import lk.ijse.hasaonlinestore.model.OrderRequest;
import lk.ijse.hasaonlinestore.util.DataBaseUtil;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/process-order")
public class OrderServlet extends HttpServlet {
    private static final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Read JSON data from request
        BufferedReader reader = request.getReader();
        OrderRequest orderRequest = gson.fromJson(reader, OrderRequest.class);

        // Get username from session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        JsonObject jsonResponse = new JsonObject();
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DataBaseUtil.getConnection();
            conn.setAutoCommit(false);

            // Insert into orders table
            String orderSQL = "INSERT INTO orders (user_id, shipping_address, total_amount) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(orderSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, username);
            pstmt.setString(2, orderRequest.getAddress());

            // Calculate total amount
            double totalAmount = calculateTotalAmount(orderRequest.getItems());
            pstmt.setDouble(3, totalAmount);
            pstmt.executeUpdate();

            // Get generated order ID
            ResultSet rs = pstmt.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Insert order items
            insertOrderItems(conn, orderId, orderRequest.getItems());

            conn.commit();

            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("orderId", orderId);

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", e.getMessage());
            e.printStackTrace();
        } finally {
            DataBaseUtil.closeResources(conn, pstmt, null);
        }

        response.getWriter().write(jsonResponse.toString());
    }

    private double calculateTotalAmount(OrderItem[] items) {
        double subtotal = 0;
        for (OrderItem item : items) {
            subtotal += item.getPrice() * item.getQuantity();
        }

        double shipping = subtotal > 50 ? 0 : 10;
        double tax = subtotal * 0.1;
        return subtotal + shipping + tax;
    }

    private void insertOrderItems(Connection conn, int orderId, OrderItem[] items)
            throws SQLException {
        String itemSQL = "INSERT INTO order_items (order_id, product_id, quantity, price_per_unit, subtotal) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(itemSQL)) {
            for (OrderItem item : items) {
                pstmt.setInt(1, orderId);
                pstmt.setInt(2, item.getId());
                pstmt.setInt(3, item.getQuantity());
                pstmt.setDouble(4, item.getPrice());
                pstmt.setDouble(5, item.getPrice() * item.getQuantity());
                pstmt.executeUpdate();
            }
        }
    }
}
