import 'dart:convert';

class TypeZ {
  TypeZ({
      this.id, 
      this.name, 
      this.description,});

  TypeZ.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }
  int? id;
  String? name;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
    };
  }

  factory TypeZ.fromMap(Map<String, dynamic> map) {
    return TypeZ(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJsonX() => json.encode(toMap());
}