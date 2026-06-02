class Pedido {
  final int? id;
  final String nombreCliente;
  final String detalles; // JSON string with items
  final int total;
  final String direccion;
  final String telefono;
  final String horaEntrega;
  final String fecha;
  final String estado; // Pendiente, En Preparación, Enviado, Entregado

  Pedido({
    this.id,
    required this.nombreCliente,
    required this.detalles,
    required this.total,
    required this.direccion,
    required this.telefono,
    required this.horaEntrega,
    required this.fecha,
    this.estado = 'Pendiente',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombreCliente': nombreCliente,
      'detalles': detalles,
      'total': total,
      'direccion': direccion,
      'telefono': telefono,
      'horaEntrega': horaEntrega,
      'fecha': fecha,
      'estado': estado,
    };
  }

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      nombreCliente: map['nombreCliente'],
      detalles: map['detalles'],
      total: map['total'],
      direccion: map['direccion'],
      telefono: map['telefono'],
      horaEntrega: map['horaEntrega'],
      fecha: map['fecha'],
      estado: map['estado'] ?? 'Pendiente',
    );
  }
}
