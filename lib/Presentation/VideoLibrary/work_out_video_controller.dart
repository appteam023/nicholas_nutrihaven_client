
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Model/WorkOutVideo/work_out_videos.dart';
import '../../Data/Repository/workout_videos_repository.dart';
import '../../Widgets/loader_widget.dart';
import 'video_library_controller.dart';


class WorkOutVideoController extends GetxController {
  final WorkoutVideosRepository workoutVideosRepository = WorkoutVideosRepository();

  RxList<Video> workoutVideos = <Video>[].obs;
  Video? selectedVideo;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchVideos();
    });
  }

  void fetchVideos() async {
    try {
      showLoader(true);
      final categoryID = Get.find<VideoLibraryController>().selectedCategory?.categoryId;
      var res = await workoutVideosRepository.getVideos(categoryID);
      workoutVideos.value = res;
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
