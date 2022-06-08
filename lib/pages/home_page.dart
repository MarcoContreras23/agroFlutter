import 'package:agro2/pages/categories.dart';
import 'package:agro2/pages/landing/login_page.dart';
import 'package:agro2/pages/product.dart';
import 'package:agro2/provider/screen_provider.dart';
import 'package:agro2/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

///Widget pricnipal que muestra la vista segun la barra de navegación inferior
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroMarket'),
      ),
      body: Consumer<ScreenCurrent>(
        builder: (context, current, child) {
          switch (current.current) {
            case 0:
              return const CategoriesPage();
            case 1:
              return const ProductPage();
            default:
              return const CategoriesPage();
          }
        },
      ),
      bottomNavigationBar: const BottonNavigator(),
    );
  }
}
