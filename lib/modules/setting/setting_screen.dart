import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/modules/setting/change_language_screen.dart';
import 'package:flutter_clara_v1/modules/setting/mode_screen.dart';
import 'package:flutter_clara_v1/modules/setting/provider/language_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChangeLanguageScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.language,
                    ),
                    label: const Text(
                      "language_button",
                    ).tr(),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ModeScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.palette,
                    ),
                    label: const Text(
                      "theme_button",
                    ).tr(),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
