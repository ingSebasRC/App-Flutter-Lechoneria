import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../db/base_datos.dart';
import 'pantalla_admin.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final TextEditingController usuarioCtrl = TextEditingController();
  final TextEditingController claveCtrl = TextEditingController();

  Future<void> iniciarSesion() async {
    final db = BaseDatos();

    final usuario = await db.validarUsuario(
      usuarioCtrl.text.trim(),
      claveCtrl.text.trim(),
    );

    if (!mounted) return;

    if (usuario != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const PantallaAdmin(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Acceso Denegado'),
          content: const Text('Solo el administrador puede acceder a este panel.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.admin_panel_settings, size: 80, color: Color(0xFFD35400))
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(),
              const SizedBox(height: 24),
              const Text(
                "Panel Administrativo",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
              const Text(
                "Ingrese sus credenciales de administrador",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.1),
              const SizedBox(height: 48),
              TextField(
                controller: usuarioCtrl,
                decoration: const InputDecoration(
                  labelText: "Usuario Admin",
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.1),
              const SizedBox(height: 20),
              TextField(
                controller: claveCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ).animate().fadeIn(delay: 500.ms, duration: 600.ms).slideY(begin: 0.1),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: iniciarSesion,
                child: const Text("Ingresar al CRM"),
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms).scale(begin: const Offset(0.9, 0.9)),
            ],
          ),
        ),
      ),
    );
  }
}
