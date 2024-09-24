package com.delysnacks.servlet;

import com.delysnacks.dao.ProductoDAO;
import com.delysnacks.model.Producto;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/AdminProductosServlet")
@MultipartConfig
public class AdminProductosServlet extends HttpServlet {
    private ProductoDAO productoDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        productoDAO = new ProductoDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            if ("getAll".equals(action)) {
                List<Producto> productos = productoDAO.obtenerTodos();
                jsonResponse.put("success", true);
                jsonResponse.put("productos", productos);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Acción no válida");
            }
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", e.getMessage());
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(jsonResponse));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            if ("add".equals(action)) {
                Producto producto = new Producto();
                producto.setNombre(request.getParameter("nombre"));
                producto.setDescripcion(request.getParameter("descripcion"));
                producto.setPrecio(new BigDecimal(request.getParameter("precio")));

                Part filePart = request.getPart("imagen");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }
                    filePart.write(uploadPath + File.separator + fileName);
                    producto.setImagen("images/" + fileName);
                }

                productoDAO.agregarProducto(producto);
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Producto agregado exitosamente");
            } else if ("update".equals(action)) {
                Producto producto = new Producto();
                producto.setId(Integer.parseInt(request.getParameter("id")));
                producto.setNombre(request.getParameter("nombre"));
                producto.setDescripcion(request.getParameter("descripcion"));
                producto.setPrecio(new BigDecimal(request.getParameter("precio")));

                Part filePart = request.getPart("imagen");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }
                    filePart.write(uploadPath + File.separator + fileName);
                    producto.setImagen("images/" + fileName);
                }

                productoDAO.actualizarProducto(producto);
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Producto actualizado exitosamente");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                productoDAO.eliminarProducto(id);
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Producto eliminado exitosamente");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Acción no válida");
            }
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", e.getMessage());
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(jsonResponse));
    }
}