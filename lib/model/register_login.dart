const String tableDataUser = 'usuarios';

///Clase que contiene todos los atributos o campos que tiene la tabla usuarios
class DataFieldsUsuarios {
  static final List<String> values = [
    id,
    name,
    email,
    document,
    phone,
    password
  ];
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String document = 'document';
  static const String phone = 'phone';
  static const String password = 'password';
  //static const String tipo = 'tipo';
}

///Modelo Usuarios con los atributos, encargado de convertir y retornar la información de la tabla Usuarios en formato json
class Usuarios {
  int? id;
  String name;
  String email;
  String document;
  String phone;
  String password;
  //String tipo;

  Usuarios({
    this.id,
    required this.name,
    required this.email,
    required this.document,
    required this.phone,
    required this.password,
    //required this.tipo
  });

  Usuarios copy({
    int? id,
    String? name,
    String? email,
    String? document,
    String? phone,
    String? password,
    //String? tipo
  }) =>
      Usuarios(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        document: document ?? this.document,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        //tipo: tipo ?? this.tipo,
      );

  static Usuarios fromJson(Map<String, Object?> json) => Usuarios(
        id: json["id"] as int,
        name: json["name"] as String,
        email: json["email"] as String,
        document: json["document"] as String,
        phone: json["phone"] as String,
        password: json["password"] as String,
        //tipo: json["tipo"] as String,
      );

  Map<String, Object?> toJson() => {
        DataFieldsUsuarios.id: id,
        DataFieldsUsuarios.name: name,
        DataFieldsUsuarios.email: email,
        DataFieldsUsuarios.document: document,
        DataFieldsUsuarios.phone: phone,
        DataFieldsUsuarios.password: password,
      };
}
