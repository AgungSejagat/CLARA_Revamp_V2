import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Future<void> changeLanguage(BuildContext context, String languageCode) async {
    context.setLocale(Locale(languageCode));
    notifyListeners();
  }
}
