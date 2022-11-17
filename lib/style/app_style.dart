import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = const Color(0xffe2e2ff);
  static Color mainColor = const Color(0xff000633);
  static Color accentColor = Color(0xff0065ff);

  static List<Color> cardsColor = [
    Colors.red.shade200,
    Colors.pink.shade200,
    Colors.orange.shade400,
    Colors.yellow.shade400,
    Colors.green.shade200,
    Colors.blue.shade100,
    Colors.blueGrey.shade200,
  ];

  static TextStyle mainTitle = GoogleFonts.ubuntu(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle mainContent = GoogleFonts.ubuntu(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle dateTitle = GoogleFonts.ubuntu(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
}
