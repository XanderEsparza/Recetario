class Usuario {
  int? id;
  String nombre;
  String apellidos;
  String usuario;
  String password;

  Usuario({
    this.id,
    required this.nombre,
    required this.apellidos,
    required this.usuario,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'usuario': usuario,
      'password': password,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nombre: map['nombre'],
      apellidos: map['apellidos'],
      usuario: map['usuario'],
      password: map['password'],
    );
  }
}
