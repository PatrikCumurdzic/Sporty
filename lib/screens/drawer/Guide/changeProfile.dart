import 'package:flutter/material.dart';
import 'package:myapp/screens/drawer/settings.dart';

class ProfileChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text("How to change your profile"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            "1. In the bottom of the main screen, navigate to the right button on navigation bar.\n\n"
            "2. After the page is loaded, profile page will be shown.\n\n"
            "3. There you will choose the button right of profile picture (pen).\n\n"
            "4. Edit page will be shown ad there you can change the profile picture by clicking on it,"
            " change your name or about you section.\n\n"
            "5. After you make changes press the button 'Save' in top right corner.",
            style: TextStyle(
              color: primaryColors,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
