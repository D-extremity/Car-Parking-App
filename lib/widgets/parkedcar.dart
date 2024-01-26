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
  final dynamic slot;
  const ParkedCar(
      {super.key,
      required this.size,
      required this.itemNumber,
      required this.ownerName,
      required this.time,
      required this.type,
      required this.vehNumber,
      required this.otp,
      this.slot});

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
              style: TextStyle(
                color: Color.fromARGB(229, 48, 42, 42),
                fontWeight: FontWeight.w600,
                fontSize: size.height*0.04
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    color: Color.fromRGBO(13, 12, 12, 0.68),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  ownerName,
                  style: TextStyle(
                    color: Color.fromRGBO(13, 12, 12, 0.68),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Color.fromRGBO(13, 12, 12, 0.68),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  slot.toString(),
                  style: TextStyle(
                    color: Color.fromRGBO(13, 12, 12, 0.68),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  otp,
                  style: TextStyle(
                    color: Color.fromRGBO(13, 12, 12, 0.68),
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
