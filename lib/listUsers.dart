import 'package:flutter/material.dart';
import 'sql_helper.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  bool _isLoading = true;

  void _refreshUsers() async {
    final data = await SQLHelper.getUsers();
    setState(() {
      _users = data;
      _filteredUsers = List.from(data);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _identificationController =
      TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingUser = _users.firstWhere((element) => element['id'] == id);
      _nameController.text = existingUser['name'];
      _emailController.text = existingUser['email'];
      _identificationController.text =
          existingUser['identification'].toString();
      _imageController.text = existingUser['image'];
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
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                suffixIcon: Icon(Icons.person),
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
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                suffixIcon: Icon(Icons.email),
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
              controller: _identificationController,
              decoration: InputDecoration(
                hintText: 'Identification',
                suffixIcon: Icon(Icons.card_membership),
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
              controller: _imageController,
              decoration: InputDecoration(
                hintText: 'image',
                suffixIcon: Icon(Icons.image),
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
                  if (id == null) {
                    await _addUser();
                  }

                  if (id != null) {
                    await _updateUser(id);
                  }

                  _nameController.text = '';
                  _emailController.text = '';
                  _identificationController.text = '';

                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Create New' : 'Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addUser() async {
    await SQLHelper.createUser(
      _nameController.text,
      _emailController.text,
      _identificationController.text,
      _imageController.text,
    );
    _refreshUsers();
  }

  Future<void> _updateUser(int id) async {
    await SQLHelper.updateUser(id, _nameController.text, _emailController.text,
        _identificationController.text, _imageController.text);
    _refreshUsers();
  }

  void _deleteUser(int id) async {
    await SQLHelper.deleteUser(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully deleted a user!'),
      ),
    );
    _refreshUsers();
  }

  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteUser(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _searchUsers(String searchTerm) {
    setState(() {
      _filteredUsers = _users
          .where((user) =>
              user['name'].toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
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
              onChanged: _searchUsers,
              decoration: InputDecoration(
                hintText: 'Buscar usuarios',
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
                leading: Icon(Icons.home),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/vista');
                },
              ),
              ListTile(
                leading: Icon(Icons.category),
                title: const Text(
                  'Categorias',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/category');
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: const Text(
                  'Productos',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/products');
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory),
                title: const Text(
                  'Inventario',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/listproducts');
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory),
                title: const Text(
                  'Usuarios',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/users');
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text(
                  'Cerrar Sesion',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/');
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
              padding: const EdgeInsets.only(top: 150.0),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: _filteredUsers.length,
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
                          _filteredUsers[index]['name'],
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
                          _filteredUsers[index]['email'],
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
                                _showForm(_filteredUsers[index]['id']),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: const Color(0xFF3E54AC),
                            ),
                            onPressed: () => _showDeleteConfirmation(
                                _filteredUsers[index]['id']),
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
                  Icons.person_add,
                  color: const Color(0xFF3E54AC),
                ),
                const SizedBox(width: 8),
                Text(
                  'Agregar usuarios',
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
