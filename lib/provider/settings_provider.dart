import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_theme/my_theme.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  void changeTheme(ThemeMode newMode) async {
    final pref = await SharedPreferences.getInstance();
    if (newMode == currentTheme) return;
    currentTheme = newMode;

    pref.setString("theme", currentTheme == ThemeMode.light ? "light" : "dark");
    notifyListeners();
  }

  String languageCode = 'en';

  void changeLanguage(String lang) async {
    final pref = await SharedPreferences.getInstance();

    if (languageCode == lang) return;
    languageCode = lang;
    pref.setString("lang", languageCode);
    notifyListeners();
  }

  Color changeBackgroundColor() {
    return currentTheme == ThemeMode.light
        ? MyTheme.lightScaffoldBackground
        : MyTheme.darkScaffoldBackground;
  }

  isDarkMood() {
    return currentTheme == ThemeMode.dark;
  }

  isEnglish() {
    return languageCode == 'en';
  }
}
