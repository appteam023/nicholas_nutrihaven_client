import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

import '../../Config/AppRoutes/routes_imports.dart';

class ChestWorkoutVideos extends StatelessWidget {
  ChestWorkoutVideos({super.key});
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
          Get.back();
        },
        actionIcon: Icons.search,
        title: 'Chest Workout Videos',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          child: Column(
            children: [
              Expanded(
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
            ],
          ),
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
