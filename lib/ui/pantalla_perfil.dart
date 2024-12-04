import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetario/ui/pantalla_actualizar_perfil.dart';
import 'dart:io';
import '../provider/usuario_provider.dart';
import '../provider/receta_provider.dart';
import '../ui/pantalla_login.dart';

class PantallaPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final currentUser = usuarioProvider.currentUser;
    final recetaProvider = Provider.of<RecetaProvider>(context);

    final recetasUsuario = recetaProvider.recetas
        .where((receta) => receta.id_usuario == currentUser?.id)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              usuarioProvider.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const PantallaLogin(),
                ),
                (route) => false, // Esto elimina todas las rutas anteriores
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Parte superior (perfil)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[400],
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.black54,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PantallaActualizarPerfil(),
                              ),
                            );
                            print('Editar perfil');
                          },
                          tooltip: 'Editar perfil',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentUser?.nombre ?? 'Nombre no disponible',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '@${currentUser?.usuario ?? 'Sin usuario'}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            // Título de "Platillos principales"
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Platillos principales',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Grid de platillos principales con imágenes predeterminadas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: recetasUsuario.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final receta = recetasUsuario[index];
                  return GestureDetector(
                    onTap: () {
                      // Acción al presionar una receta
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                  bottom: Radius.circular(10)),
                              child: Image.file(
                                File(receta.imagen),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
