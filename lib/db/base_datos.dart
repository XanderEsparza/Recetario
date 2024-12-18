import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/usuario.dart';
import '../models/receta.dart';
import '../models/comentario.dart';

class AyudanteBaseDatos {
  static final AyudanteBaseDatos _instancia = AyudanteBaseDatos._interno();
  static Database? _baseDatos;

  factory AyudanteBaseDatos() => _instancia;

  AyudanteBaseDatos._interno();

  Future<Database> get baseDatos async {
    if (_baseDatos != null) return _baseDatos!;
    _baseDatos = await _inicializarBaseDatos();
    return _baseDatos!;
  }

  Future<Database> _inicializarBaseDatos() async {
    String ruta = join(await getDatabasesPath(), 'recetario.db');
    return await openDatabase(
      ruta,
      version: 1,
      onCreate: _crearTablas,
    );
  }

  Future<void> _crearTablas(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        apellidos TEXT,
        usuario TEXT,
        password TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE recetas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        porciones INTEGER,
        dificultad TEXT,
        categoria TEXT,
        descripcion TEXT,
        documento TEXT,
        imagen TEXT,
        id_usuario INTEGER,
        FOREIGN KEY(id_usuario) REFERENCES usuarios(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE comentarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        comentario TEXT,
        id_usuario INTEGER,
        id_receta INTEGER,
        FOREIGN KEY(id_usuario) REFERENCES usuarios(id)
        FOREIGN KEY(id_receta) REFERENCES recetas(id)
      )
    ''');
  }

//USUARIOS
  Future<int> agregarUsuario(Usuario usuario) async {
    final db = await baseDatos;
    return await db.insert('usuarios', usuario.toMap());
  }

  Future<List<Usuario>> obtenerUsuarios() async {
    final db = await baseDatos;
    final List<Map<String, dynamic>> mapas = await db.query('usuarios');
    return List.generate(mapas.length, (i) => Usuario.fromMap(mapas[i]));
  }

  Future<int> actualizarUsuario(Usuario usuario) async {
    final db = await baseDatos;
    return await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<int> eliminarUsuario(int id) async {
    final db = await baseDatos;
    return await db.delete(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //RECETAS
  Future<int> agregarReceta(Receta receta) async {
    final db = await baseDatos;
    return await db.insert('recetas', receta.toMap());
  }

  Future<List<Receta>> obtenerRecetas() async {
    final db = await baseDatos;
    final List<Map<String, dynamic>> mapas = await db.query('recetas');
    return List.generate(mapas.length, (i) => Receta.fromMap(mapas[i]));
  }

  Future<int> actualizarReceta(Receta receta) async {
    final db = await baseDatos;
    return await db.update(
      'recetas',
      receta.toMap(),
      where: 'id = ?',
      whereArgs: [receta.id],
    );
  }

  Future<int> eliminarReceta(int id) async {
    final db = await baseDatos;
    return await db.delete(
      'recetas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Comentarios
  Future<int> agregarComentario(Comentario comentario) async {
    final db = await baseDatos;
    return await db.insert('comentarios', comentario.toMap());
  }

  Future<List<Comentario>> obtenerComentarios() async {
    final db = await baseDatos;
    final List<Map<String, dynamic>> mapas = await db.query('comentarios');
    return List.generate(mapas.length, (i) => Comentario.fromMap(mapas[i]));
  }

  Future<int> actualizarComentario(Comentario comentario) async {
    final db = await baseDatos;
    return await db.update(
      'comentarios',
      comentario.toMap(),
      where: 'id = ?',
      whereArgs: [comentario.id],
    );
  }

  Future<int> eliminarComentario(int id) async {
    final db = await baseDatos;
    return await db.delete(
      'comentarios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
