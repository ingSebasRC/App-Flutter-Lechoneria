import 'package:flutter/material.dart';
import '../db/base_datos.dart';
import '../modelos/pedido.dart';

class PantallaAdmin extends StatefulWidget {
  const PantallaAdmin({super.key});

  @override
  State<PantallaAdmin> createState() => _PantallaAdminState();
}

class _PantallaAdminState extends State<PantallaAdmin> with SingleTickerProviderStateMixin {
  final BaseDatos _db = BaseDatos();
  List<Pedido> _todosLosPedidos = [];
  bool _isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _cargarPedidos();
  }

  Future<void> _cargarPedidos() async {
    setState(() => _isLoading = true);
    final pedidos = await _db.obtenerPedidos();
    setState(() {
      _todosLosPedidos = pedidos;
      _isLoading = false;
    });
  }

  int get _ventasTotales => _todosLosPedidos
      .where((p) => p.estado == 'Entregado')
      .fold(0, (sum, p) => sum + p.total);

  int get _pedidosPendientes => _todosLosPedidos.where((p) => p.estado != 'Entregado').length;

  String get _platoEstrella {
    if (_todosLosPedidos.isEmpty) return "N/A";
    Map<String, int> conteo = {};
    for (var p in _todosLosPedidos) {
      // Simplificado: toma el primer item de detalles si es un string simple
      String item = p.detalles.split(',').first.split('x ').last;
      conteo[item] = (conteo[item] ?? 0) + 1;
    }
    var sorted = conteo.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.isNotEmpty ? sorted.first.key : "N/A";
  }

  Future<void> _cambiarEstado(int id, String nuevoEstado) async {
    await _db.actualizarEstadoPedido(id, nuevoEstado);
    await _cargarPedidos();
  }

  Color _getColorEstado(String estado) {
    switch (estado) {
      case 'Pendiente': return Colors.orange;
      case 'En Preparación': return Colors.blue;
      case 'Enviado': return Colors.purple;
      case 'Entregado': return Colors.green;
      default: return Colors.grey;
    }
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text('CRM Lechonería Pro', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _cargarPedidos),
          IconButton(icon: const Icon(Icons.logout), onPressed: () => Navigator.pop(context)),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Activos'),
            Tab(text: 'Completados'),
            Tab(text: 'Todos'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Dashboard Stats
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(child: _buildStatCard('Ventas (Entregados)', '\$${_ventasTotales}', Icons.attach_money, Colors.green)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatCard('Pendientes', '${_pedidosPendientes}', Icons.timer, Colors.orange)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildStatCard('Plato Estrella', _platoEstrella, Icons.star, Colors.amber),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildListaPedidos(_todosLosPedidos.where((p) => p.estado != 'Entregado').toList()),
                      _buildListaPedidos(_todosLosPedidos.where((p) => p.estado == 'Entregado').toList()),
                      _buildListaPedidos(_todosLosPedidos),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildListaPedidos(List<Pedido> pedidos) {
    if (pedidos.isEmpty) return const Center(child: Text('Sin pedidos en esta sección'));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pedidos.length,
      itemBuilder: (context, index) {
        final pedido = pedidos[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey[200]!)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(pedido.nombreCliente, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: _getColorEstado(pedido.estado).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: Text(pedido.estado, style: TextStyle(color: _getColorEstado(pedido.estado), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Items: ${pedido.detalles}', style: const TextStyle(fontSize: 14)),
                const Divider(height: 24),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(child: Text(pedido.direccion, style: const TextStyle(fontSize: 13))),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.redAccent),
                    const SizedBox(width: 4),
                    Text(pedido.horaEntrega, style: const TextStyle(fontSize: 13, color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text('\$${pedido.total}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2C3E50))),
                  ],
                ),
                const SizedBox(height: 16),
                if (pedido.estado != 'Entregado')
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _actionButton(pedido.id!, 'En Preparación', Colors.blue),
                        const SizedBox(width: 8),
                        _actionButton(pedido.id!, 'Enviado', Colors.purple),
                        const SizedBox(width: 8),
                        _actionButton(pedido.id!, 'Entregado', Colors.green),
                      ],
                    ),
                  )
                else
                  TextButton.icon(
                    onPressed: () => _db.eliminarPedido(pedido.id!).then((_) => _cargarPedidos()),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text('Eliminar Historial', style: TextStyle(color: Colors.red)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionButton(int id, String estado, Color color) {
    return ElevatedButton(
      onPressed: () => _cambiarEstado(id, estado),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(100, 36),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(estado, style: const TextStyle(fontSize: 11, color: Colors.white)),
    );
  }
}
