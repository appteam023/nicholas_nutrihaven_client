import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Data/Model/muscleModel/get_muscle_model.dart';
import 'package:nicholas_nutrihaven/Data/response/status.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/WorkoutPlanScreen/widgets/muscle_card_widget.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/WorkoutPlanScreen/widgets/options_bottom_sheet.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/controller/workout_plan_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import 'package:nicholas_nutrihaven/Widgets/dropdown_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Widgets/loader_widget.dart';
import '../group_details_view/group_details_view.dart';
import 'workout_controller.dart';

class WorkoutPlan extends StatefulWidget {
  const WorkoutPlan({super.key});

  @override
  State<WorkoutPlan> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlan> {
  final int selectedTabIndex = 0;
  bool _isStartTimer = false;
  final WorkoutPlanController _controller = Get.put(WorkoutPlanController());

  final List<List<String>> _tabTitles = [
    ['1hr', '2hr', '3hr'],
    ['Beginner', 'Intermediate', 'Expert'],
    ['Fresh Muscles'],
    ['All Exercises'],
    ['Bodybuilding'],
  ];

  final List<Map<String, String>> _exerciseList = [
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicepbg,
      'title': 'Dumbbell Bicep Curl',
      'subtitle': '4 SETS • 10 REPS • 8 KG',
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': 'Hip Thrust',
      'subtitle': '4 SETS • 4 REPS',
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': 'Hip Thrust',
      'subtitle': '4 SETS • 4 REPS',
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': 'Hip Thrust',
      'subtitle': '4 SETS • 4 REPS',
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': 'Hip Thrust',
      'subtitle': '4 SETS • 4 REPS',
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': 'Hip Thrust',
      'subtitle': '4 SETS • 4 REPS',
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': 'Hip Thrust',
      'subtitle': '4 SETS • 4 REPS',
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': 'Hip Thrust',
      'subtitle': '4 SETS • 4 REPS',
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': 'Hip Thrust',
      'subtitle': '4 SETS • 4 REPS',
    },
  ];

