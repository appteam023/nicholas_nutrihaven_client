
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Model/CategoryModel/video_lib_category_model.dart' as category_model;
import '../../Data/Repository/category_repository.dart';
import '../../Widgets/loader_widget.dart';


class VideoLibraryController extends GetxController {
  final VideosCategoriesRepository categoriesRepository = VideosCategoriesRepository();

  RxList<category_model.Category> videoCategories = <category_model.Category>[].obs;
  category_model.Category? selectedCategory;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchVideoCategories();
    });
  }

  void fetchVideoCategories() async {
    try {
      showLoader(true);
      var res = await categoriesRepository.getCategories();
      videoCategories.value = res;
    } catch (error, stackTrace) {
      showLoader(false);
      update();
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
    } finally {
      showLoader(false);
    }
  }

}
