import 'dart:convert';

import 'package:agro2/pages/categories.dart';
import 'package:agro2/pages/product.dart';
import 'package:agro2/pages/profile.dart';
import 'package:agro2/provider/screen_provider.dart';
import 'package:agro2/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

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
            case 2:
              return const ProfilePage();
            default:
              return const CategoriesPage();
          }
        },
      ),
      bottomNavigationBar: const BottonNavigator(),
    );
  }
}
