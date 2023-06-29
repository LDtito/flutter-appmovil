import 'package:app/register.dart';
import 'package:app/vista.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final isValid = await DatabaseHelper.instance.loginUser(username, password);

    if (isValid) {
      // Inicio de sesión exitoso, realiza las acciones necesarias
      print('Inicio de sesión exitoso');
    } else {
      // Inicio de sesión fallido, muestra un mensaje de error
      print('Inicio de sesión fallido');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio de sesión')),
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
                    _login();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vista()),
                    );
                  }
                },
                child: Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
