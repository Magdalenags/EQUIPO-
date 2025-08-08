import '../models/libro.dart';

/// Servicio que gestiona el catálogo de libros.
/// Ofrece búsqueda, filtrado y gestión del inventario.
class LibroService {
  final List<Libro> _libros = [
    Libro(
      id: '1',
      titulo: 'Cien años de soledad',
      autor: 'Gabriel García Márquez',
      genero: 'Novela',
      imagenUrl: 'https://ejemplo.com/cien-anos.jpg',
    ),
    Libro(
      id: '2',
      titulo: 'El Principito',
      autor: 'Antoine de Saint-Exupéry',
      genero: 'Literatura infantil',
    ),
  ];

  /// Obtiene todos los libros ordenados alfabéticamente
  List<Libro> obtenerTodos() {
    return _libros..sort((a, b) => a.titulo.compareTo(b.titulo));
  }

  /// Busca libros por título o autor (case insensitive)
  List<Libro> buscar(String query) {
    return _libros.where((libro) =>
      libro.titulo.toLowerCase().contains(query.toLowerCase()) ||
      libro.autor.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  /// Agrega un nuevo libro al catálogo
  bool agregar(Libro nuevoLibro) {
    if (_libros.any((l) => l.id == nuevoLibro.id)) return false;
    _libros.add(nuevoLibro);
    return true;
  }
}