import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../../../Helpers/get_storare_helper.dart';
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
      var token;
      if (isTokenRequired) {
        token = await getToken();
        print("token ==> $token");
      }
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
      debugPrint("==================API RESPONSE==================");
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
      return response.data;
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw NoInternetException('Network Request time out');
    } on DioException catch (e) {
      errorHandling(e);
    }
  }

  @override
  Future PostResponse(
      {required String url,
      required dynamic data,
      bool isTokenRequired = true}) async {
    try {
      var token;
      if (isTokenRequired) {
        token = await getToken();
        debugPrint("user token: $token");
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
      print('Code Verified');
      return response.data;
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw NoInternetException('Network Request time out');
    } on DioException catch (e) {
      print("base api error: $e");
      errorHandling(e);
    }
  }



  @override
  Future PutResponse(
      {required String url,
      required var data,
      bool isTokenRequired = true}) async {
    try {
      var token;
      if (isTokenRequired) {
        token = await getToken();
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
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw NoInternetException('Network Request time out');
    } on DioException catch (e) {
      errorHandling(e);
    }
  }

  Future PutResponseFormData(
      {required String url,
      required FormData data,
      bool isTokenRequired = true}) async {
    try {
      var token;
      if (isTokenRequired) {
        print("token ==> $token");
        token = await getToken();
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
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw NoInternetException('Network Request time out');
    } on DioException catch (e) {
      errorHandling(e);
    }
  }
}
