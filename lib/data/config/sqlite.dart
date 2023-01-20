//Untuk mengurus database lokal
import 'package:sqflite/sqflite.dart';

class Sqlite {
  static final Sqlite _instance = Sqlite._();
  static Database? _database; //

  factory Sqlite() {
    return _instance;
  }

  Future<Database> get database async {
    return _database ??= await _initDB();
  } // Untuk memanggil sqlite

  Sqlite._();

  Future<Database> _initDB() async {
    //Untuk awal inisiasi aplikasi
    return await openDatabase(
      'database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE room(id TEXT PRIMARY KEY, location TEXT)'); //Untuk membuat tabel espID dan lokasi dari aplikasi
        await db.execute(
            'CREATE TABLE user_devices(espId TEXT PRIMARY KEY, name TEXT, location TEXT)');
      },
    );
  }
}
