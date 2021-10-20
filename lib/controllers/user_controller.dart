import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/firebase.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/models/notification.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/Home/home.dart';

class UserController extends GetxController {
  var userData = User().obs;
  final authController = Get.find<AuthController>();
  final _notification = FlutterLocalNotificationsPlugin();

  Rx<List<Notifications>> listOfNotifications = Rx<List<Notifications>>([]);
  var notificationCounter = 0.obs;

  @override
  void onReady() {
    super.onReady();
    if (authController.firebaseUser.value != null) {
      listOfNotifications.bindStream(fetchNotifications());
      getProfileData();
    }
  }

  Stream<List<Notifications>> fetchNotifications() {
    return firebaseFirestore
        .collection("users")
        .doc(authController.firebaseUser.value.uid)
        .collection("notifications")
        .orderBy("sentDateTime", descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Notifications> streamList = [];

      querySnapshot.docs.forEach((element) {
        if (Notifications.fromSnapshot(element.data()).read == false &&
            Notifications.fromSnapshot(element.data()).sendingUser !=
                authController.firebaseUser.value.uid) {
          showNotification(
              "Notification",
              Notifications.fromSnapshot(element.data()).message,
              "to ce biti payload");
        }
        streamList.add(Notifications.fromSnapshot(element.data()));
      });
      return streamList;
    });
  }

  clearAllNotifications() async {
    await firebaseFirestore
        .collection("users")
        .doc(authController.firebaseUser.value.uid)
        .collection("notifications")
        .get()
        .then((value) => {
              for (DocumentSnapshot ds in value.docs)
                {
                  ds.reference.delete(),
                  Get.snackbar(
                      "Success", "You succesfully clear all notifications.")
                }
            });
  }

  Future notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channelId', 'channelName', 'channelDescription',
            icon: "@mipmap/ic_launcher", importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  Future showNotification(
    String title,
    String body,
    String payload, {
    int id = 0,
  }) async =>
      _notification.show(id, title, body, await notificationDetails(),
          payload: payload);

  getProfileData() async {
    await firebaseFirestore
        .collection("users")
        .doc(authController.firebaseUser.value.uid)
        .get()
        .then((value) => userData.value = User.fromSnapshot(value.data()));
  }

  editProfile() async {
    await firebaseFirestore
        .collection("users")
        .doc(authController.firebaseUser.value.uid)
        .update({
          "name": userData.value.name,
          "about": userData.value.about,
          "imagePath": userData.value.imagePath
        })
        .then((value) => {
              Get.offAll(() => Home(
                    currentIndex: 2,
                  )),
              Get.snackbar(
                  "Success", "You succesfully update your profile info."),
            })
        .onError(
            (error, stackTrace) => {Get.snackbar("Error", error.toString())});
  }
}
