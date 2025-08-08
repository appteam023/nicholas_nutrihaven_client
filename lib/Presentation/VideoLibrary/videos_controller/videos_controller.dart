import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../work_out_video_controller.dart';

class VideoController extends GetxController {
  late BetterPlayerController betterPlayerController;
  final RxBool isVideoInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeVideo(Get.find<WorkOutVideoController>().selectedVideo?.workoutVideosCdnUrl ?? "");
    });
  }

  void initializeVideo(String url) {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource.network(
      url,

    );

    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(enableSubtitles: false),

      ),
    );

    betterPlayerController.setupDataSource(dataSource).then((_) {
      isVideoInitialized.value = true;
    }).catchError((error) {
      print("Video initialization error: $error");
    });
  }

  @override
  void onClose() {
    betterPlayerController.dispose();
    super.onClose();
  }
}
