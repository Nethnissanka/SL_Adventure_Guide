// styles.dart
import 'package:flutter/material.dart';

import 'colors.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 20,
  color: Color.fromARGB(255, 170, 139, 24),
  fontWeight: FontWeight.w200,
);

const textInputDecoration = InputDecoration(
  hintText: "email",
  hintStyle: TextStyle(color: textLight, fontSize: 15),
  fillColor: Color.fromARGB(255, 251, 251, 251),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 6, 85, 81), width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 6, 85, 81), width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
  // set text color to white
  labelStyle: TextStyle(color: Colors.white),
);