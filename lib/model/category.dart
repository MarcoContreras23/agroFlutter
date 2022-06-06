const String tableDataCategorie = 'categorias';

class DataFields {
  static final List<String> values = [id, name, description];
  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
}

class Categoria {
  int? id;
  String name;
  String description;

  Categoria({this.id, required this.name, required this.description});

  Categoria copy({
    int? id,
    String? name,
    String? description,
  }) =>
      Categoria(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  static Categoria fromJson(Map<String, Object?> json) => Categoria(
        id: json["id"] as int,
        name: json["name"] as String,
        description: json["description"] as String,
      );

  Map<String, Object?> toJson() => {
        DataFields.id: id,
        DataFields.name: name,
        DataFields.description: description,
      };
}
