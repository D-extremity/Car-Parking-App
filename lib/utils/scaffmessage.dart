import 'package:flutter/material.dart';

void scaffoldMessage(BuildContext context,String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      showCloseIcon: true,
      margin: const EdgeInsetsDirectional.only(
          bottom: 10, start: 10, end: 10),
      content: Text(message),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ));
  }