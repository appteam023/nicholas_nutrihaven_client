import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

import '../../Config/AppRoutes/routes_imports.dart';
import '../../Utils/Const/asset_const.dart';
import '../../Widgets/build_level_button_widget.dart';
import '../../Widgets/workout_levels_card.dart';

class WorkOutVideosScreen extends StatelessWidget {
  final ValueNotifier<int> selectedLevelIndex = ValueNotifier<int>(0);

  WorkOutVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'WorkOut Videos',
        leadingIcon: Icons.arrow_back,
        onLeadingPressed: () {
          Get.back();
        },
        actionIcon: Icons.search,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            'Continue Watching',
            style: context.headlineSmall!.copyWith(
              color: primary,
              fontSize: 24.sp,
            ),
          ),
        ),
        15.verticalSpace,
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            ImageConst.dietPlan,
            fit: BoxFit.fitWidth,
          ),
        ),
        10.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'How to build your stamina with our diet plan',
            style: context.titleLarge!.copyWith(
                color: primary,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        10.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '925.497 views . a year ago',
            style: context.bodyMedium!.copyWith(
                fontFamily: 'Inter',
                color: Color(0xff999999),
                fontWeight: FontWeight.w500),
          ),
        ),
        10.verticalSpace,
        Divider(
          color: Color(0xffEAEAEA),
          thickness: 2,
        ),
        10.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Your Workout',
                style: context.headlineSmall!.copyWith(
                  fontSize: 24.sp,
                  color: primary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: context.labelSmall!.copyWith(
                    color: mustardYellow,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: mustardYellow,
                  ),
                ),
              )
            ],
          ),
        ),
        10.verticalSpace,

        /// Start Your Workout Buttons
        ValueListenableBuilder<int>(
          valueListenable: selectedLevelIndex,
          builder: (context, selectedIndex, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLevelButton(
                    0, 'Beginner', selectedIndex, context),
                buildLevelButton(
                    1, 'Intermediate', selectedIndex, context),
                buildLevelButton(
                    2, 'Advance', selectedIndex, context),
              ],
            );
          },
        ),
        20.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
          height: 250.h, // Set height for the grid
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10, // Number of items in the grid
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.videoCategory);
                },
                  child: WorkoutLevelCard()
              );
            },
          ),
        ),
      ),
      ],
    ),)
    ,
    )
    ,
    );
  }

  Widget buildLevelButton(int index, String title, int selectedIndex,
      BuildContext context) {
    final bool isSelected = selectedIndex == index;


    return GestureDetector(
      onTap: () {
        selectedLevelIndex.value = index;
      },
      child: Container(
        height: 35.h,
        width: 125.w,
        decoration: BoxDecoration(
          gradient: isSelected ? gradientYellow : null,
          color: isSelected ? null : primary.withOpacity(0.10),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: Text(
            title,
            style: context.labelSmall!.copyWith(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: isSelected ? secondary : darkGrey,
            ),
          ),
        ),
      ),
    );
  }
}
