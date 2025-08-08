import 'package:biblioteca/screens/home_screen.dart';
import 'package:biblioteca/screens/registro_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

/// Punto de entrada principal que configura la aplicación MaterialApp.
/// Define las rutas principales y el tema visual.
void main() => runApp(const BibliotecaApp());

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Biblioteca',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/registro': (context) => const RegistroScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}