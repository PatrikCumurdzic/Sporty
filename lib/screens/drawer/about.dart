import 'package:flutter/material.dart';
import 'package:myapp/screens/drawer/settings.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColors,
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text(
          "About Sporty",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Text(
            "Sporty is a sports application that helps users to find or create a sports activities on the desired location.\n\n\n"
            "The main goal of the Sporty App is to find participants of sports activities with the same interests "
            "and wants to encourage recreation for both young and old and gather all sports in one place.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
