import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../provider/receta_provider.dart';
import '../provider/usuario_provider.dart';
import '../models/receta.dart';

class UpdateRecipeScreen extends StatefulWidget {
  final Receta? receta;

  UpdateRecipeScreen({this.receta});

  @override
  _UpdateRecipeScreenState createState() => _UpdateRecipeScreenState();
}

class _UpdateRecipeScreenState extends State<UpdateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  String difficulty = 'Fácil';
  File? _image;
  File? _documento;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _porcionesController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.receta != null) {
      _nombreController.text = widget.receta!.nombre;
      _porcionesController.text = widget.receta!.porciones.toString();
      difficulty = widget.receta!.dificultad;
      _categoriaController.text = widget.receta!.categoria;
      _descripcionController.text = widget.receta!.descripcion;
      _image = File(widget.receta!.imagen);
      _documento = File(widget.receta!.documento);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    setState(() {});
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _documento = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final currentUser = usuarioProvider.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.receta == null
                            ? 'Crear Receta'
                            : 'Actualizar Receta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre del platillo',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre del platillo';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _porcionesController,
                          decoration: InputDecoration(
                            labelText: 'Porciones',
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el número de porciones';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Por favor ingrese un número válido';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: difficulty,
                          decoration: InputDecoration(
                            labelText: 'Dificultad',
                            border: UnderlineInputBorder(),
                          ),
                          items:
                              ['Fácil', 'Medio', 'Difícil'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              difficulty = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _categoriaController,
                    decoration: InputDecoration(
                      labelText: 'Categoría',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la categoría';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _descripcionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la descripción';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text('Imagen:'),
                        SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _image!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: Text('Seleccionar Imagen'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text('Documento:'),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.description),
                              SizedBox(width: 10),
                              Text(_documento != null
                                  ? 'Documento seleccionado'
                                  : 'Ningún documento seleccionado'),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _pickDocument,
                          child: Text('Seleccionar Documento'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final receta = Receta(
                            id: widget.receta?.id ??
                                0, // Usamos el ID si existe
                            nombre: _nombreController.text,
                            porciones: int.parse(_porcionesController.text),
                            dificultad: difficulty,
                            categoria: _categoriaController.text,
                            descripcion: _descripcionController.text,
                            imagen: _image?.path ?? '',
                            documento: _documento?.path ?? '',
                            id_usuario: currentUser?.id ?? 1,
                          );

                          if (widget.receta == null) {
                            // Si es una receta nueva, agregarla
                            Provider.of<RecetaProvider>(context, listen: false)
                                .agregarReceta(receta);
                          } else {
                            // Si es una receta existente, actualizarla
                            Provider.of<RecetaProvider>(context, listen: false)
                                .actualizarReceta(receta);
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(widget.receta == null
                                    ? 'Receta agregada con éxito'
                                    : 'Receta actualizada con éxito')),
                          );
                          _nombreController.clear();
                          _porcionesController.clear();
                          _categoriaController.clear();
                          _descripcionController.clear();
                          setState(() {
                            _image = null;
                            _documento = null;
                          });
                          Navigator.pop(context);
                        }
                      },
                      child:
                          Text(widget.receta == null ? 'Crear' : 'Actualizar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 40),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
