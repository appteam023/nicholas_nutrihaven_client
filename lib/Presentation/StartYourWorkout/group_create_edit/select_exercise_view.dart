

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/api_constant.dart';

import '../../../Utils/Const/color_const.dart';
import '../../../Utils/Extensions/text_extension.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_dropdown_widget.dart';
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
            if (state.controller?.addNewExerciseData.value == null || state.controller?.addNewExerciseData.value?.exercises == null
                && (state.controller?.addNewExerciseData.value!.exercises!.isEmpty ?? true)) {
              state.controller?.fetchAllExercises();
            }
          });
        },
        builder: (controller) {
          return CustomLoader(
            isLoading: controller.isLoading.value,
            child: Scaffold(
              backgroundColor: secondary,
              appBar: CustomAppBar(
                title: "Select Exercises",
                actionWidget: Row(
                  children: [
                    Visibility(
                      visible: controller.addNewExerciseData.value != null && controller.addNewExerciseData.value?.total != null,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          "${controller.selectedExercises.length}",
                          style: context.titleLarge,
                        ),
                      ),
                    ),
                    IconButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12)),
                        visualDensity: VisualDensity.comfortable,
                        backgroundColor: WidgetStateProperty.all(secondary.withValues(alpha: 0.1)),
                        foregroundColor: WidgetStateProperty.all(secondary),
                        overlayColor: WidgetStateProperty.all(Colors.white12),
                        shape: WidgetStateProperty.all(CircleBorder())
                      ),
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: controller.toggleVisibility,
                    ),
                  ],
                ),
                searchField: controller.searchFieldVisibility.value,
                searchTFCtrl: controller.searchTFCtrl,
                onChanged: (val) {
                  if (val.length >= 2) {
                    if (controller.searchQuery.value == val.trim()) {
                      return;
                    }
                    controller.searchQuery(val);
                  } else if (val.isEmpty) {
                    controller.searchQuery(val);
                  }
                },
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
                              controller.fetchAllExercises(searchQuery: controller.searchTFCtrl.text);
                            }
                          }
                        }
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        return await controller.fetchAllExercises(
                          forceReload: true,
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Exercises",
                                              style: context.headlineSmall!.copyWith(color: primary),
                                            ),
                                            GetBuilder<WorkoutPlanController>(
                                              builder: (controller) {
                                              return CustomDropdownWidget<Map<int, String>>(
                                                dropdownItems: controller.filterExerciseByMuscle,
                                                onChanged: (val) {
                                                  if (val != null && val.isNotEmpty && controller.filterExerciseMuscle.isNotEmpty &&
                                                      val.keys.first != controller.filterExerciseMuscle.keys.first) {
                                                    controller.filterExerciseMuscle = val;
                                                  } else if (val != null && val.isNotEmpty && controller.filterExerciseMuscle.isEmpty) {
                                                    controller.filterExerciseMuscle = val;
                                                  }
                                                  controller.update();
                                                  controller.fetchAllExercises(forceReload: true, searchQuery: controller.searchTFCtrl.text);
                                                },
                                                hint: "Select",
                                                selectedValue: Map<int, String>.from(controller.filterExerciseMuscle),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GetBuilder<WorkoutPlanController>(
                                  builder: (controller) => controller.addNewExerciseData.value?.exercises?.isNotEmpty ?? false ?
                                  SliverList.builder(
                                    itemCount: controller.addNewExerciseData.value?.exercises?.length,
                                    itemBuilder: (context, index) {
                                      final element = controller.addNewExerciseData.value?.exercises?[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (controller.selectedExercises.any((e) => e.id == element?.id)) {
                                              controller.selectedExercises.removeWhere((e) => e.id == element?.id);
                                            } else if (element != null && element.id != null) {
                                              controller.selectedExercises.add(element);
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
                                                    controller.selectedExercises.any((e) => e.id == element?.id) ? 10 : 0
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
                                                    controller.selectedExercises.any((e) => e.id == element?.id) ? Container(
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
                title: "Continue",
                onTap: () {
                  Get.back();
                  // if (!isEditing) {
                  //   controller.createGroup(
                  //     context, selectedExercises: controller.selectedExercises
                  //   );
                  // } else {
                  //   controller.editGroup(
                  //     context, groupID: controller.groupDetails.value?.id,
                  //     groupName: controller.groupDetails.value?.title,
                  //     selectedExercises: controller.selectedExercises,
                  //     onSuccess: () {
                  //       Get.back();
                  //     }
                  //   );
                  // }
                },
              ),
            ),
          );
        }
    );
  }
}
