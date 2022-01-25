import 'package:flutter/material.dart';

// init text input decoration
const textInputDecoration = InputDecoration(
  hintStyle: TextStyle(),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.green,
      width: 2.0,
    ),
  ),
);

// init colors
const offWhite = Color(0xFFC2B9A7);
const green = Color(0xFF2E7D32);
const black = Colors.black;
const white = Colors.white;
const red = Colors.red;
// init font size
const fontSizeHH = 30.0;
const fontSizeH = 25.0;
const fontSizeM = 20.0;
const fontSizeS = 15.0;

// init bold
const bold = FontWeight.bold;

// init button border style
final btnStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(offWhite),
  foregroundColor: MaterialStateProperty.all<Color>(offWhite),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
      side: BorderSide(color: offWhite),
    ),
  ),
);

// icon size
const iconSize = 25.0;
