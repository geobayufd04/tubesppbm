import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Singleton pattern untuk mendapatkan instance database
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // Inisialisasi database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE chats(id INTEGER PRIMARY KEY, message TEXT, timestamp TEXT)
      ''');
    });
  }

  // Menyimpan pesan ke database
  Future<void> insertChat(String message) async {
    final db = await database;
    await db.insert(
      'chats',
      {'message': message, 'timestamp': DateTime.now().toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Mengambil semua pesan
  Future<List<Map<String, dynamic>>> getChats() async {
    final db = await database;
    return await db.query('chats');
  }
}
