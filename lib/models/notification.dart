class Notifications {
  String message;
  String sendingUser;
  DateTime sentDateTime;
  bool read;
  String id;

  Notifications(
      {this.message, this.sendingUser, this.sentDateTime, this.read, this.id});

  Notifications.fromSnapshot(Map<String, dynamic> data) {
    message = data["message"];
    sendingUser = data["sendingUser"];
    sentDateTime = data["sentDateTime"].toDate();
    read = data["read"];
    id = data["id"];
  }
}
