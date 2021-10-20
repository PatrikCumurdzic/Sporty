import 'package:flutter/material.dart';
import 'package:myapp/screens/drawer/settings.dart';

class ChangeThemes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text("How to change app themes"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            "1. In the top right on the main screen, press the button to open drawer.\n\n"
            "2. In the 'Sporty Menu' choose the 'Settings' option.\n\n"
            "3. There you just choose which color you want to have in the app.\n\n",
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
