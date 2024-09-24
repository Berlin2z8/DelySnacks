package com.delysnacks.servlet;

import com.delysnacks.dao.ProductoDAO;
import com.delysnacks.model.Producto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CarritoServlet")
public class CarritoServlet extends HttpServlet {
    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                Producto producto = productoDAO.obtenerPorId(productId);
                if (producto != null) {
                    carrito.add(producto);
                    session.setAttribute("carrito", carrito);
                    response.getWriter().write("{\"success\": true, \"cartCount\": " + carrito.size() + "}");
                } else {
                    response.getWriter().write("{\"success\": false, \"message\": \"Producto no encontrado\"}");
                }
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Acción no válida\"}");
            }
        } catch (SQLException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        request.setAttribute("carrito", carrito);
        request.getRequestDispatcher("/carrito.jsp").forward(request, response);
    }
}