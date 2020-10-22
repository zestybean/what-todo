////MAIN ROOT FILE////
//Flutter
import 'package:flutter/material.dart';

//Screens
import 'screens/screens.dart';

//Helper
import 'helper/helpers.dart';

//Packages
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //Root widget for the entire application
  @override
  Widget build(BuildContext context) {
    //Use provider package to listen to note provider changes
    return ChangeNotifierProvider.value(
      value: NoteProvider(),
      child: MaterialApp(
        title: 'What_ToDo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        //Application screen routes
        routes: {
          '/': (context) => NoteListScreen(),
          NoteViewScreen.route: (context) => NoteViewScreen(),
          NoteEditScreen.route: (context) => NoteEditScreen(),
        },
      ),
    );
  }
}
