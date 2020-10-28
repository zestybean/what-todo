//Flutter
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const route = '/drawer-settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
      ),
    );
  }
}
