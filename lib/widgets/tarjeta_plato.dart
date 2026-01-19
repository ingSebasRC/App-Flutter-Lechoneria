import 'package:flutter/material.dart';
import '../modelos/plato.dart';
import '../pantallas/pantalla_formulario.dart';

class TarjetaPlato extends StatelessWidget {
  final Plato plato;

  const TarjetaPlato({required this.plato});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset('assets/${plato.imagen}', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plato.nombre, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(plato.descripcion),
                SizedBox(height: 6),
                Text('\$${plato.precio}', style: TextStyle(fontSize: 16, color: Colors.green[700])),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PantallaFormulario(plato: plato),
                        ),
                      );
                    },
                    child: Text('Pedir'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

