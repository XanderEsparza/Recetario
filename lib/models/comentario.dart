class Comentario {
  int? id;
  String comentario;
  int id_usuario;
  int id_receta;

  Comentario(
      {this.id,
      required this.comentario,
      required this.id_usuario,
      required this.id_receta});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'comentario': comentario,
      'id_usuario': id_usuario,
      'id_receta': id_receta
    };
  }

  factory Comentario.fromMap(Map<String, dynamic> map) {
    return Comentario(
        id: map['id'],
        comentario: map['comentario'],
        id_usuario: map['id_usuario'],
        id_receta: map['id_receta']);
  }
}
