import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/screens/drawer/drawer.dart';
import 'package:myapp/screens/events/events.dart';
import 'package:myapp/screens/notifications/notifications.dart';
import 'package:myapp/screens/profile/profile.dart';
import 'package:myapp/shared_widgets/map/map.dart';
import 'package:myapp/screens/drawer/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/screens/drawer/settings.dart';

SharedPreferences preferences;

class Home extends StatefulWidget {
  const Home({Key key, this.currentIndex}) : super(key: key);
  final int currentIndex;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  dynamic navigation = GoogleMaps();

  Future getColor() async {
    preferences = await SharedPreferences.getInstance();
    int idx = preferences.getInt('color');
    primaryColors = getColorIndex(idx);
    setState(() {});
  }

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
    getColor();
  }

  _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _currentIndex = index;
      });
    }
    if (index == 1) {
      setState(() {
        _currentIndex = index;
      });
    }
    if (index == 2) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer(context),
        appBar: AppBar(
          backgroundColor: primaryColors,
          elevation: 10,
          title: Text(
            "Sporty",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GetX<UserController>(
                    init: Get.find<UserController>(),
                    builder: (UserController userController) {
                      if (userController != null &&
                          userController.listOfNotifications.value
                                  .where((element) => element.read == false)
                                  .length >
                              0) {
                        return Badge(
                          badgeColor: Colors.grey[300],
                          padding: EdgeInsets.all(10),
                          badgeContent: Text(
                            userController.listOfNotifications.value
                                .where((element) => element.read == false)
                                .length
                                .toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.to(() => Notifications());
                            },
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 40,
                            ),
                            iconSize: 40,
                          ),
                        );
                      } else {
                        return IconButton(
                            onPressed: () {
                              Get.to(() => Notifications());
                            },
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 40,
                            ));
                      }
                    }))
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 250),
          backgroundColor: primaryColors,
          color: Colors.white,
          height: 50,
          index: _currentIndex ?? 0,
          items: [
            Icon(Icons.map, size: 35),
            Icon(Icons.sports_tennis_sharp, size: 35),
            Icon(Icons.person_sharp, size: 35),
          ],
          onTap: _onItemTapped,
        ),
        body: IndexedStack(
          index: _currentIndex ?? 0,
          children: [GoogleMaps(), Events(), Profile()],
        ));
  }
}
