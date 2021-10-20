import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/firebase.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/screens/notifications/widgets/notification_card.dart';
import 'package:myapp/screens/drawer/settings.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  @override
  void initState() {
    readNotification();
    super.initState();
  }

  readNotification() async {
    userController.listOfNotifications.value.forEach((element) async {
      await firebaseFirestore
          .collection("users")
          .doc(authController.firebaseUser.value.uid)
          .collection("notifications")
          .doc(element.id)
          .update({"read": true}).then(
              (value) => userController.notificationCounter.value = 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColors,
          title: Text(
            "Notifications",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            if (userController.listOfNotifications.value.length > 0)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColors,
                ),
                onPressed: () {
                  userController.clearAllNotifications();
                },
                child: Text("Clear"),
              ),
          ],
        ),
        body: SafeArea(
            child: Column(children: [
          GetX<UserController>(
            init: Get.find<UserController>(),
            builder: (UserController userController) {
              if (userController != null &&
                  userController.listOfNotifications.value.length > 0) {
                return Expanded(
                  child: ListView.builder(
                      itemCount:
                          userController.listOfNotifications.value.length,
                      itemBuilder: (_, index) {
                        return NotificationCard(
                            notification: userController
                                .listOfNotifications.value[index]);
                      }),
                );
              } else {
                return Center(
                  child: Text("Empty"),
                );
              }
            },
          )
        ])));
  }
}
