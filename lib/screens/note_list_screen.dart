//Screen used to list out notes

//Flutter
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//Packages
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//Helpers
import '../helper/helpers.dart';

//Screens
import '../screens/screens.dart';

//Constant
import 'package:what_todo_app/utils/constants.dart';

class NoteListScreen extends StatelessWidget {
  static const route = '/note-list';

  @override
  Widget build(BuildContext context) {
    //FutureBuilder depends on state which will determine UI
    return FutureBuilder(
      //Future builder needs this
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        //If loading show loading progress indicator else proceed
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          //Check is state is complete else error out
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                brightness: Brightness.dark,
                backgroundColor: headerColor,
                elevation: 0.0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quick',
                      style: headerRideStyle,
                    ),
                    Text(
                      'Notes',
                      style: headerNoteStyle,
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  header(),
                  //Part of provider listener?
                  Consumer<NoteProvider>(
                    child: noNotesUI(context),
                    //Builder checks to see if there are any notes from the provider
                    //if there are none it will display the child above with the context
                    //of no noNotesUI else it will display a different UI.
                    builder: (context, noteprovider, child) =>
                        noteprovider.items.length <= 0 ? child : Container(),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                elevation: 0.0,
                heroTag: 'btn1',
                onPressed: () {
                  goToNoteEditScreen(context);
                },
                child: Icon(Icons.add),
              ),
            );
          }
          //Oops wtf just happened!?
          return Container(
            width: 0.0,
            height: 0.0,
          );
        }
      },
    );
  }

  //Main header for the screen
  Widget header() {
    //Header will launch a url which will navigate to a webpage
    return GestureDetector(
      onTap: _launchUrl,
      child: Container(
        decoration: BoxDecoration(
          color: headerColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(75.0),
          ),
        ),
        height: 50,
        width: double.infinity,
        child: null,
      ),
    );
  }

  //Method for the url launcher in the header method
  _launchUrl() async {
    const url = 'https://www.androidride.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Widget displayed when no notes are available
  Widget noNotesUI(BuildContext context) {
    //Column is for the header not to move with rest of ui
    return Expanded(
      child: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 25.0),
                child: Image.asset(
                  'assets/images/sad_note.png',
                  fit: BoxFit.cover,
                  width: 300,
                  height: 300,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: noNotesStyle,
                  children: [
                    TextSpan(text: 'There is no note available\nTap on"'),
                    //Make this tappable to the user to add a note
                    TextSpan(
                      text: '+',
                      style: boldPlus,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          goToNoteEditScreen(context);
                        },
                    ),
                    TextSpan(text: '"to add new note'),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  //Method used to move on the note editing screen
  void goToNoteEditScreen(BuildContext context) {
    //Push to screen stack
    Navigator.of(context).pushNamed(NoteEditScreen.route);
  }
}
