import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/data/model/lamp.dart';
import 'package:flutter_clara_v1/data/repository/lamp.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorProvider extends ChangeNotifier {
  Color pickColor(BuildContext context, String docId, Color currentColor,
      void Function(Color) onColorChanged) {
    Color pickerColor = currentColor;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Color"),
        content: Wrap(
          children: [
            SlidePicker(
              pickerColor: pickerColor,
              enableAlpha: false,
              onColorChanged: onColorChanged,
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    return pickerColor;
  }

  // update color
  Future<void> updateLampColor(String id, Color color) async {
    await LampRepository().getLampById(id).then((value) {
      LampRepository().updateLamp(Lamp(
        id: id,
        isOn: value.isOn,
        red: color.red,
        green: color.green,
        blue: color.blue,
        isRainbow: value.isRainbow,
      ));
    });
  }

  Future<void> turnOnOff(String id, bool isOn) async {
    await LampRepository().getLampById(id).then((value) {
      LampRepository().updateLamp(Lamp(
        id: id,
        isOn: isOn,
        red: value.red,
        green: value.green,
        blue: value.blue,
        isRainbow: value.isRainbow,
      ));
    });
  }

  Future<void> turnOnOffRainbow(String id, bool isRainbow) async {
    await LampRepository().getLampById(id).then((value) {
      LampRepository().updateLamp(Lamp(
        id: id,
        isOn: value.isOn,
        red: value.red,
        green: value.green,
        blue: value.blue,
        isRainbow: isRainbow,
      ));
    });
  }
}
