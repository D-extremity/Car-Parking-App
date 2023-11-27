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
      body: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[backgroundColor, backgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          Center(
            child: SizedBox(
              height: size.height * 0.5,
              width: size.width * 0.8,
              child: Card(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(colors: <Color>[
                      lightBackgroundColor,
                      lightBackgroundColor,
                      // Colors.black
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: size.height * 0.009,
                        ),
                        InputTextWidget(isObscurse: false,
                            widgetUsageName: "Email", controller: getEmail),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        InputTextWidget(isObscurse: false,
                            widgetUsageName: "Password", controller: getPass),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[900]),
                            onPressed: () {
                              if (getPass.text.isNotEmpty &&
                                  getEmail.text.isNotEmpty) {
                                loginUser(context, getEmail, getPass);
                                //! Login Auth
                              } else {
                                scaffoldMessage(context,"Fields are Empty");
                                return;
                              }
                            },
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            )),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>const SignUpPage())),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Parking is Not Registered Yet? ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 15, 76, 17),
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
            ),
          ),
        ],
      ),
    );
  }

  
}
