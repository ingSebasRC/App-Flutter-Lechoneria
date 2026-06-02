import 'package:flutter/material.dart';
import '../modelos/pedido.dart';

class TarjetaPedido extends StatelessWidget {
  final Pedido pedido;

  TarjetaPedido({required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.shopping_bag, color: Colors.white),
        ),
        title: Text(pedido.nombreCliente),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detalles: ${pedido.detalles}'),
            Text('Total: \$${pedido.total}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Entrega: ${pedido.horaEntrega}'),
          ],
        ),
      ),
    );
  }
}
