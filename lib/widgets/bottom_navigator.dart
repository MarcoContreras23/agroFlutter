import 'package:agro2/provider/screen_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottonNavigator extends StatefulWidget {
  const BottonNavigator({Key? key}) : super(key: key);

  @override
  State<BottonNavigator> createState() => _BottonNavigatorState();
}

class _BottonNavigatorState extends State<BottonNavigator> {
  ///Widget principal que la barra de navegación inferior con su estilo y animación
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = Provider.of<ScreenCurrent>(context);
    return CurvedNavigationBar(
      index: _currentIndex,
      height: 60.0,
      items: const <Widget>[
        Text("Categorias"),
        Text("Productos"),
        Text("Perfil"),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.transparent,
      backgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (value) {
        _currentIndex = value;
        screens.screen = value;
        setState(() {});
      },
    );
  }
}