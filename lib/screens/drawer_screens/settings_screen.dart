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
            'Settings Screen',
            style: boldPlus,
          ),
        ),
        body: Column(
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
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Theme',
                style: boldPlus,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _themeButton(1, theme, headerColor1),
                  _themeButton(2, theme, headerColor2),
                  _themeButton(3, theme, headerColor3),
                  _themeButton(4, theme, headerColor4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeButton(int selection, ThemeProvider theme, Color color) {
    return ClipOval(
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
    );
  }
}
