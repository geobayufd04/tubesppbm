import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// Database Helper Class
class PathDatabaseHelper {
  static const _dbName = 'contacts.db';
  static const _dbVersion = 1;
  static const _tableName = 'contacts';

  PathDatabaseHelper._privateConstructor();
  static final PathDatabaseHelper instance = PathDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Contact contact) async {
    Database db = await instance.database;
    return await db.insert(_tableName, contact.toMap());
  }

  Future<List<Contact>> queryAllRows() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
  }
}

// Contact Model Class
class Contact {
  final int? id; // Nullable because it will be assigned by the database
  final String name;
  final String phone;

  Contact({this.id, required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }
}

// Main Application
void main() {
  runApp(const PhoneBookApp());
}

class PhoneBookApp extends StatelessWidget {
  const PhoneBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Phone Book',
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    setState(() {});
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
