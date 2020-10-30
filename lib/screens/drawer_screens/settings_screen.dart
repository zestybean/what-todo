//Flutter
import 'package:flutter/material.dart';

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
          title: Text('Settings Screen'),
        ),
        body: Column(
          children: [
            RaisedButton(
              onPressed: () {
                theme.setLightMode(1);
              },
            ),
            RaisedButton(
              onPressed: () {
                theme.setLightMode(2);
              },
            ),
            RaisedButton(
              onPressed: () {
                theme.setLightMode(3);
              },
            ),
            RaisedButton(
              onPressed: () {
                theme.setLightMode(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}
