import 'dart:io';
import 'package:flutter/material.dart';
import '../models/receta.dart';
import 'package:open_filex/open_filex.dart';

class PantallaDetalle extends StatelessWidget {
  final Receta receta;

  const PantallaDetalle({Key? key, required this.receta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen principal
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  child: Image.file(
                    File(receta.imagen),
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Botón de cerrar
                Positioned(
                  top: 20,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Título
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                receta.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Información clave
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoIcon(
                    icon: Icons.emoji_events,
                    label: 'Dificultad',
                    value: receta.dificultad ?? 'N/A',
                  ),
                  _infoIcon(
                    icon: Icons.restaurant,
                    label: 'Porciones',
                    value: receta.porciones.toString(),
                  ),
                  _infoIcon(
                    icon: Icons.category,
                    label: 'Categoría',
                    value: receta.categoria ?? 'N/A',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Descripción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    receta.descripcion,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Botones de acción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionButton(
                      icon: Icons.menu_book,
                      label: 'Ver receta',
                      onPressed: () async {
                        try {
                          // Abrir el documento almacenado en la receta
                          await OpenFilex.open(receta.documento);
                        } catch (e) {
                          // Manejo de errores
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Error al abrir el documento: $e')),
                          );
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _infoIcon(
      {required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.black),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 30, color: Colors.black),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
