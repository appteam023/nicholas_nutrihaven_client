

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/api_constant.dart';

import '../../../Utils/Const/color_const.dart';
import '../../../Utils/Extensions/text_extension.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/image_widget.dart';
import '../../../Widgets/loader_widget.dart';
import '../controller/workout_plan_controller.dart';

class SelectExerciseView extends StatelessWidget {
  const SelectExerciseView({
    super.key,
    this.isEditing = false,
  });

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
        init: Get.find<WorkoutPlanController>(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            state.controller?.fetchExercises(
              muscleId: state.controller?.selectedMuscle.value?.id
            );
          });
        },
        builder: (controller) {
          return CustomLoader(
            isLoading: controller.isLoading.value,
            child: Scaffold(
              backgroundColor: secondary,
              appBar: CustomAppBar(
                title: "Select Exercises",
                actionWidget: Visibility(
                  visible: controller.exerciseData.value != null && controller.exerciseData.value?.total != null,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      "${controller.selectedExercises.length}/${controller.exerciseData.value?.total}",
                      style: context.titleLarge,
                    ),
                  ),
                ),
              ),
              body: SafeArea(
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
                              controller.fetchExercises(muscleId: controller.selectedMuscle.value?.id);
                            }
                          }
                        }
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        return await controller.fetchExercises(
                          forceReload: true, muscleId: controller.selectedMuscle.value?.id
                        );
                      },
                      child: CustomScrollView(
                        slivers: [
                          SliverMainAxisGroup(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0, bottom: 14),
                                        child: Text(
                                          "Pick the exercises you want to add in the workout group.",
                                          style: context.bodyMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 14.0),
                                        child: Text(
                                          "${controller.selectedMuscle.value?.name} Exercises",
                                          style: context.headlineSmall!.copyWith(color: primary),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GetBuilder<WorkoutPlanController>(
                                  builder: (controller) => controller.exerciseData.value?.exercises?.isNotEmpty ?? false ?
                                  SliverList.builder(
                                    itemCount: controller.exerciseData.value?.exercises?.length,
                                    itemBuilder: (context, index) {
                                      final element = controller.exerciseData.value?.exercises?[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (controller.selectedExercises.contains(element?.id)) {
                                              controller.selectedExercises.remove(element?.id);
                                            } else if (element != null && element.id != null) {
                                              controller.selectedExercises.add(element.id!);
                                            }
                                            controller.update();
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(
                                                    controller.selectedExercises.contains(element?.id) ? 10 : 0
                                                  ),
                                                ),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: ImageWidget(
                                                        isNetworkImage: true,
                                                        imageUrl: "${ApiConstants.baseUrl}${element?.exerciseImage}",
                                                        height: 100,
                                                        width: 100,
                                                      ),
                                                    ),
                                                    controller.selectedExercises.contains(element?.id) ? Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: yellow.withValues(alpha: 0.5)
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                          color: themeColor,
                                                          borderRadius:
                                                          BorderRadius.circular(8),
                                                        ),
                                                        child: const Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ) : const SizedBox.shrink(),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text(
                                                    "${element?.name}",
                                                    style: context.bodyMedium!.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      color: primary,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  ) : SliverToBoxAdapter(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30.0),
                                        child: Text(
                                          'No Exercises Found',
                                          style: context.bodyLarge?.copyWith(
                                            fontSize: 18
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: controller.selectedExercises.isEmpty ? null : CustomButton(
                margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                title: isEditing
                    ? "Edit Workout Group"
                    : "Create Workout Group",
                onTap: () {
                  if (!isEditing) {
                    controller.createGroup(
                      context, selectedExercises: controller.selectedExercises
                    );
                  } else {
                    controller.editGroup(
                      context, groupID: controller.groupDetails.value?.id,
                      groupName: controller.groupDetails.value?.title,
                      selectedExercises: controller.selectedExercises,
                      onSuccess: () {
                        Get.back();
                      }
                    );
                  }
                },
              ),
            ),
          );
        }
    );
  }
}
