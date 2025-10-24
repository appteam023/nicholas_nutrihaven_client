export '../Model/FoodLibModels/recipe_model.dart';


import 'dart:developer';

import '../DataSources/remote/api_constant.dart';
import '../DataSources/remote/api_endpoints.dart';
import '../DataSources/remote/network_api_service.dart';

import '../Model/FoodLibModels/food_item_details_model.dart';
import '../Model/FoodLibModels/recipe_model.dart';

class FoodLibRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<RecipeModel> getFoodMenu({String? query, int pageSize = 50,
    String? cuisine, required String diet}) async {
    try {
      dynamic response = await _networkApiService.GetResponse(
        url: ApiEndPointUrls.foodMenu,
        isTokenRequired: false,
        queryParameter: {
          if (query != null) "query": query,
          "apiKey": ApiConstants.foodLibAPIKey,
          "number": pageSize,
          "diet": diet,
          if (cuisine != null && cuisine != "null") "cuisine": cuisine,
          "sort": "popularity",
          "instructionsRequired": true,
          "addRecipeInformation": true,
        }
      );
      log(response.toString());
      return RecipeModel.fromJson(response);
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
          "includeNutrition": true,
          "instructionsRequired": true,
          "addRecipeInformation": true,
        }
      );
      log(response.toString());
      return FoodItemDetailsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


}
