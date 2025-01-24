package lk.ijse.hasaonlinestore.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import javax.sql.DataSource;
import java.io.*;
import java.sql.*;

@WebServlet(name = "itemSaveServlet", value = "/item-save")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 5,      // 5 MB
        maxRequestSize = 1024 * 1024 * 10   // 10 MB
)
public class itemSaveServlet extends HttpServlet {
    @Resource(name = "jdbc/Pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("itemName");
        String category = req.getParameter("itemCategory");
        String brand = req.getParameter("itemBrand");
        String description = req.getParameter("itemDescription");
        double price = Double.parseDouble(req.getParameter("itemPrice"));
        int qty = Integer.parseInt(req.getParameter("itemQty"));

        // Handle file upload
        Part filePart = req.getPart("itemImage");
        String fileName = getFileName(filePart);
        String uploadPath = getServletContext().getRealPath("/assets/images");
        String imagePath = "/assets/images/" + fileName;

        // Create upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Save file to server
        filePart.write(uploadPath + File.separator + fileName);

        try {
            Connection connection = dataSource.getConnection();
            String sql = "INSERT INTO item (item_name,category,description,unit_price,qty_on_hand,brand,image_path)VALUES (?,?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, category);
            statement.setString(3, description);
            statement.setDouble(4, price);
            statement.setInt(5, qty);
            statement.setString(6, brand);
            statement.setString(7, imagePath);
            int rowCount = statement.executeUpdate();
            if (rowCount > 0) {
                resp.sendRedirect("ItemManagement.jsp?message=Successfully Registered");
            } else {
                resp.sendRedirect("ItemManagement.jsp?error=Failed to Register");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("ItemManagement.jsp?error=Database Error: " + e.getMessage());
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}