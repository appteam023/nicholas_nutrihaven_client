import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_snackbar.dart';

showCustomSnackbar({
  required String message,
  Color? backgroundColor,
}) {
  return ScaffoldMessenger.of(Get.context!).showSnackBar(CustomSnackBar(
    message: message,
    backgroundColor: backgroundColor,
  ));
}
