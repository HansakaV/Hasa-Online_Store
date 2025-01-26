package lk.ijse.hasaonlinestore.dao;

import jakarta.annotation.Resource;

import javax.sql.DataSource;
import java.sql.*;

public class cartDAO {
    @Resource(name = "jdbc/Pool")
    private DataSource dataSource;

    public boolean addOrUpdateItem(String username, String itemCode) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            // Check if item exists in cart
            String checkSql = "SELECT quantity FROM cart WHERE username = ? AND item_code = ?";
            PreparedStatement checkStmt = connection.prepareStatement(checkSql);
            checkStmt.setString(1, username);
            checkStmt.setString(2, itemCode);

            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Update existing item
                int newQuantity = rs.getInt("quantity") + 1;
                String updateSql = "UPDATE cart SET quantity = ? WHERE username = ? AND item_code = ?";
                PreparedStatement updateStmt = connection.prepareStatement(updateSql);
                updateStmt.setInt(1, newQuantity);
                updateStmt.setString(2, username);
                updateStmt.setString(3, itemCode);
                return updateStmt.executeUpdate() > 0;
            } else {
                // Insert new item
                String insertSql = "INSERT INTO cart (username, item_code, quantity, image_path) " +
                        "SELECT ?, ?, 1, image_path FROM item WHERE item_code = ?";
                PreparedStatement insertStmt = connection.prepareStatement(insertSql);
                insertStmt.setString(1, username);
                insertStmt.setString(2, itemCode);
                insertStmt.setString(3, itemCode);
                return insertStmt.executeUpdate() > 0;
            }
        }
    }
}
