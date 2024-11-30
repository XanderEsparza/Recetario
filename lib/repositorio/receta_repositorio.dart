import '../db/base_datos.dart';
import '../models/receta.dart';

class RecetaRepositorio {
  final AyudanteBaseDatos _ayudanteBaseDatos = AyudanteBaseDatos();

  //Obtener todas las recetas
  Future<List<Receta>> obtenerRecetas() async {
    return await _ayudanteBaseDatos.obtenerRecetas();
  }

  //Insertar una nueva receta
  Future<void> agregarReceta(Receta receta) async {
    await _ayudanteBaseDatos.agregarReceta(receta);
  }

  //Actualizar una receta
  Future<void> actualizarReceta(Receta receta) async {
    await _ayudanteBaseDatos.actualizarReceta(receta);
  }

  //Eliminar una receta
  Future<void> eliminarReceta(int id) async {
    await _ayudanteBaseDatos.eliminarReceta(id);
  }
}
