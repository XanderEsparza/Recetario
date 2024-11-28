import 'package:flutter/material.dart';
import 'package:recetario/ui/pantalla_registro.dart';

class PantallaLogin extends StatelessWidget {
  const PantallaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado con imagen y título
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/fondo_bienvenida.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/icono.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Formulario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Campo de Usuario
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Usuario',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo de Contraseña
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Contraseña',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botón de Acceder
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/recetas');
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                    ),
                    child: const Text(
                      'Acceder',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Enlace a la pantalla de Registro
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PantallaRegistro(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: '¿Aún no tienes cuenta? ',
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
          ],
        ),
      ),
    );
  }
}
