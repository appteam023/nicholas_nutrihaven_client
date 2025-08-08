import 'dart:developer';

import 'package:nicholas_nutrihaven/Data/DataSources/remote/network_api_service.dart';

import '../DataSources/remote/api_endpoints.dart';
import '../Model/CategoryModel/video_lib_category_model.dart';

class VideosCategoriesRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<List<Category>> getCategories() async {
    try {
      dynamic response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.categories, isTokenRequired: true
      );
      log(response.toString());
      return CategoryModel.fromJson(response).categories ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
