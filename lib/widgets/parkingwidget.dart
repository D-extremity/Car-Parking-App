import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/firebasemethod/parking.dart';
import 'package:parking_system/widgets/dialogunpark.dart';
import 'package:parking_system/widgets/parkedcar.dart';

List<Map<String, dynamic>> parkedVehicleList = [{}];
List<Map<String, dynamic>> parkedVehicle = parkedVehicleList;

Widget vehicleListScreen(
    BuildContext context, FirebaseAuth auth, String username, Size size) {
  final ParkingStorage parkingStorage = ParkingStorage(auth, context, username);
  return StreamBuilder(
      stream: parkingStorage.getParkedData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, int index) {
                  // final vehicle = parkedCars[index];
                  parkedVehicleList = snapshot.data!.docs
                      .map((document) =>
                          (document.data() as Map<String, dynamic>))
                      .toList();
                  return snapshot.data!.docs
                      .map((document) =>
                          vehicleTile(size, index, document, context))
                      .toList()[index];
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                width: 100,
                height: 100,
                child: Text("Error Occurred\n${snapshot.error}"),
              ),
            );
          }
        }
        return Center(
          child: Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        );
      });
}

Widget vehicleTile(
  Size size,
  int itemNumber,
  DocumentSnapshot document,
  BuildContext context,
) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  return GestureDetector(
    onTap: () {
      showUnparkDialog(
          context,
          size,
          data['dateTime'],
          data['code'],
          data["vehicleType"],
          data['uid'],
          data["vehicle"],
          data["ownerName"],
          data['parkedslot']);
    },
    child: ParkedCar(
        size: size,
        itemNumber: itemNumber,
        ownerName: data['ownerName'],
        time: data['time'],
        type: data["vehicleType"],
        vehNumber: data['vehicle'],
        otp: data['code'],
        slot: data['parkedslot']),
  );
}



Widget searchedvehicleTile(
  Size size,
  int itemNumber,
  Map<String,dynamic> data,
  BuildContext context,
) {

  return GestureDetector(
    onTap: () {
      showUnparkDialog(
          context,
          size,
          data['dateTime'],
          data['code'],
          data["vehicleType"],
          data['uid'],
          data["vehicle"],
          data["ownerName"],
          data['parkedslot']);
    },
    child: ParkedCar(
        size: size,
        itemNumber: itemNumber,
        ownerName: data['ownerName'],
        time: data['time'],
        type: data["vehicleType"],
        vehNumber: data['vehicle'],
        otp: data['code'],
        slot: data['parkedslot']),
  );
}
