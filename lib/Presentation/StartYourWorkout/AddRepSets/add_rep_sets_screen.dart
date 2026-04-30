
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';

import '../../../Config/AppRoutes/routes_imports.dart';
import '../../../Data/Model/ExcerciseModel/get_exercise_model.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/loader_widget.dart';
import '../WorkoutPlanScreen/workout_controller.dart';
import '../controller/workout_plan_controller.dart';
import '../group_details_view/group_details_view.dart';

class AddRepSetsScreen extends StatelessWidget {
  const AddRepSetsScreen({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
      builder: (controller) => CustomLoader(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: secondary,
          appBar: CustomAppBar(
            title: "${controller.selectedExercise.value?.name?.capitalizeFirst}",
            actionWidget: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: IconButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(14)),
                  visualDensity: VisualDensity.comfortable,
                  backgroundColor: WidgetStateProperty.all(secondary.withValues(alpha: 0.1)),
                  overlayColor: WidgetStateProperty.all(Colors.white12),
                  shape: WidgetStateProperty.all(CircleBorder())
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.repWeightsSetting);
                },
                icon: Icon(
                  Icons.settings,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            // actionImage: InkWell(
            //   onTap: () {
            //     Get.toNamed(AppRoutes.instructionVideo);
            //   },
            //   child: const Icon(
            //     Icons.play_arrow,
            //     color: Colors.white,
            //   ),
            // ),
            // actionImageBG: secondary.withOpacity(0.1),
          ),
          body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: verticalPadding),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Divider(color: grey)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: GetBuilder<WorkoutPlanController>(
                            builder: (controller) => Text(
                              "${controller.selectedExercise.value?.defaultSets?.length} Set(s)",
                              style: context.labelSmall!.copyWith(
                                  fontWeight: FontWeight.bold, color: darkTheme),
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: Divider(color: grey)),
                      ],
                    ),
                  ),
                  GetBuilder<WorkoutPlanController>(
                    builder: (controller) => Column(
                      children: [
                        ...controller.selectedExercise.value?.defaultSets?.mapIndexed((i, e) => Container(
                          width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.only(
                            left: horizontalPadding * 1.2,
                            top: 14,
                            bottom: 14,
                            right: 10
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: controller.selectedExercise.value?.defaultSets?[i].isCompleted ?? false ? themeColor :
                              grey.withValues(alpha: 0.5)
                            ),
                            color: controller.selectedExercise.value?.defaultSets?[i].isCompleted ?? false ? themeColor.withValues(alpha: 0.1) :
                            Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getOrdinal(i)} Set",
                                    style: context.labelSmall?.copyWith(fontWeight: FontWeight.bold, color: yellow),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showPicker(context, e.reps ?? 1, (value) {
                                            e.reps = value;
                                            controller.update();
                                          });
                                        },
                                        child: Text(
                                          "${e.reps} Reps",
                                          style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                                        ),
                                      ),
                                      Text(
                                        "  /  ",
                                        style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showPicker(context, e.weight ?? 1, (value) {
                                            e.weight = value;
                                            controller.update();
                                          });
                                        },
                                        child: Text(
                                          "${e.weight} Kilos",
                                          style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              if (Get.isRegistered<WorkOutController>())
                                IconButton(
                                  onPressed: () {
                                    showBottomSheet(context,[
                                      if (Get.isRegistered<WorkOutController>()) ...[
                                        if (controller.selectedExercise.value?.defaultSets?[i].isCompleted == false)
                                          CustomOptionsBottomSheet.buildBottomSheetItem(
                                            Icons.done, "Mark Set Complete",
                                            onTap: () {
                                              Get.back();
                                              controller.selectedExercise.value?.defaultSets?[i].isCompleted = true;
                                              controller.update();
                                            }
                                          )
                                        else
                                          CustomOptionsBottomSheet.buildBottomSheetItem(
                                            Icons.undo, "Mark Set InComplete",
                                            onTap: () {
                                              Get.back();
                                              controller.selectedExercise.value?.defaultSets?[i].isCompleted = false;
                                              controller.update();
                                            }
                                          ),
                                        ],
                                      if (i > 0)
                                      CustomOptionsBottomSheet.buildBottomSheetItem(
                                        Icons.delete, "Delete Set",
                                        onTap: () {
                                          Get.back();
                                          controller.selectedExercise.value?.defaultSets?.removeAt(i);
                                          controller.update();
                                        }
                                      ),
                                    ]);
                                  },
                                  icon: Icon(Icons.more_vert)
                                )
                              else if (i > 0)
                                IconButton(
                                    onPressed: () {
                                      showBottomSheet(context,[
                                        CustomOptionsBottomSheet.buildBottomSheetItem(
                                          Icons.delete, "Delete Set",
                                          onTap: () {
                                            Get.back();
                                            controller.selectedExercise.value?.defaultSets?.removeAt(i);
                                            controller.update();
                                          }
                                        ),
                                      ]);
                                    },
                                    icon: Icon(Icons.more_vert)
                                ),

                            ],
                          ),
                        )).toList() ?? [],
                      ]
                    )
                  ),

                  20.verticalSpace,
                  SizedBox(
                    width: 120.w,
                    child: CustomButton(
                      title: "+ Add Sets",
                      onTap: () {
                        controller.selectedExercise.value?.defaultSets?.add(
                          DefaultSets(
                            set: controller.selectedExercise.value?.defaultSets?.length ?? 0,
                            reps: controller.globalReps.value,
                            weight: controller.globalWeight.value,
                          ),
                        );
                        controller.update();
                      },
                    ),
                  ),
                  20.verticalSpace,
                  if (controller.selectedExercise.value?.workoutVideo != null)
                  InkWell(
                    onTap: () {
                      Get.to(()=> VideoPlayer(
                        exerciseName: controller.selectedExercise.value?.name,
                        videoTitle: controller.selectedExercise.value?.workoutVideo?.workoutVideosTitle,
                        videoUrl: controller.selectedExercise.value?.workoutVideo?.workoutVideosCdnUrl ?? "",
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding*2,),
                      decoration: BoxDecoration(
                        color: grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Follow & Watch Now",
                                style: context.labelSmall!
                                    .copyWith(fontWeight: FontWeight.bold, color: yellow),
                              ),
                              Text(
                                "Instructions & Videos",
                                style: context.labelLarge!
                                    .copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: yellowText,
                            child: Icon(Icons.play_arrow,color: Colors.white,),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showPicker(BuildContext context, int selectedNumber, Function(int) onChange) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select",
                      style: context.labelLarge?.copyWith(),
                    ),
                  ),
                  CupertinoButton(
                    child: Text("Done"),
                    onPressed: () {
                      onChange(selectedNumber);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedNumber,
                  ),
                  onSelectedItemChanged: (index) {
                    selectedNumber = index;
                  },
                  children: List.generate(101, (index) {
                    return Center(child: Text(index.toString()));
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showBottomSheet(BuildContext context, List<Widget> options) {
    showModalBottomSheet<void>(
      context: context,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 300),
      ),
      builder: (BuildContext context) {
        return CustomOptionsBottomSheet(
          options: options
        );
      },
    );
  }

  String getOrdinal(int index) {
    final number = index + 1;

    if (number % 100 >= 11 && number % 100 <= 13) {
      return '${number}th';
    }

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }
}

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
    required this.exerciseName,
    required this.videoTitle,
    required this.videoUrl,
  });

  final String? exerciseName;
  final String? videoTitle;
  final String videoUrl;


  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  late BetterPlayerController betterPlayerController;
  final RxBool isVideoInitialized = false.obs;
  final RxBool isVideoPlaying = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeVideo(widget.videoUrl);
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
      debugPrint("Video initialization error: $error");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "${widget.exerciseName}",
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child:
                Obx(() {
                  if (isVideoInitialized.value) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(controller: betterPlayerController),
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.videoTitle}',
                        style: context.titleLarge!.copyWith(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp
                        ),
                      ),
                      8.verticalSpace,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

