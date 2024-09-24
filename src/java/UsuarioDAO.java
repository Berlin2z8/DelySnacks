package com.delysnacks.dao;

import com.delysnacks.model.Usuario;
import com.delysnacks.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // Importar ResultSet
import java.sql.SQLException;

public class UsuarioDAO {
    private Connection connection;

    public UsuarioDAO() {
        try {
            connection = DatabaseUtil.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Usuario obtenerPorEmail(String email) throws SQLException {
        String query = "SELECT * FROM usuarios WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) { // Usar ResultSet
                if (resultSet.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(resultSet.getInt("id"));
                    usuario.setNombre(resultSet.getString("nombre"));
                    usuario.setEmail(resultSet.getString("email"));
                    usuario.setPassword(resultSet.getString("password"));
                    usuario.setRol(resultSet.getString("rol_id"));
                    usuario.setFechaRegistro(resultSet.getTimestamp("fecha_registro"));
                    return usuario;
                }
            }
        }
        return null;
    }

    public void crear(Usuario usuario) throws SQLException {
        String query = "INSERT INTO usuarios (nombre, email, password, rol_id, fecha_registro) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, usuario.getNombre());
            statement.setString(2, usuario.getEmail());
            statement.setString(3, usuario.getPassword());
            statement.setString(4, usuario.getRol());
            statement.setTimestamp(5, usuario.getFechaRegistro());
            statement.executeUpdate();
        }
    }
}