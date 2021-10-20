import 'package:flutter/material.dart';
import 'package:myapp/constants/firebase.dart';

import 'package:myapp/models/notification.dart';
import 'package:myapp/models/user.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key key, this.notification}) : super(key: key);
  final Notifications notification;
  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  var userData = User();

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    await firebaseFirestore
        .collection("users")
        .doc(widget.notification.sendingUser)
        .get()
        .then((value) {
      setState(() {
        userData = User.fromSnapshot(value.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: userData != null
          ? Container(
              height: 140,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        if (userData.imagePath != null)
                          Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              userData.imagePath ?? "",
                              fit: BoxFit.fill,
                            ),
                          ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              widget.notification.message.toString(),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                          child: Icon(
                            Icons.schedule,
                            color: Color(0xFF151B1E),
                            size: 25,
                          ),
                        ),
                        Text(timeago
                            .format(widget.notification.sentDateTime)
                            .toString())
                      ],
                    )
                  ],
                ),
              ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
