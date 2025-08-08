import '../models/usuario.dart';

/// Servicio que maneja la autenticación de usuarios.
/// Implementa registro y login con persistencia en memoria.
class AuthService {
  final List<Usuario> _usuarios = [];

  /// Registra un nuevo usuario con validación previa
  /// Lanza excepción si el usuario ya existe o los campos son inválidos
  Future<void> registrarUsuario(Usuario nuevoUsuario) async {
    if (!nuevoUsuario.validarCampos()) {
      throw Exception('Todos los campos son obligatorios');
    }

    if (_usuarios.any((u) => u.usuario == nuevoUsuario.usuario)) {
      throw Exception('El nombre de usuario ya está registrado');
    }

    _usuarios.add(nuevoUsuario);
  }

  /// Autentica un usuario existente
  /// Lanza excepción si las credenciales son incorrectas
  Future<Usuario> login(String usuario, String contrasena) async {
    try {
      return _usuarios.firstWhere(
        (u) => u.usuario == usuario && u.contrasena == contrasena,
      );
    } catch (e) {
      throw Exception('Usuario o contraseña incorrectos');
    }
  }
}