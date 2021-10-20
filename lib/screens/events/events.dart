import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/event_controller.dart';
import 'package:myapp/screens/drawer/settings.dart';
import 'package:myapp/screens/events/widgets/addEvents.dart';
import 'package:myapp/screens/events/widgets/event_card.dart';

class Events extends StatefulWidget {
  const Events({Key key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final authController = Get.find<AuthController>();
  EventController eventController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColors,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 35),
          onPressed: () => Get.to(() => AddEvent()),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SafeArea(
            child: GetX<EventController>(
          init: Get.find<EventController>(),
          builder: (EventController eventController) {
            if (eventController != null &&
                eventController.listOfEvents != null) {
              return ListView.builder(
                  itemCount: eventController.listOfEvents.value.length,
                  itemBuilder: (_, index) {
                    return EventCard(
                        event: eventController.listOfEvents.value[index]);
                  });
            } else {
              return Center(
                child: Text("Empty"),
              );
            }
          },
        )));
  }
}
