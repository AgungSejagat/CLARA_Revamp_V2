//File ini untuk state management, untuk mengatur data yang akan ditampilkan di UI

import 'package:flutter/cupertino.dart';
import 'package:flutter_clara_v1/data/model/room.dart';
import 'package:flutter_clara_v1/data/repository/room.dart';

class RoomProvider extends ChangeNotifier { 
  //Class Room Provider mengextends ChangeNotifier sehingga class ini 
  //mampu untuk membroadcast perubahan ke widget yang menggunakan class ini
  List<Room> rooms = [];
  final RoomRepository _roomRepository = RoomRepository();

  Future<List<Room>> getRooms() async { //Untuk mengambil semua data room
    rooms = await _roomRepository.getRooms();
    return rooms;
  }

  Future<void> loadRooms() async { //Untuk memuat data room
    await _roomRepository.getRooms().then((value) {
      rooms = value;
      notifyListeners();
    });
  }

  Future<void> addRoom(Room room) async { //Untuk menambah data room
    if (!checkIfExist(room)) { //Untuk mengecek apakah data room sudah ada atau belum sehingga tidak ada duplikat data
      await _roomRepository.addRoom(room);
    }
    loadRooms();
  }

  Future<void> removeRoom(Room room) async { //Untuk menghapus data room
    await _roomRepository.removeRoom(room);
    loadRooms();
  }

  bool checkIfExist(Room room) {
    return rooms.any((element) => element.location == room.location); //Untuk mengecek apakah data room sudah ada atau belum
  }
}
