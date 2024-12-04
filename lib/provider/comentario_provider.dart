import 'package:flutter/material.dart';
import '../models/comentario.dart';
import '../repositorio/comentario_repositorio.dart';

class ComentarioProvider with ChangeNotifier {
  final ComentarioRepositorio _comentarioRepositorio = ComentarioRepositorio();
  List<Comentario> _comentarios = [];

  List<Comentario> get comentarios => _comentarios;

  Future<void> obtenerComentarios() async {
    _comentarios = await _comentarioRepositorio.obtenerComentarios();
    notifyListeners();
  }

  Future<void> agregarComentario(Comentario comentario) async {
    await _comentarioRepositorio.agregarComentario(comentario);
    await obtenerComentarios();
  }

  Future<void> actualizarComentario(Comentario comentario) async {
    await _comentarioRepositorio.actualizarComentario(comentario);
    await obtenerComentarios();
  }

  Future<void> eliminarComentario(int id) async {
    await _comentarioRepositorio.eliminarComentario(id);
    await obtenerComentarios();
  }
}
