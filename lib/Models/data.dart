
class Data {
  Data({required this.id, required this.creado});

  final String id;
  final DateTime creado;

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] as String,
      creado: (map['creado']).toDate(),
    );
  }
}