import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/utils/scaffmessage.dart';

final FirebaseFirestore _store = FirebaseFirestore.instance;

class ParkingStorage {
  final FirebaseAuth auth;
  final BuildContext context;
  final String username;

  ParkingStorage(this.auth, this.context, this.username);

  Future<void> parkCar(
      {required String vehicleNumber,
      required String vehicleType,
      required String code,
      required String time,
      required String ownerName,
      required String ownerMail,
      required String currentTime,
      required String parkedslot}) async {
    try {
      final id = await _store
          .collection('parking')
          .doc('**$username**')
          .collection('parkList')
          .add({
        'vehicle': vehicleNumber,
        'vehicleType': vehicleType,
        'code': code,
        'ownerName': ownerName,
        'time': time,
        'ownerMail': ownerMail,
        'dateTime': currentTime,
        'parkedslot': parkedslot
      });

      await _store
          .collection('parking')
          .doc('**$username**')
          .collection('parkList')
          .doc(id.id)
          .set({
        'vehicle': vehicleNumber,
        'vehicleType': vehicleType,
        'code': code,
        'ownerName': ownerName,
        'time': time,
        'dateTime': currentTime,
        'ownerMail': ownerMail,
        "uid": id.id,
        'parkedslot': parkedslot
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      scaffoldMessage(context, "Some error Occurrred\n$e");
    }
  }

  Stream<QuerySnapshot> getParkedData() {
    return _store
        .collection('parking')
        .doc('**$username**')
        .collection("parkList")
        .snapshots();
  }
}

Future<void> unparkVehicle(String docId) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  DocumentSnapshot snap = await FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .get();
  final String username = (snap.data() as Map<String, dynamic>)['username'];
  await _store
      .collection('parking')
      .doc('**$username**')
      .collection('parkList')
      .doc(docId)
      .delete();
}
