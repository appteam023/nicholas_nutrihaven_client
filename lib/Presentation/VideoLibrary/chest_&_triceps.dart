import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';

import '../../Config/AppRoutes/routes_imports.dart';
import '../../Utils/Const/asset_const.dart';

class ChestTriceps extends StatefulWidget {
  const ChestTriceps({super.key});

  @override
  State<ChestTriceps> createState() => _ChestTricepsState();
}

class _ChestTricepsState extends State<ChestTriceps> {
  bool isSwitched = false;
  final List<Videos> videos = [
    Videos(
        image: 'assets/images/v1.png',
        title: 'Prepare For Your First Workout Routine',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v2.png',
        title: 'Chest Workout | 4 Exercises For GROWTH 💪',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v3.png',
        title: 'Big Chest Workout Routine for Beginners ',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v4.png',
        title: 'The 💯 Chest Workout (MOST EFFECTIVE!)',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v5.png',
        title: 'Science-Based Chest Workout for Mass',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v1.png',
        title: 'Prepare For Your First Workout Routine',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v2.png',
        title: 'Chest Workout | 4 Exercises For GROWTH 💪',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v3.png',
        title: 'Big Chest Workout Routine for Beginners ',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v4.png',
        title: 'The 💯 Chest Workout (MOST EFFECTIVE!)',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
    Videos(
        image: 'assets/images/v5.png',
        title: 'Science-Based Chest Workout for Mass',
        subTitle: 'NutriHaven',
        viewsDays: '125,908 views  •  2 days ago'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingPressed: () {
          Get.toNamed(AppRoutes.chestWorkoutVideos);
        },
        actionIcon: Icons.search,
        title: 'Chest & Triceps',
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Stack(
                  children: [
                Image.asset(
                  ImageConst.v2,
                  height: 231.h,
                  width: 397.w,
                  fit: BoxFit.fill,
                ),
                Positioned(
                    top: 0,
                    child: Container(
                      height: 231.h,
                      width: 397.w,
                      decoration: BoxDecoration(
                          color: black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30.r)),
                    )),
                Positioned(
                    top: 0,
                    child: Container(
                      height: 231.h,
                      width: 397.w,
                      child: Image.asset(ImageConst.vPlay),
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Chest Workout Pt.1',
                      style: context.titleLarge!.copyWith(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp
                      ),),
                      8.verticalSpace,
                      Text(
                        '925.497 views . a year ago',
                        style: context.labelMedium!.copyWith(
                            color: black.withOpacity(0.5)
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
                        color: black.withOpacity(0.5)
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: ListView.builder(
                  itemCount: videos.length,
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
                            child: Image.asset(
                              videos[index].image,
                              width: 160.w,
                              height: 95.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  videos[index].title,
                                  style: context.titleLarge!.copyWith(
                                      color: black,
                                      fontFamily: 'Inter'
                                  ),
                                ),
                                5.verticalSpace,
                                Text(
                                  videos[index].subTitle,
                                  style: context.labelSmall!.copyWith(
                                      color: black.withOpacity(0.5)
                                  ),
                                ),
                                5.verticalSpace,
                                Text(
                                  videos[index].viewsDays,
                                  style: context.labelSmall!.copyWith(
                                      color: black.withOpacity(0.5)
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

