import 'package:flutter/material.dart';
import 'sql_helper.dart';

class ListProducts extends StatefulWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  // All journals
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> _filteredJournals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _filteredJournals = List.from(data);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
      _countController.text = existingJournal['count'];
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          // this will prevent the soft keyboard from covering the text fields
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'producto',
                suffixIcon: Icon(Icons.production_quantity_limits_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              height: 20.0,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                suffixIcon: Icon(Icons.message_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 20.0,
            ),
            TextField(
              controller: _countController,
              decoration: InputDecoration(
                hintText: 'count',
                suffixIcon: Icon(Icons.price_change),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  // Save new journal
                  if (id == null) {
                    await _addItem();
                  }

                  if (id != null) {
                    await _updateItem(id);
                  }

                  // Clear the text fields
                  _titleController.text = '';
                  _descriptionController.text = '';
                  _countController.text = '';

                  // Close the bottom sheet
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Create New' : 'Actualizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
      _titleController.text,
      _descriptionController.text,
      _countController.text,
    );
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
      id,
      _titleController.text,
      _descriptionController.text,
      _countController.text,
    );
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully deleted a journal!'),
      ),
    );
    _refreshJournals();
  }

  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteItem(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        backgroundColor: const Color(0xFF3E54AC),
        toolbarHeight: 50,
        shape: RoundedRectangleBorder(
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
                  Navigator.pushNamed(context, '/vista'); // Handle item 1 click
                },
              ),
              ListTile(
                title: const Text(
                  'Categorias',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.shopping_cart, color: Colors.black),
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
                trailing: Icon(Icons.shopping_cart,
                    color: Colors.black), // Icono agregado en el lado derecho
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/products',
                  ); // Maneja el clic en el elemento 2
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
                  Navigator.pushNamed(context, '/'); // Handle item 2 click
                },
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  top: 150.0), // Ajusta el valor según tus preferencias
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0), // Agrega el padding vertical deseado
                itemCount: _filteredJournals.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://th.bing.com/th?id=OIP.qITy5UI-WFPC6T2wWRiBRgHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 80,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          _filteredJournals[index]['title'],
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color(0xFF3E54AC),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          _filteredJournals[index]['description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF3E54AC),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _filteredJournals[index]['count'],
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF3E54AC),
                          ),
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: const Color(0xFF3E54AC),
                            ),
                            onPressed: () =>
                                _showForm(_filteredJournals[index]['id']),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: const Color(0xFF3E54AC),
                            ),
                            onPressed: () => _showDeleteConfirmation(
                                _filteredJournals[index]['id']),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 170.0),
        child: SizedBox(
          height: 130,
          width: 400,
          child: FloatingActionButton(
            onPressed: () => _showForm(null),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_upload,
                  color: const Color(0xFF3E54AC),
                ),
                const SizedBox(width: 8),
                Text(
                  'Agregar productos',
                  style:
                      TextStyle(fontSize: 16, color: const Color(0xFF3E54AC)),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 4,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
