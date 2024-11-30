import 'package:flutter/material.dart';
import '../models/receta.dart';
import '../repositorio/receta_repositorio.dart';

class RecetaProvider with ChangeNotifier {
  final RecetaRepositorio _recetaRepositorio = RecetaRepositorio();
  List<Receta> _recetas = [];

  List<Receta> get recetas => _recetas;

  Future<void> obtenerRecetas() async {
    _recetas = await _recetaRepositorio.obtenerRecetas();
    notifyListeners();
  }

  Future<void> agregarReceta(Receta receta) async {
    await _recetaRepositorio.agregarReceta(receta);
    await obtenerRecetas();
  }

  Future<void> actualizarReceta(Receta receta) async {
    await _recetaRepositorio.actualizarReceta(receta);
    await obtenerRecetas();
  }

  Future<void> eliminarReceta(int id) async {
    await _recetaRepositorio.eliminarReceta(id);
    await obtenerRecetas();
  }
}
