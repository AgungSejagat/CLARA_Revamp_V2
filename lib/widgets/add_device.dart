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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'greeting_add'.tr(),
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
      ],
    );
  }
}