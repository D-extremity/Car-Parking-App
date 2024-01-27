import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/firebasemethod/firebaseauth.dart';
import 'package:parking_system/pages/loginpage.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/textinput.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

void signUpUser(BuildContext context, TextEditingController _getEmail,
    TextEditingController _getPass, TextEditingController _getName) async {
  await FirebaseAuthMethod(FirebaseAuth.instance).signUpWithEmail(
      email: _getEmail.text.trim(),
      password: _getPass.text.trim(),
      context: context,
      userName: _getName.text.trim());
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController getParkingName = TextEditingController();
  TextEditingController getPass = TextEditingController();
  TextEditingController getEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            "Parking",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.height * 0.1,
                color: titleColor),
          ),
          Center(
            child: SizedBox(
              height: size.height * 0.6,
              width: size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * 0.009,
                    ),
                    InputTextWidget(
                        isObscurse: false,
                        widgetUsageName: "Parking Name",
                        controller: getParkingName),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    InputTextWidget(
                        isObscurse: false,
                        widgetUsageName: "Email",
                        controller: getEmail),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    InputTextWidget(
                        isObscurse: true,
                        widgetUsageName: "Password",
                        controller: getPass),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0, left: 40.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: const ContinuousRectangleBorder(),
                              backgroundColor: titleColor),
                          onPressed: () {
                            if (getParkingName.text.toString().isNotEmpty &&
                                getPass.text.isNotEmpty &&
                                getEmail.text.isNotEmpty) {
                              signUpUser(
                                  context, getEmail, getPass, getParkingName);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                showCloseIcon: true,
                                margin: const EdgeInsetsDirectional.only(
                                    bottom: 10, start: 10, end: 10),
                                content: const Text("Fields are Empty"),
                                duration: const Duration(seconds: 5),
                                backgroundColor: titleColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ));
                              return;
                            }
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: backgroundColor, fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (context) => LoginPage())),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         const Text(
                            "Parking is Already Registered? ",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                                color: lightBackgroundColor,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
