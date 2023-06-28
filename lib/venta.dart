import 'package:flutter/material.dart';

import 'sql_helper.dart';

class Product {
  int id;
  String title;
  String? description;
  String? count;

  Product(
      {required this.id, required this.title, this.description, this.count});
}

class Venta extends StatefulWidget {
  @override
  _VentaState createState() => _VentaState();
}

class _VentaState extends State<Venta> {
  List<Product> cartItems = [];

  Future<List<Product>> fetchCartItems() async {
    final db = await SQLHelper.db();
    final items = await SQLHelper.getItems();
    return items
        .map((item) => Product(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              count: item['count'],
            ))
        .toList();
  }

  void addToCart(Product product) async {
    final db = await SQLHelper.db();

    if (cartItems.contains(product)) {
      // If the product is already in the cart, increase the count
      setState(() {
        int index = cartItems.indexOf(product);
        cartItems[index].count =
            (int.parse(cartItems[index].count ?? '0') + 1).toString();
      });
    } else {
      // Add the product to the cart
      final id = await SQLHelper.createItem(
        product.title,
        product.description,
        product.count,
      );
      setState(() {
        cartItems.add(Product(
          id: id,
          title: product.title,
          description: product.description,
          count: product.count,
        ));
      });
    }
  }

  void removeFromCart(Product product) async {
    final db = await SQLHelper.db();

    if (cartItems.contains(product)) {
      // Decrease the count of the product
      setState(() {
        int index = cartItems.indexOf(product);
        int count = int.parse(cartItems[index].count ?? '0');
        if (count > 1) {
          cartItems[index].count = (count - 1).toString();
        } else {
          // Remove the product from the cart if the count becomes 0
          db.delete("items", where: "id = ?", whereArgs: [product.id]);
          cartItems.removeAt(index);
        }
      });
    }
  }

  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += double.parse(item.count ?? '0');
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems().then((items) {
      setState(() {
        cartItems = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = cartItems[index];
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(product.title),
            subtitle: Text('Count: ${product.count}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    removeFromCart(product);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    addToCart(product);
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          'Total: ${calculateTotal()}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
