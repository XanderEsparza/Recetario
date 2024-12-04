import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/receta_provider.dart';
import 'dart:io';
import '../ui/pantalla_detalle.dart';

class BuscarRecetas extends StatefulWidget {
  const BuscarRecetas({Key? key}) : super(key: key);

  @override
  State<BuscarRecetas> createState() => _BuscarRecetasState();
}

class _BuscarRecetasState extends State<BuscarRecetas> {
  final TextEditingController _searchController = TextEditingController();

  void buscarRecetas(BuildContext context) {
    final recetaProvider = Provider.of<RecetaProvider>(context, listen: false);
    recetaProvider.buscarRecetas(_searchController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Buscar Recetas', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de búsqueda
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Busca una receta...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => buscarRecetas(context),
                  ),
                ),
                onSubmitted: (_) => buscarRecetas(context),
              ),
            ),
            const SizedBox(height: 20),

            // Resultados de búsqueda
            Expanded(
              child: Consumer<RecetaProvider>(
                builder: (context, recetaProvider, child) {
                  final recetas = recetaProvider.recetasFiltradas;

                  if (recetas.isEmpty) {
                    return const Center(
                      child: Text(
                        'No se encontraron recetas',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: recetas.length,
                    itemBuilder: (context, index) {
                      final receta = recetas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: receta.imagen != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(receta.imagen),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.fastfood, size: 50),
                          title: Text(receta.nombre,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            receta.descripcion,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PantallaDetalle(receta: receta),
                              ),
                            );
                          },
                        ),
                      );
                    },
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
