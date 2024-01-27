import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:parking_system/backend/codegenerate.dart';
import 'package:parking_system/firebasemethod/firebaseauth.dart';
import 'package:parking_system/firebasemethod/parking.dart';
import 'package:parking_system/pages/homepage.dart';
import 'package:parking_system/sendmail.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/drawerui.dart';
import 'package:parking_system/utils/scaffmessage.dart';
import 'package:parking_system/utils/textinput.dart';

class BookingPage extends StatefulWidget {
  final Size size;
  final String username;
  final FirebaseAuth auth;
  const BookingPage(
      {super.key,
      required this.size,
      required this.username,
      required this.auth});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

bool isSlotSelected = false;
String selection = "0";
String s = "ABCD";
TextEditingController getOwnerName = TextEditingController();
TextEditingController getVehicleNumber = TextEditingController();
TextEditingController getEmail = TextEditingController();

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: getDrawer(context,widget.size,widget.username),
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(
            "Book Slot",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: widget.size.height * 0.04,
                color: titleColor),
          ),
        ),
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0, top: 2),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: widget.size.height * 0.009,
                    ),
                    InputWidget(
                        isObscurse: false,
                        widgetUsageName: "Owner Name",
                        controller: getOwnerName),
                    SizedBox(
                      height: widget.size.height * 0.02,
                    ),
                    SizedBox(
                      height: 70,
                      child: TextField(
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        controller: getVehicleNumber,
                        onTapOutside: (event) =>
                            FocusScope.of(context).requestFocus(FocusNode()),
                        cursorHeight: 30,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            hintText: "Vehicle Number",
                            labelText: "Vehicle Number",
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: widget.size.height * 0.01,
                    ),
                    InputWidget(
                        isObscurse: false,
                        widgetUsageName: "Owner E-mail",
                        controller: getEmail),
                    SizedBox(
                      height: widget.size.height * 0.01,
                    ),
                    DropdownButton(
                        isExpanded: true,
                        hint: Text(
                          dropDownValue,
                          selectionColor: titleColor,
                          style: TextStyle(color: titleColor),
                        ),
                        icon: Icon(
                          Icons.arrow_downward,
                          color: titleColor,
                        ),
                        elevation: 16,
                        enableFeedback: true,
                        dropdownColor: lightBackgroundColor,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 239, 236, 243)),
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropDownValue = value!;
                          });
                        }),
                    SizedBox(
                      height: widget.size.height * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Column(children: [
                    for (int i = 0; i <4; i++) ...[
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int j = 1; j < 16; j++) ...[
                              if (parkedSlots.contains("${s[i]}$j"))
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    height: 20,
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        // isSlotSelected = !isSlotSelected;
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              titleColor.withOpacity(0.5)),
                                      child: Text("${s[i]}$j",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                )
                              else if (selection == "${s[i]}$j")
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    height: 20,
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        // isSlotSelected = !isSlotSelected;
                                        selection = "${s[i]}$j";
                                        setState(() {});
                                      },
                                      child: Text("${s[i]}$j",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: titleColor),
                                    ),
                                  ),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        // isSlotSelected = !isSlotSelected;
                                        selection = "${s[i]}$j";
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              featureBackgroundColor,
                                          shape: LinearBorder()),
                                      child: Text("${s[i]}$j",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                )
                            ],
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int j = 16; j < 31; j++) ...[
                              if (parkedSlots.contains("${s[i]}$j"))
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    height: 20,
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        // isSlotSelected = !isSlotSelected;
                                      },
                                      child: Text("${s[i]}$j",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              titleColor.withOpacity(0.5)),
                                    ),
                                  ),
                                )
                              else if (selection == "${s[i]}$j")
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    height: 20,
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        // isSlotSelected = !isSlotSelected;
                                        selection = "${s[i]}$j";
                                        setState(() {});
                                      },
                                      child: Text("${s[i]}$j",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: titleColor),
                                    ),
                                  ),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        // isSlotSelected = !isSlotSelected;
                                        selection = "${s[i]}$j";
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              featureBackgroundColor,
                                          shape: LinearBorder()),
                                      child: Text("${s[i]}$j",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                )
                            ],
                          ],
                        ),
                      )
                    ],
                  ]),
                ),
              ),
              SizedBox(
                height: widget.size.height * 0.02,
              ),
              CupertinoButton(
                onPressed: () async {
                  parkedSlots.add(selection);
                  if (getVehicleNumber.text.length == 4 &&
                      getOwnerName.text.isNotEmpty &&
                      getEmail.text.isNotEmpty &&
                      selection != "0") {
                    if (EmailValidator.validate(getEmail.text.trim())) {
                      String code = getCode();
                      await ParkingStorage(
                              widget.auth, context, widget.username)
                          .parkCar(
                              vehicleNumber: getVehicleNumber.text,
                              vehicleType: dropDownValue,
                              code: code,
                              parkedslot: selection,
                              time:
                                  "${DateTime.now().hour}:${DateTime.now().minute}",
                              ownerName: getOwnerName.text,
                              ownerMail: getEmail.text.trim(),
                              currentTime: DateTime.now().toString());
                      await FirebaseAuthMethod(widget.auth)
                          .addParkedSlot(parkedSlots);
                      final Email email = Email(
                          subject: "Your $dropDownValue has been parked",
                          body:
                              "Thank you for using ${widget.username} Parking , Show $code to unpark your $dropDownValue parked at slot number $selection",
                          recipients: [(getEmail.text)],
                          isHTML: false);

                      bool isMailSend = await sendMail(email);
                      if (isMailSend) {
                        scaffoldMessage(context, "Code sent");
                        Navigator.of(context).pop();
                      } else {
                        scaffoldMessage(context, "Error Occurred");
                        Navigator.of(context).pop();
                      }
                    } else {
                      scaffoldMessage(context, "Invalid Email");
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      showCloseIcon: true,
                      margin: const EdgeInsetsDirectional.only(
                          bottom: 10, start: 10, end: 10),
                      content: const Text("Empty Fields"),
                      duration: const Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: titleColor,
                  ),
                  // width: 50,
                  // height: 60,
                  child: Text(
                    " Park It ",
                    style: TextStyle(
                        color: backgroundColor,
                        fontSize: widget.size.height * 0.048),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
