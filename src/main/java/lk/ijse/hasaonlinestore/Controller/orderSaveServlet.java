package lk.ijse.hasaonlinestore.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.hasaonlinestore.dto.ItemDTO;
import lk.ijse.hasaonlinestore.dto.OrderDTO;
import lk.ijse.hasaonlinestore.dto.cartDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "orderSaveServlet", value = "/order-save")
public class orderSaveServlet extends HttpServlet {
    @Resource(name = "jdbc/Pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String subtotalParam = request.getParameter("subtotal");
        String shippingParam = request.getParameter("shipping");
        String totalParam = request.getParameter("total");

        HttpSession session = request.getSession(false); // false prevents creating a new session if it doesn't exist
        String username = (String) session.getAttribute("username");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Get cart details for the user
            List<cartDTO> cartItems = getCartDetails(username);

            // Establish database connection
            connection = dataSource.getConnection();
            connection.setAutoCommit(false); // Start transaction

            // Prepare SQL statement
            String sql = "INSERT INTO orders1 (userId, itemCode, qty, unitPrice, subtotal, shipping, total) VALUES (?, ?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);

            // Process each cart item
            for (cartDTO cart : cartItems) {
                statement.setString(1, username);
                statement.setInt(2, cart.getItemCode());
                statement.setInt(3, cart.getQuantity());
                statement.setDouble(4, cart.getUnitPrice());
                statement.setDouble(5, Double.parseDouble(subtotalParam));
                statement.setDouble(6, Double.parseDouble(shippingParam));
                statement.setDouble(7, Double.parseDouble(totalParam));

                statement.addBatch(); // Add to batch for efficient insertion
            }

            // Execute batch insert
            statement.executeBatch();
            connection.commit(); // Commit transaction

        } catch (SQLException e) {
            // Rollback transaction in case of error
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    // Log rollback error
                    Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Rollback failed", rollbackEx);
                }
            }
            // Log and handle the original exception
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Order insertion failed", e);
            throw new RuntimeException("Failed to save orders", e);

        } finally {
            // Properly close resources
            try {
                if (statement != null) statement.close();
                if (connection != null) {
                    connection.setAutoCommit(true); // Reset to default
                    connection.close();
                }
                response.sendRedirect("orderDone.jsp");

            } catch (SQLException e) {
                Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Resource closing failed", e);
            }
        }

    }
    private List<cartDTO> getCartDetails(String user){
        List<cartDTO> cartItems = new ArrayList<>();

        try {
            Connection connection = dataSource.getConnection();
            String sql = "Select * from cart2 where user_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user);
            statement.execute();
            ResultSet resultSet = statement.getResultSet();
            while (resultSet.next()) {
                cartDTO cart = new cartDTO();
                cart.setItemCode(resultSet.getInt("item_code"));
                cart.setUserId(resultSet.getString("user_id"));
                cart.setQuantity(resultSet.getInt("quantity"));
                cart.setUnitPrice(resultSet.getDouble("unit_price"));

                cartItems.add(cart);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cartItems;
    }
}
