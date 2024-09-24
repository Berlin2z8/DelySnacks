$(document).ready(function () {
    // Cargar productos existentes
    $.ajax({
        url: "AdminProductosServlet",
        method: "GET",
        data: { action: "getAll" },
        success: function (response) {
            if (response.success) {
                var productos = response.productos;
                var productList = $("#product-list");
                productList.empty();
                productos.forEach(function (producto) {
                    var productCard =
                        '<div class="product-card" data-id="' + producto.id + '">' +
                        '<h3>' + producto.nombre + '</h3>' +
                        '<p>' + producto.descripcion + '</p>' +
                        '<p class="price">$' + producto.precio + '</p>' +
                        '<img src="' + producto.imagen + '" alt="' + producto.nombre + '" class="product-image">' +
                        '<button class="edit-product">Editar</button>' +
                        '<button class="delete-product">Eliminar</button>' +
                        '</div>';
                    productList.append(productCard);
                });
            } else {
                alert('Error al cargar productos: ' + response.message);
            }
        },
        error: function (xhr, status, error) {
            console.error('Error en la solicitud AJAX:', error);
            alert('Error al cargar productos: ' + error);
        }
    });

    // Agregar producto
    $('#add-product-form').submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        formData.append('action', 'add');

        $.ajax({
            url: 'AdminProductosServlet',
            method: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                if (response.success) {
                    alert(response.message);
                    location.reload();
                } else {
                    alert('Error al agregar el producto: ' + response.message);
                }
            },
            error: function (xhr, status, error) {
                console.error('Error en la solicitud AJAX:', error);
                alert('Error al agregar el producto: ' + error);
            }
        });
    });

    // Editar producto
    $(document).on('click', '.edit-product', function () {
        var id = $(this).closest('.product-card').data('id');
        var nombre = $(this).siblings('h3').text();
        var descripcion = $(this).siblings('p').first().text();
        var precio = $(this).siblings('.price').text().replace('$', '');

        $('#edit-product-id').val(id);
        $('#edit-product-nombre').val(nombre);
        $('#edit-product-descripcion').val(descripcion);
        $('#edit-product-precio').val(precio);

        $('#edit-product-modal').modal('show');
    });

    // Actualizar producto
    $('#edit-product-form').submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        formData.append('action', 'update');

        $.ajax({
            url: 'AdminProductosServlet',
            method: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                if (response.success) {
                    alert(response.message);
                    location.reload();
                } else {
                    alert('Error al actualizar el producto: ' + response.message);
                }
            },
            error: function (xhr, status, error) {
                console.error('Error en la solicitud AJAX:', error);
                alert('Error al actualizar el producto: ' + error);
            }
        });
    });

    // Eliminar producto
    $(document).on('click', '.delete-product', function () {
        if (confirm('¿Estás seguro de que deseas eliminar este producto?')) {
            var id = $(this).closest('.product-card').data('id');

            $.ajax({
                url: 'AdminProductosServlet',
                method: 'POST',
                data: {
                    action: 'delete',
                    id: id
                },
                success: function (response) {
                    if (response.success) {
                        alert(response.message);
                        location.reload();
                    } else {
                        alert('Error al eliminar el producto: ' + response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error en la solicitud AJAX:', error);
                    alert('Error al eliminar el producto: ' + error);
                }
            });
        }
    });
});