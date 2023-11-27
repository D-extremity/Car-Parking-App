import 'package:flutter/material.dart';
import 'package:parking_system/utils/colours.dart';

class ParkedCar extends StatelessWidget {
  final Size size;
  final int itemNumber;
  final String vehNumber;
  final String type;
  final String ownerName;
  final String time;
  final String otp;
  const ParkedCar(
      {super.key,
      required this.size,
      required this.itemNumber,
      required this.ownerName,
      required this.time,
      required this.type,
      required this.vehNumber,
      required this.otp});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: size.width,
      height: size.height * 0.1,
      child: Card(
        color:
            itemNumber.isEven ? featureBackgroundColor : lightBackgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.005,
            ),
            Text(
              vehNumber,
              style:
                  TextStyle(color: Colors.black, fontSize: size.height * 0.04),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                Text(
                  type,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  ownerName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),Text(
                  otp,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
