import 'package:flutter/material.dart';

class ModeProvider extends ChangeNotifier {
  ThemeMode _currentMode = ThemeMode.system;

  getCurrentMode() {
    // notifyListeners();
    return _currentMode;
  }

  setCurrentMode(ThemeMode mode) {
    _currentMode = mode;
    notifyListeners();
  }
}
