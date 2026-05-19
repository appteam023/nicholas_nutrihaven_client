import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Data/Model/muscleModel/get_muscle_model.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/WorkoutPlanScreen/widgets/muscle_card_widget.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/WorkoutPlanScreen/widgets/options_bottom_sheet.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/controller/workout_plan_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

import '../../../Data/DataSources/remote/api_constant.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_dropdown_widget.dart';
import '../../../Widgets/image_widget.dart';
import '../../../Widgets/loader_widget.dart';
import 'saved_workout_list_view.dart';

class WorkoutPlan extends StatefulWidget {
  const WorkoutPlan({super.key});

  @override
  State<WorkoutPlan> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlan> {


  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
      init: WorkoutPlanController(),
      builder: (controller) {
        return CustomLoader(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: secondary,
            appBar: _buildAppBar(),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollUpdateNotification) {
                      if (scrollInfo.metrics.axis == Axis.vertical) {
                        if (scrollInfo.metrics.atEdge) {
                          if (scrollInfo.metrics.pixels == 0) {
                            debugPrint("At the top");
                          } else {
                            debugPrint("At the bottom");
                            // controller.fetchExercises(filter: controller.selectedFilter.value);
                          }
                        }
                      }
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return await controller.fetchExercises(forceReload: true, filter: controller.selectedFilter.value);
                    },
                    child: CustomScrollView(
                      slivers: [
                        _buildFilterAndMusclesSection(),
                        GetBuilder<WorkoutPlanController>(
                          id: "exercise-list",
                          builder: (controller) {
                            return _buildExerciseList();
                          }
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(height: 60,),
                        )
                        // _buildExercisesSection(),
                        // _buildExerciseList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: CustomButton(
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              title: "Start Workout",
              onTap: () {
                if (listEquals(controller.selectedSavedWorkout?.exerciseData?.exercises, controller.exerciseData.value?.exercises) &&
                    controller.isSavedWorkOutSelected) {
                  controller.navigateToStartWorkout(controller.selectedSavedWorkout);
                } else {
                  controller.createWorkoutPlan(
                    context, listOfExercises: controller.exerciseData.value?.exercises ?? []
                  );
                }
              },
            ),
          ),
        );
      }
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Your Workout Plan',
      actionWidget: Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: IconButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12)),
            visualDensity: VisualDensity.comfortable,
            backgroundColor: WidgetStateProperty.all(secondary.withValues(alpha: 0.1)),
            overlayColor: WidgetStateProperty.all(Colors.white12),
            shape: WidgetStateProperty.all(CircleBorder())
          ),
          onPressed: () {
            _showBottomSheet(context);
          },
          icon: Icon(
            Icons.more_vert_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 300),
      ),
      builder: (BuildContext context) {
        return OptionsBottomSheet(
          onCreateWorkoutTap: () {
            Get.back();
            Get.find<WorkoutPlanController>().createWorkoutPlan(
              context, listOfExercises: Get.find<WorkoutPlanController>().exerciseData.value?.exercises ?? [],
              saveWorkout: true,
            );
          },
          onSavedWorkoutTap: () {
            Get.back();
            Get.to(()=> SavedWorkoutListView());
          },
        );
      },
    );
  }

  SliverToBoxAdapter _buildFilterAndMusclesSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          _buildFilterTabs(),
          _buildMusclesHeader(),
          _buildMusclesList(),
          _buildExercisesSection(),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final controller = Get.find<WorkoutPlanController>();
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CustomDropdownWidget<String>(
              dropdownItems: controller.filterDuration,
              onChanged: (val) {
                if (val != null && val != controller.selectedFilter.value.duration) {
                  controller.updateFilter(duration: val);
                }
              },
              selectedValue: controller.selectedFilter.value.duration,
            ),
            CustomDropdownWidget<String>(
              dropdownItems: controller.filterLevel,
              onChanged: (val) {
                if (val != null && val != controller.selectedFilter.value.level) {
                  controller.updateFilter(level: val);
                }
              },
              selectedValue: controller.selectedFilter.value.level,
            ),
            CustomDropdownWidget<Map<int, String>>(
              dropdownItems: controller.filterMuscle,
              onChanged: (val) async {
                if (val != null && val.isNotEmpty && controller.selectedFilter.value.muscle.isNotEmpty &&
                    val.keys.first != controller.selectedFilter.value.muscle.keys.first) {
                  await controller.fetchMuscles(forceReload: true, mainMuscle: val.values.first);
                  controller.selectedMuscle.clear();
                  controller.selectedMuscle.addAll(controller.musclesData.value?.muscles ?? []);
                  controller.updateFilter(muscle: val, muscleList: controller.selectedMuscle);
                } else if (val != null && val.isEmpty && controller.selectedFilter.value.muscle.isEmpty) {
                  await controller.fetchMuscles(forceReload: true, mainMuscle: val.values.first);
                  controller.selectedMuscle.clear();
                  controller.selectedMuscle.addAll(controller.musclesData.value?.muscles ?? []);
                  controller.updateFilter(muscle: val, muscleList: controller.selectedMuscle);
                }
              },
              selectedValue: Map<int, String>.from(controller.selectedFilter.value.muscle),
            ),
            CustomDropdownWidget<String>(
              dropdownItems: controller.filterGoal,
              onChanged: (val) {
                if (val != null && val != controller.selectedFilter.value.goal) {
                  controller.updateFilter(goal: val);
                }
              },
              hint: "Goals",
              selectedValue: controller.selectedFilter.value.goal,
            ),
          ]
          // _tabTitles
          //     .asMap()
          //     .entries
          //     .map((entry) => DropdownButtonWidget(list: entry.value))
          //     .toList(),
        ),
      ),
    );
  }

  Widget _buildMusclesHeader() {
    final controller = Get.find<WorkoutPlanController>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${controller.selectedMuscle.length} Targeted Muscles',
            style: context.headlineSmall!.copyWith(color: primary),
          ),
          TextButton(
            onPressed: () async {
              await Get.toNamed(AppRoutes.selectMuscle);
              final newItems = [...controller.selectedMuscle];
              if (listEquals(controller.selectedFilter.value.muscleList, newItems)) return;
              controller.updateFilter(muscleList: [...newItems]);
            },
            child: const Text('Add New Muscles'),
          ),
        ],
      ),
    );
  }

  Widget _buildMusclesList() {
    final ctrl = Get.find<WorkoutPlanController>();
    return Obx(() {
      final response = ctrl.selectedMuscle.length;
      switch (response) {
        case 0:
          return const SizedBox(height: 10,);

        default:
          return SizedBox(
            height: 90.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: ctrl.selectedMuscle.length,
              itemBuilder: (context, index) =>
                  _buildMuscleCard(
                    index, ctrl.selectedMuscle[index], () {
                      ctrl.selectedMuscle.removeAt(index);
                      ctrl.fetchExercises(forceReload: true, filter: ctrl.selectedFilter.value);
                    }
                  ),
              separatorBuilder: (context, index) => SizedBox(width: 7.w),
            ),
          );
      }
    });
  }

  Widget _buildMuscleCard(int index, Muscle muscle, VoidCallback onRemove) {
    return MuscleCardWidget(
      muscleName: muscle.name ?? 'Unknown',
      imageUrl: muscle.muscleImage != null ?
      "${ApiConstants.baseUrl}${muscle.muscleImage}"  : ImageConst.abs,
      onRemove: onRemove,
    );
  }

  Widget _buildExercisesSection() {
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
                        controller.exerciseData.value != null ?
                        "${controller.exerciseData.value?.exercises?.length ?? ""}"
                            " Exercises"
                        : "Exercises",
                        style: context.headlineSmall!.copyWith(color: primary),
                        maxLines: 2,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        // controller.selectedExercises.clear();
                        await Get.toNamed(AppRoutes.selectExercise, arguments: {
                          "isEditing": true,
                        });
                        if (controller.selectedExercises.isEmpty) return;
                        // controller.exerciseData.value!.exercises?.addAllIf(
                        //     controller.selectedExercises.where(
                        //     (ex) => !controller.exerciseData.value!.exercises!.any((e) => e.id == ex.id),
                        //   ),
                        //   controller.selectedExercises
                        // );
                        for (var ex in controller.selectedExercises) {
                          bool exists = controller.exerciseData.value!.exercises?.any((e) => e.id == ex.id) ?? false;

                          if (!exists) {
                            controller.exerciseData.value!.exercises?.add(ex);
                          }
                        }
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

  Widget _buildExerciseList() {
    final controller = Get.find<WorkoutPlanController>();
    final isListEmpty = controller.exerciseData.value == null || (controller.exerciseData.value!.exercises?.isEmpty ?? false);
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildExerciseItem(index),
        childCount: controller.exerciseData.value!.exercises?.length,
      ),
    );
  }

  Widget _buildExerciseItem(int index) {
    final controller = Get.find<WorkoutPlanController>();
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        extentRatio: 0.6,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              // controller.selectedExercises.clear();
              await Get.toNamed(AppRoutes.selectExercise, arguments: {
                "isEditing": true,
              });
              if (controller.selectedExercises.isEmpty) return;
              controller.exerciseData.value!.exercises?.removeAt(index);
              // controller.exerciseData.value!.exercises?.insertAll(index, controller.selectedExercises);
              for (var ex in controller.selectedExercises) {
                bool exists = controller.exerciseData.value!.exercises?.any((e) => e.id == ex.id) ?? false;

                if (!exists) {
                  controller.exerciseData.value!.exercises?.insert(index, ex);
                }
              }
              controller.update(["exercise-list"]);
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
              controller.exerciseData.value!.exercises?.removeWhere(
                (e)=> e.id == controller.exerciseData.value!.exercises![index].id
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
          controller.selectedExercise.value = controller.exerciseData.value!.exercises![index];
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
              Expanded(child: _buildExerciseDetails(index)),
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
                "${Get.find<WorkoutPlanController>().exerciseData.value!.exercises![index].exerciseImage}",
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

  Widget _buildExerciseDetails(int index) {
    return GetBuilder<WorkoutPlanController>(
      builder: (controller)=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              "${controller.exerciseData.value!.exercises![index].name?.capitalizeFirst}",
              style: context.titleMedium!.copyWith(color: primary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (controller.exerciseData.value!.exercises![index].defaultSets?.isNotEmpty ?? false)
          Text(
            "${controller.exerciseData.value!.exercises![index].defaultSets?.length }"
                " SET(S) \u2022 ${controller.exerciseData.value!.exercises![index].defaultSets?.fold(0, (sum, e) => sum + (e.reps ?? 0))} REP(S)",
            style: context.bodySmall!.copyWith(color: darkGrey),
          ),
        ],
      ),
    );
  }

  // Widget _buildStartWorkoutButton() {
  //   return CustomButton(
  //     width: 1.sw - horizontalPadding,
  //     title: 'Start Workout',
  //     onTap: () => setState(() => _isStartTimer = true),
  //   );
  // }
}
