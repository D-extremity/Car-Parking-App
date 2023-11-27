import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/firebasemethod/firebaseauth.dart';
import 'package:parking_system/pages/loginpage.dart';
import 'package:parking_system/utils/colours.dart';

signOutDialog(BuildContext context, Size size, 
    FirebaseAuth _auth) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: featureBackgroundColor,
          scrollable: true,
          title: const Text(
            "Do You Want to Sign Out ?",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuthMethod(_auth).signOut();
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                builder: (context) => LoginPage()));
                    },
                    child: Text("Yes"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                )
              ],
            )
          ],
        );
      });
}
