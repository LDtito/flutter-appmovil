import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> _filteredJournals = [];

  final TextEditingController _searchController = TextEditingController();

  void _searchJournals(String searchTerm) {
    setState(() {
      _filteredJournals = _journals
          .where((journal) =>
              journal['title'].toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: const Color(0xFF3E54AC),
        toolbarHeight: 100,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchJournals,
              decoration: InputDecoration(
                hintText: 'Buscar productos',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: const Color(0xFF3E54AC),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF3E54AC),
                ),
                child: Text(
                  'Ferreteria',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/vista');
                },
              ),
              ListTile(
                leading: Icon(Icons.category),
                title: const Text(
                  'Categorias',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/category');
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: const Text(
                  'Productos',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/products');
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory),
                title: const Text(
                  'Inventario',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/listproducts');
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add),
                title: const Text(
                  'Usuarios',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/users');
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text(
                  'Cerrar Sesion',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffecf2ff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 600 * fem,
              child: Stack(
                children: [
                  Positioned(
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 393 * fem,
                        height: 350 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff3e54ac),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 120 * fem,
                    top: 100 * fem,
                    child: Align(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 163 * fem,
                            height: 163 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20 * fem),
                                border: Border.all(color: Color(0xff3e54ac)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0 * fem, 4 * fem),
                                    blurRadius: 6 * fem,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'images/vector-mVv.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 16 *
                                  fem), // Espacio entre la imagen y el contenedor del código de barras
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        Text('Escanea el código del producto'),
                                    actions: [
                                      TextButton(
                                        child: Text('Aceptar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10 * fem),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: BarcodeWidget(
                                barcode: Barcode
                                    .code128(), // Selecciona el tipo de código de barras que desees
                                data:
                                    '1234567890', // El valor del código de barras
                                width: 150 * fem,
                                height: 50 * fem,
                                drawText:
                                    false, // Si deseas mostrar el texto debajo del código de barras
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0 * fem,
                    top: 350 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 393 * fem,
                        height: 360 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40 * fem),
                              topRight: Radius.circular(40 * fem),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0 * fem, -4 * fem),
                                blurRadius: 6 *
                                    fem, // Añadir blurRadius para sombra más visible
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(25 * fem),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    'Nombre del producto',
                                    style: TextStyle(
                                      fontSize: 20 * fem,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0d1f3c),
                                    ),
                                  ),
                                  SizedBox(height: 20 * fem),
                                  Text(
                                    'Descripción del producto',
                                    style: TextStyle(
                                      fontSize: 16 * fem,
                                      color: Color(0xff0d1f3c),
                                    ),
                                  ),
                                  SizedBox(height: 20 * fem),
                                  Text(
                                    'Precio: \$10.00',
                                    style: TextStyle(
                                      fontSize: 16 * fem,
                                      color: Color(0xff0d1f3c),
                                    ),
                                  ),
                                  SizedBox(height: 20 * fem),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/venta');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff3e54ac),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20 * fem),
                                      ),
                                      minimumSize: Size(100 * fem, 50 * fem),
                                    ),
                                    child: Text(
                                      'Agregar al carrito',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
