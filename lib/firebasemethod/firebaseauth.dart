import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/pages/homepage.dart';
import 'package:parking_system/utils/scaffmessage.dart';

class FirebaseAuthMethod {
  final FirebaseAuth _auth;
  FirebaseAuthMethod(this._auth);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//?Sign Up With Email
  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required String userName,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      await sendEmailVerification(context);
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': userName,
        'uid': userCredential.user!.uid,
        // 'uid': userName,
        'email': email,
        'password': password,
      });
      // !this one can be used to make more clear to user that he/she has to login now
      // scaffoldMessage(context, "You can Login now");
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        showCloseIcon: true,
        margin:
            const EdgeInsetsDirectional.only(bottom: 10, start: 10, end: 10),
        content: Text(e.message!),
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));
    }
  }

  //?Send Email Verification

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Verification email sent")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  //?Login With With Email

  Future<void> loginWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Logged In Successfully ")));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
