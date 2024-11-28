import 'package:flutter/material.dart';
import 'ui/pantalla_bienvenida.dart';
import './ui/pantalla_login.dart';
import './ui/navbar.dart';
import './ui/pantalla_registro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/bienvenida',
      routes: {
        '/bienvenida': (context) => PantallaBienvenida(),
        '/login': (context) => PantallaLogin(),
        '/registro': (context) => PantallaRegistro(),
        '/recetas': (context) => NavBar(),
      },
    );
  }
}
