import 'package:flutter_clara_v1/data/config/sqlite.dart';
import 'package:flutter_clara_v1/data/model/device.dart';
import 'package:sqflite/sqflite.dart';

class DeviceRepository {
  static final DeviceRepository _instance = DeviceRepository._();

  factory DeviceRepository() {
    return _instance;
  }

  DeviceRepository._();

  Future<List<Device>> getDevices() async {
    final db = await Sqlite().database;
    final List<Map<String, dynamic>> maps = await db.query('user_devices');
    return List.generate(
      maps.length,
      (i) {
        return Device(
          espId: maps[i]['espId'] as String,
          location: maps[i]['location'] as String,
          name: maps[i]['name'] as String,
        );
      },
    );
  }

  Future<void> addDevice(Device device) async {
    final db = await Sqlite().database;
    await db.insert(
      'user_devices',
      device.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeDevice(Device device) async {
    final db = await Sqlite().database;
    await db.delete(
      'user_devices',
      where: 'espId = ?',
      whereArgs: [device.espId],
    );
  }
}
