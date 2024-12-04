import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/receta.dart';
import '../models/comentario.dart';
import '../provider/comentario_provider.dart';
import '../provider/usuario_provider.dart';
import 'package:open_filex/open_filex.dart';

class PantallaDetalle extends StatefulWidget {
  final Receta receta;

  const PantallaDetalle({Key? key, required this.receta}) : super(key: key);

  @override
  _PantallaDetalleState createState() => _PantallaDetalleState();
}

class _PantallaDetalleState extends State<PantallaDetalle> {
  final TextEditingController comentarioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Cargar los comentarios cuando la pantalla se inicia
    final comentarioProvider =
        Provider.of<ComentarioProvider>(context, listen: false);
    comentarioProvider.obtenerComentarios();
  }

  @override
  Widget build(BuildContext context) {
    final comentarioProvider = Provider.of<ComentarioProvider>(context);
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    // Filtrar los comentarios por el id_receta de la receta actual
    final comentariosFiltrados = comentarioProvider.comentarios
        .where((comentario) => comentario.id_receta == widget.receta.id)
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen principal y botón de cerrar
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  child: Image.file(
                    File(widget.receta.imagen),
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Título de la receta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.receta.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Información clave de la receta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoIcon(
                    icon: Icons.emoji_events,
                    label: 'Dificultad',
                    value: widget.receta.dificultad ?? 'N/A',
                  ),
                  _infoIcon(
                    icon: Icons.restaurant,
                    label: 'Porciones',
                    value: widget.receta.porciones.toString(),
                  ),
                  _infoIcon(
                    icon: Icons.category,
                    label: 'Categoría',
                    value: widget.receta.categoria ?? 'N/A',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Descripción de la receta
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
                    widget.receta.descripcion,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionButton(
                      icon: Icons.menu_book,
                      label: 'Ver receta',
                      onPressed: () async {
                        print('Ruta del archivo: ${widget.receta.documento}');
                        try {
                          await OpenFilex.open(widget.receta.documento);
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Error al abrir el documento: $e')));
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Formulario para agregar un comentario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Agregar un comentario',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: comentarioController,
                    decoration: const InputDecoration(
                      hintText: 'Escribe tu comentario aquí...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final nuevoComentario = Comentario(
                        comentario: comentarioController.text,
                        id_usuario: usuarioProvider.currentUser?.id ?? 1,
                        id_receta: widget.receta.id!,
                      );

                      await comentarioProvider
                          .agregarComentario(nuevoComentario);
                      comentarioController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Comentario agregado con éxito'),
                        ),
                      );
                    },
                    child: const Text('Comentar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Lista de comentarios
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comentarios',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comentariosFiltrados.length,
                    itemBuilder: (context, index) {
                      final comentario = comentariosFiltrados[index];
                      final nombreUsuario = usuarioProvider
                          .getNombreUsuario(comentario.id_usuario);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(nombreUsuario),
                          subtitle: Text(
                            comentario.comentario,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _infoIcon({
    required IconData icon,
    required String label,
    required String value,
  }) {
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
          icon: Icon(icon,
              size: 50, color: const Color.fromARGB(255, 128, 47, 182)),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
