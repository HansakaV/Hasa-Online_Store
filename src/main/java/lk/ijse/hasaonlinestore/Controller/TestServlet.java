package lk.ijse.hasaonlinestore.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "TestServlet", value = "/test")
public class TestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = "Hasa";
        req.setAttribute("name", name);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/test.jsp");  // Note the leading slash
        dispatcher.forward(req, resp);
    }
}

