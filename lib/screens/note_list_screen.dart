//Screen used to list out notes

//Flutter
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//Packages
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:what_todo_app/widgets/list_item.dart';

//Helpers
import '../helper/helpers.dart';

//Screens
import '../screens/screens.dart';

//Widgets
import '../widgets/widgets.dart';

//Utils
import '../utils/utils.dart';

class NoteListScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
              key: _scaffoldKey,
              appBar: AppBar(
                brightness: Brightness.dark,
                backgroundColor: headerColor,
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.more_vert_sharp,
                    size: 40.0,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
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
                        noteprovider.items.length <= 0
                            ? child
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: noteprovider.items.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Container();
                                    } else {
                                      final i = index - 1;
                                      final item = noteprovider.items[i];
                                      return ListItem(
                                        id: item.id,
                                        title: item.title,
                                        content: item.content,
                                        imagePath: item.imagePath,
                                        date: item.date,
                                      );
                                    }
                                  },
                                ),
                              ),
                  ),
                ],
              ),
              drawer: drawer(context),
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 0.0,
                heroTag: 'noteListBtn',
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

  //Drawer properties for list screen
  Widget drawer(BuildContext context) {
    return SizedBox(
      //Half the screen size
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: headerColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 25.0),
                child: Image.asset(
                  'assets/images/note_logo.png',
                  fit: BoxFit.scaleDown,
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  DrawerListItem(
                    onTap: () {
                      Navigator.of(context).pushNamed(SettingsScreen.route);
                    },
                    title: 'Settings',
                    icon: Icons.settings,
                  ),
                  DrawerListItem(
                    onTap: () {
                      Navigator.of(context).pushNamed(AboutScreen.route);
                    },
                    title: 'About',
                    icon: Icons.person,
                  ),
                  DrawerListItem(
                    onTap: () {},
                    title: 'Support',
                    icon: Icons.mail,
                  ),
                  DrawerListItem(
                    onTap: () {},
                    title: 'Share',
                    icon: Icons.ios_share,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        height: 35,
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
