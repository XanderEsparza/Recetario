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
    print(
        'usuario agregado:  ${usuario.usuario}, Password: ${usuario.password}');
    listarUsuarios();
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

  bool validarUsuario(String usuario, String password) {
    final hashedPassword = encriptarPassword(password);
    return _usuarios
        .any((u) => u.usuario == usuario && u.password == hashedPassword);
  }

  void listarUsuarios() {
    for (var u in _usuarios) {
      print('Usuario: ${u.usuario}, Password: ${u.password}');
    }
  }
}
