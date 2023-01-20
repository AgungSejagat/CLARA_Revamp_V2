import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/data/model/device.dart';
import 'package:flutter_clara_v1/data/model/room.dart';
import 'package:flutter_clara_v1/modules/home/provider/room_provider.dart';
import 'package:flutter_clara_v1/modules/home/room_screen.dart';
import 'package:flutter_clara_v1/modules/setting/setting_screen.dart';
import 'package:flutter_clara_v1/widgets/add_device.dart';
import 'package:provider/provider.dart';

import '../device/provider/device_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController roomName;

  late final TextEditingController deviceName;

  late final TextEditingController deviceId;

  @override
  void initState() {
    roomName = TextEditingController();
    deviceName = TextEditingController();
    deviceId = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CLARA Smartlamp'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: FutureBuilder(
        future: context.read<RoomProvider>().getRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Consumer(
            //
            builder: (context, RoomProvider provider, child) {
              return ListView.builder(
                itemCount: provider.rooms.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_pin),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<RoomProvider>()
                            .removeRoom(provider.rooms[index]);
                      },
                      icon: const Icon(Icons.delete_forever_outlined),
                    ),
                    title: Text(provider.rooms[index].location),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return RoomScreen(room: provider.rooms[index]);
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // show dialog
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: AddDeviceSheet(
                  roomName: roomName,
                  deviceName: deviceName,
                  deviceId: deviceId,
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      if (roomName.text.isEmpty &&
                          deviceId.text.isEmpty &&
                          deviceName.text.isEmpty) {
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
                            });
                        return;
                      }

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
                    child: Text('Add'),
                  )
                ],
              );
            },
          );
          // Untuk menampilkan lingkaran plus bulet di tengah layar
          // showModalBottomSheet<void>(
          //   //Untuk menampilkan popup bottom sheet dari bawah
          //   context: context,
          //   builder: (BuildContext context) {
          //     return AddDeviceSheet(
          //       deviceId: deviceId,
          //       deviceName: deviceName,
          //       roomName: roomName,
          //     );
          //   },
          // );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
