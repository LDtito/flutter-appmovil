import 'package:app/bienvenida.dart';
import 'package:app/carrito.dart';
import 'package:app/categorias.dart';
import 'package:app/listProducts.dart';
import 'package:app/listUsers.dart';
import 'package:app/login.dart';
import 'package:app/producto.dart';
import 'package:app/register.dart';
import 'package:app/venta.dart';
import 'package:app/vista.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Bienvenida(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => Register(),
        '/vista': (context) => const Vista(),
        '/category': (context) => const Category(),
        '/products': (context) => const Products(),
        '/listproducts': (context) => const ListProducts(),
        '/cart': (context) => const Carrito(),
        '/users': (context) => const ListUsers(),
        '/venta': (context) => Venta(),
      },
    );
  }
}
