<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/hasaonlinestore";
    String dbUser = "root";
    String dbPassword = "Ijse@1234";

    // Read the JSON data from the request
    StringBuilder jsonBuilder = new StringBuilder();
    BufferedReader reader = request.getReader();
    String line;
    while ((line = reader.readLine()) != null) {
        jsonBuilder.append(line);
    }

    JSONObject jsonData = new JSONObject(jsonBuilder.toString());

    // Get the username from session
    String username = (String) session.getAttribute("username");

    Connection conn = null;
    PreparedStatement pstmt = null;
    JSONObject jsonResponse = new JSONObject(); // Renamed from 'response' to 'jsonResponse'

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        conn.setAutoCommit(false); // Start transaction

        // Insert into orders table
        String orderSQL = "INSERT INTO orders (user_id, shipping_address, total_amount) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(orderSQL, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, username);
        pstmt.setString(2, jsonData.getString("address"));

        // Calculate total amount
        JSONArray items = jsonData.getJSONArray("items");
        double totalAmount = 0;
        for (int i = 0; i < items.length(); i++) {
            JSONObject item = items.getJSONObject(i);
            totalAmount += item.getDouble("price") * item.getInt("quantity");
        }

        // Add shipping and tax
        double shipping = totalAmount > 50 ? 0 : 10;
        double tax = totalAmount * 0.1;
        totalAmount += shipping + tax;

        pstmt.setDouble(3, totalAmount);
        pstmt.executeUpdate();

        // Get the generated order ID
        ResultSet rs = pstmt.getGeneratedKeys();
        int orderId = 0;
        if (rs.next()) {
            orderId = rs.getInt(1);
        }

        // Insert order items
        String itemSQL = "INSERT INTO order_items (order_id, product_id, quantity, price_per_unit, subtotal) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(itemSQL);

        for (int i = 0; i < items.length(); i++) {
            JSONObject item = items.getJSONObject(i);
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, item.getInt("id"));
            pstmt.setInt(3, item.getInt("quantity"));
            pstmt.setDouble(4, item.getDouble("price"));
            pstmt.setDouble(5, item.getDouble("price") * item.getInt("quantity"));
            pstmt.executeUpdate();
        }

        conn.commit(); // Commit transaction

        jsonResponse.put("success", true);
        jsonResponse.put("orderId", orderId);

    } catch (Exception e) {
        if (conn != null) {
            try {
                conn.rollback(); // Rollback transaction on error
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        jsonResponse.put("success", false);
        jsonResponse.put("error", e.getMessage());
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
/*
    out.print(jsonResponse.toString());
*/
%>