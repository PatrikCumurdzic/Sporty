import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/firebase.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/screens/Authentification/Login.dart';
import 'package:myapp/screens/Home/home.dart';

class AuthController extends GetxController {
  Rxn<User> firebaseUser = Rxn<User>().obs();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rxn<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(
        firebaseUser,
        (_) => {
              if (firebaseUser.value == null)
                {Get.offAll(() => Login())}
              else
                {Get.offAll(() => Home())}
            });
  }

  signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        var userController = Get.find<UserController>();
        userController.getProfileData();
        userController.fetchNotifications();
        clearControllers();
      });
    } catch (e) {
      Get.snackbar("Error", e.message.toString());
    }
  }

  registration() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        addUserToFirestore(result.user);
        clearControllers();
      });
    } catch (e) {
      Get.snackbar("Error", e.message.toString());
    }
  }

  signOut() async {
    auth.signOut();
  }

  addUserToFirestore(User user) async {
    await firebaseFirestore.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
    }).catchError((e) => {Get.snackbar("Error", e.message.toString())});
  }

  clearControllers() {
    email.clear();
    password.clear();
  }
}
