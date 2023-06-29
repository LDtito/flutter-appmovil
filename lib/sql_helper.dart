import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        count TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<void> createUsersTable(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      email TEXT,
      identification TEXT,
      image TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'ferreteriaV2.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await createUsersTable(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String title, String? description, String? count) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'description': description, 'count': count};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? description, String? count) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': description,
      'count': count,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete an item by id
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Create a new user
  static Future<int> createUser(
      String name, String email, String identification, String image) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'email': email,
      'identification': identification,
      'image': image
    };
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all users
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQLHelper.db();
    return db.query('users', orderBy: "id");
  }

  // Read a single user by id
  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update a user by id
  static Future<int> updateUser(int id, String name, String email,
      String identification, String image) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'email': email,
      'identification': identification,
      'image': image,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete a user by id
  static Future<void> deleteUser(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("users", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a user: $err");
    }
  }
}
