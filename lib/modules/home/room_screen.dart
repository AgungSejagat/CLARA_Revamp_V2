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
    return Scaffold(
      appBar: AppBar(
        title: Text(room.location),
      ),
      body: FutureBuilder(
        future: context.read<DeviceProvider>().getDevices(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Consumer(
            builder: (context, DeviceProvider provider, child) {
              final devices = provider.devices
                  .where((element) => element.location == room.location)
                  .toList();

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
