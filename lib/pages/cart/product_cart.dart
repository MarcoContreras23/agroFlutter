import 'dart:convert';

import 'package:agro2/database/db.dart';
import 'package:agro2/model/order.dart';
import 'package:agro2/model/store_bloc.dart';
import 'package:agro2/provider/provider_cart.dart';
import 'package:flutter/material.dart';

class GrocerytoreCart extends StatefulWidget {
  const GrocerytoreCart({Key? key}) : super(key: key);

  @override
  State<GrocerytoreCart> createState() => _GrocerytoreCartState();
}

String precio = "";
String prodcutsString = "";
List products = [];
bool state = false;

class _GrocerytoreCartState extends State<GrocerytoreCart> {
  ///Widget principal que contiene todos los widget encargados de pintar la vista del carrito
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _fondo(size),
            _body(context),
          ],
        ),
      ),
    );
  }

  ///Widget encargado de pintar el fondo del carrito
  Widget _fondo(size) {
    return Container(
      height: size.height * 0.3,
      decoration: const BoxDecoration(
        color: Colors.white,
        // image: DecorationImage(
        //   image: AssetImage("assets/FondoShop.png"),
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }

  ///Widget encargado de pintar cuerpo del carrito
  Widget _body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.01,
        ),
        Flexible(
          child: carrito(context),
        ),
      ],
    );
  }

  ///Widget encargado de pintar el carrito
  Widget carrito(BuildContext context) {
    final bloc = GroceryProvider.of(context)?.bloc ?? GroceryStoreBloc();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // image: DecorationImage(
        //   image: AssetImage("assets/FondoShop.png"),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: bloc.cart.length,
                      itemBuilder: (context, index) {
                        final item = bloc.cart[index];
                        products.add(item);
                        Image image = Image.asset('assets/logo.png');
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                  backgroundImage: image.image,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  item.quantity.toString(),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                              const Expanded(
                                  child: Text(
                                "x",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '\$${(int.parse(item.product.price) * item.quantity).toString()}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color:
                                      const Color.fromARGB(255, 145, 138, 138),
                                  onPressed: () {
                                    setState(() {
                                      bloc.deleteProduct(item);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  '\$${bloc.totalPriceElement()}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              color: const Color.fromARGB(255, 197, 254, 37),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Pagar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              onPressed: () => _crear(),
            ),
          ),
        ],
      ),
    );
  }

  void _crear() {
    prodcutsString = "";
    final bloc = GroceryProvider.of(context)?.bloc ?? GroceryStoreBloc();
    precio = bloc.totalPriceElement().toString();
    for (var i = 0; i < bloc.cart.length; i++) {
      if (bloc.cart.length == 1) {
        prodcutsString = "${products[i].product.name}" + prodcutsString;
        state = true;
      }
      if (bloc.cart.length > 1) {
        prodcutsString = "${products[i].product.name}," + prodcutsString;
        state = true;
      }
    }
    final data = {
      'products': prodcutsString,
      'price': precio,
    };
    setState(() {});
    if(state){
    _queryData(data);
    }
  }

  void _queryData(data) {
    dynamic user2 = jsonEncode(data);
    Map<String, dynamic> user = jsonDecode(user2);
    var dataRegister = Order.fromJson(user);
    DB.instance.insertDataOrders(dataRegister);
  }
}
