import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final double fem = 1.0; // Define el factor de escala fem

  @override
  Widget build(BuildContext context) {
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
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar productos',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF3E54AC),
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
        padding: EdgeInsets.fromLTRB(
          34 * fem,
          30 * fem,
          41.5 * fem,
          50 * fem,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                0 * fem,
                0 * fem,
                0 * fem,
                22.25 * fem,
              ),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      0 * fem,
                      0 * fem,
                      220.5 * fem,
                      2.75 * fem,
                    ),
                    child: Text(
                      'Categorias',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w600,
                        height: 1.255 * fem,
                        color: Color(0xff3e54ac),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Container(
                      width: 40 * fem,
                      height: 40 * fem,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10 * fem),
                      ),
                      child: Icon(
                        Icons.tune,
                        color: Color(0xff3e54ac),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20 * fem,
                crossAxisSpacing: 20 * fem,
                childAspectRatio: 1 / 1.2,
                children: [
                  Container(
                    padding: EdgeInsets.all(20 * fem),
                    decoration: BoxDecoration(
                      color: Color(0xfff6f7f9),
                      borderRadius: BorderRadius.circular(15 * fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100 * fem,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/screwdriver.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                        ),
                        SizedBox(height: 15 * fem),
                        Text(
                          'Herramientas',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16 * fem,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3e54ac),
                          ),
                        ),
                        SizedBox(height: 5 * fem),
                        Text(
                          'Encuentra una amplia variedad de herramientas para tus proyectos.',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7f7f7f),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20 * fem),
                    decoration: BoxDecoration(
                      color: Color(0xfff6f7f9),
                      borderRadius: BorderRadius.circular(15 * fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100 * fem,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/vector-A6Q.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                        ),
                        SizedBox(height: 15 * fem),
                        Text(
                          'Escaleras',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16 * fem,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3e54ac),
                          ),
                        ),
                        SizedBox(height: 5 * fem),
                        Text(
                          'Encuentra una gran variedad de pinturas para tu hogar.',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7f7f7f),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20 * fem),
                    decoration: BoxDecoration(
                      color: Color(0xfff6f7f9),
                      borderRadius: BorderRadius.circular(15 * fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100 * fem,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/vector-amS.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                        ),
                        SizedBox(height: 15 * fem),
                        Text(
                          'Martillos',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16 * fem,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3e54ac),
                          ),
                        ),
                        SizedBox(height: 5 * fem),
                        Text(
                          'Encuentra una gran variedad de pinturas para tu hogar.',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7f7f7f),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20 * fem),
                    decoration: BoxDecoration(
                      color: Color(0xfff6f7f9),
                      borderRadius: BorderRadius.circular(15 * fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100 * fem,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/vector-amS.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                        ),
                        SizedBox(height: 15 * fem),
                        Text(
                          'Pinturas',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16 * fem,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3e54ac),
                          ),
                        ),
                        SizedBox(height: 5 * fem),
                        Text(
                          'Encuentra una gran variedad de pinturas para tu hogar.',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7f7f7f),
                          ),
                        ),
                      ],
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

void main() {
  runApp(const MaterialApp(
    home: Category(),
  ));
}
