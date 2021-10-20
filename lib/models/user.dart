class User {
  String imagePath;
  String name;
  String uid;
  String email;
  String about;
  double rating;

  User(
      {this.imagePath,
      this.name,
      this.email,
      this.about,
      this.rating,
      this.uid});

  User.fromSnapshot(Map<String, dynamic> data) {
    name = data["name"];
    uid = data["uid"];
    email = data["email"];
    about = data["about"];
    rating = data["rating"];
    imagePath = data["imagePath"];
  }
}
