package com.delysnacks.servlet;

import com.delysnacks.dao.UsuarioDAO;
import com.delysnacks.model.Usuario;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());
    private UsuarioDAO usuarioDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        usuarioDAO = new UsuarioDAO();
        gson = new Gson();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        LOGGER.info("Intento de inicio de sesión para el email: " + email);

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            Usuario usuario = usuarioDAO.obtenerPorEmail(email);
            if (usuario != null && verificarPassword(password, usuario.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                String rol = usuario.getRol();
                session.setAttribute("rol", rol);

                LOGGER.info("Inicio de sesión exitoso para el usuario: " + email + " con rol: " + rol);

                jsonResponse.put("success", true);
                jsonResponse.put("message", "Inicio de sesión exitoso");
                jsonResponse.put("rol", rol);

                if ("1".equals(rol)) { // Verificar si el rol es ADMIN
                    jsonResponse.put("redirect", request.getContextPath() + "/admin_productos.jsp");
                } else {
                    jsonResponse.put("redirect", request.getContextPath() + "/index.jsp");
                }
            } else {
                LOGGER.warning("Intento de inicio de sesión fallido para el email: " + email);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Credenciales inválidas");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error en el inicio de sesión para el email: " + email, e);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error al iniciar sesión. Por favor, inténtelo de nuevo más tarde.");
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(jsonResponse));
    }

    private boolean verificarPassword(String inputPassword, String storedPassword) {
        // Verificación simple de contraseña
        return inputPassword.equals(storedPassword);
    }
}