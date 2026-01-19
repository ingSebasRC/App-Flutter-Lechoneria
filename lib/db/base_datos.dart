import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modelos/usuario.dart';

class BaseDatos {
  static Database? _db; //variable estatica

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

//Si la base de datos ya está abierta, la devuelve.
//Si no, llama para inicializarla.
  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'lechoneria.db');  //crea la ruta de archivo

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
      },
    );
  }

  //crea una tabla llamada usuarios
  Future<int> insertarUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //inserta un nuevo usuario a la tabla
  Future<Usuario?> validarUsuario(String username, String password) async {
    final db = await database;
    final result = await db.query(
      'usuarios',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
//consulta si hay un usuario con ese nombre
    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    } else {
      return null;
    }
  }
}