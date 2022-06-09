import 'package:agro2/database/db.dart';
import 'package:agro2/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('El contador debe ser incrementado', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });

  test('Creación producto', () {
    WidgetsFlutterBinding();
    final producto = CrearProductos();

    producto.crear();
    

    expect(producto.productos,1);
  });

  test('Creación de la orden', () {
    WidgetsFlutterBinding();
    final orden = CrearOrden();

    orden.crearOrden();
    

    expect(orden.ordenes,1);
  });
}
