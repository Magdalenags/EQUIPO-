import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';

/// Pantalla de registro con validación de formulario.
/// Conecta con AuthService para crear nuevos usuarios.
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _usuarioController.dispose();
    _contrasenaController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  /// Procesa el formulario de registro
  Future<void> _registrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      try {
        await AuthService().registrarUsuario(
          Usuario(
            nombre: _nombreController.text,
            usuario: _usuarioController.text,
            contrasena: _contrasenaController.text,
            correo: _correoController.text,
            telefono: _telefonoController.text,
          ),
        );
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registro exitoso!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: _nombreController,
                  label: 'Nombre Completo',
                  validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _usuarioController,
                  label: 'Nombre de Usuario',
                  validator: (value) =>
                    value!.length < 4 ? 'Mínimo 4 caracteres' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _contrasenaController,
                  label: 'Contraseña',
                  obscureText: true,
                  validator: (value) =>
                    value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _correoController,
                  label: 'Correo Electrónico',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                    !value!.contains('@') ? 'Correo inválido' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _telefonoController,
                  label: 'Teléfono (Opcional)',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _registrarUsuario,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('REGISTRARSE'),
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