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
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(_filteredUsers[index]['name']),
                    subtitle: Text(_filteredUsers[index]['email']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _showDeleteConfirmation(
                        _filteredUsers[index]['id'],
                      ),
                    ),
                    onTap: () => _showForm(_filteredUsers[index]['id']),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
