import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:parking_system/backend/codegenerate.dart';
import 'package:parking_system/firebasemethod/firebaseauth.dart';
import 'package:parking_system/firebasemethod/parking.dart';
import 'package:parking_system/pages/loginpage.dart';
import 'package:parking_system/sendmail.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/farestyle.dart';
import 'package:parking_system/utils/scaffmessage.dart';
import 'package:parking_system/utils/textinput.dart';
import 'package:parking_system/widgets/parkingwidget.dart';
import 'package:parking_system/widgets/signoutdialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

const List<String> list = ["2 Wheeler", "4 Wheeler", "Cycle"];
String dropDownValue = "2 Wheeler";

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
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightBackgroundColor,
        onPressed: () {
          TextEditingController getOwnerName = TextEditingController();
          TextEditingController getVehicleNumber = TextEditingController();
          TextEditingController getEmail = TextEditingController();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.black,
                    scrollable: true,
                    title: const Text(
                      "Vehicle's Detail",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    actions: [
                      Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: size.height * 0.5,
                              width: size.width * 0.8,
                              child: Card(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    shape: BoxShape.rectangle,
                                    gradient: LinearGradient(
                                        colors: <Color>[
                                          lightBackgroundColor,
                                          lightBackgroundColor,
                                          // Colors.black
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15, right: 15),
                                    child: ListView(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.009,
                                        ),
                                        InputTextWidget(
                                            isObscurse: false,
                                            widgetUsageName: "Owner Name",
                                            controller: getOwnerName),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        TextField(
                                          maxLength: 4,
                                          keyboardType: TextInputType.number,
                                          controller: getVehicleNumber,
                                          onTapOutside: (event) =>
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode()),
                                          cursorHeight: 30,
                                          style: const TextStyle(fontSize: 20),
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black)),
                                              hintText: "Vehicle Number",
                                              labelText: "Vehicle Number",
                                              labelStyle: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        InputTextWidget(
                                            isObscurse: false,
                                            widgetUsageName: "Owner E-mail",
                                            controller: getEmail),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        DropdownButton(
                                            isExpanded: true,
                                            hint: const Text("Vehicle Type? "),
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            enableFeedback: true,
                                            dropdownColor: Colors.black,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 239, 236, 243)),
                                            // underline: Container(
                                            //   height: 2,
                                            //   color: lightBackgroundColor,
                                            // ),
                                            items: list
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem(
                                                child: Text(value),
                                                value: value,
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                dropDownValue = value!;
                                              });
                                            }),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.orange[900]),
                                            onPressed: () async {
                                              if (getVehicleNumber.text.length ==
                                                      4 &&
                                                  getOwnerName
                                                      .text.isNotEmpty &&
                                                  getEmail.text.isNotEmpty) {
                                                if (EmailValidator.validate(
                                                    getEmail.text.trim())) {
                                                  String code = getCode();
                                                  ParkingStorage(_auth, context,
                                                          username)
                                                      .parkCar(
                                                          vehicleNumber:
                                                              getVehicleNumber
                                                                  .text,
                                                          vehicleType:
                                                              dropDownValue,
                                                          code: code,
                                                          time:
                                                              "${DateTime.now().hour}:${DateTime.now().minute}",
                                                          ownerName:
                                                              getOwnerName.text,
                                                          ownerMail: getEmail
                                                              .text
                                                              .trim(),
                                                          currentTime:
                                                              DateTime.now()
                                                                  .toString());
                                                  final Email email = Email(
                                                      subject:
                                                          "Your $dropDownValue has been parked",
                                                      body:
                                                          "Thank you for using $username Parking , Show $code to unpark your $dropDownValue",
                                                      recipients: [
                                                        (getEmail.text)
                                                      ],
                                                      isHTML: false);
                                                  bool isMailSend =
                                                      await sendMail(email);
                                                  if (isMailSend) {
                                                    scaffoldMessage(
                                                        context, "Code sent");
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    scaffoldMessage(context,
                                                        "Error Occurred");
                                                    Navigator.of(context).pop();
                                                  }
                                                } else {
                                                  scaffoldMessage(
                                                      context, "Invalid Email");
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  showCloseIcon: true,
                                                  margin:
                                                      const EdgeInsetsDirectional
                                                          .only(
                                                          bottom: 10,
                                                          start: 10,
                                                          end: 10),
                                                  content: const Text(
                                                      "Empty Fields"),
                                                  duration: const Duration(
                                                      seconds: 5),
                                                  backgroundColor: Colors.red,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ));
                                              }
                                            },
                                            child: const Text(
                                              "Park It",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 30),
                                            )),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ));
        }, // Implement function here.
        child: Icon(
          Icons.add,
          color: Colors.white,
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username,
                        // widget.parkingName,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      GestureDetector(
                          onTap: () async {
                            signOutDialog(context, size, _auth);
                          },
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                            size: 40,
                          ))
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
