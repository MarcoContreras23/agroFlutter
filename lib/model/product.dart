const String tableDataProduct = 'productos';

///Clase que contiene todos los atributos o campos que tiene la tabla productos
class DataFieldsProduct {
  static final List<String> values = [id, name, description, price, quantity];
  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
  static const String price = 'price';
  static const String quantity = 'quantity';
}
///Modelo Product con los atributos, encargado de convertir y retornar la información de la tabla productos en formato json
class Product {
  int? id;
  String name;
  String description;
  String price;
  String quantity;

  Product(
      {this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity});

  Product copy({
    int? id,
    String? name,
    String? description,
    String? price,
    String? quantity,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
      );

  static Product fromJson(Map<String, Object?> json) => Product(
        id: json["id"] as int,
        name: json["name"] as String,
        description: json["description"] as String,
        price: json["price"] as String,
        quantity: json["quantity"] as String,
      );

  Map<String, Object?> toJson() => {
        DataFieldsProduct.id: id,
        DataFieldsProduct.name: name,
        DataFieldsProduct.description: description,
        DataFieldsProduct.price: price,
        DataFieldsProduct.quantity: quantity,
      };
}
