package lk.ijse.hasaonlinestore.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Read the JSON data from request
            BufferedReader reader = request.getReader();
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }

            // Parse JSON data
            JSONObject jsonData = new JSONObject(jsonBuilder.toString());

            // Get or create cart session
            HttpSession session = request.getSession();
            ArrayList<JSONObject> cart = (ArrayList<JSONObject>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }

            // Add item to cart
            cart.add(jsonData);

            // Send success response
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Product added to cart");
            out.print(jsonResponse.toString());

        } catch (Exception e) {
            // Send error response
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error adding to cart: " + e.getMessage());
            out.print(jsonResponse.toString());
        }
    }
}