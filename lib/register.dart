import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(Register());

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqflite Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RegisterScreen(),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'my_databaseV4.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        phone INTEGER,
        password TEXT
      )
    ''');
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('users', user);
  }

  Future<bool> loginUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;

    await DatabaseHelper.instance.insertUser({
      'username': username,
      'password': password,
      'email': email,
      'phone': phone
    });

    // Registro exitoso, realiza las acciones necesarias
    print('Registro exitoso');
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo[900],
          title: Text(
            'Registrate',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: 80,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 31, 54, 223),
                Color.fromARGB(197, 14, 24, 218),
              ],
            ),
          ), // Fondo azul marino
          child: ListView(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(10,
                          3), // Cambia los valores de offset para ajustar la sombra
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                child: Center(
                  child: Image.asset(
                    'images/logo2.png',
                    width: 300,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Nombre de usuario',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: _usernameController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Nombre de usuario',
                            filled: true,
                            fillColor: Colors.white, // Fondo morado claro
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            suffixIcon: Icon(
                              Icons.mail,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingresa tu nombre de usuario';
                            }
                            return null;
                          },
                        ),
                        Divider(
                          height: 30.0,
                        ),
                        Text(
                          'Correo',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: ('alguien@gmail.com'),
                            filled: true,
                            fillColor: Colors.white, // Fondo morado claro
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            suffixIcon: Icon(
                              Icons.mail,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingresa tu correo electrónico';
                            }
                            return null;
                          },
                        ),
                        Divider(
                          height: 30.0,
                        ),
                        Text(
                          'Telefono',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.numberWithOptions(),
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: ('+593 955 439 3094'),
                            filled: true,
                            fillColor: Colors.white, // Fondo morado claro
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            suffixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingresa tu número de teléfono';
                            }
                            return null;
                          },
                        ),
                        Divider(
                          height: 30.0,
                        ),
                        Text(
                          'Contraseña',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            filled: true,
                            fillColor: Colors.white, // Fondo morado claro
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              child: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingresa tu contraseña';
                            }
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\\$&*~]).{8,}$');
                            if (!regex.hasMatch(value)) {
                              return 'La contraseña debe contener al menos una mayúscula, una minúscula y un carácter especial';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                Color.fromARGB(255, 29, 8, 119), // Color morado
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            minimumSize: Size(100, 50),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _register();
                            }
                          },
                          child: Text('Registrarse'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
