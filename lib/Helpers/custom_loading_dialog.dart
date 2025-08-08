import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';

showCustomLoadingDialog({
  required BuildContext context,
  String? message,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            CircularProgressIndicator(
              color: themeColor,
            ),
            SizedBox(height: 20.h),
            Text(message ?? 'Loading...'),
          ],
        ),
      );
    },
  );
}
