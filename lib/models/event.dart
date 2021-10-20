import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user.dart';

class Event {
  String id;
  String sport;
  double lat;
  double lng;
  String address;
  String note;
  String creator;
  int totalParticipants;
  DateTime dateTime;
  List<dynamic> participants;

  Event(
      {this.id,
      this.creator,
      this.participants,
      this.sport,
      this.dateTime,
      this.totalParticipants,
      this.note,
      this.lat,
      this.lng,
      this.address});

  Event.fromSnapshot(Map<String, dynamic> data) {
    sport = data["sport"];
    lat = data["lat"];
    lng = data["lng"];
    address = data["address"];
    participants = data["participants"] as List<dynamic>;
    id = data["id"];
    creator = data["creator"];
    dateTime = data["dateTime"].toDate();
    totalParticipants = data["totalParticipants"];
    note = data["note"];
  }
}
