import 'package:flutter/material.dart';

const _kDefaultBodyStyle =
    TextStyle(color: Colors.white, fontFamily: 'Vietnam');
const _kHeaderStyle = TextStyle(color: Colors.white, fontFamily: 'Jakarta');

const _primaryColour = Color.fromARGB(255, 187, 0, 255);
const _secondaryColour = Color.fromARGB(248, 55, 255, 20);
const _tertiaryColour = Color.fromARGB(255, 255, 0, 123);
const _backgroundColor = Color.fromARGB(255, 15, 23, 42);

final theme = ThemeData(
  colorScheme: ColorScheme.dark(
      onPrimary: Colors.black,
      primary: _primaryColour,
      secondary: _secondaryColour,
      onSecondary: Colors.white,
      surface: _backgroundColor,
      onSurface: Colors.white),
  scaffoldBackgroundColor: _backgroundColor,
  textTheme: TextTheme(
      bodyMedium: _kDefaultBodyStyle.copyWith(
          fontSize: 15, fontWeight: FontWeight.w400),
      titleMedium: _kHeaderStyle.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      )),
);
