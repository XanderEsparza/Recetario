import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../repositorio/usuario_repositorio.dart';
import '../helpers/encriptar.dart';

class UsuarioProvider with ChangeNotifier {
  final UsuarioRepositorio _usuarioRepositorio = UsuarioRepositorio();
  List<Usuario> _usuarios = [];

  List<Usuario> get usuarios => _usuarios;

  Usuario? _currentUser;

  Usuario? get currentUser => _currentUser;

  Future<void> obtenerUsuarios() async {
    _usuarios = await _usuarioRepositorio.obtenerUsuarios();
    notifyListeners();
  }

  Future<bool> agregarUsuario(Usuario nuevoUsuario) async {
    if (_usuarios.any((usuario) => usuario.usuario == nuevoUsuario.usuario)) {
      return false; // Retornamos false si el usuario ya existe
    }
    nuevoUsuario.password = encriptarPassword(nuevoUsuario.password);
    await _usuarioRepositorio.agregarUsuario(nuevoUsuario);
    await obtenerUsuarios();
    notifyListeners(); // Notificamos a los listeners sobre el cambio
    return true; // Retornamos true si el usuario se agregó correctamente
  }

  Future<void> actualizarUsuario(Usuario usuario) async {
    await _usuarioRepositorio.actualizarUsuario(usuario);
    _currentUser = usuario;
    notifyListeners();
    await obtenerUsuarios();
  }

  Future<void> eliminarUsuario(int id) async {
    await _usuarioRepositorio.eliminarUsuario(id);
    await obtenerUsuarios();
  }

  bool validarUsuario(String usuario, String password) {
    final hashedPassword = encriptarPassword(password);
    final userIndex = _usuarios.indexWhere(
      (u) => u.usuario == usuario && u.password == hashedPassword,
    );

    if (userIndex != -1) {
      _currentUser = _usuarios[userIndex];
      notifyListeners();
      return true;
    }
    return false;
  }

  void listarUsuarios() {
    for (var u in _usuarios) {
      print('Usuario: ${u.usuario}, Password: ${u.password}');
    }
  }
}
