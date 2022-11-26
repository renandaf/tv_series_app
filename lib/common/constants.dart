import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';

// colors
const Color kRichBlack = Color.fromARGB(255, 12, 12, 13);
const Color kOxfordRed = Color.fromARGB(255, 61, 0, 0);
const Color kPrussianRed = Color.fromARGB(255, 102, 0, 0);
const Color kRed = Color.fromARGB(255, 157, 2, 2);
const Color kDavysGrey = Color.fromARGB(255, 119, 118, 118);
const Color kGrey = Color(0xFF303030);
const Color kYellow = Color.fromARGB(255, 239, 216, 1);

// text style
final TextStyle kH5 = GoogleFonts.poppins(
    fontSize: 23,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.9));
final TextStyle kH3 = GoogleFonts.poppins(
    fontSize: 26, fontWeight: FontWeight.w600, color: kYellow);
final TextStyle kH6 = GoogleFonts.poppins(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: Colors.white.withOpacity(0.9));
final TextStyle kSub = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: Colors.white.withOpacity(0.9));
final TextStyle kBody = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.white.withOpacity(0.9));
final TextStyle kSmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    color: kDavysGrey);
final TextStyle kTitle = GoogleFonts.poppins(
    fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white);

// text theme
final kTextTheme = TextTheme(
  headline3: kH3,
  headline5: kH5,
  headline6: kH6,
  subtitle1: kSub,
  bodyText2: kBody,
);

const kColorScheme = ColorScheme(
  primary: kYellow,
  primaryContainer: kYellow,
  secondary: kRichBlack,
  secondaryContainer: kRichBlack,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.red,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
