import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
              title: const Text('Ver categorias'),
              onTap: () {
                Navigator.pushNamed(context, '/listarCategoria');
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: Align(
              alignment: Alignment.center,
              child: ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Crear nueva categoria para productos'),
                onTap: () {
                  Navigator.pushNamed(context, '/crearCategoria');
                },
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar categoria'),
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
              title: const Text('Eliminar categoria'),
              onTap: () {
                Navigator.pushNamed(context, '/eliminarCategoria');
              },
            ),
          ),
        ],
      ),
    );
  }
}
