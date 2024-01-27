import 'package:flutter/material.dart';
import 'package:parking_system/utils/colours.dart';

class InputTextWidget extends StatelessWidget {
  final String widgetUsageName;
  final TextEditingController controller;
  final bool isObscurse;

  const InputTextWidget(
      {super.key,
      required this.widgetUsageName,
      required this.controller,
      required this.isObscurse});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTapOutside: (event) =>
          FocusScope.of(context).requestFocus(new FocusNode()),
      cursorHeight: 30,
      obscureText: isObscurse,
      obscuringCharacter: "*",
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black)),
          hintText: widgetUsageName,
          labelText: widgetUsageName,
          labelStyle: TextStyle(color: Colors.black)),
    );
  }
}

class InputWidget extends StatelessWidget {
  final String widgetUsageName;
  final TextEditingController controller;
  final bool isObscurse;

  const InputWidget(
      {super.key,
      required this.widgetUsageName,
      required this.controller,
      required this.isObscurse});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(new FocusNode()),
        cursorHeight: 30,
        obscureText: isObscurse,
        obscuringCharacter: "*",
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10, left: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)),
            hintText: widgetUsageName,
            labelText: widgetUsageName,
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}

Widget changefarewidget(
    final String widgetUsageName,
    final TextEditingController controller,
    final bool isObscurse,
    BuildContext context,
    Size size,
    IconData icon) {
  return SizedBox(
    height: 50,
    child: SizedBox(
      width: size.width * 0.38,
      child: TextField(
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
        keyboardAppearance: Brightness.dark,
        controller: controller,
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(new FocusNode()),
        cursorHeight: 30,
        obscureText: isObscurse,
        obscuringCharacter: "*",
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: titleColor,
            ),
            // prefix: Text("Cycle",style: TextStyle(color: titleColor),),
            contentPadding: EdgeInsets.only(top: 10, left: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)),
            hintText: widgetUsageName,
            labelText: widgetUsageName,
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(fontSize: 20)),
      ),
    ),
  );
}
