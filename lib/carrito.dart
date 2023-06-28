import 'package:flutter/material.dart';

class Carrito extends StatefulWidget {
  static List<Map<String, dynamic>> cartItems = [];

  const Carrito({Key? key}) : super(key: key);

  @override
  State<Carrito> createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    totalPrice = Carrito.cartItems.fold(
      0,
      (previousValue, item) => previousValue + double.parse(item['count']),
    );
  }

  void _increaseQuantity(int index) {
    setState(() {
      Carrito.cartItems[index]['quantity']++;
      _calculateTotalPrice();
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (Carrito.cartItems[index]['quantity'] > 1) {
        Carrito.cartItems[index]['quantity']--;
      }
      _calculateTotalPrice();
    });
  }

  void _removeItem(int index) {
    setState(() {
      Carrito.cartItems.removeAt(index);
      _calculateTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Carrito.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = Carrito.cartItems[index];
                return ListTile(
                  title: Text(cartItem['title']),
                  subtitle: Text(cartItem['description']),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '\$${cartItem['count']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => _decreaseQuantity(index),
                          ),
                          Text(cartItem['quantity'].toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _increaseQuantity(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    _removeItem(index);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
