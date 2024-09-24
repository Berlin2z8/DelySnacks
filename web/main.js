$(document).ready(function() {
    var modal = $('#auth-modal');
    var authBtn = $('#auth-btn');
    var closeBtn = $('.close');
    var authOptions = $('.auth-option');

    authBtn.click(function() {
        modal.css('display', 'block');
    });

    closeBtn.click(function() {
        modal.css('display', 'none');
    });

    $(window).click(function(event) {
        if (event.target == modal[0]) {
            modal.css('display', 'none');
        }
    });

    authOptions.click(function() {
        var targetForm = $(this).data('form');
        authOptions.removeClass('active');
        $(this).addClass('active');
        $('.auth-form').removeClass('active');
        $('#' + targetForm).addClass('active');
    });

    $('#login-form-element').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: 'login',
            method: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                if(response.success) {
                    $('#login-message').html('<p class="success-message">' + response.message + '</p>');
                    setTimeout(function() {
                        window.location.href = response.redirect;
                    }, 1500);
                } else {
                    $('#login-message').html('<p class="error-message">' + response.message + '</p>');
                }
            },
            error: function(xhr, status, error) {
                $('#login-message').html('<p class="error-message">Error al iniciar sesión: ' + error + '</p>');
            }
        });
    });

    $('#register-form-element').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: 'registro',
            method: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                if(response.success) {
                    $('#register-message').html('<p class="success-message">' + response.message + '</p>');
                    setTimeout(function() {
                        $('.auth-option[data-form="login-form"]').click();
                    }, 1500);
                } else {
                    $('#register-message').html('<p class="error-message">' + response.message + '</p>');
                }
            },
            error: function(xhr, status, error) {
                $('#register-message').html('<p class="error-message">Error al registrar usuario: ' + error + '</p>');
            }
        });
    });

    $('#logout-btn').click(function(e) {
        e.preventDefault();
        $.ajax({
            url: 'logout',
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


    // Función para agregar al carrito
    function addToCart(id, nombre, precio, cantidad) {
        $.ajax({
            url: 'CarritoServlet',
            method: 'POST',
            data: {
                action: 'add',
                id: id,
                nombre: nombre,
                precio: precio,
                cantidad: cantidad
            },
            success: function(response) {
                if (response.success) {
                    alert(response.message);
                    updateCartCount(response.cartCount);
                } else {
                    alert('Error al añadir al carrito: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en la solicitud AJAX:', error);
                alert('Error al añadir al carrito: ' + error);
            }
        });
    }

    // Actualizar el contador del carrito
    function updateCartCount(count) {
        $('#cart-count').text(count);
    }

    // Agregar al carrito cuando se hace clic en el botón
    $('.add-to-cart').click(function(e) {
        e.preventDefault();
        let card = $(this).closest('.product-card');
        let id = card.data('id');
        let nombre = card.find('h3').text();
        let precio = parseFloat(card.find('.price').text().replace('$', ''));
        addToCart(id, nombre, precio, 1);
    });

    // Cargar el contador del carrito al iniciar la página
    $.ajax({
        url: 'CarritoServlet',
        method: 'POST',
        data: { action: 'getCount' },
        success: function(response) {
            if (response.success) {
                updateCartCount(response.cartCount);
            }
        }
    });
});