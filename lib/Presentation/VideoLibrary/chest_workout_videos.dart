import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/datetime_extension.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

import '../../Config/AppRoutes/routes_imports.dart';
import 'video_library_controller.dart';
import 'work_out_video_controller.dart';

class ChestWorkoutVideos extends StatelessWidget {
  const ChestWorkoutVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<WorkOutVideoController>(
      init: WorkOutVideoController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            leadingIcon: Icons.arrow_back,
            onLeadingPressed: () {
              Get.back();
            },
            actionIcon: Icons.search,
            title: '${Get.find<VideoLibraryController>().selectedCategory?.categoryName} Workout Videos',
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.workoutVideos.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 20.h), // Add space between items
                        child: InkWell(
                          onTap: () {
                            controller.selectedVideo = controller.workoutVideos[index];
                            Get.toNamed(AppRoutes.chestAndTriceps);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  controller.workoutVideos[index].categoryImage ?? "",
                                  width: 160.w,
                                  height: 95.h,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Image.asset(
                                      "assets/images/v2.png",
                                      width: 160.w,
                                      height: 95.h,
                                      fit: BoxFit.cover,
                                    );
                                  }
                                ),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.workoutVideos[index].workoutVideosTitle ?? "",
                                      style: context.titleLarge!.copyWith(
                                        color: black,
                                        fontFamily: 'Inter'
                                      ),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      "NutriHaven",
                                      style: context.labelSmall!.copyWith(
                                        color: black.withValues(alpha: 0.5)
                                      ),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      controller.workoutVideos[index].createdAt?.toDateTime?.timeAgo ?? "",
                                      style: context.labelSmall!.copyWith(
                                        color: black.withValues(alpha: 0.5)
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
