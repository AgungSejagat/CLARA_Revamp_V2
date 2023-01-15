import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModeProvider extends ChangeNotifier {
  ThemeMode _currentMode = ThemeMode.system;

  getCurrentMode() {
    notifyListeners();
    // TODO: save mode to local storage
    return _currentMode;
  }

  setCurrentMode(ThemeMode mode) {
    _currentMode = mode;
    notifyListeners();
  }
}