import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/data/model/room.dart';
import 'package:flutter_clara_v1/modules/device/device_screen.dart';
import 'package:flutter_clara_v1/modules/device/provider/device_provider.dart';
import 'package:provider/provider.dart';

class RoomScreen extends StatelessWidget {
  final Room room;
  const RoomScreen({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold( //Menggunakan Scaffold untuk membuat UI
      appBar: AppBar(
        title: Text(room.location),
      ),
      body: FutureBuilder( //Pakai FutureBuilder untuk menunggu data masuk,saat belum ada akan ada sombil loading
        future: context.read<DeviceProvider>().getDevices(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Consumer( //Consumer untuk menerima broadcast dari changenoitifier provider
            builder: (context, DeviceProvider provider, child) { //Broadcast yang hanya diterima oleh consumer adalah deviceprovider
              final devices = provider.devices
                  .where((element) => element.location == room.location)
                  .toList(); //Mengambil data device yang memiliki location yang sama dengan room yang dipilih

              return ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_pin),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<DeviceProvider>().removeDevice(devices[index]);
                      },
                      icon: Icon(Icons.delete_forever_outlined),
                    ),
                    title: Text(devices[index].name),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DeviceScreen(device: devices[index]);
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
    );
  }
}
