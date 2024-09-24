$(document).ready(function() {
    function loadCarrito() {
        $.ajax({
            url: 'CarritoServlet',
            method: 'POST',
            data: { action: 'getCarrito' },
            success: function(response) {
                if (response.success) {
                    displayCarrito(response.carrito);
                } else {
                    alert('Error al cargar el carrito: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en la solicitud AJAX:', error);
                alert('Error al cargar el carrito: ' + error);
            }
        });
    }

    function displayCarrito(carrito) {
        let $carritoItems = $('#carrito-items');
        let total = 0;

        $carritoItems.empty();

        if (carrito.length === 0) {
            $carritoItems.append('<p class="empty-cart">Tu carrito está vacío.</p>');
        } else {
            carrito.forEach(function(item) {
                let subtotal = item.precio * item.cantidad;
                total += subtotal;

                $carritoItems.append(`
                    <div class="carrito-item" data-id="${item.id}">
                        <img src="images/${item.id}.jpg" alt="${item.nombre}">
                        <div class="carrito-item-info">
                            <h3 class="carrito-item-name">${item.nombre}</h3>
                            <p class="carrito-item-price">$${item.precio.toFixed(2)}</p>
                        </div>
                        <div class="carrito-item-quantity">
                            <button class="quantity-btn minus">-</button>
                            <input type="number" class="quantity-input" value="${item.cantidad}" min="1">
                            <button class="quantity-btn plus">+</button>
                        </div>
                        <button class="remove-item">Eliminar</button>
                    </div>
                `);
            });
        }

        $('#total-amount').text(total.toFixed(2));
    }

    $(document).on('click', '.remove-item', function() {
        let itemId = $(this).closest('.carrito-item').data('id');
        removeFromCart(itemId);
    });

    $(document).on('click', '.quantity-btn', function() {
        let $input = $(this).siblings('.quantity-input');
        let currentValue = parseInt($input.val());
        if ($(this).hasClass('minus') && currentValue > 1) {
            $input.val(currentValue - 1);
        } else if ($(this).hasClass('plus')) {
            $input.val(currentValue + 1);
        }
        updateCartItem($(this).closest('.carrito-item').data('id'), $input.val());
    });

    $(document).on('change', '.quantity-input', function() {
        let newValue = parseInt($(this).val());
        if (newValue < 1) {
            $(this).val(1);
            newValue = 1;
        }
        updateCartItem($(this).closest('.carrito-item').data('id'), newValue);
    });

    function removeFromCart(id) {
        $.ajax({
            url: 'CarritoServlet',
            method: 'POST',
            data: {
                action: 'remove',
                id: id
            },
            success: function(response) {
                if (response.success) {
                    loadCarrito();
                } else {
                    alert('Error al eliminar del carrito: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en la solicitud AJAX:', error);
                alert('Error al eliminar del carrito: ' + error);
            }
        });
    }

    function updateCartItem(id, cantidad) {
        $.ajax({
            url: 'CarritoServlet',
            method: 'POST',
            data: {
                action: 'update',
                id: id,
                cantidad: cantidad
            },
            success: function(response) {
                if (response.success) {
                    loadCarrito();
                } else {
                    alert('Error al actualizar el carrito: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en la solicitud AJAX:', error);
                alert('Error al actualizar el carrito: ' + error);
            }
        });
    }

    $('#checkout-btn').click(function() {
        alert('Gracias por tu compra. Implementar la lógica de pago aquí.');
    });

    loadCarrito();
});