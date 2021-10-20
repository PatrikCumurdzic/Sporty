import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/screens/Authentification/login.dart';
import 'package:myapp/screens/drawer/settings.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final authController = Get.find<AuthController>();

  bool passwordVisibility = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment(-0.14, -0.08),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: primaryColors,
                  ),
                  alignment: Alignment(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => Login());
                        },
                        child: Text('You are already member? LOGIN',
                            style: TextStyle(color: Colors.white)),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                            child: TextFormField(
                              controller: authController.email,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: GoogleFonts.getFont(
                                  'Roboto',
                                  color: primaryColors,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: GoogleFonts.getFont(
                                'Roboto',
                                color: primaryColors,
                                fontWeight: FontWeight.normal,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Ovo polje je obavezno';
                                }

                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                            child: TextFormField(
                              controller: authController.password,
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                hintText: 'Lozinka',
                                hintStyle: GoogleFonts.getFont(
                                  'Roboto',
                                  color: primaryColors,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColors,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColors,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility =
                                        !passwordVisibility,
                                  ),
                                  child: Icon(
                                    passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              style: GoogleFonts.getFont(
                                'Roboto',
                                color: primaryColors,
                                fontWeight: FontWeight.normal,
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Ovo polje je obavezno';
                                }

                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await authController.registration();
                            },
                            child: Text('Sign up'),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
