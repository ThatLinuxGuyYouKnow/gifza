import 'package:flutter/material.dart';

const _kDefaultBodyStyle =
    TextStyle(color: Colors.white, fontFamily: 'Vietnam');
const _kHeaderStyle = TextStyle(color: Colors.white, fontFamily: 'Jakarta');

const _primaryColour = Color.fromARGB(255, 215, 121, 255);
const _secondaryColour = Color(0xFF39FF14);
const _tertiaryColour = Color(0XFFFF007A);
const _backgroundColor = Color(0xFF0F172A);
const neutralColor = Color(0xFF141f38);

final theme = ThemeData(
  colorScheme: ColorScheme.dark(
      onPrimary: Colors.black,
      primary: _primaryColour,
      secondary: _secondaryColour,
      onSecondary: Colors.white,
      tertiary: _tertiaryColour,
      onTertiary: Colors.white,
      surface: _backgroundColor,
      onSurface: Colors.white),
  scaffoldBackgroundColor: _backgroundColor,
  textTheme: TextTheme(
    bodyMedium:
        _kDefaultBodyStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
    titleMedium: _kHeaderStyle.copyWith(
      color: _primaryColour,
      fontSize: 30,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w700,
    ),
  ),
);
