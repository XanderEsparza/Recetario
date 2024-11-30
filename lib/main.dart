import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/usuario_provider.dart';
import './provider/receta_provider.dart';
import 'ui/pantalla_bienvenida.dart';
import './ui/pantalla_login.dart';
import './ui/navbar.dart';
import './ui/pantalla_registro.dart';
import './ui/pantalla_agregar_receta.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => RecetaProvider()),
      ],
      child: MyApp(),
    ),
  );
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
        '/agregarReceta': (context) => CreateRecipeScreen()
      },
    );
  }
}
