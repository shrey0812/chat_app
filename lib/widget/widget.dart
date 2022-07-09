import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      'assets/images/logo.png',
      height: 70,
    ),
  );
}

InputDecoration textInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return const TextStyle(color: Colors.white, fontSize: 16);
}
