import '../modelos/item_carrito.dart';

class ServicioCarrito {
  static final ServicioCarrito _instance = ServicioCarrito._internal();
  factory ServicioCarrito() => _instance;
  ServicioCarrito._internal();

  final List<ItemCarrito> _items = [];

  List<ItemCarrito> get items => _items;

  void agregar(String nombre, int precio) {
    final index = _items.indexWhere((item) => item.nombre == nombre);
    if (index != -1) {
      _items[index].cantidad++;
    } else {
      _items.add(ItemCarrito(nombre: nombre, precio: precio));
    }
  }

  void eliminar(String nombre) {
    _items.removeWhere((item) => item.nombre == nombre);
  }

  void limpiar() {
    _items.clear();
  }

  int get total => _items.fold(0, (sum, item) => sum + item.subtotal);
  
  int get cantidadTotal => _items.fold(0, (sum, item) => sum + item.cantidad);
}
