
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Model/FoodLibModels/food_item_details_model.dart';
import '../../Data/Model/FoodLibModels/menu_list_model.dart';
import '../../Data/Repository/foob_lib_repository.dart';
import '../../Widgets/loader_widget.dart';




class FoodLibController extends GetxController {

  var searchFieldVisibility = false.obs;

  FoodMenuModel foodMenuModel = FoodMenuModel(menuItems: []);
  RxList<MenuItems> listOfMenuItems = <MenuItems>[].obs;
  Rxn<FoodItemDetailsModel> foodItemDetails = Rxn<FoodItemDetailsModel>(null);

  RxString searchQuery = "".obs;
  Worker? searchWorker;




  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchMenuItems();
    });
  }

  @override
  void onReady() {
    super.onReady();
    searchWorker = debounce(searchQuery, (callBack) {
      foodMenuModel.totalMenuItems = null;
      foodMenuModel.menuItems?.clear();
      fetchMenuItems(searchQuery: callBack);
    }, time: 1000.milliseconds);
  }

  @override
  void onClose() {
    searchWorker?.dispose();
    super.onClose();
  }

  void toggleVisibility () {
    searchFieldVisibility.value = !searchFieldVisibility.value;
  }

  void fetchMenuItems({String? searchQuery}) async {
    try {
      if(foodMenuModel.totalMenuItems != null && foodMenuModel.totalMenuItems == foodMenuModel.menuItems?.length) {
        return;
      }
      showLoader(true);
      FoodMenuModel? res = await FoodLibRepository().getFoodMenu(
        query: searchQuery ?? "workout", //pageSize: (foodMenuModel.offset ?? 0) * 2,
      );
      if (res.menuItems != null) {
        foodMenuModel.menuItems?.addAll(res.menuItems ?? []);
        listOfMenuItems.value = [...foodMenuModel.menuItems ?? []];
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
      if(foodMenuModel.totalMenuItems != null && foodMenuModel.totalMenuItems == foodMenuModel.menuItems?.length) {
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

}
