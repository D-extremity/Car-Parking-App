import 'package:flutter/material.dart';
import 'package:parking_system/utils/colours.dart';

TextStyle fareStyle(Size size) {
  return TextStyle(color: Colors.black, fontSize: size.width * 0.025);
}


TextStyle amountStyle(Size size) {
  return TextStyle(color: titleColor, fontSize: size.width * 0.05,fontWeight: FontWeight.w500);
}
