import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var radius = BorderRadius.circular(25.r);
var horizontalPadding = 20.w;
var verticalPadding = 10.h;

/// Colors
Color black = const Color(0xff000000);
Color primary = const Color(0xff000000);
Color secondary = const Color(0xFFFFFFFF);
Color yellow = const Color(0xffAD8240);
Color themeColor = const Color(0xFF093538);
Color grey = const Color(0xFF9E9EA0);
Color darkGrey = const Color(0xFF666666);
Color darkTheme = const Color(0xFF142B2E);
Color yellowText = const Color(0xFFFFD75F);
Color containerColor = const Color(0xFFF9FAFE);
Color seaGreen = const Color(0XFF0FA37F);
Color mustardYellow = const Color(0xFF9A8947);



// Color iconColor = const Color(0xFF272B35);

List<BoxShadow> boxShadow = [
  BoxShadow(
    color: darkGrey.withOpacity(0.3),
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

/// For Material Colors
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
