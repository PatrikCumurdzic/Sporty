import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'about.dart';
import 'settings.dart';
import 'guide.dart';
import 'package:myapp/screens/drawer/settings.dart';

Widget drawer(BuildContext context) {
  final authController = Get.find<AuthController>();

  return Drawer(
    child: ListView(
      children: [
        Container(
          height: 65,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColors,
            ),
            child: Text(
              "Sporty Menu",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.info_outline, size: 20),
          title: Text(
            "About",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => About()));
          },
        ),
        ListTile(
          leading: Icon(Icons.help_outline, size: 20),
          title: Text(
            "User guide",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Manual()));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings_outlined, size: 20),
          title: Text(
            "Settings",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangeTheme()));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout, size: 20),
          title: Text(
            "Log Out",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            authController.signOut();
          },
        ),
      ],
    ),
  );
}
