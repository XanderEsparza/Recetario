class Receta {
  int? id;
  String nombre;
  int porciones;
  String dificultad;
  String categoria;
  String descripcion;
  String documento;
  String imagen;
  int id_usuario;

  Receta(
      {this.id,
      required this.nombre,
      required this.porciones,
      required this.dificultad,
      required this.categoria,
      required this.descripcion,
      required this.documento,
      required this.imagen,
      required this.id_usuario});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'porciones': porciones,
      'dificultad': dificultad,
      'categoria': categoria,
      'descripcion': descripcion,
      'documento': documento,
      'imagen': imagen,
      'id_usuario': id_usuario
    };
  }

  factory Receta.fromMap(Map<String, dynamic> map) {
    return Receta(
      id: map['id'],
      nombre: map['nombre'],
      porciones: map['porciones'],
      dificultad: map['dificultad'],
      categoria: map['categoria'],
      descripcion: map['descripcion'],
      documento: map['documento'],
      imagen: map['imagen'],
      id_usuario: map['id_usuario'],
    );
  }
}
