import 'package:flutter/material.dart';
import '../modelos/plato.dart';
import '../widgets/tarjeta_plato.dart';

class PantallaCatalogo extends StatelessWidget {
  final List<Plato> platos = [
    Plato('Plato Económico', 'lechona12.jpg', 12000, 'Porción básica con arroz, carne y arepa.'),
    Plato('Plato Especial', 'lechona15.jpg', 15000, 'Porción con más carne, arroz, arepa y chicharrón.'),
    Plato('Plato Premium', 'lechona20.jpg', 20000, 'Porción completa con bebida y extra de carne.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú de Lechona'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: platos.length,
        itemBuilder: (context, index) {
          return TarjetaPlato(plato: platos[index]);
        },
      ),
    );
  }
}
