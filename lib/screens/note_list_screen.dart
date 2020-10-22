//Screen used to list out notes

//Flutter
import 'package:flutter/material.dart';

//Helpers
import '../helper/helpers.dart';

//Packages
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //FutureBuilder depends on state which will determine UI
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              child: Text('We here!'),
            ),
          );
        }
      },
    );
  }
}
