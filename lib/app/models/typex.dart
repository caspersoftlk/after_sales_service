import 'dart:convert';

class Typex{
  final int id;
  final String name;
  final String description;

  String toJson() => json.encode(toMap());

  factory Typex.fromJson(String source) =>
      Typex.fromMap(json.decode(source));

//<editor-fold desc="Data Methods">

  const Typex({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Typex &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;

  @override
  String toString() {
    return 'Typex{' +
        ' id: $id,' +
        ' name: $name,' +
        ' description: $description,' +
        '}';
  }

  Typex copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Typex(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
    };
  }

  factory Typex.fromMap(Map<String, dynamic> map) {
    return Typex(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

//</editor-fold>
}