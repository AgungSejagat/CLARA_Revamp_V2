import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_clara_v1/modules/device/provider/color_provider.dart';
import 'package:flutter_clara_v1/modules/device/provider/device_provider.dart';
import 'package:flutter_clara_v1/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/modules/home/provider/room_provider.dart';
import 'package:flutter_clara_v1/modules/setting/provider/language_provider.dart';
import 'package:flutter_clara_v1/modules/setting/provider/mode_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => DeviceProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(
          create: (_) => ModeProvider(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('id', 'ID'),
          Locale('es', 'ES')
        ],
        path: 'assets',
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ModeProvider, LanguageProvider>(
      builder: (context, modeProvider, languageProvider, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          themeMode: modeProvider.getCurrentMode(),
          home: HomeScreen(),
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
        );
      },
    );
  }
}
