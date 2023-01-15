import 'package:flutter/cupertino.dart';
import 'package:flutter_clara_v1/data/model/device.dart';
import 'package:flutter_clara_v1/data/model/lamp.dart';
import 'package:flutter_clara_v1/data/repository/device.dart';
import 'package:flutter_clara_v1/data/repository/lamp.dart';

class DeviceProvider extends ChangeNotifier {
  List<Device> devices = [];
  final DeviceRepository _deviceRepository = DeviceRepository();

  Future<List<Device>> getDevices() async {
    devices = await _deviceRepository.getDevices();
    return devices;
  }

  Future<void> loadDevices() async {
    await _deviceRepository.getDevices().then((value) {
      devices = value;
      notifyListeners();
    });
  }

  Future<void> addDevice(Device device) async {
    if (!checkIfExist(device)) {
      await _deviceRepository.addDevice(device);
    }
    loadDevices();
  }

  Future<void> removeDevice(Device device) async {
    await _deviceRepository.removeDevice(device);
    loadDevices();
  }

  bool checkIfExist(Device device) {
    return devices.any((element) => element.espId == device.espId);
  }

  Future<Lamp> getLampById(String id) async {
    return LampRepository().getLampById(id);
  }

  Future<bool> checkLampisExist(String id) async {
    return LampRepository().isExist(id);
  }
}
