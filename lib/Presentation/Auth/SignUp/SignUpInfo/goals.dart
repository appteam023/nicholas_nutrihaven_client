import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';
import '../../../../Utils/Const/asset_const.dart';
import '../../../../Utils/Const/color_const.dart';

class GoalScreen extends StatelessWidget {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  GoalScreen({super.key});

  final AddpreferencesController addPreferencesController = Get.find<AddpreferencesController>();

  @override
  Widget build(BuildContext context) {
    selectedIndex.value = addPreferencesController.goal?.keys.first ?? 0;
    return Scaffold(
      body: Column(
        children: [
          80.verticalSpace,

          /// Title
          Text(
            "What's Your Goal?",
            style: context.headlineLarge!
                .copyWith(color: primary, fontWeight: FontWeight.w400),
          ),

          100.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (context, value, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTappableContainer(
                        0, 'Lose Weight', ImageConst.banana, value),
                    _buildTappableContainer(
                        1, 'Gain Weight', ImageConst.weight, value),
                    _buildTappableContainer(
                        2, 'Stay Healthy', ImageConst.healthy, value),
                  ],
                );
              },
            ),
          ),
          // Spacer(),
          // Row(
          //   children: [
          //     CircularButton(onTap: () {
          //       print('Button tapped');
          //       Get.back();
          //     }),
          //     Spacer(),
          //     GradButton(
          //       title: 'Next',
          //       onTap: () {
          //         Get.toNamed(AppRoutes.physicalActivity);
          //       },
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _buildTappableContainer(
    int index,
    String text,
    String imageConst, // Use imagePath instead of icon
    int selectedIndex,
  ) {
    return GestureDetector(
      onTap: () {
        this.selectedIndex.value = index;
        if (this.selectedIndex.value == 0) {
          addPreferencesController.goal = {addPreferencesController.goalData.entries.elementAt(0).key :
            addPreferencesController.goalData.entries.elementAt(0).value};
        } else if (this.selectedIndex.value == 1) {
          addPreferencesController.goal = {addPreferencesController.goalData.entries.elementAt(1).key :
            addPreferencesController.goalData.entries.elementAt(1).value};
        } else if (this.selectedIndex.value == 2) {
          addPreferencesController.goal = {addPreferencesController.goalData.entries.elementAt(2).key :
            addPreferencesController.goalData.entries.elementAt(2).value};
        }
        log(addPreferencesController.goal.toString());
      },
      child: Container(
        height: 90.h,
        width: 1.sw,
        margin: EdgeInsets.symmetric(vertical: 12),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: selectedIndex == index ? themeColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: selectedIndex == index ? Colors.white : Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Inter',
                  fontWeight: selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.w500),
            ),
            Image.asset(
              imageConst, // Use the provided image path
              height: 60.h, // Adjust image size as needed
              width: 60.w,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
