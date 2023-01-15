import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clara_v1/modules/setting/change_language_screen.dart';
import 'package:flutter_clara_v1/modules/setting/mode_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeLanguageScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.language,
                ),
                label: Text(
                  "Change Language",
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
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ModeScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.palette,
                ),
                label: Text(
                  "Change Mode",
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
