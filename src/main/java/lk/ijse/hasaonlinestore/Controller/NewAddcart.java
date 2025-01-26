package lk.ijse.hasaonlinestore.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.hasaonlinestore.dao.cartDAO;
import lk.ijse.hasaonlinestore.dto.ItemDTO;
import lk.ijse.hasaonlinestore.dto.cartDTO;
import org.json.JSONObject;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "NewAddcart", value = "/new-add-cart")
public class NewAddcart extends HttpServlet {
    @Resource(name = "jdbc/Pool")
    private DataSource dataSource;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("cart Load");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false); // false prevents creating a new session if it doesn't exist
            Integer userId = (Integer) session.getAttribute("userId");
            String username = (String) session.getAttribute("username");


        try {
            // Get parameters
            System.out.println("Try ekt awa");
            int itemCode = Integer.parseInt(request.getParameter("itemCode"));
            cartDTO cartItem = new cartDTO();

            for (ItemDTO itemDTO : getItemFromDatabase(itemCode)) {
                cartItem.setItemCode(itemDTO.getItemCode());
                cartItem.setUserId(username);
                cartItem.setQuantity(1);
                cartItem.setUnitPrice(itemDTO.getUnitPrice());

            }

            boolean added = saveToDatabase(cartItem);



            // Prepare JSON response
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", added ? "success" : "error");

            out.print(jsonResponse.toString());
        } catch (Exception e) {
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("status", "error");
            out.print(errorResponse.toString());
        }
    }

    private boolean saveToDatabase(cartDTO cartDTO) {
        System.out.println("save call");
        String sql = "INSERT INTO cart2 (item_code, user_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Set parameters from the CartDTO
            statement.setInt(1, cartDTO.getItemCode());
            statement.setString(2, cartDTO.getUserId());
            statement.setInt(3, cartDTO.getQuantity());
            statement.setDouble(4, cartDTO.getUnitPrice());

            // Execute the update and check if rows were affected
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Failed to save cart item to database", e);
        }
    }

    private List<ItemDTO> getItemFromDatabase(int itemCode) {
        System.out.println("get item call");
        List<ItemDTO> itemList = new ArrayList<>();
        String sql = "SELECT * FROM item WHERE item_code = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, itemCode);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    ItemDTO cartItem = new ItemDTO();
                    cartItem.setItemCode(resultSet.getInt("item_code"));
                    cartItem.setItemName(resultSet.getString("item_name"));
                    cartItem.setCategory(resultSet.getString("category"));
                    cartItem.setDescription(resultSet.getString("description"));
                    cartItem.setUnitPrice(resultSet.getDouble("unit_price"));
                    cartItem.setQtyOnHand(resultSet.getInt("qty_on_hand"));
                    cartItem.setBrand(resultSet.getString("brand"));
                    cartItem.setImagePath(resultSet.getString("image_path"));
                    itemList.add(cartItem);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching item from database", e);
        }

        return itemList;
    }
}

