import 'package:agro2/preferences/preferences_user.dart';
import 'package:agro2/routes/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  final prefs = PreferenciasUsuario();
  WidgetsFlutterBinding();
  await prefs.iniciarPreferencias();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const Routes();
  }
}
