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

void main() async { //Async karena ada await
  WidgetsFlutterBinding.ensureInitialized(); //Memastikan bahwa flutter sudah diinisialisasi
  await EasyLocalization.ensureInitialized(); //Menunggu EasyLocalization selesai diinisialisasi
  Firebase.initializeApp(); //Memastikan bahwa firebase sudah diinisialisasi

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('id'), Locale('es')],
      path: 'assets',
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RoomProvider()),
          ChangeNotifierProvider(create: (_) => DeviceProvider()),
          ChangeNotifierProvider(create: (_) => ColorProvider()),
          ChangeNotifierProvider(create: (_) => ModeProvider()),
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ],
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
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          themeMode: modeProvider.getCurrentMode(),
          locale: context.locale,
          home: const HomeScreen(),
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
        );
      },
    );
  }
}
