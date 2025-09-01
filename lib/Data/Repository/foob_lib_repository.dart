import 'dart:developer';

import '../DataSources/remote/api_constant.dart';
import '../DataSources/remote/api_endpoints.dart';
import '../DataSources/remote/network_api_service.dart';

import '../Model/FoodLibModels/food_item_details_model.dart';
import '../Model/FoodLibModels/menu_list_model.dart';

class FoodLibRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<FoodMenuModel> getFoodMenu({String? query, int pageSize = 100}) async {
    try {
      dynamic response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.foodMenu,
        isTokenRequired: false,
        queryParameter: {
          "query": query,
          "apiKey": ApiConstants.foodLibAPIKey,
          "number": pageSize,
        }
      );
      log(response.toString());
      return FoodMenuModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<FoodItemDetailsModel?> getFoodDetails(String id) async {
    try {
      dynamic response = await _networkApiService.GetResponse(
        url: "${ApiEndPointUrls.foodItemDetails}$id/information",
        isTokenRequired: false,
        queryParameter: {
          "apiKey": ApiConstants.foodLibAPIKey,
        }
      );
      log(response.toString());
      return FoodItemDetailsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


}
