import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class PathDatabaseHelper {
  static final PathDatabaseHelper _instance = PathDatabaseHelper._internal();
  factory PathDatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  PathDatabaseHelper._internal();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'phonebook.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone_number TEXT,
            email TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> insertContact(Contact contact) async {
    final db = await database;
    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phoneNumber: maps[i]['phone_number'],
        email: maps[i]['email'], phone: '',
      );
    });
  }

  Future<void> updateContact(Contact contact) async {
    final db = await database;
    await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class Contact {
  final int? id; // Nullable because it will be assigned by the database
  final String name;
  final String phone;
  final String? email; // Tambahkan email jika ingin menyimpannya

  Contact({
    this.id,
    required this.name,
    required this.phone,
    this.email, required phoneNumber,
  });

  // Convert a Contact object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phone, // Pastikan ini sesuai dengan nama kolom di database
      'email': email, // Tambahkan email jika ingin menyimpannya
    };
  }

  // Convert a Map object into a Contact object
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone_number'], // Pastikan ini sesuai dengan nama kolom di database
      email: map['email'], phoneNumber: null, // Jika Anda ingin menyimpan email
    );
  }
}