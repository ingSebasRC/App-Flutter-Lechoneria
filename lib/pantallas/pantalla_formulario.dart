import 'package:flutter/material.dart';
import '../modelos/plato.dart';

class PantallaFormulario extends StatelessWidget {
  final Plato plato;

  PantallaFormulario({required this.plato});

  final _direccionCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _horaCtrl = TextEditingController();

  void _confirmarPedido(BuildContext context) {
    final direccion = _direccionCtrl.text.trim();
    final telefono = _telefonoCtrl.text.trim();
    final hora = _horaCtrl.text.trim();

    if (direccion.isEmpty || telefono.isEmpty || hora.isEmpty) return;

    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Pedido Confirmado'),
        content: Text('Tu pedido de ${plato.nombre} será entregado a las $hora.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completar Pedido'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Plato: ${plato.nombre}', style: TextStyle(fontSize: 18)),
            Text('Precio: \$${plato.precio}', style: TextStyle(fontSize: 16, color: Colors.green[700])),
            SizedBox(height: 16),
            TextField(
              controller: _direccionCtrl,
              decoration: InputDecoration(labelText: 'Dirección de entrega'),
            ),
            TextField(
              controller: _telefonoCtrl,
              decoration: InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _horaCtrl,
              decoration: InputDecoration(labelText: 'Hora de entrega'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmarPedido(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('Confirmar Pedido'),
            )
          ],
        ),
      ),
    );
  }
}
