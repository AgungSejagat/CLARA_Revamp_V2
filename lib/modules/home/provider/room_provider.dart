import 'package:flutter/cupertino.dart';
import 'package:flutter_clara_v1/data/model/room.dart';
import 'package:flutter_clara_v1/data/repository/room.dart';

class RoomProvider extends ChangeNotifier {
  List<Room> rooms = [];
  final RoomRepository _roomRepository = RoomRepository();

  Future<List<Room>> getRooms() async {
    rooms = await _roomRepository.getRooms();
    return rooms;
  }

  Future<void> loadRooms() async {
    await _roomRepository.getRooms().then((value) {
      rooms = value;
      notifyListeners();
    });
  }

  Future<void> addRoom(Room room) async {
    if (!checkIfExist(room)) {
      await _roomRepository.addRoom(room);
    }
    loadRooms();
  }

  Future<void> removeRoom(Room room) async {
    await _roomRepository.removeRoom(room);
    loadRooms();
  }

  bool checkIfExist(Room room) {
    return rooms.any((element) => element.location == room.location);
  }
}
