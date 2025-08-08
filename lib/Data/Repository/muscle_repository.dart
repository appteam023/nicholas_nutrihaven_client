import 'dart:developer';

import 'package:nicholas_nutrihaven/Data/DataSources/remote/network_api_service.dart';
import 'package:nicholas_nutrihaven/Data/Model/muscleModel/get_muscle_model.dart';

import '../DataSources/remote/api_endpoints.dart';
import '../Model/WorkOutVideo/work_out_videos.dart';

class MuscleRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<GetMuscleModel> getMuscle() async {
    try {
      dynamic response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.muscle,
        isTokenRequired: true,
      );
      log(response.toString());
      return GetMuscleModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
