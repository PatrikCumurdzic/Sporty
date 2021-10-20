import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/profile/widgets/profileWidget.dart';
import 'package:myapp/screens/drawer/settings.dart';

class PlayerProfile extends StatefulWidget {
  const PlayerProfile({Key key, this.playerData}) : super(key: key);
  final User playerData;
  @override
  _PlayerProfileState createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text(
          "Player profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: widget.playerData.imagePath != null
                ? ProfileWidget(
                    imagePath: widget.playerData.imagePath,
                    onClicked: () async {
                      _showPic(context);
                    },
                  )
                : InkWell(
                    child: Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/no_image.png',
                      ),
                    ),
                  ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text(
                widget.playerData.name ?? "Display name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 100, 0, 0),
            child: Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              widget.playerData.about ?? "No informations given",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showPic(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Stack(
                children: [
                  Image.network(widget.playerData.imagePath),
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                    top: 10,
                    right: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
