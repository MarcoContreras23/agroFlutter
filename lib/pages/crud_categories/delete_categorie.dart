import 'package:agro2/database/db.dart';
import 'package:agro2/model/category.dart';
import 'package:flutter/material.dart';

class DeleteCategorie extends StatefulWidget {
  const DeleteCategorie({Key? key}) : super(key: key);

  @override
  State<DeleteCategorie> createState() => _DeleteCategorieState();
}

class _DeleteCategorieState extends State<DeleteCategorie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar categorias'),
      ),
      body: Container(
        child: FutureBuilder<List<Categoria>>(
          future: DB.instance.readAllData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Categoria>> snapshop) {
            if (snapshop.hasData) {
              return ListView.builder(
                itemCount: snapshop.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  print("snapshot data: ${snapshop.data?[index].name}");
                  return ListTile(
                    title: Text(snapshop.data![index].name),
                    subtitle: Text(snapshop.data![index].description),
                    onTap: () {
                      DB.instance.deleteData(snapshop.data![index].id!);
                      setState(() {});
                    },
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/87651/earth-blue-planet-globe-planet-87651.jpeg'),
                    ),
                    trailing: const Icon(Icons.delete),
                  );
                },
              );
            } else if (snapshop.hasError) {
              return Center(
                child: Text("Error:\ ${snapshop.error}"),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
