import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../DataSources/remote/api_endpoints.dart';
import '../DataSources/remote/network_api_service.dart';
import '../Model/BaseApiModel/base_api_model.dart';
import '../Model/ForgetpasswordModel/forget_password_model.dart';
import '../Model/SignInModel/Signin_model.dart';

class AuthRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future SignupApiRepo(Map<String, dynamic> data) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
          url: ApiEndPointUrls.signUp, data: data, isTokenRequired: false);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<SigninModel> SigninApiRepo(Map<String, dynamic> data) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
          url: ApiEndPointUrls.signIn, data: data, isTokenRequired: false);
      print(response);
      return SigninModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgetPasswordModel> forgetPassword(Map<String, dynamic> data) async {
    try {
      var response = await _networkApiService.PostResponse(
          data: data, url: ApiEndPointUrls.forgetPass, isTokenRequired: false);
      print(response);
      return ForgetPasswordModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseApiModel> verifyCode(data) async {
    try {
      var response = await _networkApiService.PostResponse(
          data: data, url: ApiEndPointUrls.verifyCode, isTokenRequired: true);
      return compute(BaseApiModel.fromJson, response);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<BaseApiModel> resetPassword(data, {userId}) async {
    try {
      var response = await _networkApiService.PutResponse(
          data: data,
          url: ApiEndPointUrls.resetPass + userId,
          isTokenRequired: false);
      print("${ApiEndPointUrls.resetPass + userId}");
      return compute(BaseApiModel.fromJson, response);
    } catch (e) {
      rethrow;
    }
  }
}
