import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/modules/home/provider/room_provider.dart';
import 'package:flutter_clara_v1/modules/home/room_screen.dart';
import 'package:flutter_clara_v1/modules/setting/setting_screen.dart';
import 'package:flutter_clara_v1/widgets/add_device.dart';
import 'package:provider/provider.dart';

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
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return AddDeviceSheet(
                deviceId: deviceId,
                deviceName: deviceName,
                roomName: roomName,
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
