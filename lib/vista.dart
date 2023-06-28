import 'package:app/carrito.dart';
import 'package:flutter/material.dart';
import 'sql_helper.dart';

class Vista extends StatefulWidget {
  const Vista({Key? key}) : super(key: key);

  @override
  State<Vista> createState() => _VistaState();
}

class _VistaState extends State<Vista> {
  List<Map<String, dynamic>> _createdJournals = [];
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> _filteredJournals = [];

  void _loadCreatedJournals() async {
    final items = await SQLHelper.getItems();

    setState(() {
      _createdJournals =
          items.where((item) => item['createdAt'] != null).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCreatedJournals();
  }

  final TextEditingController _searchController = TextEditingController();

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      _createdJournals.remove(product);
    });
    Carrito.cartItems.add(product);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Carrito()),
    );
  }

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
    final double fem = 1.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: const Color(0xFF3E54AC),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
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
                  Navigator.pushNamed(
                      context, '/category'); // Handle item 2 click
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
        padding: EdgeInsets.fromLTRB(27 * fem, 45 * fem, 23 * fem, 43 * fem),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 31 * fem),
              width: 329 * fem,
              height: 135 * fem,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20 * fem),
                child: Image.asset(
                  'images/rectangle-46.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 178 * fem, 9 * fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Nuestro Productos',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w600,
                    height: 1.255 * fem,
                    color: const Color(0xFFBFACE0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16 * fem),
              alignment: Alignment.centerLeft,
              child: Text(
                'Productos Destacados',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 20 * fem,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3E54AC),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _createdJournals.length,
                itemBuilder: (context, index) {
                  final journal = _createdJournals[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to product details screen
                      Navigator.pushNamed(context, '/products');
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 15 * fem,
                        right: 16 * fem,
                        bottom: 15 * fem,
                      ),
                      padding: EdgeInsets.all(15 * fem),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1 * fem,
                            blurRadius: 5 * fem,
                            offset: Offset(0, 3 * fem),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 15 * fem),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                journal['title'],
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 16 * fem,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF3E54AC),
                                ),
                              ),
                              SizedBox(height: 5 * fem),
                              Text(
                                journal['description'],
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF666666),
                                ),
                              ),
                              SizedBox(height: 5 * fem),
                              Text(
                                journal['count'],
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 16 * fem,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF3E54AC),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _addToCart(journal);
                                },
                                child: Text('Agregar al carrito2'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart'); // Navigate to cart screen
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: const Color(0xFF3E54AC),
      ),
    );
  }
}
