import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/pages/searchpage.dart';

import 'package:parking_system/pages/slot_booking.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/drawerui.dart';
// import 'package:parking_system/utils/farestyle.dart';

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

int cycle = 5;
int bike = 20;
int car = 30;

final FirebaseAuth auth = FirebaseAuth.instance;

String username = "Loading...";

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getUsername(auth);
  }

  getUsername(FirebaseAuth auth) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    parkedSlots = (snap.data() as Map<String, dynamic>)['parkedslots'];
    cycle = (snap.data() as Map<String, dynamic>)['cycle'];
    bike = (snap.data() as Map<String, dynamic>)['bike'];
    car = (snap.data() as Map<String, dynamic>)['car'];
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      drawer: getDrawer(context, size, username),
      appBar: AppBar(
        title: Text(
          'Parking',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.height * 0.04,
              color: titleColor),
        ),
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => SearchPage()));
              },
              icon: Icon(
                Icons.search,
                color: titleColor,
                size: size.height * 0.04,
              )),
          const SizedBox(
            width: 3,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: titleColor,
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => BookingPage(
                    size: size,
                    username: username,
                    auth: auth,
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
                const SizedBox(
                  height: 3,
                ),

                const SizedBox(
                  height: 3,
                ),

                Expanded(
                   child: vehicleListScreen(context, auth, username, size))

              ],
            ),
          ),
        ],
      ),
    ));
  }
}
