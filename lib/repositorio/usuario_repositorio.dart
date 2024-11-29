import '../db/base_datos.dart';
import '../models/usuario.dart';

class UsuarioRepositorio {
  final AyudanteBaseDatos _ayudanteBaseDatos = AyudanteBaseDatos();

  //Obtener todas las recetas
  Future<List<Usuario>> obtenerUsuarios() async {
    return await _ayudanteBaseDatos.obtenerUsuarios();
  }

  //Insertar una nueva receta
  Future<void> agregarUsuario(Usuario usuario) async {
    await _ayudanteBaseDatos.agregarUsuario(usuario);
  }

  //Actualizar una receta
  Future<void> actualizarUsuario(Usuario usuario) async {
    await _ayudanteBaseDatos.actualizarUsuario(usuario);
  }

  //Eliminar una receta
  Future<void> eliminarUsuario(int id) async {
    await _ayudanteBaseDatos.eliminarUsuario(id);
  }
}
