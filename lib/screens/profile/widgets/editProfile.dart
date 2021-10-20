import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/screens/drawer/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/screens/profile/widgets/profileWidget.dart';
import 'package:myapp/screens/profile/widgets/textFieldWidget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userController = Get.find<UserController>();
  final authController = Get.find<AuthController>();
  final _picker = ImagePicker();
  var pickedFile;
  var picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: primaryColors,
        title: Text(
          "Edit profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                userController.editProfile();
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GetX<UserController>(
                  init: userController,
                  builder: (UserController userController) {
                    if (picture != null) {
                      return InkWell(
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.file(picture),
                        ),
                      );
                    } else if (userController != null &&
                        userController.userData.value.imagePath != null) {
                      return ProfileWidget(
                        isEdit: true,
                        imagePath: userController.userData.value.imagePath,
                        onClicked: () {
                          _showChoiceDialog(context);
                        },
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          _showChoiceDialog(context);
                        },
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
                    }
                  })),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full name',
            text: userController.userData.value.name ?? "",
            onChanged: (name) {
              userController.userData.value.name = name;
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: userController.userData.value.about ?? "",
            maxLines: 5,
            onChanged: (about) {
              userController.userData.value.about = about;
            },
          ),
        ],
      ),
    );
  }

  _openGallery(BuildContext context) async {
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      picture = File(pickedFile.path);
    });

    if (pickedFile != null) {
      Navigator.pop(context);
      await _uploadPhoto(pickedFile.path);
    }
  }

  _openCamera(BuildContext context) async {
    pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      picture = File(pickedFile.path);
    });

    if (pickedFile != null) {
      Navigator.pop(context);
      await _uploadPhoto(pickedFile.path);
    }
  }

  UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<void> _uploadPhoto(imagePath) async {
    UploadTask task;
    File file;
    file = File(imagePath);
    task = uploadFile("users/${authController.firebaseUser.value.uid}", file);
    if (task == null) {
      print("empty");
    }
    final snapshot = await task.whenComplete(() {
      print("complete");
    });
    final urlDownload = await snapshot.ref.getDownloadURL();
    if (urlDownload.isNotEmpty) {
      userController.userData.value.imagePath = urlDownload;
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select source:'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
