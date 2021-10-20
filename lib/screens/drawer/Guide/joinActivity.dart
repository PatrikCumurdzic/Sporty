import 'package:flutter/material.dart';
import 'package:myapp/screens/drawer/settings.dart';

class JoinActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text("How to join activity"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            "1. In the bottom of the main screen, navigate to the middle button on navigation bar.\n\n"
            "2. After the page is loaded, all available activities will be shown in cards.\n\n"
            "3. There you will choose which activity you want to join.\n\n"
            "4. Press the button 'Join'.",
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
