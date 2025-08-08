
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Data/Repository/workout_videos_repository.dart';
import '../../../Widgets/loader_widget.dart';
import '../work_out_video_controller.dart';




class TagVideoController extends GetxController {
  final WorkoutVideosRepository workoutVideosRepository = WorkoutVideosRepository();

  final tagFormKey = GlobalKey<FormState>();
  TextEditingController tagNameCtrl = TextEditingController();
  TextEditingController tagDescCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
  }

  @override
  void onClose() {
    tagNameCtrl.dispose();
    tagDescCtrl.dispose();
    super.onClose();
  }



  Future<bool> tagVideos() async {
    if (!tagFormKey.currentState!.validate()) {
      return false;
    }
    try {
      showLoader(true);
      var res = await workoutVideosRepository.tagVideos(
        Get.find<WorkOutVideoController>().selectedVideo?.workoutVideosId,
        tagNameCtrl.text,
        tagDescCtrl.text,
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
