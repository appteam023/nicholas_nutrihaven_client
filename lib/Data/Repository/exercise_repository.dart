import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/network_api_service.dart';
import 'package:nicholas_nutrihaven/Data/Model/ExcerciseModel/get_exercise_model.dart';
import 'package:nicholas_nutrihaven/Data/Model/ExcerciseModel/post_exercise_model.dart';
import '../DataSources/remote/api_endpoints.dart';

class ExerciseRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<GetExerciseModel> getExercise() async {
    try {
      dynamic response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.getExercise,
        isTokenRequired: true,
      );
      log(response.toString());
      return GetExerciseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<PostExerciseModel> postExercise(FormData data) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
          url: ApiEndPointUrls.postExercise, isTokenRequired: true, data: data);
      log(response.toString());
      return PostExerciseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future postExerciseMuscle(FormData data) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
          url: ApiEndPointUrls.postExerciseMuscle,
          isTokenRequired: true,
          data: data);
      log(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
