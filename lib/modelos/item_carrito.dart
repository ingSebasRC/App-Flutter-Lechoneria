class ItemCarrito {
  final String nombre;
  final int precio;
  int cantidad;

  ItemCarrito({
    required this.nombre,
    required this.precio,
    this.cantidad = 1,
  });

  int get subtotal => precio * cantidad;
}
