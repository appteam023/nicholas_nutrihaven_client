import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_exception.dart';

errorHandling(DioException e,void Function(Exception, String? message) showDialog) {
  final ApiExceptions error;
  if (e.response != null) {
    debugPrint("==================DIO ERROR API RESPONSE==================");
    debugPrint("DioExceptionData ==> ${e.response?.realUri.toString()}");
    debugPrint("DioExceptionHeader ==> ${e.requestOptions.headers}");
    debugPrint("DioExceptionStatusCode ==> ${e.response!.statusCode}");
    debugPrint("DioExceptionRequestOption ==> ${e.response!.requestOptions}");
    debugPrint("DioExceptionData ==> ${e.response!.data}");

    /// Error Handling

    if (e.response?.statusCode == 400) {
      error = BadRequestException(e.response!.data['message']);

      // throw ScaffoldMessenger.of(Get.context!).showSnackBar(
      //   CustomSnackBar(
      //     backgroundColor: Colors.red,
      //     message: "${e.response?.data['message']}",
      //   ),
      // );
    } else if (e.response?.statusCode == 401) {
      // Get.offAllNamed(AppRoutes.signin);

      error = BadRequestException(e.response!.data['message']);
    } else if (e.response?.statusCode == 409) {
      // throw ScaffoldMessenger.of(Get.context!).showSnackBar(
      //   CustomSnackBar(
      //     backgroundColor: Colors.red,
      //     message: "${e.response?.data['message']}",
      //   ),
      // );
      error = BadRequestException(e.response!.data['message']);
    } else if (e.response?.statusCode == 401) {
      // Get.offAllNamed(AppRoutes.signin);

      error = BadRequestException(e.response!.data['message']);
    } else if (e.response?.statusCode == 404) {
      error = NotFoundException(e.response!.data['message']);
    } else if (e.response!.statusCode! >= 500 &&
        e.response!.statusCode! < 600) {
      error = ApiExceptions(
          "Oops! Something went wrong. Our team is working to fix the issue. Please try again later.",
          "Server Error");
    } else if (e is SocketException) {
      error = NoInternetException('No Internet Connection');
    } else if (e is TimeoutException) {
      error = NoInternetException('Network Request Time Out');
    } else {
      error = ApiExceptions(e.response!.data['message']);
    }
  } else {
    debugPrint("DIO EXCEPTION ELSE Condition");
    if (kDebugMode) {
      print("DioExceptionRequestOptionInElse ==>${e.requestOptions}");
    }
    debugPrint(e.message);
    error = ApiExceptions(e.message);
  }
  showDialog(error, error.message);
  throw error;
}
