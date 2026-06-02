import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modelos/usuario.dart';
import '../modelos/pedido.dart';

class BaseDatos {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'lechoneria.db');

    return await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE pedidos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombreCliente TEXT NOT NULL,
            detalles TEXT NOT NULL,
            total INTEGER NOT NULL,
            direccion TEXT NOT NULL,
            telefono TEXT NOT NULL,
            horaEntrega TEXT NOT NULL,
            fecha TEXT NOT NULL,
            estado TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE pedidos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nombreCliente TEXT NOT NULL,
              plato TEXT NOT NULL,
              cantidad INTEGER NOT NULL,
              direccion TEXT NOT NULL,
              telefono TEXT NOT NULL,
              horaEntrega TEXT NOT NULL,
              fecha TEXT NOT NULL
            )
          ''');
        }
        if (oldVersion < 3) {
          await db.execute('DROP TABLE IF EXISTS pedidos');
          await db.execute('''
            CREATE TABLE pedidos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nombreCliente TEXT NOT NULL,
              detalles TEXT NOT NULL,
              total INTEGER NOT NULL,
              direccion TEXT NOT NULL,
              telefono TEXT NOT NULL,
              horaEntrega TEXT NOT NULL,
              fecha TEXT NOT NULL
            )
          ''');
        }
        if (oldVersion < 4) {
          // Add 'estado' column to version 4
          try {
            await db.execute('ALTER TABLE pedidos ADD COLUMN estado TEXT NOT NULL DEFAULT "Pendiente"');
          } catch (e) {
            // In case the column already exists or table needs recreation
          }
        }
      },
    );
  }

  Future<int> insertarPedido(Pedido pedido) async {
    final db = await database;
    return await db.insert('pedidos', pedido.toMap());
  }

  Future<int> actualizarEstadoPedido(int id, String nuevoEstado) async {
    final db = await database;
    return await db.update(
      'pedidos',
      {'estado': nuevoEstado},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Pedido>> obtenerPedidos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pedidos', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => Pedido.fromMap(maps[i]));
  }

  Future<int> eliminarPedido(int id) async {
    final db = await database;
    return await db.delete('pedidos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertarUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Usuario?> validarUsuario(String username, String password) async {
    // Primero verificamos el admin fijo solicitado
    if (username == 'admin' && password == '123') {
      return Usuario(username: 'admin', password: '123');
    }

    // Luego verificamos en la base de datos por si acaso
    final db = await database;
    final result = await db.query(
      'usuarios',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    }
    return null;
  }
}