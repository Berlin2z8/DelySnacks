<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DelySnacks - Tu tienda de snacks favorita</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <header>
        <nav>
            <div class="logo">
                <img src="images/logo.png" alt="DelySnacks ">
                Logo
            </div>
            <ul class="nav-links">
                <li><a href="#home">Inicio</a></li>
                <li><a href="#productos">Productos</a></li>
                <li><a href="#ofertas">Ofertas</a></li>
                <li><a href="#about">Nosotros</a></li>
                <li><a href="#contact">Contacto</a></li>
            </ul>
            <div class="nav-buttons">
                <c:choose>
                    <c:when test="${sessionScope.usuario != null}">
                        <a href="#" class="btn btn-outline" id="profile-btn"><i class="fas fa-user"></i> Perfil</a>
                        <a href="#" class="btn btn-outline" id="logout-btn"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>
                    </c:when>
                    <c:otherwise>
                        <a href="#" class="btn btn-outline" id="auth-btn"><i class="fas fa-sign-in-alt"></i> Iniciar sesión</a>
                    </c:otherwise>
                </c:choose>
                <a href="carrito.jsp" class="btn btn-cart"><i class="fas fa-shopping-cart"></i> <span id="cart-count">${sessionScope.carrito != null ? sessionScope.carrito.size() : 0}</span></a>
            </div>
        </nav>
    </header>

    <main>
        <section id="home" class="hero">
            <div class="hero-content">
                <h1>Bienvenido a DelySnacks</h1>
                <p>Descubre nuestra deliciosa selección de snacks</p>
                <a href="#productos" class="cta-button">Ver Productos</a>
            </div>
        </section>

        <section id="productos" class="productos">
            <h2>Nuestros Productos</h2>
            <div class="product-grid" id="product-list">
                <!-- Los productos se cargarán aquí dinámicamente -->
            </div>
        </section>

        <section id="ofertas" class="ofertas">
            <h2>Ofertas Especiales</h2>
            <div class="offer-slider">
                <div class="offer-card">
                    <img src="images/offer1.jpg" alt="Oferta 1">
                    <h3>Combo Fiesta</h3>
                    <p>Lleva 3 productos y paga 2</p>
                    <a href="#" class="btn btn-offer">Ver oferta</a>
                </div>
                <div class="offer-card">
                    <img src="images/offer2.jpg" alt="Oferta 2">
                    <h3>Descuento del 20%</h3>
                    <p>En todos los productos saludables</p>
                    <a href="#" class="btn btn-offer">Ver oferta</a>
                </div>
            </div>
        </section>

        <section id="about" class="about">
            <h2>Sobre Nosotros</h2>
            <p>En DelySnacks, nos apasiona ofrecer los mejores snacks de la más alta calidad. Nuestra misión es satisfacer tus antojos con sabores únicos y experiencias inolvidables.</p>
            <div class="about-features">
                <div class="feature">
                    <i class="fas fa-check-circle"></i>
                    <h3>Calidad Premium</h3>
                    <p>Seleccionamos cuidadosamente cada producto</p>
                </div>
                <div class="feature">
                    <i class="fas fa-truck"></i>
                    <h3>Entrega Rápida</h3>
                    <p>Llevamos tus snacks favoritos a tu puerta</p>
                </div>
                <div class="feature">
                    <i class="fas fa-heart"></i>
                    <h3>Satisfacción Garantizada</h3>
                    <p>Tu felicidad es nuestra prioridad</p>
                </div>
            </div>
        </section>

        <section id="contact" class="contact">
            <h2>Contáctanos</h2>
            <form id="contact-form">
                <input type="text" placeholder="Nombre" required>
                <input type="email" placeholder="Email" required>
                <textarea placeholder="Mensaje" required></textarea>
                <button type="submit" class="btn btn-primary">Enviar Mensaje</button>
            </form>
        </section>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>DelySnacks</h3>
                <p>Tu tienda de snacks favorita</p>
            </div>
            <div class="footer-section">
                <h3>Enlaces Rápidos</h3>
                <ul>
                    <li><a href="#home">Inicio</a></li>
                    <li><a href="#productos">Productos</a></li>
                    <li><a href="#ofertas">Ofertas</a></li>
                    <li><a href="#about">Nosotros</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Síguenos</h3>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 DelySnacks. Todos los derechos reservados.</p>
        </div>
    </footer>

    <div id="auth-modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div class="auth-options">
                <button class="auth-option active" data-form="login-form">Iniciar sesión</button>
                <button class="auth-option" data-form="register-form">Registrarse</button>
            </div>
            <div id="login-form" class="auth-form active">
                <h2>Iniciar sesión</h2>
                <form id="login-form-element">
                    <input type="email" name="email" placeholder="Email" required>
                    <input type="password" name="password" placeholder="Contraseña" required>
                    <button type="submit">Iniciar sesión</button>
                </form>
                <div id="login-message"></div>
            </div>
            <div id="register-form" class="auth-form">
                <h2>Registrarse</h2>
                <form id="register-form-element">
                    <input type="text" name="nombre" placeholder="Nombre" required>
                    <input type="email" name="email" placeholder="Email" required>
                    <input type="password" name="password" placeholder="Contraseña" required>
                    <button type="submit">Registrarse</button>
                </form>
                <div id="register-message"></div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Cargar productos existentes
            $.ajax({
                url: 'AdminProductosServlet',
                method: 'GET',
                data: { action: 'getAll' },
                success: function(response) {
                    if (response.success) {
                        var productos = response.productos;
                        var productList = $('#product-list');
                        productList.empty();
                        productos.forEach(function(producto) {
                            var productCard = '<div class="product-card" data-id="' + producto.id + '">' +
                                '<img src="' + producto.imagen + '" alt="' + producto.nombre + '" class="product-image">' +
                                '<h3>' + producto.nombre + '</h3>' +
                                '<p>' + producto.descripcion + '</p>' +
                                '<span class="price">$' + producto.precio + '</span>' +
                                '<button class="add-to-cart">Agregar al carrito</button>' +
                                '</div>';
                            productList.append(productCard);
                        });
                    } else {
                        alert('Error al cargar productos: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert('Error al cargar productos: ' + error);
                }
            });

            // Cerrar sesión
            $('#logout-btn').click(function(e) {
                e.preventDefault();
                $.ajax({
                    url: 'LogoutServlet',
                    method: 'POST',
                    success: function(response) {
                        if(response.success) {
                            alert('Sesión cerrada exitosamente');
                            window.location.href = 'index.jsp';
                        } else {
                            alert('Error al cerrar sesión');
                        }
                    },
                    error: function() {
                        alert('Error al cerrar sesión');
                    }
                });
            });

            // Manejar el formulario de inicio de sesión
            $('#login-form-element').submit(function(e) {
                e.preventDefault();
                var formData = $(this).serialize();
                $.ajax({
                    url: 'login',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        if (response.success) {
                            alert('Inicio de sesión exitoso');
                            window.location.href = response.redirect;
                        } else {
                            $('#login-message').text('Error: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        $('#login-message').text('Error al iniciar sesión: ' + error);
                    }
                });
            });

            // Manejar el formulario de registro
            $('#register-form-element').submit(function(e) {
                e.preventDefault();
                var formData = $(this).serialize();
                $.ajax({
                    url: 'RegisterServlet',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        if (response.success) {
                            alert('Registro exitoso');
                            window.location.href = 'index.jsp';
                        } else {
                            $('#register-message').text('Error: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        $('#register-message').text('Error al registrarse: ' + error);
                    }
                });
            });

            // Mostrar el modal de autenticación
            $('#auth-btn').click(function() {
                $('#auth-modal').css('display', 'block');
            });

            // Cerrar el modal de autenticación
            $('.close').click(function() {
                $('#auth-modal').css('display', 'none');
            });

            // Cambiar entre formularios de inicio de sesión y registro
            $('.auth-option').click(function() {
                var formToShow = $(this).data('form');
                $('.auth-option').removeClass('active');
                $(this).addClass('active');
                $('.auth-form').removeClass('active');
                $('#' + formToShow).addClass('active');
            });

            // Manejar el evento de clic en "Agregar al carrito"
            $(document).on('click', '.add-to-cart', function() {
                var productId = $(this).closest('.product-card').data('id');
                $.ajax({
                    url: 'CarritoServlet',
                    method: 'POST',
                    data: { action: 'add', productId: productId },
                    success: function(response) {
                        if (response.success) {
                            alert('Producto agregado al carrito');
                            $('#cart-count').text(response.cartCount);
                        } else {
                            alert('Error al agregar el producto al carrito: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('Error al agregar el producto al carrito: ' + error);
                    }
                });
            });
        });
    </script>
</body>
</html>