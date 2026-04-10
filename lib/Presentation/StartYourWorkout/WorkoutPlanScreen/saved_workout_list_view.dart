

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../Utils/Const/asset_const.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Utils/Extensions/text_extension.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/loader_widget.dart';
import '../controller/workout_plan_controller.dart';
import '../group_details_view/group_details_view.dart';

class SavedWorkoutListView extends StatelessWidget {
  const SavedWorkoutListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
      init: Get.find<WorkoutPlanController>(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller?.fetchWorkoutPlanList();
        });
      },
      builder: (controller) {
        return CustomLoader(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: secondary,
            appBar: CustomAppBar(
              title: "Saved Workout",
            ),
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollUpdateNotification) {
                        if (scrollInfo.metrics.axis == Axis.vertical) { //
                          if (scrollInfo.metrics.atEdge) {
                            if (scrollInfo.metrics.pixels == 0) {
                              debugPrint("At the top");
                            } else {
                              debugPrint("At the bottom");
                              controller.fetchWorkoutPlanList();
                            }
                          }
                        }
                      }
                      return true;
                    },
                    child: controller.workoutData.value != null && controller.workoutData.value!.workouts!.isNotEmpty ?
                    GetBuilder<WorkoutPlanController>(
                      id: "saved-workout-list",
                      builder: (controller) => RefreshIndicator(
                        onRefresh: () async {
                          return await controller.fetchWorkoutPlanList(forceReload: true,);
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.workoutData.value!.workouts!.length,
                          itemBuilder: (context, index) {
                            var element = controller.workoutData.value!.workouts![index];
                            return Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.3,
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (ctx) {
                                      controller.deleteGroup(context, workoutID: element.id);
                                    },
                                    icon: CupertinoIcons.delete,
                                    label: 'Delete',
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.pinkAccent,
                                    spacing: 5,
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  controller.getGroupDetails(workout: element);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 30.h),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Image.asset(
                                            ImageConst.signIn2,
                                            width: 70.w,
                                            height: 100.h,
                                            fit: BoxFit.contain,
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
                                      SizedBox(width: 20.w),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "${element.name}",
                                                style: context.titleMedium!.copyWith(color: primary),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            Text(
                                              "No of exercises: ${element.exerciseData?.total}",
                                              style: context.bodySmall!.copyWith(color: grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            sheetAnimationStyle: AnimationStyle(
                                              duration: const Duration(milliseconds: 500),
                                              reverseDuration: const Duration(milliseconds: 300),
                                            ),
                                            builder: (BuildContext context) {
                                              return CustomOptionsBottomSheet(
                                                options: [
                                                  CustomOptionsBottomSheet.buildBottomSheetItem(
                                                    Icons.edit, "Edit Group",
                                                    onTap: () {
                                                      Get.back();
                                                      controller.editGroup(
                                                        context,
                                                        workoutID: element.id,
                                                        workoutName: element.name,
                                                      );
                                                    }
                                                  ),
                                                ]
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.more_vert)
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      ),
                    ) : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          'No Saved Workout Plan Found',
                          style: context.bodyLarge?.copyWith(
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: controller.selectedMuscle.isEmpty ? null : CustomButton(
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              title: "Continue",
              onTap: () {
                Get.back();
              },
            ),
          ),
        );
      }
    );
  }
}
