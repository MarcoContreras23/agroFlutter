import 'package:agro2/model/product.dart';
import 'package:flutter/material.dart';

class GroceryProductDetails extends StatefulWidget {
  const GroceryProductDetails(
      {Key? key, required this.product, required this.onProductAdded})
      : super(key: key);

  final Product product;
  final VoidCallback onProductAdded;

  @override
  State<GroceryProductDetails> createState() => _GroceryProductDetailsState();
}

class _GroceryProductDetailsState extends State<GroceryProductDetails> {
  String heroTag = '';

  /// Funcion encargada de añadir al carrito y hacer la animación cambiando el HeroTag
  void _addToCart(BuildContext context) {
    setState(() {
      heroTag = 'details';
    });
    widget.onProductAdded();
    Navigator.of(context).pop();
  }

  /// Widgets principal encargado de mostrar la información del producto
  @override
  Widget build(BuildContext context) {
    print(widget.product.name);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'list_${widget.product.name}$heroTag',
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      widget.product.description,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 189, 179, 179)),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          '\$${widget.product.price}',
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: RaisedButton(
                      color: const Color.fromARGB(255, 197, 254, 37),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Añadir al carrito',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        _addToCart(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
