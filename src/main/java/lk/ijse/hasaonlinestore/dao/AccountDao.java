package lk.ijse.hasaonlinestore.dao;

import lk.ijse.hasaonlinestore.model.Account;
import jakarta.annotation.Resource;
import lk.ijse.hasaonlinestore.util.DataBaseUtil;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AccountDao {
    @Resource(name = "java:comp/env/jdbc/Pool")
    private   DataSource DataBaseUtil1;


    public boolean registerAccount(Account account) throws SQLException {
        String sql = "INSERT INTO accounts (name, address, phone_number, email, username, password) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DataBaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, account.getName());
            pstmt.setString(2, account.getAddress());
            pstmt.setString(3, account.getPhoneNumber());
            pstmt.setString(4, account.getEmail());
            pstmt.setString(5, account.getUsername());
            pstmt.setString(6, account.getPassword()); // In production, use password hashing

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM accounts WHERE username = ?";

        try (Connection conn = DataBaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Account login(String username, String password) throws SQLException {

        String sql = "SELECT * FROM accounts WHERE username = ? AND password = ?";

        try (Connection conn = DataBaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password); // In production, use password hashing

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Account account = new Account();
                account.setName(rs.getString("name"));
                account.setAddress(rs.getString("address"));
                account.setPhoneNumber(rs.getString("phone_number"));
                account.setEmail(rs.getString("email"));
                account.setUsername(rs.getString("username"));
                // Don't set the password for security
                return account;
            }
        }

        return null;
    }
    public String checkAdmin(String name,String pw) throws SQLException {
        String sql = "SELECT * FROM accounts WHERE username = ? AND password = ?";

        try (Connection conn = DataBaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name);
            pstmt.setString(2, pw); // In production, use password hashing

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                if (rs.getString("username").equals("admin") && rs.getString("password").equals("admin123")){
                    return "admin";
                }
            }
        }
        return null;

    }

    public void updateLastLogin(int userId) throws SQLException {
        String sql = "UPDATE accounts SET last_login = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = DataBaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        }
    }
}
