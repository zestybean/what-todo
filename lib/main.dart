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
    return MultiProvider(
      providers: [
        ListenableProvider<NoteProvider>(
          create: (_) => NoteProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],

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
        child: Consumer<ThemeProvider>(
          builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),

            title: 'What_ToDo',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            //Application screen routes
            routes: {
              '/': (context) => SplashScreen(),
              NoteListScreen.route: (context) => NoteListScreen(),
              NoteViewScreen.route: (context) => NoteViewScreen(),
              NoteEditScreen.route: (context) => NoteEditScreen(),
              AboutScreen.route: (context) => AboutScreen(),
              SettingsScreen.route: (context) => SettingsScreen(),
            },
          ),
        ),
      ),
    );
  }
}
