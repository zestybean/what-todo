//Displays an alertbox when deleting a note

//Flutter
import 'package:flutter/material.dart';

//Models
import '../models/note.dart';

//Helpers
import '../helper/helpers.dart';

//Packages
import 'package:provider/provider.dart';

//Utils
import '../utils/utils.dart';

class DeletePopUp extends StatelessWidget {
  const DeletePopUp({
    Key key,
    @required this.selectedNote,
  }) : super(key: key);

  final Note selectedNote;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text('Delete?', style: popUpTitleStyle),
      content:
          Text('Do you want to delete this note?', style: popUpContentStyle),
      actions: [
        FlatButton(
          child: Text(
            'Yes',
            style: popUpContentStyle,
          ),
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false)
                .deleteNote(selectedNote.id);
            Navigator.popUntil(context, ModalRoute.withName('/note-list'));
          },
        ),
        FlatButton(
          child: Text(
            'No',
            style: popUpContentStyle,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
