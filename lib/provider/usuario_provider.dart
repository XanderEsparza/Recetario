import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../repositorio/usuario_repositorio.dart';
import '../helpers/encriptar.dart';

class UsuarioProvider with ChangeNotifier {
  final UsuarioRepositorio _usuarioRepositorio = UsuarioRepositorio();
  List<Usuario> _usuarios = [];

  List<Usuario> get usuarios => _usuarios;

  Future<void> obtenerUsuarios() async {
    _usuarios = await _usuarioRepositorio.obtenerUsuarios();
    notifyListeners();
  }

  Future<void> agregarUsuario(Usuario usuario) async {
    usuario.password = encriptarPassword(usuario.password);
    await _usuarioRepositorio.agregarUsuario(usuario);
    await obtenerUsuarios();
  }

  Future<void> actualizarUsuario(Usuario usuario) async {
    await _usuarioRepositorio.actualizarUsuario(usuario);
    await obtenerUsuarios();
  }

  Future<void> eliminarUsuario(int id) async {
    await _usuarioRepositorio.eliminarUsuario(id);
    await obtenerUsuarios();
  }
}
