package lk.ijse.hasaonlinestore.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/GetCartCountServlet")
public class GetCartCountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        ArrayList<JSONObject> cart = (ArrayList<JSONObject>) session.getAttribute("cart");

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("count", cart != null ? cart.size() : 0);

        out.print(jsonResponse.toString());
    }
}