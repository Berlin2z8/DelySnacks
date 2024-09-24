<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="carrito-styles.css">
</head>
<body>
    <header>
        <nav>
            <div class="logo">
                <img src="images/logo.png" alt="DelySnacks Logo">
                DelySnacks
            </div>
            <ul class="nav-links">
                <li><a href="index.jsp#home">Inicio</a></li>
                <li><a href="index.jsp#productos">Productos</a></li>
                <li><a href="index.jsp#ofertas">Ofertas</a></li>
                <li><a href="index.jsp#about">Nosotros</a></li>
                <li><a href="index.jsp#contact">Contacto</a></li>
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
        <section class="carrito-container">
            <h2 class="carrito-title">Tu Carrito de Compras</h2>
            <c:choose>
                <c:when test="${not empty carrito}">
                    <div class="carrito-items">
                        <c:forEach var="producto" items="${carrito}">
                            <div class="carrito-item">
                                <img src="${producto.imagen}" alt="${producto.nombre}" class="cart-item-image">
                                <div class="carrito-item-info">
                                    <h3 class="carrito-item-name">${producto.nombre}</h3>
                                    <p class="carrito-item-price">$${producto.precio}</p>
                                </div>
                                <div class="carrito-item-quantity">
                                    <button class="quantity-btn quantity-decrease">-</button>
                                    <input type="number" class="quantity-input" value="1" min="1">
                                    <button class="quantity-btn quantity-increase">+</button>
                                </div>
                                <button class="remove-item">Eliminar</button>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="carrito-total">
                        <h3>Total: $<span id="total-amount">0.00</span></h3>
                    </div>
                    <button class="checkout-btn">Proceder al Pago</button>
                </c:when>
                <c:otherwise>
                    <p>Tu carrito está vacío.</p>
                </c:otherwise>
            </c:choose>
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
                    <li><a href="index.jsp#home">Inicio</a></li>
                    <li><a href="index.jsp#productos">Productos</a></li>
                    <li><a href="index.jsp#ofertas">Ofertas</a></li>
                    <li><a href="index.jsp#about">Nosotros</a></li>
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const updateTotal = () => {
                let total = 0;
                document.querySelectorAll('.carrito-item').forEach(item => {
                    const price = parseFloat(item.querySelector('.carrito-item-price').textContent.replace('$', ''));
                    const quantity = parseInt(item.querySelector('.quantity-input').value);
                    total += price * quantity;
                });
                document.getElementById('total-amount').textContent = total.toFixed(2);
            };

            document.querySelectorAll('.quantity-decrease').forEach(button => {
                button.addEventListener('click', function() {
                    const input = this.nextElementSibling;
                    if (input.value > 1) {
                        input.value = parseInt(input.value) - 1;
                        updateTotal();
                    }
                });
            });

            document.querySelectorAll('.quantity-increase').forEach(button => {
                button.addEventListener('click', function() {
                    const input = this.previousElementSibling;
                    input.value = parseInt(input.value) + 1;
                    updateTotal();
                });
            });

            document.querySelectorAll('.quantity-input').forEach(input => {
                input.addEventListener('change', function() {
                    if (this.value < 1) {
                        this.value = 1;
                    }
                    updateTotal();
                });
            });

            updateTotal();
        });
    </script>
</body>
</html>