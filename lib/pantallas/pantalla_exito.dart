import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PantallaExito extends StatelessWidget {
  final String nombre;
  final int total;

  const PantallaExito({super.key, required this.nombre, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: Colors.green, size: 100),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              const SizedBox(height: 32),
              Text(
                '¡Pedido Recibido!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 16),
              Text(
                'Gracias $nombre, estamos preparando tu lechona premium.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Pagado:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\$$total', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 18)),
                  ],
                ),
              ).animate().slideY(begin: 0.2, delay: 800.ms).fadeIn(),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Volver al Inicio'),
              ).animate().fadeIn(delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }
}
