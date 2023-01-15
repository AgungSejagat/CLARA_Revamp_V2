import 'package:sqflite/sqflite.dart';

class Sqlite {
  static final Sqlite _instance = Sqlite._();
  static Database? _database;

  factory Sqlite() {
    return _instance;
  }

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Sqlite._();

  Future<Database> _initDB() async {
    return await openDatabase(
      'database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE room(id TEXT PRIMARY KEY, location TEXT)' );
        await db.execute(
          'CREATE TABLE user_devices(espId TEXT PRIMARY KEY, name TEXT, location TEXT)');
      },
    );
  }
}