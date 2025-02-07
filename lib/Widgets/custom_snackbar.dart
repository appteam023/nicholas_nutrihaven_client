import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Utils/Const/color_const.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    required String message,
    Color? backgroundColor,
  }) : super(
    backgroundColor: backgroundColor ?? Colors.yellow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.white.withOpacity(0.2)),
    ),
    padding: EdgeInsets.all(18),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class CustomAlertDialog extends StatelessWidget {
  // final String title;
  final String message;
  final String imagePath;

  const CustomAlertDialog({
    Key? key,
    // required this.title,
    required this.message,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Get.isDarkMode ? Color(0xFF161618) : Colors.white,
      // title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 100.w,
              height: 100.h,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
