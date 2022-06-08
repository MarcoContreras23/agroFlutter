import 'package:agro2/database/db.dart';
import 'package:flutter/material.dart';

enum GroceyState {
  normal,
  details,
  cart,
}

/// Clase que evalua el estado de la pantalla y añade o elimina productos al carrito
class GroceryStoreBloc with ChangeNotifier {
  GroceyState groceyState = GroceyState.normal;
  Future<List>? catalog = DB.instance.readAllDataProduct();
  List<GroceryProductItem> cart = [];

  void changeToNormal() {
    groceyState = GroceyState.normal;
    notifyListeners();
  }

  void changeToCart() {
    groceyState = GroceyState.cart;
    notifyListeners();
  }

  void addProduct(dynamic product) {
    for (GroceryProductItem item in cart) {
      if (item.product.name == product.name) {
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(GroceryProductItem(product: product));
    notifyListeners();
  }

  void deleteProduct(GroceryProductItem product) {
    product.decrement();
    notifyListeners();
    if (product.quantity == 0) {
      cart.remove(product);
    }
    return;
  }

  int totalCartElements() => cart.fold<int>(
      0, (previousValue, element) => previousValue + element.quantity);
  double totalPriceElement() => cart.fold<double>(
      0.0,
      (previousValue, element) =>
          previousValue +
          element.quantity * int.parse(element.product.price));
}

///Clase encargada de representar un producto en el carrito
class GroceryProductItem {
  GroceryProductItem(
      {this.quantity = 1, @required this.product, this.adicionales = const []});

  int quantity;
  final product;
  List adicionales = [];

  void increment() {
    quantity++;
  }

  void decrement() {
    quantity--;
  }
}