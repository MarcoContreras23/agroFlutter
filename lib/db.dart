import 'dart:convert';
import 'package:agro2/model/order.dart';
import 'package:path/path.dart';
import 'package:agro2/database/db.dart';
import 'package:agro2/model/product.dart';
import 'package:sqflite/sqflite.dart';

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}

class CrearProductos {
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('dataBaseAgro.db');
    return _database;
  }

  Future<Database?> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute(
        'CREATE TABLE $tableDataProduct (${DataFieldsProduct.id} $idType, ${DataFieldsProduct.name} $textType , ${DataFieldsProduct.description} $textType,${DataFieldsProduct.price} $textType, ${DataFieldsProduct.quantity} $textType)');
  }

  int productos = 0;
  final data = {
    'id': 99999,
    'name': 'prueba producto',
    'description': 'prueba description',
    'price': '00000',
    'quantity': '1',
  };

  void crear() {
    dynamic user2 = jsonEncode(data);
    Map<String, dynamic> user = jsonDecode(user2);
    var dataProduct = Product.fromJson(user);
    DB.instance.insertDataProduct(dataProduct);
    increment();
  }

  void increment() => productos++;
}

class CrearOrden {
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('dataBaseAgro2.db');
    return _database;
  }

  Future<Database?> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

     await db.execute(
        'CREATE TABLE $tableDataOrder (${DataFieldsOrder.id} $idType, ${DataFieldsOrder.products} $textType , ${DataFieldsOrder.price} $textType)');
  }

  int ordenes = 0;
  final data = {
    'id': 99,
    'products': 'prueba producto orden',
    'price': '00000',
  };

  void crearOrden() {
    dynamic user2 = jsonEncode(data);
    Map<String, dynamic> user = jsonDecode(user2);
    var dataProduct = Order.fromJson(user);
    DB.instance.insertDataOrders(dataProduct);
    increment();
  }

  void increment() => ordenes++;
}