/// Modelo que representa un libro en el catálogo.
/// Incluye metadatos básicos y métodos de serialización.
class Libro {
  final String id;
  final String titulo;
  final String autor;
  final String genero;
  final String? imagenUrl;

  /// Constructor principal
  Libro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.genero,
    this.imagenUrl,
  });

  /// Crea una instancia desde un Map
  factory Libro.fromMap(Map<String, dynamic> map) {
    return Libro(
      id: map['id'],
      titulo: map['titulo'],
      autor: map['autor'],
      genero: map['genero'],
      imagenUrl: map['imagenUrl'],
    );
  }

  /// Convierte el objeto a Map para serialización
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'genero': genero,
      'imagenUrl': imagenUrl,
    };
  }
}