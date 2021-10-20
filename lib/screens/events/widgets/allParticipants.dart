import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/event_controller.dart';
import 'package:myapp/models/event.dart';
import 'package:myapp/screens/events/widgets/participantCard.dart';
import 'package:myapp/screens/drawer/settings.dart';

class AllParticipants extends StatefulWidget {
  AllParticipants({Key key, this.event}) : super(key: key);
  final Event event;
  @override
  _AllParticipantsState createState() => _AllParticipantsState();
}

class _AllParticipantsState extends State<AllParticipants> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final eventController = Get.find<EventController>();
  @override
  void initState() {
    eventController.getParticipants(widget.event);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColors,
        automaticallyImplyLeading: true,
        title: Text(
          'Participants',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(child: GetX<EventController>(
        builder: (EventController eventController) {
          if (eventController != null &&
              eventController.listOfParticipants != null) {
            return ListView.builder(
                itemCount: eventController.listOfParticipants.value.length,
                itemBuilder: (_, index) {
                  return ParticipantCard(
                      participant:
                          eventController.listOfParticipants.value[index]);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
