import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parking_system/firebase_options.dart';
import 'package:parking_system/pages/homepage.dart';
import 'package:parking_system/pages/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return HomePage();
              } else if (snapshot.hasError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("${snapshot.error}")));
                return LoginPage();
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return SafeArea(
                  child: Scaffold(
                body: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Lottie.asset(
                      "assets/hamster.json",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ));
            }
             return LoginPage();
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}
