import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';

/// Pantalla de inicio de sesión con validación de credenciales.
/// Navega a HomeScreen al autenticarse exitosamente.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _usuarioController = TextEditingController();
  final _contrasenaController = TextEditingController();

  /// Maneja el proceso de autenticación
  Future<void> _iniciarSesion() async {
    try {
      await _authService.login(
        _usuarioController.text.trim(),
        _contrasenaController.text.trim(),
      );
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (mounted) _mostrarError(e.toString());
    }
  }

  /// Muestra errores en un SnackBar
  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.library_books, size: 100, color: Colors.blue),
              const SizedBox(height: 30),
              const Text(
                'Biblioteca Digital',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _usuarioController,
                label: 'Nombre de usuario',
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _contrasenaController,
                label: 'Contraseña',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _iniciarSesion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('INICIAR SESIÓN'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/registro'),
                child: const Text('¿No tienes cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}