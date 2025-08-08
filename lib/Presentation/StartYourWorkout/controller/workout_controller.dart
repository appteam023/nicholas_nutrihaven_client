import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/Model/muscleModel/get_muscle_model.dart';
import 'package:nicholas_nutrihaven/Data/Repository/muscle_repository.dart';
import 'package:nicholas_nutrihaven/Data/Response/api_response.dart';

class WorkoutController extends GetxController {
  final MuscleRepository _muscleRepository = MuscleRepository();
  final Rx<ApiResponse<GetMuscleModel>> getMuscleResponse =
      ApiResponse<GetMuscleModel>.initial().obs;

  @override
  void onInit() {
    fetchMuscles();
    super.onInit();
  }

  Future<void> fetchMuscles() async {
    try {
      getMuscleResponse.value = ApiResponse.loading();
      final response = await _muscleRepository.getMuscle();
      getMuscleResponse.value = ApiResponse.completed(response);
    } catch (e) {
      getMuscleResponse.value = ApiResponse.error(e.toString());
    }
  }
}
