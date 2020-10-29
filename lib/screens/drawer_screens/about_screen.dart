//Flutter
import 'package:flutter/material.dart';

//Packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

//Constants
import '../../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  static const route = '/drawer-about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headerColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: headerColor,
        title: Text(
          'About',
          style: headerNoteStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
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
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 0.0),
              child: Image.asset(
                'assets/images/splash_note.png',
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Artwork Design By: ',
                style: boldWhitePlus,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text('Thelma Studio', style: boldWhiteMinus),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 40.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _launchUrl('https://www.instagram.com/thelmastudio/');
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.facebookSquare,
                      size: 40.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _launchUrl('https://www.facebook.com/artbythelma/');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Programmed By: ',
                style: boldWhitePlus,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text('Zestybean Studio', style: boldWhiteMinus),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
              child: FlatButton(
                color: Colors.white,
                height: 50.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onPressed: () {
                  _launchUrl('https://www.buymeacoffee.com/zestybean');
                },
                child: Image.asset(
                  'assets/images/bmc_logo.png',
                  height: 40,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Version: 1.0.0',
                style: versionBoldMinus,
              ),
            )
          ],
        ),
      ),
    );
  }

  //Method for the url launcher
  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
