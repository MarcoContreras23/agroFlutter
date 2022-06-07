import 'package:agro2/database/db.dart';

class User {
  final String name;
  final String id;

  const User({required this.name, required this.id});

  static User fromJson(Map<String, dynamic> json) =>
      User(name: json['nombre'], id: json['id']);
}

class UserApi {
  static Future<List<User>> getUserSuggestions(String query) async {
    final response = await DB.instance.readAllDataProduct();

    final List users = response;

    return users.map((json) => User.fromJson(json)).where((user) {
      final nameLower = user.name.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower);
    }).toList();
  }

  static Future<List<User>> getProducts(String query) async {
    String url = 'http://localhost:5000/producto/listar';

    final response = await DB.instance.readAllDataProduct();
    
      final List users = response;

      return users.map((json) => User.fromJson(json)).where((user) {
        final nameLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
  }
}
