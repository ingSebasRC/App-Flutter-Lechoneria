import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../db/base_datos.dart';
import '../modelos/usuario.dart';
import 'pantalla_login.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final usuarioCtrl = TextEditingController();
  final claveCtrl = TextEditingController();

  void registrarUsuario() async {
    final nuevo = Usuario(
      username: usuarioCtrl.text.trim(),
      password: claveCtrl.text.trim(),
    );

    final db = BaseDatos();
    await db.insertarUsuario(nuevo);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Usuario registrado correctamente"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.green,
      ),
    );

    // 🔥 Redirige al login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PantallaLogin()),
    );
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
              const Text(
                "Crea tu cuenta",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
              const Text(
                "Únete a la mejor experiencia",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.1),
              const SizedBox(height: 60),
              TextField(
                controller: usuarioCtrl,
                decoration: const InputDecoration(
                  labelText: "Nuevo Usuario",
                  prefixIcon: Icon(Icons.person_add_outlined),
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
                onPressed: registrarUsuario,
                child: const Text("Registrarse"),
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms).scale(begin: const Offset(0.9, 0.9)),
            ],
          ),
        ),
      ),
    );
  }
}
