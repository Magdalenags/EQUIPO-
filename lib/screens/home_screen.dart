import 'package:flutter/material.dart';
import '../models/libro.dart';
import '../services/libro_service.dart';

/// Pantalla principal que muestra el catálogo de libros.
/// Permite búsqueda en tiempo real y visualización de detalles.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LibroService _libroService = LibroService();
  late List<Libro> _libros;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _libros = _libroService.obtenerTodos();
  }

  /// Filtra libros según el texto de búsqueda
  void _buscarLibros(String query) {
    setState(() {
      _libros = query.isEmpty
          ? _libroService.obtenerTodos()
          : _libroService.buscar(query);
    });
  }

  /// Muestra detalles del libro en un diálogo
  void _mostrarDetalles(Libro libro) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(libro.titulo),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Autor: ${libro.autor}'),
            Text('Género: ${libro.genero}'),
            if (libro.imagenUrl != null)
              Image.network(libro.imagenUrl!),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Libros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar libros...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _buscarLibros,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _libros.length,
              itemBuilder: (context, index) {
                final libro = _libros[index];
                return ListTile(
                  title: Text(libro.titulo),
                  subtitle: Text('Autor: ${libro.autor}'),
                  onTap: () => _mostrarDetalles(libro),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}