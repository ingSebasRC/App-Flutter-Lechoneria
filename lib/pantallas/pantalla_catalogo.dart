import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../modelos/plato.dart';
import '../widgets/tarjeta_plato.dart';
import '../servicios/servicio_carrito.dart';
import 'pantalla_login.dart';
import 'pantalla_carrito.dart';

class PantallaCatalogo extends StatefulWidget {
  @override
  State<PantallaCatalogo> createState() => _PantallaCatalogoState();
}

class _PantallaCatalogoState extends State<PantallaCatalogo> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Plato> platos = [
    Plato('Plato Económico', 'lechona12.jpg', 12000, 'Porción básica con arroz, carne y arepa.'),
    Plato('Plato Especial', 'lechona15.jpg', 15000, 'Porción con más carne, arroz, arepa y chicharrón.'),
    Plato('Plato Premium', 'lechona20.jpg', 20000, 'Porción completa con bebida y extra de carne.'),
  ];

  final List<Plato> bebidas = [
    Plato('Jugo de Naranja', 'lechona12.jpg', 4000, 'Fresco y natural.'),
    Plato('Coca-Cola 400ml', 'lechona12.jpg', 4000, 'Presentación personal.'),
    Plato('Coca-Cola 1 Litro', 'lechona12.jpg', 5000, 'Ideal para compartir.'),
    Plato('Coca-Cola 1.5L', 'lechona12.jpg', 7500, 'Para la familia.'),
    Plato('Coca-Cola 3L', 'lechona12.jpg', 10000, 'Súper tamaño familiar.'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFFF8F9FA),
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.admin_panel_settings, color: Color(0xFF2C3E50)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PantallaLogin()),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Lechonería Premium',
                style: TextStyle(
                  color: Color(0xFF2C3E50),
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 60),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'Nuestra Lechona'),
                Tab(text: 'Bebidas Frías'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab Platos
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: platos.length,
              itemBuilder: (context, index) {
                return TarjetaPlato(plato: platos[index])
                    .animate()
                    .fadeIn(delay: (index * 100).ms, duration: 600.ms)
                    .slideY(begin: 0.1);
              },
            ),
            // Tab Bebidas
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bebidas.length,
              itemBuilder: (context, index) {
                final bebida = bebidas[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 2,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.local_drink, color: Theme.of(context).primaryColor),
                    ),
                    title: Text(bebida.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text('\$${bebida.precio}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle, size: 32),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        ServicioCarrito().agregar(bebida.nombre, bebida.precio);
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${bebida.nombre} añadida'),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ),
                ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.05);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PantallaCarrito()),
          );
          setState(() {}); 
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        label: Text(
          'Carrito (${ServicioCarrito().cantidadTotal})',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ).animate().scale(delay: 400.ms),
    );
  }
}
