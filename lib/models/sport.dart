class Sport {
  String id;
  String name;

  Sport({this.id, this.name});

  Sport.fromSnapshot(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
  }
}
