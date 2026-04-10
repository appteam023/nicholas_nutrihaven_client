

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';


import '../../../Config/AppRoutes/routes_imports.dart';
import '../../../Data/DataSources/remote/api_constant.dart';
import '../../../Utils/Const/asset_const.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/image_widget.dart';
import '../../../Widgets/loader_widget.dart';
import '../WorkoutPlanScreen/workout_controller.dart';
import '../controller/workout_plan_controller.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
      init: Get.find<WorkoutPlanController>(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller?.workoutExercise = null;
          state.controller?.isStartTimer.value = false;
        });
      },
      builder: (controller) {
        return CustomLoader(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: secondary,
            appBar: CustomAppBar(
              title: "Workout Group Details",
              actionWidget: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.workoutLogs,);
                },
                icon: Icon(Icons.file_open, color: secondary,)
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.isStartTimer.value)
                      buildTimerSection(context),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20.h),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minTileHeight: 100,
                        minVerticalPadding: 0,
                        leading: SizedBox(
                          child: Stack(
                            children: [
                              Image.asset(
                                ImageConst.signIn2,
                                width: 80.w,
                                height: 100.h,
                                fit: BoxFit.fitHeight,
                              ),
                              Positioned(
                                bottom: -10.h,
                                right: -10.w,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: primary,
                                  ),
                                  child: Image.asset(
                                    ImageConst.bicep,
                                    height: 40.h,
                                    width: 40.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          "${controller.groupDetails.value?.title}",
                          style: context.headlineSmall!.copyWith(color: primary),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showBottomSheet(context,[
                              CustomOptionsBottomSheet.buildBottomSheetItem(
                                Icons.edit, "Edit Group",
                                onTap: () {
                                  Get.back();
                                  // controller.editGroup(
                                  //   context,
                                  //   groupID: controller.groupDetails.value?.id,
                                  //   groupName: controller.groupDetails.value?.title,
                                  //   selectedExercises: controller.groupDetails.value?.groupExercises?.map(
                                  //       (element) => element.masterExerciseId!).toList() ?? []
                                  // );
                                }
                              ),
                              CustomOptionsBottomSheet.buildBottomSheetItem(
                                Icons.edit, "Add Exercise",
                                onTap: () {
                                  Get.back();
                                  controller.updateExercisesInGroup(
                                    context,
                                    groupID: controller.groupDetails.value?.id,
                                    groupName: controller.groupDetails.value?.title,
                                    muscleID: (controller.groupDetails.value?.groupExercises?.isNotEmpty ?? false)
                                        ? controller.groupDetails.value?.groupExercises?.first.masterExercise?.muscleGroupId
                                        : null,
                                    selectedExercises: controller.groupDetails.value?.groupExercises?.map(
                                      (element) => element.masterExerciseId!).toList() ?? []
                                  );
                                }
                              ),
                            ]);
                          },
                          icon: Icon(Icons.more_vert)
                        )
                      )
                    ),
                    Text(
                      "Exercises:",
                      style: context.headlineSmall!.copyWith(color: primary),
                    ),
                    ...controller.groupDetails.value?.groupExercises?.map((element) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ImageWidget(
                                isNetworkImage: true,
                                imageUrl: "${ApiConstants.baseUrl}${element.masterExercise?.exerciseImage}",
                                height: 100,
                                width: 100,
                              ),
                            ),
                            title: Text(
                              "${element.masterExercise?.name}",
                              style: context.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                showBottomSheet(context, [
                                  CustomOptionsBottomSheet.buildBottomSheetItem(
                                    Icons.play_arrow, "Start WorkOut",
                                    onTap: () {
                                      Get.back();
                                      if (controller.isStartTimer.value || controller.workoutExercise != null) {
                                        return;
                                      }
                                      controller.workoutExercise = element;
                                      controller.isStartTimer.value = true;
                                    }
                                  ),
                                  CustomOptionsBottomSheet.buildBottomSheetItem(
                                    Icons.delete, "Remove Exercise",
                                    onTap: () {
                                      Get.back();
                                      controller.deleteGroupExercise(
                                        context, exerciseID:  element.id,
                                        groupID: element.groupId
                                      );
                                    }
                                  ),
                                ]);
                              },
                              icon: Icon(Icons.more_vert)
                            )
                          ),
                        )
                    ) ?? []
                  ],
                ),
              ),
            ),
          ),
        );
      }
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

  Widget buildTimerSection(BuildContext context) {
    return SizedBox(
      child: GetBuilder<WorkOutController>(
          init: Get.isRegistered<WorkOutController>() ?
          Get.find<WorkOutController>() : WorkOutController(),
          initState: (state) {
            // state.controller?.startTimer();
          },
          builder: (controller) {
            return Container(
              margin: EdgeInsets.only(top: verticalPadding * 2),
              padding: EdgeInsets.all(horizontalPadding * 2),
              decoration: BoxDecoration(
                color: darkTheme,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.isRunning) {
                        controller.pauseTimer();
                      } else {
                        controller.startTimer();
                      }
                    },
                    child: _buildTimerAvatar(controller.isRunning)
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Text(
                      controller.formatTime(controller.secondsElapsed),
                      style: context.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      Get.find<WorkoutPlanController>().isStartTimer.value = false;
                      //   _isStartTimer = false;
                      // });
                      // Get.find<WorkoutPlanController>().logEndWorkoutTime(context,
                      //   controller.startTime?.add(Duration(seconds: controller.secondsElapsed))
                      // );
                      controller.resetTimer();
                    },
                    child: CircleAvatar(
                      backgroundColor: yellowText,
                      child: const Icon(Icons.stop, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  Widget _buildTimerAvatar(bool isRunning) {
    return CircleAvatar(
      backgroundColor: isRunning ? Colors.red : Colors.yellow,
      radius: 16.r,
      child: CircleAvatar(
        radius: 14.r,
        backgroundColor: darkTheme,
        child: isRunning ? CircleAvatar(
          radius: 10.r,
          backgroundColor: Colors.red,
        ) : Icon(Icons.play_arrow, color: Colors.yellow,),
      ),
    );
  }
}

class CustomOptionsBottomSheet extends StatelessWidget {
  const CustomOptionsBottomSheet({
    super.key,
    required this.options
  });

  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding, vertical: verticalPadding * 2
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...options.expand((widget) => [
            widget,
            _buildDivider(),
          ]).toList()..removeLast(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  static Widget buildBottomSheetItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(title),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: grey.withValues(alpha: 0.2),
      height: 1.2,
    );
  }
}