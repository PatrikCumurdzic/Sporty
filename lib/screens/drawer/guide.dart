import 'package:flutter/material.dart';
import 'package:myapp/screens/drawer/Guide/addActivity.dart';
import 'package:myapp/screens/drawer/Guide/changeProfile.dart';
import 'package:myapp/screens/drawer/Guide/changeTheme.dart';
import 'package:myapp/screens/drawer/Guide/joinActivity.dart';
import 'package:myapp/screens/drawer/settings.dart';

class Manual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text(
          "User guide",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Divider(),
            ListTile(
              leading: Icon(Icons.add_box, size: 20),
              title: Text(
                "Create Activity",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddActivity()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_box, size: 20),
              title: Text(
                "Join Activity",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JoinActivity()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_box, size: 20),
              title: Text(
                "Change Profile Information",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileChange()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_box, size: 20),
              title: Text(
                "Change App Themes",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeThemes()));
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
