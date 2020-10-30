//Flutter
import 'package:flutter/material.dart';

//Utils
import '../utils/utils.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeData getTheme() => _themeData;

  //Constructor
  ThemeProvider() {
    StorageManager.readData('themeMode').then(
      (value) {
        var themeMode = value ?? 'light';
        if (themeMode == 'light') {
          _themeData = lightTheme;
        } else if (themeMode == 'light2') {
          _themeData = lightTheme2;
        } else if (themeMode == 'light3') {
          _themeData = lightTheme3;
        } else {
          _themeData = lightTheme4;
        }
        //Rebuild UI
        notifyListeners();
      },
    );
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode(int selection) async {
    switch (selection) {
      case 1:
        _themeData = lightTheme;
        StorageManager.saveData('themeMode', 'light');
        break;
      case 2:
        print('here2');
        _themeData = lightTheme2;
        StorageManager.saveData('themeMode', 'light2');
        break;
      case 3:
        print('here3');
        _themeData = lightTheme3;
        StorageManager.saveData('themeMode', 'light3');
        break;
      case 4:
        print('here4');
        _themeData = lightTheme4;
        StorageManager.saveData('themeMode', 'light4');
        break;
    }

    notifyListeners();
  }
}
