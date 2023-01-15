import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/modules/setting/provider/mode_provider.dart';
import 'package:provider/provider.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mode Screen"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<ModeProvider>().setCurrentMode(ThemeMode.light);
                },
                icon: Icon(
                  Icons.light_mode,
                ),
                label: Text(
                  "Light Mode",
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<ModeProvider>().setCurrentMode(ThemeMode.dark);
                },
                icon: Icon(
                  Icons.dark_mode,
                ),
                label: Text(
                  "Dark Mode",
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
