import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Presentation/VideoLibrary/videos_controller/videos_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/datetime_extension.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';

import '../../Config/AppRoutes/routes_imports.dart';
import 'work_out_video_controller.dart';

class ChestTriceps extends StatefulWidget {
  const ChestTriceps({super.key});

  @override
  State<ChestTriceps> createState() => _ChestTricepsState();
}

class _ChestTricepsState extends State<ChestTriceps> {
  bool isSwitched = false;


  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(VideoController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF093538),
        elevation: 0,
        leadingWidth: 56.w + horizontalPadding,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin:
            EdgeInsets.only(left: horizontalPadding, bottom: 5.h, top: 5.h),
            decoration: BoxDecoration(
              color: secondary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(100.r),
            ),
            child: Icon(
              Icons.adaptive.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
            '${Get.find<WorkOutVideoController>().selectedVideo?.categoryName}',
            style: context.headlineSmall!.copyWith(fontSize: 24.sp)
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: secondary.withValues(alpha: 0.1),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: secondary,
                    ),
                  )
                ),
                8.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.addTag);
                  },
                  child: CircleAvatar(
                    radius: 28.r,
                    backgroundColor: secondary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.tag,
                      size: 30,
                      color: secondary,
                    )
                  ),
                ),
                10.horizontalSpace
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child:

              // Stack(
              //     children: [
              //   Image.asset(
              //     ImageConst.v2,
              //     height: 231.h,
              //     width: 397.w,
              //     fit: BoxFit.fill,
              //   ),
              //   Positioned(
              //       top: 0,
              //       child: Container(
              //         height: 231.h,
              //         width: 397.w,
              //         decoration: BoxDecoration(
              //             color: black.withOpacity(0.8),
              //             borderRadius: BorderRadius.circular(30.r)),
              //       )),
              //   Positioned(
              //       top: 0,
              //       child: Container(
              //         height: 231.h,
              //         width: 397.w,
              //         child: Image.asset(ImageConst.vPlay),
              //       ))
              // ]),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child:
                Obx(() {
                  if (videoController.isVideoInitialized.value) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(controller: videoController.betterPlayerController),
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 231.h,
                      width: double.infinity,

                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                })

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${Get.find<WorkOutVideoController>().selectedVideo?.workoutVideosTitle}',
                      style: context.titleLarge!.copyWith(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp
                      ),),
                      8.verticalSpace,
                      Text(
                        '925.497 views . ${Get.find<WorkOutVideoController>().selectedVideo?.createdAt.toDateTime?.timeAgo}',
                        style: context.labelMedium!.copyWith(
                            color: black.withValues(alpha: 0.5)
                        ),
                      ),
                    ],
                  ),
                  CustomButton(title: 'Instructions',
                  height: 50.h,
                  width: 154.w,)
                ],
              ),
            ),
            Divider(
              color: grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  Text('Up Next',
                  style: context.headlineSmall!.copyWith(
                    color: black
                  ),),
                  Spacer(),
                  Text('Autoplay',
                    style: context.labelMedium!.copyWith(
                        color: black.withValues(alpha: 0.5)
                    ),),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      activeColor: Colors.blue,
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: Get.find<WorkOutVideoController>().workoutVideos.length > 1,
              replacement: Center(child: Text("Not Available"),),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: ListView.builder(
                    itemCount: Get.find<WorkOutVideoController>().workoutVideos.length - 1,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 20.h), // Add space between items
                      child: InkWell(
                        onTap: (){
                          Get.toNamed(AppRoutes.chestAndTriceps);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  Get.find<WorkOutVideoController>().workoutVideos[index].categoryImage ?? "",
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
                                    Get.find<WorkOutVideoController>().workoutVideos[index].workoutVideosTitle ?? "",
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
                                    Get.find<WorkOutVideoController>().workoutVideos[index].createdAt?.toDateTime?.timeAgo ?? "",
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
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class Videos {
  String image;
  String title;
  String subTitle;
  String viewsDays;

  Videos({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.viewsDays,
  });
}

