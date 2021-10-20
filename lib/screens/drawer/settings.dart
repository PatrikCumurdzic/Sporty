import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:myapp/screens/Home/home.dart';

class ChangeTheme extends StatefulWidget {
  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  Future setColor(int idx) async {
    await preferences.setInt('color', idx);
  }

  Future<bool> _willPopCallback() async {
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, "/");
    return false; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    new WillPopScope(child: new Scaffold(), onWillPop: _willPopCallback);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    fixedSize: Size(100, 20),
                  ),
                  onPressed: () {
                    setColor(1);
                    primaryColors = Colors.red;
                    _willPopCallback();
                    setState(() {});
                  },
                  child: Text(
                    "Red",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    fixedSize: Size(100, 20),
                  ),
                  onPressed: () {
                    setColor(2);
                    primaryColors = Colors.blue;
                    _willPopCallback();
                    setState(() {});
                  },
                  child: Text(
                    "Blue",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    fixedSize: Size(100, 20),
                  ),
                  onPressed: () {
                    setColor(3);
                    primaryColors = Colors.orange;
                    _willPopCallback();
                    setState(() {});
                  },
                  child: Text(
                    "Orange",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    fixedSize: Size(100, 20),
                  ),
                  onPressed: () {
                    setColor(4);
                    primaryColors = Colors.lightGreen;
                    _willPopCallback();
                    setState(() {});
                  },
                  child: Text(
                    "Green",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color primaryColors = Colors.blue;

Color getColorIndex(int idx) {
  switch (idx) {
    case 1:
      return Colors.red;
      break;
    case 2:
      return Colors.blue;
      break;
    case 3:
      return Colors.orange;
      break;
    case 4:
      return Colors.lightGreen;
      break;
  }
}
