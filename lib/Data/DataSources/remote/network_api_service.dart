// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData;
import 'package:nicholas_nutrihaven/Widgets/loader_widget.dart';
import 'dart:io';
import '../../../Helpers/get_storare_helper.dart';
import '../../../Widgets/custom_snackbar.dart';
import 'api_constant.dart';
import 'api_error_handling.dart';
import 'api_exception.dart';
import 'base_api_service.dart';

class NetworkApiService implements BaseApiServices {
  late Dio dio;
  late BaseOptions baseOptions;

  NetworkApiService() {
    baseOptions = BaseOptions(
      baseUrl: ApiConstants.mainUrl,
    );
    dio = Dio(baseOptions);
  }

  @override
  Future GetResponse(
      {required String url,
      bool isTokenRequired = true,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameter}) async {
    try {
      String? token;
      if (isTokenRequired) {
        token = getToken();
        log("token ==> $token");
      }
      log("==================API REQUEST==================");
      log(url.toString());
      log(queryParameter.toString());
      var response = await dio
          .get(
            url,
            data: data,
            queryParameters: queryParameter,
            options: Options(
              headers: {"Authorization": "Bearer $token"},
            ),
          )
          .timeout(const Duration(seconds: 20));
      log("==================API RESPONSE==================");
      log(response.realUri.toString());
      log(response.requestOptions.queryParameters.toString());
      log(response.statusCode.toString());
      log(response.data.toString());
      return response.data;
    } on SocketException {
      final error = NoInternetException('No Internet Connection');
      showDialog(error);
      throw error;
    } on TimeoutException {
      final error = NoInternetException('Network Request time out');
      showDialog(error);
      throw error;
    } on DioException catch (e) {
      errorHandling(e, (err, msg)=> showDialog(e, msg));
    }
  }

  @override
  Future PostResponse(
      {required String url,
      required dynamic data,
      bool isTokenRequired = true}) async {
    try {
      String? token;
      if (isTokenRequired) {
        token = getToken();
        debugPrint("user token: $token");
      }
      log("==================API REQUEST==================");
      log(url.toString());
      if (data is FormData) {
        log(data.fields.toString());
      } else {
        log(data.toString());
      }

      var response = await dio
          .post(
            url,
            data: data,
            options: Options(
              headers: {"Authorization": "Bearer $token"},
            ),
          )
          .timeout(const Duration(seconds: 20));
      log("==================API RESPONSE==================");
      log(response.realUri.toString());
      log(response.requestOptions.queryParameters.toString());
      log(response.statusCode.toString());
      log(response.data.toString());
      return response.data;
    } on SocketException {
      final error = NoInternetException('No Internet Connection');
      showDialog(error);
      throw error;
    } on TimeoutException {
      final error = NoInternetException('Network Request time out');
      showDialog(error);
      throw error;
    } on DioException catch (e) {
      errorHandling(e, (err, msg)=> showDialog(e, msg));
    }
  }

  @override
  Future PutResponse(
      {required String url,
      required var data,
      bool isTokenRequired = true}) async {
    try {
      String? token;
      if (isTokenRequired) {
        token = getToken();
      }
      // debugPrint("user token: $token");
      // debugPrint("==================API REQUEST==================");
      // debugPrint("Request URL: ${baseOptions.baseUrl + url}");
      var response = await dio
          .put(
            url,
            data: data,
            options: Options(
              headers: {"Authorization": "Bearer $token"},
            ),
          )
          .timeout(const Duration(seconds: 20));
      return response.data;
    } on SocketException {
      final error = NoInternetException('No Internet Connection');
      showDialog(error);
      throw error;
    } on TimeoutException {
      final error = NoInternetException('Network Request time out');
      showDialog(error);
      throw error;
    } on DioException catch (e) {
      errorHandling(e, (err, msg)=> showDialog(e, msg));
    }
  }

  Future PutResponseFormData(
      {required String url,
      required FormData data,
      bool isTokenRequired = true}) async {
    try {
      String? token;
      if (isTokenRequired) {
        log("token ==> $token");
        token = getToken();
      }
      // debugPrint("user token: $token");
      // debugPrint("==================API REQUEST==================");
      // debugPrint("Request URL: ${baseOptions.baseUrl + url}");
      var response = await dio
          .put(
            url,
            data: data,
            options: Options(
              headers: {"Authorization": "Bearer $token"},
            ),
          )
          .timeout(const Duration(seconds: 20));

      // debugPrint("==================API RESPONSE==================");
      // debugPrint(response.statusCode.toString());
      // debugPrint(response.data.toString());
      return response.data;
    } on SocketException {
      final error = NoInternetException('No Internet Connection');
      showDialog(error);
      throw error;
    } on TimeoutException {
      final error = NoInternetException('Network Request time out');
      showDialog(error);
      throw error;
    } on DioException catch (e) {
      errorHandling(e, (err, msg)=> showDialog(e, msg));
    }
  }

  void showDialog(Exception error, [String? msg]) {
    if (kIsLoading) {
      kIsLoading = false;
      Get.back();
    }
    String message = "Something went wrong";
    if (msg != null) {
      message = msg;
    }
    else if (error is ApiExceptions) {
      message = error.message.toString();
    } else if (error is DioException) {
      message = error.response?.data?.toString() ?? error.error.toString();
    }
    Get.dialog(
      CustomAlertDialog(
        title: "Error",
        message: message,
      )
    );
  }
}
