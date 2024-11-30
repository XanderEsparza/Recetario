import '../db/base_datos.dart';
import '../models/usuario.dart';

class UsuarioRepositorio {
  final AyudanteBaseDatos _ayudanteBaseDatos = AyudanteBaseDatos();

  //Obtener todos los usuarios
  Future<List<Usuario>> obtenerUsuarios() async {
    return await _ayudanteBaseDatos.obtenerUsuarios();
  }

  //Insertar un nuevo usuario
  Future<void> agregarUsuario(Usuario usuario) async {
    await _ayudanteBaseDatos.agregarUsuario(usuario);
  }

  //Actualizar un usuario
  Future<void> actualizarUsuario(Usuario usuario) async {
    await _ayudanteBaseDatos.actualizarUsuario(usuario);
  }

  //Eliminar un usuario
  Future<void> eliminarUsuario(int id) async {
    await _ayudanteBaseDatos.eliminarUsuario(id);
  }
}
