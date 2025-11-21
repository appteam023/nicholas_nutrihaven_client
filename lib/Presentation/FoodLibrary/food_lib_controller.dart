
export 'data_provider/cuisine_data.dart';
export 'data_provider/diet_data.dart';

import 'package:url_launcher/url_launcher.dart';

import 'data_provider/models/cuisine_model.dart';
import 'data_provider/models/diet_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Model/FoodLibModels/food_item_details_model.dart';
import '../../Data/Repository/foob_lib_repository.dart';
import '../../Widgets/loader_widget.dart';




class FoodLibController extends GetxController {

  var searchFieldVisibility = false.obs;


  RecipeModel recipeModel = RecipeModel(recipes: []);
  RxList<Recipe> listOfRecipeItems = <Recipe>[].obs;
  Recipe? selectedRecipe;
  Rxn<FoodItemDetailsModel> foodItemDetails = Rxn<FoodItemDetailsModel>(null);

  // var stepperCount = 1.obs;
  Rxn<DietModel> selectedDiet = Rxn<DietModel>(null);
  Rxn<CuisineModel> selectedCuisine = Rxn<CuisineModel>(null);

  RxString searchQuery = "".obs;
  Worker? searchWorker;
  TextEditingController searchTFCtrl = TextEditingController();

  Map<String, String> nutrients = {
    "carbohydrates": "assets/images/food_lib/nutrients/1_carbohydrates.png",
    "protein": "assets/images/food_lib/nutrients/2_protein.png",
    "fiber": "assets/images/food_lib/nutrients/3_fiber.png",
    "fat": "assets/images/food_lib/nutrients/4_fat.png",
    "sodium": "assets/images/food_lib/nutrients/5_sodium.png",
    "sugar": "assets/images/food_lib/nutrients/6_sugar.png",
    "cholesterol": "assets/images/food_lib/nutrients/7_cholesterol.png",
  };

  RxList<bool> mealCharacteristicsDetails = [false, false, false, false, false,
    false, false, false, false].obs;




  @override
  void onReady() {
    super.onReady();
    searchWorker = debounce(searchQuery, (callBack) {
      recipeModel.totalResults = null;
      recipeModel.recipes?.clear();
      fetchMenuItems(searchQuery: callBack);
    }, time: 1000.milliseconds);
  }

  @override
  void onClose() {
    searchWorker?.dispose();
    searchTFCtrl.dispose();
    super.onClose();
  }

  void toggleVisibility () {
    searchFieldVisibility.value = !searchFieldVisibility.value;
  }

  void fetchMenuItems({String? searchQuery, bool reload = false}) async {
    try {
      if(recipeModel.totalResults != null && recipeModel.totalResults == recipeModel.recipes?.length) {
        return;
      }
      showLoader(true);
      RecipeModel? res = await FoodLibRepository().getFoodMenu(
        query: searchQuery, //pageSize: (foodMenuModel.offset ?? 0) * 2,
        diet: "${selectedDiet.value?.name}",
        cuisine: "${selectedCuisine.value?.name}"

      );
      if (res.recipes != null) {
        if (reload) {
          recipeModel.recipes?.clear();
          listOfRecipeItems.clear();
          // searchTFCtrl.clear();
        }
        recipeModel.recipes?.addAll(res.recipes ?? []);
        listOfRecipeItems.value = [...recipeModel.recipes ?? []];
      }
    } on Exception catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    } finally {
      showLoader(false);
    }
  }

  void fetchMenuItemDetails(String id) async {
    try {
      if(recipeModel.totalResults != null && recipeModel.totalResults == recipeModel.recipes?.length) {
        return;
      }
      showLoader(true);
      FoodItemDetailsModel? res = await FoodLibRepository().getFoodDetails(id);
      if (res != null) {
        foodItemDetails.value = res;
        update();
      }
    } on Exception catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    } finally {
      showLoader(false);
    }
  }

  Future<void> launchURL() async {
    try {
      final Uri url = Uri.parse('https://spoonacular.com/food-api/docs#Nutrition');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}
