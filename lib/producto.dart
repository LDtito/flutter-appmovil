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
                title: const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/'); // Handle item 1 click
                },
              ),
              ListTile(
                title: const Text(
                  'Categorias',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/venta'); // Handle item 2 click
                },
              ),
              ListTile(
                title: const Text(
                  'Productos',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, '/products'); // Handle item 2 click
                },
              ),
              ListTile(
                title: const Text(
                  'Inventario',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, '/listproducts'); // Handle item 2 click
                },
              ),
              ListTile(
                title: const Text(
                  'Cerrar Sesion',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  // Handle item 2 click
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
              height: 766 * fem,
              child: Stack(
                children: [
                  Positioned(
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 393 * fem,
                        height: 406 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff3e54ac),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 132 * fem,
                    top: 148 * fem,
                    child: Align(
                      child: SizedBox(
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
                              )
                            ],
                          ),
                          child: Image.asset(
                            'images/vector-mVv.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0 * fem,
                    top: 406 * fem,
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
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 25 * fem,
                              right: 25 * fem,
                              top: 45 * fem,
                              bottom: 20 * fem,
                            ),
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
                                      // Handle button press
                                    },
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
