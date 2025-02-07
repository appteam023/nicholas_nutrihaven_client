import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isNext; // Determines whether the button is for "Next" or "Back"

  CircularButton({super.key, required this.onTap, this.isNext = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w, // Adjust the width
        height: 60.h, // Adjust the height
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: gradientYellow,
        ),
        child: Center(
          child: Icon(
            isNext ? Icons.arrow_forward : Icons.arrow_back, // Choose the icon
            color: Colors.white,
            size: 24.sp, // Adjust the size of the icon
          ),
        ),
      ),
    );
  }
}
