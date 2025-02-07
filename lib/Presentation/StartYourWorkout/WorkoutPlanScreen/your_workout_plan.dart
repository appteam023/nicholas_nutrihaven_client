import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignIn/signin.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';

import '../../../Widgets/dropdown_widget.dart';

class WorkoutPlan extends StatefulWidget {
  const WorkoutPlan({super.key});

  @override
  _WorkoutPlanState createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlan> {
  int _selectedTabIndex = 0;
  bool isStartTimer = false;

  final List<List<String>> _tabTitles = [
    ['1hr', '2hr', '3hr'],
    ['Beginner', 'Intermediate', 'Expert'],
    ['Fresh Muscles'],
    ['All Exercises'],
    ['Bodybuilding'],
  ];

  var musclesList = [
    'Biceps',
    'Glutes',
    'Glutes',
  ];

  var exerciseList = [
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicepbg,
      'title': "Dumbbell Bicep Curl",
      "subtitle": "4 SETS • 10 REPS • 8 KG"
    },
    {
      'bg_image': ImageConst.hipThrust,
      'fg_image': ImageConst.bicep,
      'title': "Hip Thrust",
      "subtitle": "4 SETS • 4 REPS"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBar(
        title: 'Your Workout Plan',
        actionImage: InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              sheetAnimationStyle: AnimationStyle(
                duration: const Duration(seconds: 2),
                reverseDuration: const Duration(seconds: 1),
              ),
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding*2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        onTap: () => Get.back(),
                        leading: Icon(Icons.bookmark_border),
                        title: Text("Save Workout"),
                      ),
                      Divider(
                        color: grey.withOpacity(0.2),
                        height: 1.2,
                      ),
                      ListTile(
                        onTap: () => Get.back(),
                        leading: Icon(Icons.share),
                        title: Text("Share Workout Link"),
                      ),
                      Divider(
                        color: grey.withOpacity(0.2),
                        height: 1.2,
                      ),
                      ListTile(
                        onTap: () => Get.back(),
                        leading: Icon(
                          Icons.add
                        ),
                        title: Text("Create Workout From Scratch"),
                      ),
                      Divider(
                        color: grey.withOpacity(0.2),
                        height: 1.2,
                      ),
                      ListTile(
                        onTap: () => Get.back(),
                        leading: Icon(Icons.share),
                        title: Text("Build Superset/Circuit"),
                      ),
                      Divider(
                        color: grey.withOpacity(0.2),
                        height: 1.2,
                      ),
                      ListTile(
                        onTap: () => Get.back(),
                        leading: Icon(Icons.file_download_outlined),
                        title: Text("Saved Workouts"),
                      ),
                      Divider(
                        color: grey.withOpacity(0.2),
                        height: 1.2,
                      ),
                      ListTile(
                        onTap: () => Get.back(),
                        leading: Icon(Icons.change_circle_outlined),
                        title: Text("Refresh Workout"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(
            Icons.more_vert_outlined,
            color: Colors.white,
          ),
        ),
        actionImageBG: secondary.withOpacity(0.1),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: CustomScrollView(
            slivers: [
              /// Timer
              if (isStartTimer)
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: verticalPadding * 2),
                    padding: EdgeInsets.all(horizontalPadding * 2),
                    decoration: BoxDecoration(
                      color: darkTheme,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 16.r,
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor: darkTheme,
                            child: CircleAvatar(
                              radius: 10.r,
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),

                        // Counter
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: Text(
                            "00:32:12",
                            style: context.headlineLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Spacer(),

                        /// Stop
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isStartTimer = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: yellowText,
                            child: Icon(
                              Icons.stop,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      // Custom TabBar using Row and TextButton
                      Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(_tabTitles.length, (index) {
                              return DropdownButtonWidget(
                                  list: _tabTitles[index]);
                            }),
                          ),
                        ),
                      ),

                      /// target Muscles
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: verticalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "4 Targeted Muscles",
                              style: context.headlineSmall!
                                  .copyWith(color: primary),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.addNewMuscle);
                              },
                              child: Text("Add New Muscles"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 90.h,
                        child: ListView.separated(
                          itemCount: musclesList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Card(
                            color: grey.withOpacity(0.2),
                            elevation: 0,
                            child: SizedBox(
                              width: 180.w,
                              child: Row(
                                children: [
                                  Card(
                                      color: darkTheme,
                                      elevation: 0,
                                      child: Image.asset(ImageConst.bicep)),
                                  5.horizontalSpace,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        musclesList[index],
                                        style: context.labelLarge,
                                      ),
                                      5.verticalSpace,
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: grey.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Text(
                                            "100%",
                                            style: context.bodySmall!.copyWith(
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 7.w),
                        ),
                      ),
                    ],
                  ),
                ),

              SliverToBoxAdapter(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Excercise
                  Padding(
                    padding: EdgeInsets.only(top: verticalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "8 Excercises",
                          style:
                              context.headlineSmall!.copyWith(color: primary),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Add New Excercises"),
                        ),
                      ],
                    ),
                  ),
                  Text("Superset • 4 Rounds"),
                  20.verticalSpace,
                ],
              )),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.6,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            icon: Icons.swap_horiz,
                            label: 'Replace',
                            backgroundColor: Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  25.r,
                                ),
                                bottomLeft: Radius.circular(25.r)),
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
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Image.asset(
                                    exerciseList[index]['bg_image']!,
                                    width: 70.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: -10.h,
                                    right: -10.w,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
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
                              20.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${exerciseList[index]['title']}',
                                    style: context.titleMedium!
                                        .copyWith(color: primary),
                                  ),
                                  Text(
                                    '${exerciseList[index]['subtitle']}',
                                    style: context.bodySmall!
                                        .copyWith(color: grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.more_horiz,
                                color: grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },

                  // 40 list items
                  childCount: exerciseList.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !isStartTimer
          ? CustomButton(
              width: 1.sw - horizontalPadding,
              title: 'Start Workout',
              onTap: () {
                setState(() {
                  isStartTimer = true;
                });
              },
            )
          : null,
    );
  }
}
