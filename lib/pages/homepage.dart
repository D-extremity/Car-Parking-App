import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:parking_system/pages/slot_booking.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/drawerui.dart';
import 'package:parking_system/utils/farestyle.dart';

import 'package:parking_system/widgets/parkingwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

const List<String> list = ["2 Wheeler", "4 Wheeler", "Cycle"];
String dropDownValue = "2 Wheeler";
List<dynamic> parkedSlots = [];

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String username = "Loading...";

  @override
  void initState() {
    super.initState();
    getUsername(_auth);
  }

  getUsername(FirebaseAuth auth) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    parkedSlots = (snap.data() as Map<String, dynamic>)['parkedslots'];
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      drawer: getDrawer(),
      appBar: AppBar(
        title: Text(
          username,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.height * 0.04,
              color: titleColor),
        ),
        backgroundColor: backgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: titleColor,
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => BookingPage(
                    size: size,
                    username: username,
                    auth: _auth,
                  )));
        }, // Implement function here.
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 234, 202, 234),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   username,
                      //   // widget.parkingName,
                      //   style: const TextStyle(
                      //       color: Colors.white, fontSize: 40),
                      // // ),
                      // GestureDetector(
                      //     onTap: () async {
                      //       signOutDialog(context, size, _auth);
                      //     },
                      //     child: Icon(
                      //       Icons.exit_to_app,
                      //       color: Colors.red,
                      //       size: 40,
                      //     ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("4 Wheeler : 30 Rs/ 3 hours", style: fareStyle(size)),
                    Text("||", style: fareStyle(size)),
                    Text(
                      "2 Wheeler : 20 Rs/ 3 hours ",
                      style: fareStyle(size),
                    ),
                    Text("||", style: fareStyle(size)),
                    Text(
                      "Cycle : 5 Rs/ 3 hours",
                      style: fareStyle(size),
                    )
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                //!ListView.Builder will come
                Expanded(
                    child: vehicleListScreen(context, _auth, username, size))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
