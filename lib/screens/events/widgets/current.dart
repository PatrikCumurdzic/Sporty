import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/event_controller.dart';
import 'package:myapp/models/event.dart';

class EventCard extends StatefulWidget {
  const EventCard({Key key, this.event}) : super(key: key);
  final Event event;
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  final authController = Get.find<AuthController>();
  final eventController = Get.find<EventController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Obx(() {
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: widget.event.creator == authController.firebaseUser.value.uid
                ? Colors.blue[300]
                : Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Text(
                      widget.event.sport,
                      style: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF151B1E),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        "Current participants: ${widget.event.participants.length ?? 0}/${widget.event.totalParticipants}",
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF151B1E),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    !widget.event.participants.contains(
                                authController.firebaseUser.value.uid) &&
                            widget.event.creator !=
                                authController.firebaseUser.value.uid
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(100, 20, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                eventController.joinEvent(widget.event);
                              },
                              child: Text('Join'),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(100, 20, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                // leave
                              },
                              child: Text(widget.event.creator ==
                                      authController.firebaseUser.value.uid
                                  ? 'Remove'
                                  : 'Leave'),
                            ),
                          ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(12, 4, 12, 8),
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                              child: Icon(
                                Icons.schedule,
                                color: Color(0xFF151B1E),
                                size: 25,
                              ),
                            ),
                          ])),
                      Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text(
                          "${DateFormat("EEEE, dd.MM in hh:mm").format(widget.event.dateTime)}",
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                        child: Text(
                          widget.event.note,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF151B1E),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Icon(
                        Icons.location_on_sharp,
                        color: Color(0xFF151B1E),
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Text(
                        widget.event.address,
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF151B1E),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
