// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:agro2/pages/crud_categories/create_categorie.dart';
import 'package:agro2/pages/crud_categories/delete_categorie.dart';
import 'package:agro2/pages/crud_categories/list_categorie.dart';
import 'package:agro2/pages/home_page.dart';
import 'package:agro2/pages/landing_page.dart';
import 'package:agro2/pages/register_page.dart';
import 'package:agro2/pages/products/crud_products/delete_product.dart';
import 'package:agro2/pages/products/home_products.dart';
import 'package:agro2/pages/products/crud_products/create_product.dart';
import 'package:agro2/provider/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScreenCurrent>(
            create: (context) => ScreenCurrent()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 43.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 24.0),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/landing': (context) => LandingPage(),
          '/registro': (context) => const RegisterPage(),
          '/crearCategoria': (context) => const CreateCategorie(),
          '/crearProductos': (context) => const CreateProducts(),
          '/listarCategoria': (context) => const ListCategories(),
          '/listProducts': (context) => const GroceryStoreHome(),
          '/eliminarCategoria': (context) => const DeleteCategorie(),
          '/eliminarProducto': (context) => const DeleteProduct(),
        },
      ),
    );
  }
}
