import 'package:get/get.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/screens/Authentification/sign_up.dart';
import 'package:myapp/screens/drawer/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final authController = AuthController();

  @override
  void initState() {
    super.initState();

    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
          reverse: true,
          child: Align(
            alignment: Alignment(-0.14, -0.08),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: primaryColors,
              ),
              alignment: Alignment(0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0x66EEEEEE),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: authController.email,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: GoogleFonts.getFont(
                                'Roboto',
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            style: GoogleFonts.getFont(
                              'Roboto',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0x65EEEEEE),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: authController.password,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: GoogleFonts.getFont(
                                'Roboto',
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 22,
                                ),
                              ),
                            ),
                            style: GoogleFonts.getFont(
                              'Roboto',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            authController.signIn();
                          },
                          child: Text('Login'),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: TextButton(
                            onPressed: () {
                              Get.offAll(() => SignUp());
                            },
                            child: Text('Not member yet? SIGN UP',
                                style: TextStyle(color: Colors.white)))),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
