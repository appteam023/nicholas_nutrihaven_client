import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../DataSources/remote/api_endpoints.dart';
import '../DataSources/remote/network_api_service.dart';
import '../Model/BaseApiModel/base_api_model.dart';
import '../Model/ForgetpasswordModel/forget_password_model.dart';
import '../Model/SignInModel/Signin_model.dart';

class AuthRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<SignInModel> signupApiRepo(Map<String, dynamic> data) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
          url: ApiEndPointUrls.signUp, data: data, isTokenRequired: false);
      log(response.toString());
      return SignInModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInModel> signInApiRepo(Map<String, dynamic> data) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
          url: ApiEndPointUrls.signIn, data: data, isTokenRequired: false);
      log(response.toString());
      return SignInModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgetPasswordModel> forgetPassword(Map<String, dynamic> data) async {
    try {
      var response = await _networkApiService.PostResponse(
          data: data, url: ApiEndPointUrls.forgetPass, isTokenRequired: false);
      log(response.toString());
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
      log(e.toString());
      rethrow;
    }
  }

  Future<BaseApiModel> resetPassword(data, {userId}) async {
    try {
      var response = await _networkApiService.PutResponse(
          data: data,
          url: ApiEndPointUrls.resetPass + userId,
          isTokenRequired: false);
      log(ApiEndPointUrls.resetPass + userId);
      return compute(BaseApiModel.fromJson, response);
    } catch (e) {
      rethrow;
    }
  }
}
