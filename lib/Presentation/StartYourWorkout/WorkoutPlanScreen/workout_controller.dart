
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Data/Repository/workout_videos_repository.dart';
import '../../../Widgets/custom_snackbar.dart';
import '../../../Widgets/loader_widget.dart';




class WorkOutController extends GetxController {
  final WorkoutVideosRepository workoutVideosRepository = WorkoutVideosRepository();

  Timer? timer;
  int secondsElapsed = 0;
  bool isRunning = false;

  void startTimer() {
    if (isRunning) return;
    isRunning = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      secondsElapsed++;
      update();
    });
  }

  void pauseTimer() {
    timer?.cancel();
    isRunning = false;
    update();
  }

  void resetTimer() async {
    pauseTimer();
    bool res = await saveWorkoutTime();
    if (res) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        CustomSnackBar(
          message: "Success 👏, Workout Time saved",
        ),
      );
    } else {
      debugPrint("error");
    }
    update();
    secondsElapsed = 0;
  }

  String formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${secs.toString().padLeft(2, '0')}";
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }



  Future<bool> saveWorkoutTime() async {
    if (secondsElapsed == 0) return false;
    try {
      showLoader(true);
      var res = await workoutVideosRepository.postWorkoutTime(
        secondsElapsed.toString()
      );
      if(res != null ) {
        return true;
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
    } finally {
      showLoader(false);
    }
    return false;
  }

}
