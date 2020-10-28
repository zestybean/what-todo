//Screen used to create and update notes

//Flutter
import 'package:flutter/material.dart';
import 'package:what_todo_app/widgets/delete_popup.dart';
import 'dart:io';

//Helpers
import '../helper/helpers.dart';

//Packages
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

//Constants
import '../utils/constants.dart';

//Modals
import '../models/note.dart';

class NoteEditScreen extends StatefulWidget {
  static const route = '/note-edit';

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  File _image, localFile;
  final picker = ImagePicker();

  bool firstTime = true;
  Note selectedNote;
  int id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (firstTime) {
      id = ModalRoute.of(this.context).settings.arguments;

      print(id);

      if (id != null) {
        selectedNote =
            Provider.of<NoteProvider>(this.context, listen: false).getNote(id);

        titleController.text = selectedNote?.title;
        contentController.text = selectedNote?.content;

        if (selectedNote?.imagePath != null) {
          _image = File(selectedNote.imagePath);
        }
      }
      firstTime = false;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: black2,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          AppBarActionButton(
              icon: Icon(Icons.photo_camera),
              fun: () {
                getImage(ImageSource.camera);
              }),
          AppBarActionButton(
              icon: Icon(Icons.insert_photo),
              fun: () {
                getImage(ImageSource.gallery);
              }),
          AppBarActionButton(
              icon: Icon(Icons.delete),
              fun: () {
                if (id != null) {
                  _showDialog();
                } else {
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 0.0),
              child: TextField(
                controller: titleController,
                autocorrect: true,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: createTitle,
                decoration: InputDecoration(
                    hintText: 'Enter Note Title', border: InputBorder.none),
              ),
            ),
            if (_image != null)
              GestureDetector(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: FileImage(_image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    _image = null;
                                  },
                                );
                              },
                              child: Icon(
                                Icons.delete,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 5.0,
                top: 10.0,
                bottom: 5.0,
              ),
              child: TextField(
                controller: contentController,
                maxLines: null,
                style: createContent,
                decoration:
                    InputDecoration(hintText: 'Enter the note description...'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'noteEditBtn',
        onPressed: () {
          if (titleController.text.isEmpty)
            titleController.text = 'Untitled Note';
          saveNote();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  //Method that returns the image from the devices
  void getImage(ImageSource imageSource) async {
    //Uses the image picker package to return image from device
    //in form of path
    PickedFile imageFile = await picker.getImage(source: imageSource);

    //If image selection is cancelled return null
    if (imageFile == null) return;

    File tmpFile = File(imageFile.path);

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);

    localFile = await tmpFile.copy('${appDir.path}/$fileName');

    setState(() {
      _image = localFile;
    });
  }

  //Method that will add the note to the db
  void saveNote() {
    //Inits
    String title = titleController.text.trim();
    String content = contentController.text.trim();
    String imagePath = _image != null ? _image.path : null;

    //Saved or updated
    if (id != null) {
      Provider.of<NoteProvider>(this.context, listen: false)
          .addOrUpdateNote(id, title, content, imagePath, EditMode.UPDATE);
      Navigator.of(this.context).popUntil(ModalRoute.withName('/note-list'));
    } else {
      //Using time for the id of each note for unique-ness
      int id = DateTime.now().millisecondsSinceEpoch;
      //Calls the provider listener to add or update the note dependent
      //on the id if it exists udpate else add new
      Provider.of<NoteProvider>(this.context, listen: false)
          .addOrUpdateNote(id, title, content, imagePath, EditMode.ADD);
      //Go to view notes
      Navigator.of(this.context).popUntil(ModalRoute.withName('/note-list'));
    }
  }

  void _showDialog() {
    showDialog(
      context: this.context,
      builder: (context) {
        return DeletePopUp(selectedNote: selectedNote);
      },
    );
  }
}

//Small widget for the app bar buttons
class AppBarActionButton extends StatelessWidget {
  final Icon icon;

  //Call back for each button that needs to be passed in
  final Function fun;

  AppBarActionButton({this.icon, this.fun});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      color: black2,
      onPressed: fun,
    );
  }
}
