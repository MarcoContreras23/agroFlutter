import 'package:agro2/database/db.dart';
import 'package:agro2/model/product.dart';
import 'package:flutter/material.dart';

class ListProducts extends StatefulWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: Container(
        child: FutureBuilder<List<Product>>(
          future: DB.instance.readAllDataProduct(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshop) {
            if (snapshop.hasData) {
              return ListView.builder(
                itemCount: snapshop.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshop.data![index].name),
                    subtitle: Text(snapshop.data![index].price),
                    onTap: () {},
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/87651/earth-blue-planet-globe-planet-87651.jpeg'),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
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
