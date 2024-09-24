<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.delysnacks.model.Usuario" %> <!-- Importación de la clase Usuario -->
<%
    // Verificación de seguridad adicional
    if (session == null || session.getAttribute("usuario") == null || !"1".equals(session.getAttribute("rol"))) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    // Log para depuración
    System.out.println("admin_productos.jsp - Usuario: " + session.getAttribute("usuario") + ", Rol: " + session.getAttribute("rol"));
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Administración de Productos - DelySnacks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin-styles.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin_productos.js"></script>
</head>
<body>
<header>
    <nav>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="DelySnacks Logo" />
            DelySnacks
        </div>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
            <li><a href="${pageContext.request.contextPath}/index.jsp#productos">Productos</a></li>
            <li><a href="${pageContext.request.contextPath}/carrito.jsp">Carrito</a></li>
            <li><a href="${pageContext.request.contextPath}/admin_productos.jsp">Administración</a></li>
            <li><a href="#" id="logout-btn">Cerrar Sesión</a></li>
        </ul>
    </nav>
</header>

<main class="admin-container">
    <h1>Administración de Productos</h1>
    <p>Has iniciado sesión como <strong><%= ((Usuario) session.getAttribute("usuario")).getNombre() %></strong> con rol <strong><%= session.getAttribute("rol") %></strong>.</p>

    <section id="add-product">
        <h2>Agregar Nuevo Producto</h2>
        <form id="add-product-form" enctype="multipart/form-data">
            <input type="text" name="nombre" placeholder="Nombre del producto" required />
            <textarea name="descripcion" placeholder="Descripción del producto" required></textarea>
            <input type="number" name="precio" step="0.01" placeholder="Precio" required />
            <input type="file" name="imagen" accept="image/*" required />
            <input type="hidden" name="action" value="add" /> <!-- Asegúrate de que este campo esté presente -->
            <button type="submit">Agregar Producto</button>
        </form>
    </section>

    <section id="product-list">
        <h2>Lista de Productos</h2>
        <table id="products-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Precio</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <!-- Los productos se cargarán aquí dinámicamente -->
            </tbody>
        </table>
    </section>
</main>

<footer>
    <p>&copy; 2023 DelySnacks. Todos los derechos reservados.</p>
</footer>

<!-- Modal para editar producto -->
<div id="edit-modal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Editar Producto</h2>
        <form id="edit-product-form" enctype="multipart/form-data">
            <input type="hidden" name="id" id="edit-id" />
            <input type="text" name="nombre" id="edit-nombre" placeholder="Nombre del producto" required />
            <textarea name="descripcion" id="edit-descripcion" placeholder="Descripción del producto" required></textarea>
            <input type="number" name="precio" id="edit-precio" step="0.01" placeholder="Precio" required />
            <input type="file" name="imagen" id="edit-imagen" accept="image/*" />
            <img id="current-image" src="" alt="Imagen actual" style="max-width: 100px; max-height: 100px" />
            <button type="submit">Actualizar Producto</button>
        </form>
    </div>
</div>
</body>
</html>