import 'package:flutter/material.dart';

void main() => runApp(const Ayuda());

class Ayuda extends StatelessWidget {
  const Ayuda({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ayuda',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('pagina en construccion'),
        ),
      ),
    );
  }
}