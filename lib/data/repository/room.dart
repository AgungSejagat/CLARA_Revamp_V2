//menambahkan dan menghapus data room ke database, serupa dengan device

import 'package:flutter_clara_v1/data/config/sqlite.dart';
import 'package:flutter_clara_v1/data/model/room.dart';
import 'package:sqflite/sqflite.dart';

class RoomRepository {
  static final RoomRepository _instance = RoomRepository._();

  factory RoomRepository() {
    return _instance;
  }

  RoomRepository._();

  Future<List<Room>> getRooms() async { 
    final db = await Sqlite().database;
    final List<Map<String, dynamic>> maps = await db.query('room');
    return List.generate(maps.length, (i) {
      return Room(
        id: maps[i]['id'] as String,
        location: maps[i]['location'] as String,
      );
    });
  }

  Future<Room> getRoomsById(String id) async {
    final db = await Sqlite().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'room',
      where: 'id = ?',
      whereArgs: [id],
    );
    return Room(
      id: maps[0]['id'] as String,
      location: maps[0]['location'] as String,
    );
  }

  Future<void> addRoom(Room room) async {
    final db = await Sqlite().database;
    await db.insert(
      'room',
      room.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeRoom(Room room) async {
    final db = await Sqlite().database;
    await db.delete(
      'room',
      where: 'id = ?',
      whereArgs: [room.id],
    );
  }
}
