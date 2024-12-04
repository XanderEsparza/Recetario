import 'package:flutter/material.dart';
import './pantalla_login.dart';
import './pantalla_registro.dart';
import 'package:provider/provider.dart';
import '../provider/usuario_provider.dart';

class PantallaBienvenida extends StatelessWidget {
  const PantallaBienvenida({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final currentUser = usuarioProvider.currentUser;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/fondo_bienvenida.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.4),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      'assets/icono.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botones y enlaces
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (currentUser?.id != null) {}
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PantallaLogin(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallaRegistro(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: 'Aun no tienes cuenta? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Registrarse',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
