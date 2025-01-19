package lk.ijse.hasaonlinestore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/hasaonlinestore";
    private static final String USER = "root";
    private static final String PASSWORD = "Ijse@1234";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found", e);
        }
    }
}
