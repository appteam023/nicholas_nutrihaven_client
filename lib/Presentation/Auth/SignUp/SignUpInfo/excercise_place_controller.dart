import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/network_api_service.dart';
import 'package:nicholas_nutrihaven/Data/Model/ExcercisePlaceModel/excersice_place_model.dart';

class ExercisePlaceController extends GetxController {
  final NetworkApiService _apiService = NetworkApiService();

  var exercisePlaces = <ExercisePlace>[
    ExercisePlace(id: "00", name: "Large Gym", description: "Nutri Haven will complete a starter equipment list based on the location you pick.", isSelected: false),
    ExercisePlace(id: "01", name: "Small Gym", description: "Compact public gyms with limited equipment", isSelected: false),
    ExercisePlace(id: "02", name: "Garage Gym", description: "Barbells, Squat rack, dumbbells and more", isSelected: false),
    ExercisePlace(id: "03", name: "At Home", description: "Limited equipment such as dumbbells, bands, pull-up bars, etc", isSelected: true),
    ExercisePlace(id: "03", name: "Body weight Only", description: "Workout anywhere without gym equipment", isSelected: false),
    ExercisePlace(id: "03", name: "Custom", description: "Workout anywhere without gym equipment", isSelected: false),
  ].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // fetchExercisePlaces();
    super.onInit();
  }

  Future<void> fetchExercisePlaces() async {
    try {
      isLoading.value = true;
      var response = await _apiService.GetResponse(
        url:
            "https://nutrihaven.testdevlink.net/api/exerciseplace/getexerciseplace",
      );

      if (response != null && response is Map<String, dynamic>) {
        var model = ExcersicePlaceModel.fromMap(response);
        exercisePlaces.assignAll(model.data); 
      } else {
        Get.snackbar("Error", "Invalid response from server");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch exercise places: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