  final List<Muscle> _fakeMuscles = List.generate(
    5,
    (index) => Muscle(
      id: index,
      name: 'Muscle $index',
      muscleImage: ImageConst.bicep,
    ),
  );

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
                      if (scrollInfo.metrics.axis == Axis.vertical) { //
                        if (scrollInfo.metrics.atEdge) {
                          if (scrollInfo.metrics.pixels == 0) {
                            debugPrint("At the top");
                          } else {
                            debugPrint("At the bottom");
                            controller.fetchGroups();
                          }
                        }
                      }
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 2));
                      return await Future.value();
                    },
                    child: CustomScrollView(
                      slivers: [
                        if (_isStartTimer)
                          _buildTimerSection()
                        else
                          _buildFilterAndMusclesSection(),
                        SliverFillRemaining(
                          child: controller.groupData.value != null && controller.groupData.value!.groups!.isNotEmpty ?
                          ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            itemCount: controller.groupData.value!.groups!.length,
                            itemBuilder: (context, index) {
                              var element = controller.groupData.value!.groups![index];
                              return Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.3,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (ctx) {
                                        controller.deleteGroup(context, groupID: element.id);
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
                                    controller.getGroupDetails(groupID: element.id);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 30.h),
                                    child: Row(
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
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${element.title}",
                                              style: context.titleMedium!.copyWith(color: primary),
                                            ),
                                            Text(
                                              "No of exercises: ${element.groupExercisesCount}",
                                              style: context.bodySmall!.copyWith(color: grey),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
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
                                                            groupID: controller.groupDetails.value?.id,
                                                            groupName: controller.groupDetails.value?.title,
                                                            selectedExercises: controller.groupDetails.value?.groupExercises?.map(
                                                                (element) => element.masterExerciseId!).toList() ?? []
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
                          ) : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Text(
                                'No Exercise Group Found',
                                style: context.bodyLarge?.copyWith(
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
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
              title: "Create new workout group",
              onTap: () {
                Get.toNamed(AppRoutes.selectMuscle);
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
      // actionImage: InkWell(
      //   onTap: () => _showBottomSheet(context),
      //   child: const Icon(
      //     Icons.more_vert_outlined,
      //     color: Colors.white,
      //   ),
      // ),
      // actionImageBG: secondary.withValues(alpha: 0.1),
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
        return OptionsBottomSheet();
      },
    );
  }

  SliverToBoxAdapter _buildTimerSection() {
    return SliverToBoxAdapter(
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
                    style: context.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isStartTimer = false;
                    });
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

  SliverToBoxAdapter _buildFilterAndMusclesSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          // _buildFilterTabs(),
          // _buildMusclesHeader(),
          // _buildMusclesList(),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabTitles
              .asMap()
              .entries
              .map((entry) => DropdownButtonWidget(list: entry.value))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildMusclesHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '4 Targeted Muscles',
            style: context.headlineSmall!.copyWith(color: primary),
          ),
          TextButton(
            onPressed: () => Get.toNamed(AppRoutes.addNewMuscle),
            child: const Text('Add New Muscles'),
          ),
        ],
      ),
    );
  }

  Widget _buildMusclesList() {
    return Obx(() {
      final response = _controller.getMuscleResponse.value;
      switch (response.status) {
        case Status.INITIAL:
          return const SizedBox.shrink();
        case Status.LOADING:
          return SizedBox(
            height: 90.h,
            child: Skeletonizer(
              enabled: true,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _fakeMuscles.length,
                itemBuilder: (context, index) =>
                    _buildMuscleCard(index, _fakeMuscles[index]),
                separatorBuilder: (context, index) => SizedBox(width: 7.w),
              ),
            ),
          );
        case Status.COMPLETED:
          final muscles = response.response?.data?.muscles ?? [];
          return SizedBox(
            height: 90.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: muscles.length,
              itemBuilder: (context, index) =>
                  _buildMuscleCard(index, muscles[index]),
              separatorBuilder: (context, index) => SizedBox(width: 7.w),
            ),
          );
        case Status.ERROR:
          return SizedBox(
            height: 90.h,
            child: Center(child: Text('Error: ${response.message}')),
          );
        default:
          return const SizedBox.shrink();
      }
    });
  }

  Widget _buildMuscleCard(int index, Muscle muscle) {
    return MuscleCardWidget(
      muscleName: muscle.name ?? 'Unknown',
      imageUrl: muscle.muscleImage ?? ImageConst.bicep,
    );
  }

  SliverToBoxAdapter _buildExercisesSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: verticalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '8 Exercises',
                  style: context.headlineSmall!.copyWith(color: primary),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.addNewExercise),
                  child: const Text('Add New Exercises'),
                ),
              ],
            ),
          ),
          const Text('Superset • 4 Rounds'),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  SliverList _buildExerciseList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildExerciseItem(index),
        childCount: _exerciseList.length,
      ),
    );
  }

  Widget _buildExerciseItem(int index) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.6,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.swap_horiz,
            label: 'Replace',
            backgroundColor: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              bottomLeft: Radius.circular(25.r),
            ),
            spacing: 5,
          ),
          SlidableAction(
            onPressed: (context) {},
            icon: CupertinoIcons.delete,
            label: 'Delete',
            foregroundColor: Colors.white,
            backgroundColor: Colors.pinkAccent,
            spacing: 5,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.addRepSet),
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildExerciseImage(index),
              SizedBox(width: 20.w),
              _buildExerciseDetails(index),
              const Spacer(),
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
        Image.asset(
          _exerciseList[index]['bg_image']!,
          width: 70.w,
          height: 100.h,
          fit: BoxFit.cover,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _exerciseList[index]['title']!,
          style: context.titleMedium!.copyWith(color: primary),
        ),
        Text(
          _exerciseList[index]['subtitle']!,
          style: context.bodySmall!.copyWith(color: grey),
        ),
      ],
    );
  }

  Widget _buildStartWorkoutButton() {
    return CustomButton(
      width: 1.sw - horizontalPadding,
      title: 'Start Workout',
      onTap: () => setState(() => _isStartTimer = true),
    );
  }
}
