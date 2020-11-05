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
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

//Utils
import '../utils/utils.dart';

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

  //Speech to text
  stt.SpeechToText _speech;
  bool _isListening = false;

  bool firstTime = true;
  Note selectedNote;
  int id;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (firstTime) {
      id = ModalRoute.of(this.context).settings.arguments;

      //If note exists return the note values from the db
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
                                color: black2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Divider(
              indent: 8.0,
              endIndent: 8.0,
              thickness: 1.0,
              color: black2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note Toolbar: ',
                    style: itemTitle,
                  ),
                  SpeechToTextButton(
                    isListening: _isListening,
                    listenFunction: _listen,
                  ),
                  GestureDetector(
                    onTap: () {
                      contentController.clear();
                      contentController.text = '•';
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.color,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.list,
                        color: white,
                        size: 35.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0,
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

  //Show delete pop up function
  void _showDialog() {
    showDialog(
      context: this.context,
      builder: (context) {
        return DeletePopUp(selectedNote: selectedNote);
      },
    );
  }

  //Speech to text handle
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(
            () {
              contentController.clear();
              contentController.text = val.recognizedWords;
            },
          ),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

//Speech to text button
class SpeechToTextButton extends StatelessWidget {
  final Function listenFunction;
  final bool isListening;

  SpeechToTextButton(
      {@required this.isListening, @required this.listenFunction});

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      animate: isListening,
      glowColor: Theme.of(context).appBarTheme.color,
      repeat: true,
      endRadius: 50.0,
      duration: const Duration(milliseconds: 1000),
      repeatPauseDuration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: listenFunction,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.color,
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: 50,
          width: 50,
          child: Icon(
            isListening ? Icons.mic : Icons.mic_none,
            color: white,
            size: 35.0,
          ),
        ),
      ),
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
