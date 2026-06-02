import 'package:flutter/material.dart';
import '../modelos/plato.dart';
import '../servicios/servicio_carrito.dart';

class TarjetaPlato extends StatelessWidget {
  final Plato plato;

  const TarjetaPlato({super.key, required this.plato});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/${plato.imagen}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        plato.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                    Text(
                      '\$${plato.precio}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  plato.descripcion,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    ServicioCarrito().agregar(plato.nombre, plato.precio);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${plato.nombre} añadido al carrito'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                  child: const Text('Añadir al Carrito'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

