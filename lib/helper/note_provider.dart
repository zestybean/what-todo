//Contains add update delete oprations to notify provider listeners

//Flutter
import 'package:flutter/material.dart';

//Helper
import 'database_helper.dart';

//Models
import '../models/note.dart';

//Constants
import '../utils/constants.dart';

class NoteProvider with ChangeNotifier {
  List _items = [];

  List get items {
    return [..._items];
  }

  //Retrieve notes from the DB after converting map to list
  Future getNotes() async {
    final notesList = await DatabaseHelper.getNotesFromDB();

    //Convert to list!
    _items = notesList
        .map(
          (n) => Note(n['id'], n['title'], n['content'], n['imagePath']),
        )
        .toList();

    //Will trigger rebuild to listeners
    //Used mainly by the provider package
    notifyListeners();
  }

  Future addOrUpdateNote(int id, String title, String content, String imagePath,
      EditMode editMode) async {
    final note = Note(id, title, content, imagePath);

    if (EditMode.ADD == editMode) {
      _items.insert(0, note);
    } else {
      _items[_items.indexWhere((note) => note.id == id)] = note;
    }

    notifyListeners();

    DatabaseHelper.insertNoteToDB({
      'id': note.id,
      'title': note.title,
      'content': note.content,
      'imagePath': note.imagePath,
    });
  }
}
