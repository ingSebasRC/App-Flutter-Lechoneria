import 'package:flutter/material.dart';
import '../db/base_datos.dart';
import 'pantalla_catalogo.dart';
import 'pantalla_registro.dart';

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

    // 🔥 SOLUCIÓN CLAVE
    if (!mounted) return;

    if (usuario != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PantallaCatalogo(), // ❌ sin const
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Usuario o contraseña incorrectos'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
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
        title: const Text("Iniciar sesión"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usuarioCtrl,
              decoration: const InputDecoration(
                labelText: "Usuario",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: claveCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // LOGIN
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: iniciarSesion,
                child: const Text("Ingresar"),
              ),
            ),

            const SizedBox(height: 12),

            // REGISTRO
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PantallaRegistro(),
                  ),
                );
              },
              child: const Text("¿No tienes cuenta? Regístrate"),
            ),
          ],
        ),
      ),
    );
  }
}
