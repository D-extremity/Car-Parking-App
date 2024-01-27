import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/firebasemethod/firebaseauth.dart';
import 'package:parking_system/pages/signuppage.dart';
// import 'package:parking_system/pages/homepage.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/scaffmessage.dart';
import 'package:parking_system/utils/textinput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

void loginUser(BuildContext context, TextEditingController _getLoginEmail,
    TextEditingController _getLoginPass) async {
  await FirebaseAuthMethod(FirebaseAuth.instance).loginWithEmail(
      email: _getLoginEmail.text.trim(),
      password: _getLoginPass.text.trim(),
      context: context);
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController getPass = TextEditingController();
  TextEditingController getEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [ SizedBox(
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
                padding:
                    const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * 0.009,
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
                      padding:
                          const EdgeInsets.only(right: 40.0, left: 40.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: const LinearBorder(),
                              backgroundColor: titleColor),
                          onPressed: () {
                            if (getPass.text.isNotEmpty &&
                                getEmail.text.isNotEmpty) {
                              loginUser(context, getEmail, getPass);
                              //! Login Auth
                            } else {
                              scaffoldMessage(context, "Fields are Empty");
                              return;
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: backgroundColor, fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (context) => const SignUpPage())),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Parking is Not Registered Yet? ",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Sign Up",
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
