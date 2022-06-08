import 'package:agro2/database/db.dart';
import 'package:agro2/model/register_login.dart';
import 'package:flutter/material.dart';
class listado extends StatefulWidget {
  const listado({Key? key}) : super(key: key);

  @override
  State<listado> createState() => _listadoState();
}

class _listadoState extends State<listado> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      body: Container(
        child: FutureBuilder<List<Usuarios>>(
          future: DB.instance.readAllDataUsuarios(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Usuarios>> snapshop) {
            if (snapshop.hasData) {
              return ListView.builder(
                itemCount: snapshop.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  print("snapshot data: ${snapshop.data?[index].name}");
                  return ListTile(
                    title: Text(snapshop.data![index].name),
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