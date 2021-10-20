import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/screens/profile/widgets/editProfile.dart';
import 'package:myapp/screens/profile/widgets/profileWidget.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userController = Get.find<UserController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()));
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GetX<UserController>(builder: (_) {
                    return _.userData.value.imagePath != null
                        ? ProfileWidget(
                            imagePath: _.userData.value.imagePath,
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
                          );
                  })),
            ],
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 64),
          const SizedBox(height: 48),
          Divider(),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          GetX<UserController>(
            builder: (_) {
              return Text(
                _.userData.value.name ?? "Display name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            userController.userData.value.email ?? "",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          )
        ],
      );

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GetX<UserController>(
              builder: (_) {
                return Text(
                  _.userData.value.about ?? "Add something about you",
                  style: TextStyle(fontSize: 16, height: 1.4),
                );
              },
            ),
          ],
        ),
      );

  Future<void> _showPic(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Stack(
                children: [
                  Image.network(userController.userData.value.imagePath),
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
