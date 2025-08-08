/// Modelo que representa un usuario del sistema con validaciones integradas.
/// Incluye métodos para conversión a Map y validación de campos.
class Usuario {
  final String nombre;
  final String usuario;
  final String contrasena;
  final String correo;
  final String telefono;

  /// Constructor que requiere todos los campos obligatorios
  Usuario({
    required this.nombre,
    required this.usuario,
    required this.contrasena,
    required this.correo,
    required this.telefono,
  });

  /// Valida que los campos cumplan con los requisitos mínimos
  bool validarCampos() {
    return nombre.isNotEmpty &&
        usuario.length >= 4 &&
        contrasena.length >= 6 &&
        correo.contains('@');
  }

  /// Convierte el objeto a Map para serialización
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'usuario': usuario,
      'correo': correo,
      'telefono': telefono,
    };
  }
}