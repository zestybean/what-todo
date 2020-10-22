//Contains add update delete oprations to notify provider listeners

//Flutter
import 'package:flutter/material.dart';

//Helper
import 'database_helper.dart';

//Models
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List _items = [];

  List get items {
    return [..._items];
  }

  //Retrieve notes from the DB after converting map to list
  Future getNotes() async {
    final notesList = await DatabaseHelper.getNotesFromDB();

    _items = notesList
        .map(
          (n) => Note(n['id'], n['title'], n['content'], n['imagePath']),
        )
        .toList();

    //Will trigger rebuild to listeners
    //Used mainly by the provider package
    notifyListeners();
  }
}
