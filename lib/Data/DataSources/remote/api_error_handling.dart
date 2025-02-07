import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/AppRoutes/routes_imports.dart';
import '../../../Widgets/custom_snackbar.dart';
import 'api_exception.dart';

errorHandling(DioException e) {
  if (e.response != null) {
    debugPrint("DIO EXCEPTION IF Condition");
    debugPrint("==================DIO ERROR API RESPONSE==================");
    debugPrint("DioExceptionData ==> ${e.response!.data}");
    debugPrint("DioExceptionHeader ==> ${e.response!.headers}");
    debugPrint("DioExceptionStatusCode ==> ${e.response!.statusCode}");
    debugPrint("DioExceptionRequestOption ==> ${e.response!.requestOptions}");

    /// Error Handling
    if (e.response?.statusCode == 400) {
      throw BadRequestException(e.response!.data['message']);

      // throw ScaffoldMessenger.of(Get.context!).showSnackBar(
      //   CustomSnackBar(
      //     backgroundColor: Colors.red,
      //     message: "${e.response?.data['message']}",
      //   ),
      // );
    } else if (e.response?.statusCode == 401) {
      // Get.offAllNamed(AppRoutes.signin);

      throw BadRequestException(e.response!.data['message']);
    } else if (e.response?.statusCode == 409) {
      // throw ScaffoldMessenger.of(Get.context!).showSnackBar(
      //   CustomSnackBar(
      //     backgroundColor: Colors.red,
      //     message: "${e.response?.data['message']}",
      //   ),
      // );
      throw BadRequestException(e.response!.data['message']);
    } else if (e.response?.statusCode == 401) {
      // Get.offAllNamed(AppRoutes.signin);

      throw BadRequestException(e.response!.data['message']);
    } else if (e.response?.statusCode == 404) {
      throw NotFoundException(e.response!.data['message']);
    } else if (e.response!.statusCode! >= 500 &&
        e.response!.statusCode! < 600) {
      throw ApiExceptions(
          "Oops! Something went wrong. Our team is working to fix the issue. Please try again later.",
          "Server Error");
    } else if (e is SocketException) {
      throw NoInternetException('No Internet Connection');
    } else if (e is TimeoutException) {
      throw NoInternetException('Network Request Time Out');
    } else {
      throw ApiExceptions(e.response!.data['message']);
    }
  } else {
    debugPrint("DIO EXCEPTION ELSE Condition");
    if (kDebugMode) {
      print("DioExceptionRequestOptionInElse ==>${e.requestOptions}");
    }
    debugPrint(e.message);
    throw ApiExceptions(e.message);
  }
}
