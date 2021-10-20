import 'package:flutter/material.dart';
import 'package:myapp/screens/drawer/settings.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    Key key,
    this.isEdit = false,
    this.imagePath,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return buildCircle(
      color: primaryColors,
      all: 5,
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
            child: InkWell(onTap: onClicked),
          ),
        ),
      ),
    );
  }

  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
