import 'package:flutter/material.dart';
import 'package:recetario/ui/pantalla_registro.dart';
import 'package:provider/provider.dart';
import '../provider/usuario_provider.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({Key? key}) : super(key: key);

  @override
  _PantallaLoginState createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  @override
  void initState() {
    super.initState();
    Provider.of<UsuarioProvider>(context, listen: false).obtenerUsuarios();
  }

  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();

  void _iniciarSesion() {
    if (_formKey.currentState!.validate()) {
      final usuario = _usuarioController.text;
      final password = _passwordController.text;

      final usuarioProvider =
          Provider.of<UsuarioProvider>(context, listen: false);

      if (usuarioProvider.validarUsuario(usuario, password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );
        Navigator.pushReplacementNamed(context, '/recetas');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario o contraseña incorrectos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Encabezado con imagen y título
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
                const SizedBox(height: 20),

                // Formulario
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _usuarioController,
                        decoration: const InputDecoration(labelText: 'Usuario'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu usuario';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Contraseña'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _iniciarSesion,
                        child: const Text('Iniciar sesión'),
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
                            text: '¿Aun no tienes una cuenta? ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Crea una',
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
        ),
      ),
    );
  }
}
