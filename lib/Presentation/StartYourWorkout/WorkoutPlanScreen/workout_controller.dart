
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Data/Repository/workout_repository.dart';
import '../../../Data/Repository/workout_videos_repository.dart';
import '../controller/workout_plan_controller.dart';




class WorkOutController extends GetxController {
  final WorkoutVideosRepository workoutVideosRepository = WorkoutVideosRepository();
  final WorkOutRepository workOutRepository = WorkOutRepository();

  Timer? timer;
  int secondsElapsed = 0;
  bool isRunning = false;
  DateTime? startTime;

  void startTimer() {
    if (isRunning) return;
    logStartWorkoutTime();
    isRunning = true;
    startTime ??= DateTime.now();
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
    startTime = null;
    // bool res = await logEndWorkoutTime();
    // if (res) {
    //   ScaffoldMessenger.of(Get.context!).showSnackBar(
    //     CustomSnackBar(
    //       message: "Success 👏, Workout Time saved",
    //     ),
    //   );
    // } else {
    //   debugPrint("error");
    // }
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
    secondsElapsed = 0;
    startTime = null;
    timer?.cancel();
    super.onClose();
  }



  Future<bool> logStartWorkoutTime() async {
    try {
      var res = await workOutRepository.logWorkoutTime(
        data: {
          "group_exercise_id": Get.find<WorkoutPlanController>().workoutExercise?.id,
          "start_time": DateFormat("HH:mm:ss").format(DateTime.now().toUtc()),
          "log_date": formatDateTimeToString(DateTime.now(), format: "yyyy/MM/dd")
        },
        start: true,
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

    }
    return false;
  }

  Future<bool> logEndWorkoutTime() async {

    if (secondsElapsed == 0) return false;
    if (Get.find<WorkoutPlanController>().isStartTimer.value == false) return false;
    try {
      var res = await workOutRepository.logWorkoutTime(
        data: {
          "group_exercise_id": Get.find<WorkoutPlanController>().workoutExercise?.id,
          "end_time": DateFormat("HH:mm:ss").format(DateTime.now().toUtc()),
        },
        start: false
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

    }
    return false;
  }

  String? formatDateTimeToString(DateTime? datetime, {String format = 'dd-MM-yyyy'}) {
    if (datetime == null) {
      return null;
    }
    try {
      return DateFormat(format).format(datetime);
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return null;
    }
  }

}
