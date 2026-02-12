import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Utils/Const/color_const.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String message,
    Color? backgroundColor,
  }) : super(
    backgroundColor: backgroundColor ?? Colors.yellow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: secondary.withValues(alpha: 0.2)),
    ),
    padding: EdgeInsets.all(18),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: const TextStyle(
        color: black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? btnText;
  final String? imagePath;
  final VoidCallback? onPressed;

  const CustomAlertDialog({
    super.key,
    this.title = "Error",
    required this.message,
    this.imagePath,
    this.btnText,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Get.isDarkMode ? Color(0xFF161618) : Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title != null ?
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 16),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: Get.isDarkMode ? Colors.white : Colors.black
              ),
              textAlign: TextAlign.center,
            ),
          ) : const SizedBox(),
          imagePath != null ?
          Image.asset(
            imagePath!,
            width: 100.w,
            height: 100.h,
          ) : const SizedBox(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Get.isDarkMode ? Colors.white : darkGrey
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 12),
            child: ElevatedButton(
              onPressed: onPressed ?? () {
                Get.back();
              },
              child: Text(
                btnText ?? "Ok",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Get.isDarkMode ? Colors.white : Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
