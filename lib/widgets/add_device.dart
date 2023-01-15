import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/data/model/device.dart';
import 'package:flutter_clara_v1/data/model/room.dart';
import 'package:flutter_clara_v1/data/repository/lamp.dart';
import 'package:flutter_clara_v1/modules/device/provider/device_provider.dart';
import 'package:flutter_clara_v1/modules/home/provider/room_provider.dart';
import 'package:provider/provider.dart';

class AddDeviceSheet extends StatelessWidget {
  final TextEditingController roomName;
  final TextEditingController deviceName;
  final TextEditingController deviceId;

  const AddDeviceSheet({
    super.key,
    required this.roomName,
    required this.deviceName,
    required this.deviceId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Tambahkan Ruangan',
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: roomName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'greeting_add_room'.tr(),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: deviceName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'greeting_device_name'.tr(),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: deviceId,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'ID Device',
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final bool isExist = await context
                      .read<DeviceProvider>()
                      .checkLampisExist(deviceId.text);
                  if (!isExist) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Device tidak ditemukan'),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                    roomName.text = '';
                    deviceName.text = '';
                    deviceId.text = '';
                    return;
                  }

                  await context.read<RoomProvider>().addRoom(
                        Room(
                          id: DateTime.now().microsecond.toString(),
                          location: roomName.text,
                        ),
                      );

                  await context.read<DeviceProvider>().addDevice(
                        Device(
                          espId: deviceId.text,
                          name: deviceName.text,
                          location: roomName.text,
                        ),
                      );

                  roomName.text = '';
                  deviceName.text = '';
                  deviceId.text = '';

                  Navigator.pop(context);
                },
                child: Text('Tambahkan'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
