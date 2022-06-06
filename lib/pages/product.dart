import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(
            height: 50,
            child: ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Ver Productos'),
              onTap: () {
                Navigator.pushNamed(context, '/listarProductos');
                print("ver productos");
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: Align(
              alignment: Alignment.center,
              child: ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Publicar nuevo producto'),
                onTap: () {
                  Navigator.pushNamed(context, '/crearProductos');
                  print("crear");
                },
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar producto'),
              onTap: () {
                Navigator.pushNamed(context, '/');
                print("editar");
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Eliminar producto'),
              onTap: () {
                Navigator.pushNamed(context, '/');
                print("eliminar");
              },
            ),
          ),
        ],
      ),
    );
  }
}
