//Lists all styling code and color values global scope

//Flutter
import 'package:flutter/material.dart';

//Packages
import 'package:google_fonts/google_fonts.dart';

//Init color palette
const grey = Color(0xFFEAEAEA);
const grey2 = Color(0xFF6D6D6D);
const black = Color(0xFF1C1C1C);
const black2 = Color(0xFF424242);
const headerColor = Color(0xFFFD5872);

const backgroundColor = Color(0xFFf4f1de);

const headerColor1 = Color(0xFFe07a5f);
const headerColor2 = Color(0xFF3d405b);
const headerColor3 = Color(0xFF81b29a);
const headerColor4 = Color(0xFFe9c46a);

const white = Colors.white;

var headerRideStyle = GoogleFonts.economica(
  textStyle: TextStyle(
    //color: white,
    fontSize: 30.0,
  ),
);

var headerNoteStyle = GoogleFonts.economica(
  textStyle: TextStyle(
    //color: white,
    fontSize: 45.0,
    fontWeight: FontWeight.bold,
  ),
);

enum EditMode {
  ADD,
  UPDATE,
}

var noNotesStyle = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 22.0,
    //color: black2,
    fontWeight: FontWeight.w600,
  ),
);

var boldPlus = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 30.0,
    //color: Colors.blueAccent,
    fontWeight: FontWeight.bold,
  ),
);

var boldWhitePlus = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 30.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
);

var boldWhiteMinus = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 25.0,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  ),
);

var versionBoldMinus = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 15.0,
    color: Colors.white,
    fontWeight: FontWeight.w200,
  ),
);

var dividerMenuTitle = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  ),
);

var itemTitle = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 18.0,
    //color: black,
    fontWeight: FontWeight.bold,
  ),
);

var itemDateStyle = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 11.0,
    //color: grey2,
  ),
);

var itemContentStyle = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 15.0,
    //color: grey2,
  ),
);

var viewTitleStyle = GoogleFonts.economica(
  fontWeight: FontWeight.w900,
  fontSize: 28.0,
);

var viewContentStyle = GoogleFonts.economica(
    letterSpacing: 1.0,
    fontSize: 20.0,
    height: 1.5,
    fontWeight: FontWeight.w400);

var createTitle = GoogleFonts.economica(
  textStyle: TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w900,
  ),
);

var createContent = GoogleFonts.economica(
  textStyle: TextStyle(
    letterSpacing: 1.0,
    fontSize: 20.0,
    height: 1.5,
    fontWeight: FontWeight.w400,
  ),
);
var shadow = [
  BoxShadow(
    color: Colors.grey[300],
    blurRadius: 30,
    offset: Offset(0, 10),
  ),
];

//Define the themes here!
//TODO: DARK THEME neeeds work
final darkTheme = ThemeData(
  brightness: Brightness.light,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.green),
  appBarTheme: AppBarTheme(
    color: Colors.green,
  ),
);

final lightTheme = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(color: black2),
    bodyText2: TextStyle(color: black2),
  ),
  highlightColor: Colors.green,
  brightness: Brightness.light,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: headerColor1),
  appBarTheme: AppBarTheme(
    color: headerColor1,
  ),
);

final lightTheme2 = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(color: black2),
    bodyText2: TextStyle(color: black2),
  ),
  brightness: Brightness.light,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: headerColor2),
  appBarTheme: AppBarTheme(
    color: headerColor2,
  ),
);

final lightTheme3 = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(color: black2),
    bodyText2: TextStyle(color: black2),
  ),
  brightness: Brightness.light,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: headerColor3),
  appBarTheme: AppBarTheme(
    color: headerColor3,
  ),
);

final lightTheme4 = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(color: black2),
    bodyText2: TextStyle(color: black2),
  ),
  brightness: Brightness.light,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: headerColor4),
  appBarTheme: AppBarTheme(
    color: headerColor4,
  ),
);
