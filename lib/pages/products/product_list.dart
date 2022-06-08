// ignore_for_file: deprecated_member_use

import 'package:agro2/database/db.dart';
import 'package:agro2/pages/products/home_products.dart';
import 'package:agro2/pages/products/product_detail.dart';
import 'package:agro2/provider/provider_cart.dart';
import 'package:agro2/widgets/bar_search.dart';
import 'package:flutter/material.dart';

class GroceryProductsList extends StatefulWidget {
  const GroceryProductsList({Key? key}) : super(key: key);

  @override
  State<GroceryProductsList> createState() => _GroceryProductsListState();
}

class _GroceryProductsListState extends State<GroceryProductsList> {
  ///Widget principal donde se contruye la vista de la lista de productos
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _body(context),
          ],
        ),
      ),
    );
  }

  ///Widget que contiene la estructura princial de la lista de productos
  Widget _body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.09,
        ),
        _bodyParteUno(),
        Flexible(
          child: _listProduct(context),
        ),
      ],
    );
  }

  ///Widget que contiene el navBar de la vista, barra de buscar y el boton de regreso
  Widget _bodyParteUno() {
    final size = MediaQuery.of(context).size;
    final bloc = GroceryProvider.of(context)?.bloc;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          const BarSearch(),
        ],
      ),
    );
  }

  ///Widget donde se listan todos los productos existentes

  Widget _listProduct(BuildContext context) {
    final bloc = GroceryProvider.of(context)?.bloc;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: DB.instance.readAllDataProduct(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: cartBarHeight),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final product = snapshot.data[index];
                final products = [];
                products.add(product);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, __) {
                          return FadeTransition(
                            opacity: animation,
                            child: GroceryProductDetails(
                              product: product,
                              onProductAdded: () {
                                bloc?.addProduct(product);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Row(
                        children: [
                          Hero(
                            tag: 'list_product',
                            child: Stack(
                              children: const [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://images.pexels.com/photos/87651/earth-blue-planet-globe-planet-87651.jpeg'),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 6,
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 14),
                                    height: 55,
                                    width: 120,
                                    child: Text(
                                      snapshot.data![index].name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 14),
                                    height: 55,
                                    width: 100,
                                    child: Text(
                                      '\$${snapshot.data![index].price}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text('Cargando...');
          }
        },
      ),
    );
  }
}
