const String tableDataOrder = 'ordenes';

///Clase que contiene todos los atributos o campos que tiene la tabla ordenes
class DataFieldsOrder {
  static final List<String> values = [id, products, price];
  static const String id = 'id';
  static const String products = 'products';
  static const String price = 'price';
}

///Modelo Order con los atributos, encargado de convertir y retornar la información de la tabla ordenes en formato json
class Order {
  int? id;
  String products;
  String price;

  Order({this.id, required this.products, required this.price});

  Order copy({
    int? id,
    String? products,
    String? price,
  }) =>
      Order(
        id: id ?? this.id,
        products: products ?? this.products,
        price: price ?? this.price,
      );

  static Order fromJson(Map<String, Object?> json) => Order(
        id: json["id"] as int,
        products: json["products"] as String,
        price: json["price"] as String,
      );

  Map<String, Object?> toJson() => {
        DataFieldsOrder.id: id,
        DataFieldsOrder.products: products,
        DataFieldsOrder.price: price,
      };
}
