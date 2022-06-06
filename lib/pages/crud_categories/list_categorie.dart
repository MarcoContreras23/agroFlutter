import 'package:agro2/database/db.dart';
import 'package:agro2/model/category.dart';
import 'package:flutter/material.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({Key? key}) : super(key: key);

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
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
                    onTap: () {},
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/87651/earth-blue-planet-globe-planet-87651.jpeg'),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
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
