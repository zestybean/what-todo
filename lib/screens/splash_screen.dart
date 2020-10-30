//Flutter
import 'package:flutter/material.dart';
import 'dart:async';

//Screens
import 'screens.dart';

//Utils
import '../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      //This needs to be push replacement in order to avoid having a back
      //button on the app bar
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            settings: RouteSettings(name: '/note-list'),
            transitionDuration: Duration(seconds: 2),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              //Animation properties
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInCubic);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            //This is the route that will display
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return NoteListScreen();
            }),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //The splash screen properties
    return Scaffold(
      body: Container(
        color: Theme.of(context).appBarTheme.color,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash_note.png',
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
