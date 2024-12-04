import '../db/base_datos.dart';
import '../models/comentario.dart';

class ComentarioRepositorio {
  final AyudanteBaseDatos _ayudanteBaseDatos = AyudanteBaseDatos();

  //Obtener todos los comentarios
  Future<List<Comentario>> obtenerComentarios() async {
    return await _ayudanteBaseDatos.obtenerComentarios();
  }

  //Insertar un comentario
  Future<void> agregarComentario(Comentario comentario) async {
    await _ayudanteBaseDatos.agregarComentario(comentario);
  }

  //Actualizar un comentario
  Future<void> actualizarComentario(Comentario comentario) async {
    await _ayudanteBaseDatos.actualizarComentario(comentario);
  }

  //Eliminar un comentario
  Future<void> eliminarComentario(int id) async {
    await _ayudanteBaseDatos.eliminarComentario(id);
  }
}
