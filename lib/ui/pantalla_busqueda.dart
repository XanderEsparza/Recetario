import 'package:flutter/material.dart';

class PantallaBusqueda extends StatefulWidget {
  const PantallaBusqueda({Key? key}) : super(key: key);

  @override
  State<PantallaBusqueda> createState() => _PantallaBusquedaState();
}

class _PantallaBusquedaState extends State<PantallaBusqueda> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recetas = ["Enchiladas", "Tacos", "Pizza", "Sushi", "Paella"];
  List<String> resultadosBusqueda = [];

  void buscarRecetas() {
    String query = _searchController.text.trim().toLowerCase();
    setState(() {
      resultadosBusqueda = recetas
          .where((receta) => receta.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Recetas'),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        automaticallyImplyLeading: false,
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
                    onPressed: buscarRecetas,
                  ),
                ),
                onSubmitted: (_) => buscarRecetas(),
              ),
            ),
            const SizedBox(height: 20),

            // Resultados de búsqueda
            Expanded(
              child: resultadosBusqueda.isNotEmpty
                  ? ListView.builder(
                      itemCount: resultadosBusqueda.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(resultadosBusqueda[index]),
                          leading: const Icon(Icons.fastfood),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No se encontraron recetas',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
