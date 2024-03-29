//File ini untuk mengatur data yang akan ditampilkan di UI

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_clara_v1/data/model/device.dart';
import 'package:flutter_clara_v1/data/model/lamp.dart';
import 'package:flutter_clara_v1/data/repository/lamp.dart';
import 'package:flutter_clara_v1/modules/device/provider/color_provider.dart';
import 'package:flutter_clara_v1/modules/device/provider/device_provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class DeviceScreen extends StatefulWidget {
  final Device device;

  const DeviceScreen({super.key, required this.device});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  bool isRainbow = false;
  bool isOn = false;
  Color currentColor = Color(0xff443a49);

  @override
  void initState() {
    context.read<DeviceProvider>().getLampById(widget.device.espId).then(
      (value) {
        setState(() {
          isOn = value.isOn;
          isRainbow = value.isRainbow;
          currentColor = Color.fromRGBO(value.red, value.green, value.blue, 1);
        });
      },
    ); //Supaya data yang ditampilkan sesuai dengan data yang ada di firebase
    super
        .initState(); //Super ini untuk memanggil fungsi yang ada di parent class
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
      ),
      body: StreamBuilder(
        stream: LampRepository().streamLampById(widget.device.espId), //context.read serupa dengan provider.of yng dimana hanya untuk memanggil provider
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //Snapshot untuk mengambil data kondisi terkin
            return const Center(child: Text('Error'));
          }

          // if (snapshot.connectionState != ConnectionState.done) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

          isOn = snapshot.data!.isOn;
          isRainbow = snapshot.data!.isRainbow;
          currentColor = Color.fromRGBO(snapshot.data!.red, snapshot.data!.green, snapshot.data!.blue, 1);

          return Column(
            children: [
              Container(
                height: 200,
                alignment: Alignment.center,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isOn = !isOn;
                          context
                              .read<ColorProvider>()
                              .turnOnOff(widget.device.espId, isOn);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        fixedSize: Size(80, 80),
                        elevation: 10,
                        primary: isOn ? Colors.green : Colors.red,
                      ),
                      child: Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.square,
                        color: currentColor,
                        size: 55,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // pick color here
                          context.read<ColorProvider>().pickColor(
                            context,
                            widget.device.espId,
                            currentColor,
                            (color) {
                              setState(() {
                                currentColor = color;
                              });
                              context
                                  .read<ColorProvider>()
                                  .updateLampColor(widget.device.espId, color);
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 45),
                          elevation: 10,
                          primary: Colors.indigo,
                        ),
                        child: Text(
                          "device_setting_changecolor".tr(),
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, //align center
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StatefulBuilder(builder: ((context, setState) {
                    return FlutterSwitch(
                      value: isRainbow,
                      onToggle: (val) {
                        setState(() {
                          context
                              .read<ColorProvider>()
                              .turnOnOffRainbow(widget.device.espId, val);
                          isRainbow = val;
                        });
                      },
                    );
                  })),
                  const Text(
                    'Rainbow',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
