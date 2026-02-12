

import 'package:dio/dio.dart';


import '../DataSources/remote/network_api_service.dart';
import '../Model/ExcerciseModel/get_exercise_model.dart';
import '../Model/ExerciseGroup/group_details_model.dart';
import '../Model/ExerciseGroup/group_model.dart';
import '../Model/WorkOutLogs/workout_logs_model.dart';
import '../Model/muscleModel/get_muscle_model.dart';

import '../DataSources/remote/api_endpoints.dart';

class WorkOutRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<GroupModel?> getGroup({int pageNo = 1}) async {
    try {
      var response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.groupList,
        isTokenRequired: true,
        queryParameter: {
          "page": pageNo,
        },
      );
      return GroupModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<MuscleModel?> getMuscle({int pageNo = 1}) async {
    try {
      var response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.muscleList,
        isTokenRequired: true,
        queryParameter: {
          "page": pageNo,
        },
      );
      return MuscleModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ExerciseModel?> getExercise({int pageNo = 1, int? muscleId}) async {
    try {
      var response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.exerciseListByMuscle,
        isTokenRequired: true,
        queryParameter: {
          "muscle_group_id": muscleId,
          "page": pageNo,
        },
      );
      return ExerciseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<GroupDetailsModel?> groupDetails({required int? groupID}) async {
    var response = await _networkApiService.GetResponse(
      url: "${ApiEndPointUrls.groupDetails}/$groupID",
      isTokenRequired: true,
    );
    return GroupDetailsModel.fromJson(response);
  }

  Future<GroupDetailsModel?> createGroup({required String groupName, required List<int> exerciseIDs}) async {
    try {

      final formData = FormData.fromMap({
        "title": groupName,
        "exercises[]": exerciseIDs,
      });

      // data.addAll(Map.fromEntries(exerciseIDs.mapIndexed((i,e) => MapEntry("exercises[]", e.toString()))));
      var response = await _networkApiService.PostResponse(
        url: ApiEndPointUrls.groupCreate,
        isTokenRequired: true,
        data: formData,
      );
      return GroupDetailsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<GroupDetailsModel?> updateGroup({required int? groupID, required String groupName, List<int>? exerciseIDs}) async {
    try {

      final formData = FormData.fromMap({
        "title": groupName,
        "exercises[]": exerciseIDs,
      });
      var response = await _networkApiService.PostResponse(
        url: "${ApiEndPointUrls.groupUpdate}/$groupID",
        isTokenRequired: true,
        data: formData,
      );
      return GroupDetailsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteGroup({required int? groupID}) async {
    try {
      var response = await _networkApiService.PostResponse(
        url: "${ApiEndPointUrls.groupDelete}/$groupID",
        isTokenRequired: true,
        data: null
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteGroupExercise({required int? groupExerciseID}) async {
    try {
      var response = await _networkApiService.PostResponse(
        url: "${ApiEndPointUrls.groupDeleteExercise}/$groupExerciseID",
        isTokenRequired: true,
        data: null
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<WorkoutLogData?> logWorkoutTime({required Map<String, dynamic> data, required bool start}) async {
    var response = await _networkApiService.PostResponse(
      url: start
          ? ApiEndPointUrls.workoutLogStart
          : ApiEndPointUrls.workoutLogEnd,
      isTokenRequired: true,
      data: data,
    );
    return WorkoutLogData.fromJson(response);
  }

  Future<WorkoutLogsModel?> getWorkoutTimeLogs({int pageNo = 1}) async {
    var response = await _networkApiService.GetResponse(
      url: ApiEndPointUrls.workoutLogList,
      isTokenRequired: true,
      queryParameter: {
        "page": pageNo,
      },
    );
    return WorkoutLogsModel.fromJson(response);
  }
}
