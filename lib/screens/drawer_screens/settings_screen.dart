//Flutter
import 'package:flutter/material.dart';

//Utils
import 'package:what_todo_app/utils/utils.dart';

//Helpers
import '../../helper/helpers.dart';

//Packages
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const route = '/drawer-settings';

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, _) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'Settings',
            style: headerNoteStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.color,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(75.0),
                  ),
                ),
                height: 35,
                width: double.infinity,
                child: null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Color Theme:',
                      style: boldPlus,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _themeButton(1, theme, headerColor1, 'Terra\n Cota'),
                    _themeButton(2, theme, headerColor2, 'Navy\n Blue'),
                    _themeButton(3, theme, headerColor3, 'Green\n Sheen'),
                    _themeButton(4, theme, headerColor4, 'Deep\n Champagne'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _themeButton(
      int selection, ThemeProvider theme, Color color, String colorName) {
    return Column(
      children: [
        ClipOval(
          child: Material(
            color: color,
            child: InkWell(
              child: SizedBox(
                height: 50.0,
                width: 50.0,
              ),
              onTap: () {
                theme.setLightMode(selection);
              },
            ),
          ),
        ),
        Text(
          colorName,
          textAlign: TextAlign.center,
          style: settingsThemeNameStyle,
        ),
      ],
    );
  }
}
