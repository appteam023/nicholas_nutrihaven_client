import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/Model/ExcerciseModel/get_exercise_model.dart';
import 'package:nicholas_nutrihaven/Data/Model/ExcerciseModel/post_exercise_model.dart';
import 'package:nicholas_nutrihaven/Data/Model/muscleModel/get_muscle_model.dart';
import 'package:nicholas_nutrihaven/Data/Repository/exercise_repository.dart';
import 'package:nicholas_nutrihaven/Data/Repository/muscle_repository.dart';
import 'package:nicholas_nutrihaven/Data/Response/api_response.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nicholas_nutrihaven/Helpers/custom_loading_dialog.dart';
import 'package:nicholas_nutrihaven/Helpers/custom_snackbar_helper.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';

class AddNewExerciseController extends GetxController {
  final ExerciseRepository _exerciseRepository = ExerciseRepository();
  final Rx<ApiResponse<GetExerciseModel>> getExerciseResponse =
      ApiResponse<GetExerciseModel>.initial().obs;

  final MuscleRepository _muscleRepository = MuscleRepository();
  final Rx<ApiResponse<GetMuscleModel>> getMuscleResponse =
      ApiResponse<GetMuscleModel>.initial().obs;

  final Rx<ApiResponse<PostExerciseModel>> getPostResponse =
      ApiResponse<PostExerciseModel>.initial().obs;

  final RxInt? selectedExerciseId = RxInt(-1);
  final RxInt? selectedMuscleId = RxInt(-1);

  @override
  void onInit() {
    fetchExercises();
    fetchMuscles();
    super.onInit();
  }

  Future<void> fetchExercises() async {
    try {
      getExerciseResponse.value = ApiResponse.loading();
      final response = await _exerciseRepository.getExercise();
      getExerciseResponse.value = ApiResponse.completed(response);
    } catch (e) {
      getExerciseResponse.value = ApiResponse.error(e.toString());
    }
  }

  void toggleExerciseSelection(int exerciseId) {
    log('Toggling exerciseId: $exerciseId, current: ${selectedExerciseId!.value}');
    if (selectedExerciseId!.value == exerciseId) {
      selectedExerciseId!.value = -1;
    } else {
      selectedExerciseId!.value = exerciseId;
    }
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

  void toggleMuscleSelection(int muscleId) {
    log('Toggling muscleId: $muscleId, current: ${selectedMuscleId!.value}');
    if (selectedMuscleId!.value == muscleId) {
      selectedMuscleId!.value = -1;
    } else {
      selectedMuscleId!.value = muscleId;
    }
  }

  bool isExerciseSelected() {
    final selected =
        selectedExerciseId!.value != -1 && selectedMuscleId!.value != -1;
    log('isExerciseSelected: $selected, exerciseId: ${selectedExerciseId!.value}, muscleId: ${selectedMuscleId!.value}');
    return selected;
  }

  Future<void> postExercise() async {
    if (isExerciseSelected()) {
      log('Posting exercise with ID: ${selectedExerciseId!.value} and muscle ID: ${selectedMuscleId!.value}');

      try {
        showCustomLoadingDialog(
            context: Get.context!, message: 'Adding exercise...');
        getPostResponse.value = ApiResponse.loading();
        final formData = dio.FormData.fromMap({
          'exercise_nutrihaven_exercise_id':
              selectedExerciseId!.value.toString(),
          'exercise_workout_exercise_id': '1',
          'exercise_repetitions': '1'
        });
        final response = await _exerciseRepository.postExercise(formData);
        getPostResponse.value = ApiResponse.completed(response);

        final result = await postExerciseMuscle(response.data!.exerciseId!);

        if (!result) {
          Get.back();
          showCustomSnackbar(
              message: 'Failed to add exercise muscle.',
              backgroundColor: Colors.red);
          return;
        }

        Get.back();
        showCustomSnackbar(
            message: 'Exercise added successfully.',
            backgroundColor: themeColor);
      } catch (e) {
        Get.back();
        getPostResponse.value = ApiResponse.error(e.toString());
      }
    } else {
      Get.back();
      log('No exercise or muscle selected for posting.');
    }
  }

  Future<bool> postExerciseMuscle(int exerciseId) async {
    try {
      final formData = dio.FormData.fromMap({
        'exercise_id': exerciseId,
        'muscle_id': selectedMuscleId!.value,
      });
      final response = await _exerciseRepository.postExerciseMuscle(formData);
      if (response['status'] == 'success') {
        log('Exercise muscle posted successfully: ${response['message']}');

        return true;
      } else {
        log('Failed to post exercise muscle: ${response['message']}');
        return false;
      }
    } catch (e) {
      log('Error posting exercise muscle: $e');
      return false;
    }
  }
}
