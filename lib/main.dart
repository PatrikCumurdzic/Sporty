import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/firebase.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/event_controller.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/screens/Home/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) => {
        Get.put(AuthController()),
        Get.put(UserController()),
        Get.put(EventController())
      });

  runApp(GetMaterialApp(
    title: 'Sporty',
    routes: {
      '/': (context) => const Home(
            currentIndex: 0,
          ),
    },
    theme: ThemeData(
      primaryColor: Colors.lightBlue,
    ),
  ));
}
