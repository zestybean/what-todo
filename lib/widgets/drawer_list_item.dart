//Flutter
import 'package:flutter/material.dart';

//Constants
import '../utils/utils.dart';

class DrawerListItem extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData icon;

  DrawerListItem({this.onTap, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            title: Text(
              title,
              style: dividerMenuTitle,
            ),
            trailing: Icon(icon, size: 35.0, color: headerColor),
          ),
          Divider(
            height: 2.0,
            thickness: 2.0,
            endIndent: 20.0,
          ),
        ],
      ),
    );
  }
}
