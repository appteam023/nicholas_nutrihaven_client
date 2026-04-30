

import 'package:dio/dio.dart';


import '../DataSources/remote/network_api_service.dart';
import '../Model/ExcerciseModel/get_exercise_model.dart';
import '../Model/ExerciseGroup/group_details_model.dart';
import '../Model/ExerciseGroup/saved_workout_model.dart';
import '../Model/WorkOutLogs/workout_logs_model.dart';
import '../Model/muscleModel/get_muscle_model.dart';

import '../DataSources/remote/api_endpoints.dart';

class WorkOutRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<WorkoutModel?> getWorkoutPlan({int pageNo = 1}) async {
    try {
      var response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.workoutPlanList,
        isTokenRequired: true,
        queryParameter: {
          "page": pageNo,
        },
      );
      return WorkoutModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<MuscleModel?> getMuscle({int pageNo = 1, String? mainMuscle}) async {
    try {
      var response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.muscleList,
        isTokenRequired: true,
        queryParameter: {
          if(mainMuscle != null) "targeted_muscles": mainMuscle,
          "page": pageNo,
          "per_page": 20,
        },
      );
      return MuscleModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ExerciseModel?> getExercise({Map<String, dynamic>? queryParameter}) async {
    try {
      var response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.exerciseListByMuscle,
        isTokenRequired: true,
        queryParameter: queryParameter,
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

  Future<Map<String, dynamic>> createGroup({required Map<String, dynamic> data,}) async {
    try {
      // data.addAll(Map.fromEntries(exerciseIDs.mapIndexed((i,e) => MapEntry("exercises[]", e.toString()))));
      var response = await _networkApiService.PostResponse(
        url: ApiEndPointUrls.workoutPlanCreate,
        isTokenRequired: true,
        data: data,
      );
      return response ?? {};
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateGroup({required int? workoutID, required String workoutName, List<int>? exerciseIDs}) async {
    try {

      final formData = FormData.fromMap({
        "name": workoutName,
        // "exercises_data": exerciseIDs,
      });
      var response = await _networkApiService.PostResponse(
        url: "${ApiEndPointUrls.workoutPlanUpdate}/$workoutID",
        isTokenRequired: true,
        data: formData,
      );
      return response ?? {};
    } catch (e) {
      rethrow;
    }
  }

  Future deleteGroup({required int? workoutID}) async {
    try {
      var response = await _networkApiService.PostResponse(
        url: "${ApiEndPointUrls.workoutPlanDelete}/$workoutID",
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
