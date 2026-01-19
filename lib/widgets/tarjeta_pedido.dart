import 'package:flutter/material.dart';
import '../modelos/pedido.dart';

class TarjetaPedido extends StatelessWidget {
  final Pedido pedido;

  TarjetaPedido({required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange,
          child: Text('${pedido.cantidad}'),
        ),
        title: Text(pedido.direccion),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Teléfono: ${pedido.telefono}'),
            Text('Entrega: ${pedido.horaEntrega}'),
          ],
        ),
      ),
    );
  }
}
