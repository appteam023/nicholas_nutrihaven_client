// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:nicholas_nutrihaven/Data/Model/ExcersiceEquipmentModel/excersice_equipment_model.dart';

// class ExerciseEquipmentController extends GetxController {
//   var isLoading = true.obs;
//   var categories = <Category>[].obs;

//   @override
//   void onInit() {
//     fetchExerciseEquipments();
//     super.onInit();
//   }

//   Future<void> fetchExerciseEquipments() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://nutrihaven.testdevlink.net/api/exerciseequipment/getexerciseequipment"));

//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);
//         ExerciseEquipmentModel data = ExerciseEquipmentModel.fromMap(jsonData);

//         categories.value = data.data;
//       } else {
//         Get.snackbar("Error", "Failed to load data");
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void retryFetch() {
//     isLoading.value = true;
//     fetchExerciseEquipments();
//   }

//   void toggleSelection(ExerciseItem item) {
//     for (var category in categories) {
//       for (var subCategory in category.subCategories) {
//         for (var i = 0; i < subCategory.items.length; i++) {
//           if (subCategory.items[i].id == item.id) {
//             subCategory.items[i] = ExerciseItem(
//               id: item.id,
//               name: item.name,
//               category: item.category,
//               subCategory: item.subCategory,
//               image: item.image,
//               isDeleted: item.isDeleted,
//               createdAt: item.createdAt,
//               updatedAt: item.updatedAt,
//               v: item.v,
//               isSelected: !item.isSelected,
//             );
//           }
//         }
//       }
//     }

//     categories.refresh(); // ✅ Refresh UI
//   }
// }
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nicholas_nutrihaven/Data/Model/ExcersiceEquipmentModel/excersice_equipment_model.dart';

class ExerciseEquipmentController extends GetxController {
  var isLoading = true.obs;
  var categories = <Category>[].obs;

  @override
  void onInit() {
    fetchExerciseEquipments();
    super.onInit();
  }

  Future<void> fetchExerciseEquipments() async {
    try {
      final response = await http.get(Uri.parse(
          "https://nutrihaven.testdevlink.net/api/exerciseequipment/getexerciseequipment"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        ExerciseEquipmentModel data = ExerciseEquipmentModel.fromMap(jsonData);

        categories.value = data.data;
      } else {
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void retryFetch() {
    isLoading.value = true;
    fetchExerciseEquipments();
  }

  void toggleSelection(ExerciseItem item) {
    for (var category in categories) {
      for (var subCategory in category.subCategories) {
        var foundItem = subCategory.items.firstWhereOrNull((e) => e.id == item.id);
        if (foundItem != null) {
          foundItem.isSelected = !foundItem.isSelected;
        }
      }
    }
    categories.refresh();
  }

  void toggleSelectAll(SubCategory subCategory, bool isSelected) {
    for (var i = 0; i < subCategory.items.length; i++) {
      subCategory.items[i].isSelected = isSelected;
    }
    categories.refresh();
  }

  bool isAllSelected(SubCategory subCategory) {
    return subCategory.items.every((item) => item.isSelected);
  }
}
