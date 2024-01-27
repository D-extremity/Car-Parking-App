import 'package:flutter/material.dart';
import 'package:parking_system/firebasemethod/firebaseauth.dart';
import 'package:parking_system/pages/homepage.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/drawerui.dart';
import 'package:parking_system/utils/farestyle.dart';
import 'package:parking_system/utils/textinput.dart';

class SettingsPage extends StatelessWidget {
  final Size size;
  final String username;
  const SettingsPage({super.key, required this.size, required this.username});

  @override
  Widget build(BuildContext context) {
    TextEditingController _getcyclefare = TextEditingController();
    TextEditingController _getbike = TextEditingController();
    TextEditingController _getcar = TextEditingController();
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      drawer: getDrawer(context, size, username),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.height * 0.04,
              color: titleColor),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              username,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.04,
                  color: titleColor),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20),
              child: Divider(
                height: size.height * 0.04,
                color: titleColor,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("4 Wheeler : $car Rs/ 3 hours", style: fareStyle(size)),
                Text("||", style: fareStyle(size)),
                Text(
                  "2 Wheeler : $bike Rs/ 3 hours ",
                  style: fareStyle(size),
                ),
                Text("||", style: fareStyle(size)),
                Text(
                  "Cycle : $cycle Rs/ 3 hours",
                  style: fareStyle(size),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Enter New Cycle Fare :",
                  style: TextStyle(
                      fontSize: size.width * 0.046,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
                changefarewidget("Cycle Fare", _getcyclefare, false, context,
                    size, Icons.pedal_bike),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Enter New Bike Fare :",
                  style: TextStyle(
                      fontSize: size.width * 0.046,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
                changefarewidget("Bike Fare", _getbike, false, context, size,
                    Icons.motorcycle_rounded),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Enter New Car Fare :",
                  style: TextStyle(
                      fontSize: size.width * 0.046,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
                changefarewidget("Car Fare", _getcar, false, context, size,
                    Icons.car_repair_outlined),
              ],
            ),
            SizedBox(
              height: size.height * 0.28,
            ),
            SizedBox(
              width: size.width * 0.46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: titleColor, shape: const LinearBorder()),
                child: Row(
                  children: [
                    Icon(
                      Icons.change_circle_outlined,
                      color: backgroundColor,
                      size: size.height * 0.036,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(
                      "Change",
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: size.height * 0.028,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  await FirebaseAuthMethod(auth).changeFare(
                      int.parse(_getcyclefare.text),
                      int.parse(_getbike.text),
                      int.parse(_getcar.text));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Fare changed successfully"),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
