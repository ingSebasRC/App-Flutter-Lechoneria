import 'package:flutter/material.dart';
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Usuario registrado correctamente")),
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
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usuarioCtrl,
              decoration: const InputDecoration(labelText: "Usuario"),
            ),
            TextField(
              controller: claveCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registrarUsuario,
              child: const Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}
