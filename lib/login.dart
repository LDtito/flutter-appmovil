import 'package:flutter/material.dart';

void main() {
  runApp(Login(debugShowCheckedModeBanner: false));
}

class Login extends StatelessWidget {
  final bool debugShowCheckedModeBanner;

  const Login({Key? key, this.debugShowCheckedModeBanner = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio de Sesión',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _rememberPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      if (email == 'yavirac@.com' && password == 'admin1234') {
        // Credenciales correctas
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Inicio de Sesión'),
              content: Text('Has iniciado sesión correctamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vista');
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else {
        // Credenciales incorrectas
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Inicio de Sesión'),
              content: Text('Las credenciales ingresadas no son correctas.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Iniciar Sesión',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Acciones al presionar el icono de ajustes
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.indigo[900], // Fondo azul marino
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              child: Image.asset(
                  'images/login.png'), // Agrega la ruta de tu imagen
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              filled: true,
                              fillColor:
                                  Colors.purple[50], // Fondo morado claro
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
                                return 'Por favor, ingresa tu correo';
                              }
                              if (!value.contains('@')) {
                                return 'El correo debe contener el símbolo "@"';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              filled: true,
                              fillColor:
                                  Colors.purple[50], // Fondo morado claro
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
                              if (value.length < 5 || value.length > 10) {
                                return 'La contraseña debe tener entre 5 y 8 caracteres';
                              }
                              // Agregar validaciones adicionales de contraseña aquí
                              return null;
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberPassword,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberPassword = value!;
                                  });
                                },
                              ),
                              Text(
                                'Recordar contraseña',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Acciones al presionar "Olvidaste tu contraseña"
                            },
                            child: Text(
                              'Olvidaste tu contraseña',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.0),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          primary:
                              Color.fromARGB(255, 29, 8, 119), // Color morado
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minimumSize: Size(200, 50),
                        ),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '¿No tienes cuenta?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4.0),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              'Crear cuenta',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
