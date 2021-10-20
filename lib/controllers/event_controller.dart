import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/firebase.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/models/event.dart';
import 'package:myapp/models/notification.dart';
import 'package:myapp/models/sport.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/profile/widgets/editProfile.dart';
import 'package:timezone/timezone.dart' as tz;

class EventController extends GetxController {
  var eventData = Event().obs;
  var participantNumber = 1.obs;
  Rx<List<Event>> listOfEvents = Rx<List<Event>>([]);
  Rx<List<User>> listOfParticipants = Rx<List<User>>([]);

  List<Sport> filteredSports = <Sport>[].obs;
  List<Sport> listOfSports = <Sport>[].obs;
  final TextEditingController sportController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();
  final _notification = FlutterLocalNotificationsPlugin();

  @override
  void onReady() {
    super.onReady();
    fetchSports();
    listOfEvents.bindStream(fetchEvents());
  }

  increase() {
    if (participantNumber < 24) {
      participantNumber++;
    }
  }

  decrease() {
    if (participantNumber > 1) {
      participantNumber--;
    }
  }

  createEvent() async {
    if (userController.userData.value.name.isEmpty) {
      Get.snackbar("Error", "Please complete your profile.");
      Get.offAll(() => EditProfile());
    } else {
      await firebaseFirestore.collection("activities").add({
        "sport": eventData.value.sport,
        "address": eventData.value.address,
        "dateTime": eventData.value.dateTime,
        "lat": eventData.value.lat,
        "lng": eventData.value.lng,
        "creator": authController.firebaseUser.value.uid,
        "totalParticipants": participantNumber.value,
        "participants": [],
        "note": noteController.text ?? ""
      }).then((snapshot) => {
            snapshot.update({"id": snapshot.id}).then((value) async => {
                  Get.back(),
                  Get.snackbar("Success", "You succesfully created activity"),
                }),
          });
    }
  }

  leaveEvent(Event event) async {
    await firebaseFirestore.collection("activities").doc(event.id).update({
      "participants":
          FieldValue.arrayRemove([authController.firebaseUser.value.uid])
    }).then((value) => print("uspjeh"));

    await firebaseFirestore
        .collection("users")
        .doc(event.creator)
        .collection("notifications")
        .add({
      "sendingUser": authController.firebaseUser.value.uid,
      "message":
          "${userController.userData.value.name} has just leaved your activity: ${event.sport}",
      "sentDateTime": DateTime.now(),
      "read": false,
    }).then((value) => {
              value.update({"id": value.id}),
              Get.snackbar("Success", "You are successfully leaved")
            });
  }

  joinEvent(Event event) async {
    if (userController.userData.value.name.isEmpty) {
      Get.snackbar("Error", "Please complete your profile.");
      Get.offAll(() => EditProfile());
    } else
      await firebaseFirestore.collection("activities").doc(event.id).update({
        "participants":
            FieldValue.arrayUnion([authController.firebaseUser.value.uid])
      }).then((value) => print("uspjeh"));

    await firebaseFirestore
        .collection("users")
        .doc(event.creator)
        .collection("notifications")
        .add({
      "sendingUser": authController.firebaseUser.value.uid,
      "message":
          "${userController.userData.value.name} has just joined to your activity: ${event.sport}",
      "sentDateTime": DateTime.now(),
      "read": false,
    }).then((value) => {
              value.update({"id": value.id}),
              Get.snackbar("Success", "You are successfully joined")
            });
  }

  removeEvent(Event event) async {
    await firebaseFirestore.collection("activities").doc(event.id).delete();

    for (var item in event.participants) {
      await firebaseFirestore
          .collection("users")
          .doc(item)
          .collection("notifications")
          .add({
        "sendingUser": event.creator,
        "message":
            "${userController.userData.value.name} cancelled their activity: ${event.sport}.",
        "sentDateTime": DateTime.now(),
        "read": false,
      }).then((value) => {
                value.update({"id": value.id}),
                Get.snackbar(
                    "Success", "You successfully deleted event: ${event.sport}")
              });
    }
  }

  fetchSports() async {
    if (listOfSports.isEmpty)
      listOfSports = await firebaseFirestore.collection("sports").get().then(
            (querySnapshot) => querySnapshot.docs
                .map((e) => Sport.fromSnapshot(e.data()))
                .toList(),
          );
  }

  getParticipants(Event event) async {
    listOfParticipants.value = await firebaseFirestore
        .collection("users")
        .where("uid", whereIn: event.participants)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs
              .map((e) => User.fromSnapshot(e.data()))
              .toList(),
        );
  }

  Stream<List<Event>> fetchEvents() {
    return firebaseFirestore
        .collection("activities")
        .orderBy("dateTime", descending: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Event> streamList = [];

      querySnapshot.docs.forEach((element) {
        streamList.add(Event.fromSnapshot(element.data()));
      });
      return streamList;
    });
  }

  searchSport(String searchText) {
    return filteredSports = listOfSports
        .where((element) =>
            element.name.toLowerCase().startsWith(searchText.toLowerCase()))
        .toList();
  }
}
