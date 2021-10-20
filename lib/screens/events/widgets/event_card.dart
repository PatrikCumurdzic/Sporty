import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/event_controller.dart';
import 'package:myapp/models/event.dart';
import 'package:myapp/screens/drawer/settings.dart';
import 'package:myapp/screens/events/widgets/allParticipants.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final eventController = Get.find<EventController>();
    var color =
        !event.participants.contains(authController.firebaseUser.value.uid) &&
                event.creator != authController.firebaseUser.value.uid
            ? Colors.blue
            : event.creator == authController.firebaseUser.value.uid
                ? Colors.red
                : Colors.red;

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: event.creator == authController.firebaseUser.value.uid
          ? Colors.grey[300]
          : Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(140, 4, 12, 4),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: color,
                          ),
                          onPressed: () {
                            if (event.creator ==
                                authController.firebaseUser.value.uid) {
                              eventController.removeEvent(event);
                            }
                            if (!event.participants.contains(
                                    authController.firebaseUser.value.uid) &&
                                event.creator !=
                                    authController.firebaseUser.value.uid) {
                              eventController.joinEvent(event);
                            } else {
                              eventController.leaveEvent(event);
                            }
                          },
                          child: Text(!event.participants.contains(
                                      authController.firebaseUser.value.uid) &&
                                  event.creator !=
                                      authController.firebaseUser.value.uid
                              ? 'Join'
                              : event.creator ==
                                      authController.firebaseUser.value.uid
                                  ? 'Remove'
                                  : 'Leave'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        event.sport,
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF151B1E),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                child: Text(
                  "Current participants: ${event.participants.length ?? 0}/${event.totalParticipants}",
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF151B1E),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: TextButton(
                onPressed: () {
                  Get.to(() => AllParticipants(event: event));
                },
                child: Text(
                  'See all participants',
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColors,
                  ),
                ),
              )),
          Row(children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 12, 4),
                child: Text(
                  "Note: ${event.note}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF151B1E),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ]),
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
                    "${DateFormat("EEEE, dd.MM in hh:mm").format(event.dateTime)}",
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
                child: Icon(
                  Icons.location_on_sharp,
                  color: Color(0xFF151B1E),
                  size: 25,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 0, 12),
                  child: Text(
                    event.address,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF151B1E),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
