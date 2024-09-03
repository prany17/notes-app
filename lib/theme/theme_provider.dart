import 'package:flutter/material.dart';
import 'package:todo_practice/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  // initial theme light mode
  ThemeData _themeData = lightMode;

  // getter for current theme
  ThemeData get newTheme => _themeData;

  // bool getter to check if the theme is darkmode
  bool get isDarkModeON => _themeData == darkMode;

  // setter to set the theme
  set newTheme(ThemeData newThemeData) {
    _themeData = newThemeData;
    notifyListeners();
  }

  // method to toggle the theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      newTheme = darkMode;
    } else {
      newTheme = lightMode;
    }
  }
}
