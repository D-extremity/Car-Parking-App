import 'package:flutter/material.dart';

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
