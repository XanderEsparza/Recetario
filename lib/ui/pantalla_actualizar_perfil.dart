import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/usuario_provider.dart';
import '../models/usuario.dart';

class PantallaActualizarPerfil extends StatefulWidget {
  @override
  _PantallaActualizarPerfilState createState() =>
      _PantallaActualizarPerfilState();
}

class _PantallaActualizarPerfilState extends State<PantallaActualizarPerfil> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    final currentUser =
        Provider.of<UsuarioProvider>(context, listen: false).currentUser;
    _nameController = TextEditingController(text: currentUser?.nombre ?? '');
    _lastNameController =
        TextEditingController(text: currentUser?.apellidos ?? '');
    _usernameController =
        TextEditingController(text: currentUser?.usuario ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final usuarioProvider =
            Provider.of<UsuarioProvider>(context, listen: false);
        final currentUser = usuarioProvider.currentUser;

        if (currentUser != null) {
          final updatedUser = Usuario(
              id: currentUser.id,
              nombre: _nameController.text,
              apellidos: _lastNameController.text,
              usuario: _usernameController.text,
              password: currentUser.password);

          await usuarioProvider.actualizarUsuario(updatedUser);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Perfil actualizado con éxito')),
          );
          Navigator.pop(context);
        } else {
          throw Exception('Usuario no encontrado');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el perfil: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre(s)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tus apellidos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre de usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () => _updateProfile(context),
                  child: Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
