import 'package:agro2/model/category.dart';
import 'package:agro2/model/order.dart';
import 'package:agro2/model/register_login.dart';
import 'package:agro2/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static final DB instance = DB._init();
  static Database? _database;
  DB._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('dataBase1.db');
    return _database;
  }

  Future<Database?> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /*
  Creación de las tablas en la bases de datos 
  */
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute(
        'CREATE TABLE $tableDataCategorie (${DataFields.id} $idType, ${DataFields.name} $textType , ${DataFields.description} $textType )');
    await db.execute(
        'CREATE TABLE $tableDataProduct (${DataFieldsProduct.id} $idType, ${DataFieldsProduct.name} $textType , ${DataFieldsProduct.description} $textType,${DataFieldsProduct.price} $textType, ${DataFieldsProduct.quantity} $textType)');
    await db.execute(
        'CREATE TABLE $tableDataUser (${DataFieldsUsuarios.id} $idType, ${DataFieldsUsuarios.name} $textType , ${DataFieldsUsuarios.email} $textType,${DataFieldsUsuarios.document} $textType,${DataFieldsUsuarios.phone} $textType, ${DataFieldsUsuarios.password} $textType)');
    await db.execute(
        'CREATE TABLE $tableDataOrder (${DataFieldsOrder.id} $idType, ${DataFieldsOrder.products} $textType , ${DataFieldsOrder.price} $textType)');
  }

  /*
    *recibe como parametro la información del dato a guardar 
    *Inserta un registro en la base de datos en la tabla categorias
  */
  Future<Categoria> insertData(Categoria data) async {
    final db = await database;
    final id = await db?.insert(tableDataCategorie, data.toJson());
    return data.copy(id: id);
  }

  /*
    *recibe como parametro la información del dato a guardar 
    *Inserta un registro en la base de datos en la tabla productos
  */
  Future<Product> insertDataProduct(Product data) async {
    final db = await database;
    final id = await db?.insert(tableDataProduct, data.toJson());
    return data.copy(id: id);
  }

  /*
    *recibe como parametro la información del usuario a registrar 
    *Inserta un registro en la base de datos en la tabla usuarios
  */
  Future<Usuarios> insertDataUsuarios(Usuarios data) async {
    final db = await database;
    final id = await db?.insert(tableDataUser, data.toJson());
    return data.copy(id: id);
  }

  /*
    *recibe como parametro la información de la orden  
    *Inserta un registro en la base de datos en la tabla ordenes
  */
  Future<Order> insertDataOrders(Order data) async {
    final db = await database;
    final id = await db?.insert(tableDataOrder, data.toJson());
    return data.copy(id: id);
  }

  /*
    *recibe como parametro el id del dato a buscar
    *Obtiene un dato en especifico de la base de datos de la tabla categorias
    *retorna un json con el dato obtenido
  */
  Future<Categoria> readData(int id) async {
    final db = await instance.database;
    final maps = await db!.query(
      tableDataCategorie,
      columns: DataFields.values,
      where: '${DataFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Categoria.fromJson(maps.first);
    } else {
      throw Exception('Data $id not found');
    }
  }

  /*
    *recibe como parametro el id del dato a buscar
    *Obtiene un dato en especifico de la base de datos de la tabla categorias
    *retorna un json con el dato obtenido
  */
  Future<Product> readDataProduct(int id) async {
    final db = await instance.database;
    final maps = await db!.query(
      tableDataProduct,
      columns: DataFieldsProduct.values,
      where: '${DataFieldsProduct.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      throw Exception('Data $id not found');
    }
  }

  /*
    *Obtiene todos los datos de la base de datos
    *retorna un json con los datos obtenidos
  */
  Future<List<Categoria>> readAllData() async {
    final db = await instance.database;
    final result = await db?.query(tableDataCategorie);
    var result2 = result!.map((json) => Categoria.fromJson(json)).toList();
    return result2;
  }

  /*
    *Obtiene todos los datos de la base de datos
    *retorna un json con los datos obtenidos
  */
  Future<List<Product>> readAllDataProduct() async {
    final db = await instance.database;
    final result = await db?.query(tableDataProduct);
    var result2 = result!.map((json) => Product.fromJson(json)).toList();
    return result2;
  }

  /*
    *Obtiene todos los datos de la base de datos
    *retorna un json con los datos obtenidos
  */
  Future<List<Usuarios>> readAllDataUsuarios() async {
    final db = await instance.database;
    final result = await db?.query(tableDataUser);
    var result2 = result!.map((json) => Usuarios.fromJson(json)).toList();
    return result2;
  }

  Future<List<Order>> readAllDataOrders() async {
    final db = await instance.database;
    final result = await db?.query(tableDataOrder);
    var result2 = result!.map((json) => Order.fromJson(json)).toList();
    return result2;
  }

  /*
    *Elimina un dato de la tabla de categorias
    *recibe como parametro el id de la categoria a eliminar
  */
  Future<int> deleteData(int id) async {
    final db = await instance.database;

    return await db!.delete(tableDataCategorie,
        where: '${DataFields.id} = ?', whereArgs: [id]);
  }

  /*
    *Elimina un dato de la tabla de productos 
    *recibe como parametro el id del producto a eliminar
  */
  Future<int> deleteDataProduct(int id) async {
    final db = await instance.database;

    return await db!.delete(tableDataProduct,
        where: '${DataFields.id} = ?', whereArgs: [id]);
  }

  /*
    *Elimina un dato de la tabla de productos 
    *recibe como parametro el id del producto a eliminar
  */
  Future<int> deleteDataOrder(int id) async {
    final db = await instance.database;

    return await db!.delete(tableDataOrder,
        where: '${DataFieldsOrder.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db?.close();
  }
}
