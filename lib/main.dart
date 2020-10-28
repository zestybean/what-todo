////MAIN ROOT FILE////
//Flutter
import 'package:flutter/material.dart';

//Screens
import 'screens/screens.dart';

//Helper
import 'helper/helpers.dart';

//Packages
import 'package:provider/provider.dart';

//Constants
import 'package:what_todo_app/utils/constants.dart';

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
      //Wrapping gesture detector allows the keyboard to be cancelled
      child: GestureDetector(
        onTap: () {
          //Check focus of context
          FocusScopeNode currentFocus = FocusScope.of(context);
          //This somehow cancels the keyboard?
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          theme: ThemeData(
            accentColor: headerColor,
          ),

          title: 'What_ToDo',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          //Application screen routes
          routes: {
            '/': (context) => SplashScreen(),
            NoteListScreen.route: (context) => NoteListScreen(),
            NoteViewScreen.route: (context) => NoteViewScreen(),
            NoteEditScreen.route: (context) => NoteEditScreen(),
          },
        ),
      ),
    );
  }
}
