import 'package:flutter/material.dart';
import 'package:parking_system/backend/timediff.dart';
import 'package:parking_system/firebasemethod/parking.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/farestyle.dart';
import 'package:parking_system/utils/scaffmessage.dart';

showUnparkDialog(
  BuildContext context,
  Size size,
  String time,
  String code,
  String vehicle,
  String docId,
  String vehicleNumber,
  String ownerName,
) {
  TextEditingController getCode = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          scrollable: true,
          title: Text(
            "Do You Want to Unpark Your $vehicle ?",
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: [
            Column(
              children: [
                Center(
                  child: SizedBox(
                    height: size.height * 0.4,
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
                              TextField(
                                maxLength: 4,
                                keyboardType: TextInputType.text,
                                controller: getCode,
                                onTapOutside: (event) => FocusScope.of(context)
                                    .requestFocus(FocusNode()),
                                cursorHeight: 30,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    hintText: "Code",
                                    labelText: "Code",
                                    labelStyle:
                                        const TextStyle(color: Colors.black)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Vehicle Type :",
                                    style: amountStyle(size),
                                  ),
                                  Text(
                                    vehicle,
                                    style: amountStyle(size),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Vehicle Number :",
                                    style: amountStyle(size),
                                  ),
                                  Text(
                                    vehicleNumber,
                                    style: amountStyle(size),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Owner Name :",
                                    style: amountStyle(size),
                                  ),
                                  Text(
                                    ownerName,
                                    style: amountStyle(size),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Total Charge:",
                                    style: amountStyle(size),
                                  ),
                                  Text(
                                    //! show total amount
                                    " Rs. ${getFare(time, vehicle)}",
                                    style: amountStyle(size),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Time Parked :",
                                    style: amountStyle(size),
                                  ),
                                  Text(
                                    //! show at what time it was parked
                                    time.substring(0, 16),
                                    style: amountStyle(size),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (getCode.text.trim().isNotEmpty &&
                          getCode.text.trim() == code) {
                        unparkVehicle(docId);
                        scaffoldMessage(
                            context, "Vehicle Unparked Successfully");
                        Navigator.of(context).pop();
                      } else {
                        scaffoldMessage(context, "Invalid Code");
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Paid")),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Cancel"),
                )
              ],
            )
          ],
        );
      });
}
