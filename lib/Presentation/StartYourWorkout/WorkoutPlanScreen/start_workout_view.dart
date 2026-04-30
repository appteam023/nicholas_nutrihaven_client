

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../Config/AppRoutes/routes_imports.dart';
import '../../../Data/DataSources/remote/api_constant.dart';
import '../../../Utils/Const/asset_const.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Utils/Extensions/text_extension.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_snackbar.dart';
import '../../../Widgets/image_widget.dart';
import '../../../Widgets/loader_widget.dart';
import '../controller/workout_plan_controller.dart';
import 'workout_controller.dart';

class StartWorkoutView extends StatelessWidget {
  const StartWorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
      init: Get.find<WorkoutPlanController>(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller?.isStartTimer.value = true;
        });
      },
      builder: (controller) {
        return CustomLoader(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: secondary,
            appBar: CustomAppBar(
              title: "Start Workout",
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: CustomScrollView(
                  slivers: [
                    if (controller.isStartTimer.value)
                      SliverToBoxAdapter(child: buildTimerSection(context)),
                    SliverToBoxAdapter(
                      child: _buildExercisesSection(context),
                    ),
                    _buildExerciseList(context),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        );
      }
    );
  }

  Widget _buildExercisesSection(BuildContext context) {
    return GetBuilder<WorkoutPlanController>(
      id: "exercise-list",
      builder: (controller) {
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: verticalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '${controller.workoutPlan.value?.exerciseData?.total?? ""} Exercises',
                        style: context.headlineSmall!.copyWith(color: primary),
                        maxLines: 2,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        controller.selectedExercises.clear();
                        await Get.toNamed(AppRoutes.selectExercise, arguments: {
                          "isEditing": true,
                        });
                        if (controller.selectedExercises.isEmpty) return;
                        controller.workoutPlan.value?.exerciseData?.exercises?.addAll(controller.selectedExercises);
                        controller.update(["exercise-list"]);
                      },
                      child: const Text('Add New Exercises'),
                    ),
                  ],
                ),
              ),
              // const Text('Superset • 4 Rounds'),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }
    );
  }

  Widget _buildExerciseList(BuildContext context) {
    final controller = Get.find<WorkoutPlanController>();
    final isListEmpty = controller.workoutPlan.value == null || (controller.workoutPlan.value?.exerciseData?.exercises?.isEmpty ?? true);
    if(isListEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            "No Exercises Found",
            style: context.headlineSmall!.copyWith(color: primary),
          ),
        ),
      );
    }
    return GetBuilder<WorkoutPlanController>(
      id: "exercise-list",
      builder: (controller)=> SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildExerciseItem(context, index),
          childCount: controller.workoutPlan.value?.exerciseData?.exercises?.length,
        ),
      ),
    );
  }

  Widget _buildExerciseItem(BuildContext context, int index) {
    final controller = Get.find<WorkoutPlanController>();
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        extentRatio: 0.6,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {

            },
            icon: CupertinoIcons.repeat,
            label: 'Replace',
            backgroundColor: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              bottomLeft: Radius.circular(25.r),
            ),
            spacing: 5,
          ),
          SlidableAction(
            onPressed: (context) {
              controller.workoutPlan.value?.exerciseData?.exercises?.removeWhere(
                (e)=> e.id == controller.workoutPlan.value?.exerciseData?.exercises![index].id
              );
              // controller.exerciseData.value!.total = (controller.exerciseData.value!.total ?? 1) - 1;
              controller.update(["exercise-list"]);
            },
            icon: CupertinoIcons.delete,
            label: 'Delete',
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFD93E68),
            spacing: 5,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          controller.selectedExercise.value = controller.workoutPlan.value?.exerciseData?.exercises![index];
          Get.toNamed(AppRoutes.addRepSet);
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildExerciseImage(index),
              SizedBox(width: 20.w),
              Expanded(child: _buildExerciseDetails(context, index)),
              Icon(Icons.more_horiz, color: grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseImage(int index) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageWidget(
            isNetworkImage: true,
            imageUrl: "${ApiConstants.baseUrl}"
              "${Get.find<WorkoutPlanController>().workoutPlan.value?.exerciseData?.exercises![index].exerciseImage}",
            height: 85,
            width: 75,
          ),
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
    );
  }

  Widget _buildExerciseDetails(BuildContext context, int index,) {
    return GetBuilder<WorkoutPlanController>(
      builder: (controller)=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              "${controller.workoutPlan.value?.exerciseData?.exercises![index].name?.capitalizeFirst}",
              style: context.titleMedium!.copyWith(color: primary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (controller.workoutPlan.value?.exerciseData?.exercises![index].defaultSets?.isNotEmpty ?? false)
            Text(
              "${controller.workoutPlan.value?.exerciseData?.exercises![index].defaultSets?.length }"
                  " SET(S) \u2022 ${controller.workoutPlan.value?.exerciseData?.exercises![index].defaultSets?.fold(0, (sum, e) => sum + (e.reps ?? 0))} REP(S)",
              style: context.bodySmall!.copyWith(color: darkGrey),
            ),
        ],
      ),
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
                  onTap: () async {
                    Get.find<WorkoutPlanController>().isStartTimer.value = false;
                    bool res = await Get.find<WorkoutPlanController>().logEndWorkoutTime(
                      context,
                      controller.startTime,
                      controller.startTime?.add(Duration(seconds: controller.secondsElapsed))
                    );
                    if (res) {
                      Get.back();
                      controller.resetTimer();
                    } else if (context.mounted) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          message: "Error, Workout Time not saved",
                        ),
                      );
                    }
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
