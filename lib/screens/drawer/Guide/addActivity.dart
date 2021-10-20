import 'package:flutter/material.dart';
import 'package:myapp/screens/drawer/settings.dart';

class AddActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text("How to create activity"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            "1. In the bottom of the main screen, navigate to the middle button on navigation bar.\n\n"
            "2. After the page is loaded, press the plus button in the bottom right corner of the page.\n\n"
            "3. There you will choose which sport you want, time, location, how many participants you want"
            " and additional information.\n\n4. After everything is filled press the Create button in the top right corner.",
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
