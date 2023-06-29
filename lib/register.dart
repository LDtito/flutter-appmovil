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
    final path = join(await getDatabasesPath(), 'my_database2.2.db');
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
        phone TEXT,
        password TEXT
      )
    ''');
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('users', user);
  }

  Future<bool> loginUser(String username, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
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
    final email = _emailController.text;
    final phone = _phoneController.text;
    final password = _passwordController.text;

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
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nombre de usuario'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu nombre de usuario';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo de usuario'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu nombre de usuario';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(labelText: 'Telefono usuario'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu nombre de usuario';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
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
    );
  }
}
