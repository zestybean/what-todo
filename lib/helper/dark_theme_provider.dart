//Flutter
import 'package:flutter/material.dart';

//Packages
import 'package:what_todo_app/utils/shared_preferences.dart';

//Provider model for dark theme
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    //Update listners and render ui change
    notifyListeners();
  }
}
