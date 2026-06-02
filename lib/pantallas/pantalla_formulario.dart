import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../modelos/pedido.dart';
import '../db/base_datos.dart';
import '../servicios/servicio_carrito.dart';
import 'pantalla_exito.dart';

class PantallaFormulario extends StatefulWidget {
  const PantallaFormulario({super.key});

  @override
  State<PantallaFormulario> createState() => _PantallaFormularioState();
}

class _PantallaFormularioState extends State<PantallaFormulario> {
  final _nombreCtrl = TextEditingController();
  final _direccionCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _horaCtrl = TextEditingController();
  final _carrito = ServicioCarrito();

  void _confirmarPedido(BuildContext context) async {
    final nombre = _nombreCtrl.text.trim();
    final direccion = _direccionCtrl.text.trim();
    final telefono = _telefonoCtrl.text.trim();
    final hora = _horaCtrl.text.trim();

    if (nombre.isEmpty || direccion.isEmpty || telefono.isEmpty || hora.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Por favor completa todos los campos'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Convert items to a JSON string or a simple string summary
    final detalles = _carrito.items.map((item) => '${item.cantidad}x ${item.nombre}').join(', ');
    
    final nuevoPedido = Pedido(
      nombreCliente: nombre,
      detalles: detalles,
      total: _carrito.total,
      direccion: direccion,
      telefono: telefono,
      horaEntrega: hora,
      fecha: DateTime.now().toString().split('.')[0],
    );

    await BaseDatos().insertarPedido(nuevoPedido);
    _carrito.limpiar();

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaExito(nombre: nombre, total: nuevoPedido.total),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Detalles de Entrega',
          style: TextStyle(color: Color(0xFF2C3E50), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFEAEAEA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resumen del Pedido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Divider(),
                    ..._carrito.items.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${item.cantidad}x ${item.nombre}'),
                          Text('\$${item.subtotal}'),
                        ],
                      ),
                    )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total a pagar', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('\$${_carrito.total}', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.1),
              const SizedBox(height: 40),
              const Text(
                "Información de Entrega",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 24),
              TextField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tu nombre completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ).animate().fadeIn(delay: 250.ms, duration: 600.ms).slideX(begin: 0.05),
              const SizedBox(height: 16),
              TextField(
                controller: _direccionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Dirección de entrega',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideX(begin: 0.05),
              const SizedBox(height: 16),
              TextField(
                controller: _telefonoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Teléfono de contacto',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: 0.05),
              const SizedBox(height: 16),
              TextField(
                controller: _horaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Hora preferida',
                  prefixIcon: Icon(Icons.access_time_outlined),
                ),
              ).animate().fadeIn(delay: 500.ms, duration: 600.ms).slideX(begin: 0.05),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => _confirmarPedido(context),
                child: const Text('Confirmar Pedido'),
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms).scale(begin: const Offset(0.9, 0.9)),
            ],
          ),
        ),
      ),
    );
  }
}
