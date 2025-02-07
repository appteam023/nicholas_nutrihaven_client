import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/network_api_service.dart';
import 'package:nicholas_nutrihaven/Data/Model/ExcercisePlaceModel/excersice_place_model.dart';

class ExercisePlaceController extends GetxController {
  final NetworkApiService _apiService = NetworkApiService();

  var exercisePlaces = <ExercisePlace>[].obs; 
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchExercisePlaces();
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
