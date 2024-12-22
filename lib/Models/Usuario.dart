class Usuario {
  const Usuario(
      {required this.nombre,
      required this.id,
       this.ingreso,
      required this.creado});
  final String nombre;
  final String id;
  final DateTime? ingreso;
  final DateTime creado;

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nombre: map['nombre'] as String,
      id: map['id'] as String,
      ingreso: map['ingreso'] != null ? map['ingreso'].toDate() : null,
      creado: map['creado'].toDate(),
    );
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nombre': nombre,
      'id': id,
      'creado': creado,
    };
  }
}
