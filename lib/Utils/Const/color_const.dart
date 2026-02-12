import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var radius = BorderRadius.circular(25.r);
var horizontalPadding = 20.w;
var verticalPadding = 10.h;

/// Colors
const Color black = Color(0xff000000);
const Color primary = Color(0xff000000);
const Color secondary = Color(0xFFFFFFFF);
const Color yellow = Color(0xffAD8240);
const Color themeColor = Color(0xFF093538);
const Color grey = Color(0xFF9E9EA0);
const Color darkGrey = Color(0xFF666666);
const Color darkTheme = Color(0xFF142B2E);
const Color yellowText = Color(0xFFFFD75F);
const Color containerColor = Color(0xFFF9FAFE);
const Color seaGreen = Color(0XFF0FA37F);
const Color mustardYellow = Color(0xFF9A8947);

// Color iconColor = const Color(0xFF272B35);

List<BoxShadow> boxShadow = [
  BoxShadow(
    color: darkGrey.withValues(alpha: 0.3),
    offset: Offset(0, 0),
    spreadRadius: 5,
    blurRadius: 1,
  ),
];

LinearGradient gradientYellow = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xffE4BB49), Color(0xffAB7D01)],
);
LinearGradient gradientGrey = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.grey, Colors.grey],
);

/// For Material Colors
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final double r = color.r, g = color.g, b = color.b;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      (r + ((ds < 0 ? r : (255 - r)) * ds).round()).toInt(),
      (g + ((ds < 0 ? g : (255 - g)) * ds).round()).toInt(),
      (b + ((ds < 0 ? b : (255 - b)) * ds).round()).toInt(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
