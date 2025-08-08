import 'dart:developer';

import 'package:nicholas_nutrihaven/Data/DataSources/remote/network_api_service.dart';

import '../DataSources/remote/api_endpoints.dart';
import '../Model/TagVideo/tag_model.dart';
import '../Model/WorkOutVideo/work_out_videos.dart';

class WorkoutVideosRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<List<Video>> getVideos(int? categoryID) async {
    try {
      dynamic response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.videos, isTokenRequired: true,
        queryParameter: {"q": categoryID}
      );
      log(response.toString());
      return WorkoutVideosModel.fromJson(response).videos ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<TagModel?> tagVideos(int? videoID, String tagName, String tagDesc) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
        url: ApiEndPointUrls.postTag, isTokenRequired: true,
        data: {
          "tag_nutriheaven_excerise_id" : videoID.toString(),
          "tag_name" : tagName,
          "tag_description" : tagDesc,
        }
      );
      log(response.toString());
      return TagModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<TagModel?> postWorkoutTime(String time) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
        url: ApiEndPointUrls.userWorkout, isTokenRequired: true,
        data: {
          "user_workout_total_time" : time
        }
      );
      log(response.toString());
      return TagModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
