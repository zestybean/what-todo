//Flutter
import 'package:flutter/material.dart';

//Utils
import '../utils/utils.dart';

class ThemeProvider with ChangeNotifier {
  //Define the themes here!
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    dividerColor: Colors.white,
    accentColor: Colors.white,
    primarySwatch: Colors.grey,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: white),
      bodyText2: TextStyle(color: white),
    ),
  );

  final lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  ThemeData _themeData;

  ThemeData getTheme() => _themeData;

  //Constructor
  ThemeProvider() {
    StorageManager.readData('themeMode').then(
      (value) {
        print('value read from storage: ' + value.toString());
        var themeMode = value ?? 'light';
        if (themeMode == 'light') {
          _themeData = lightTheme;
        } else {
          print('setting dark theme');
          _themeData = darkTheme;
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

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
