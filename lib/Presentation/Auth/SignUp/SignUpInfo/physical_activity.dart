import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';

import '../../../../Config/AppRoutes/routes_imports.dart';
import '../../../../Utils/Const/color_const.dart';
import '../widgets/circluar_button.dart';
import '../widgets/grad_button.dart';

class PhysicalActivity extends StatelessWidget {
  final ValueNotifier<int> selectedIndex =
      ValueNotifier<int>(2); // Default to 'Intermediate'

  final List<String> levels = [
    'Rookie',
    'Beginner',
    'Intermediate',
    'Advance',
    'True Beast',
  ];

  PhysicalActivity({super.key});

  final AddpreferencesController addpreferencesController =
      Get.put(AddpreferencesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          80.verticalSpace,

          /// Title
          Text(
            "Your Regular Physical \nActivity Level",
            style: context.headlineLarge!
                .copyWith(color: primary, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          120.verticalSpace,

          /// CleanWheel Picker
          SizedBox(
            height: 280.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// Highlight Divider Lines
                Positioned(
                  top: 100.h,
                  left: 20.w,
                  right: 20.w,
                  child: Divider(
                    thickness: 3,
                    color: themeColor,
                  ),
                ),
                Positioned(
                  bottom: 100.h,
                  left: 20.w,
                  right: 20.w,
                  child: Divider(
                    thickness: 3,
                    color: themeColor,
                  ),
                ),

                /// ListWheelScrollView
                ValueListenableBuilder<int>(
                  valueListenable: selectedIndex,
                  builder: (context, value, _) {
                    return ListWheelScrollView.useDelegate(
                      physics: const FixedExtentScrollPhysics(),
                      itemExtent: 60.h,
                      controller:
                          FixedExtentScrollController(initialItem: value),
                      onSelectedItemChanged: (index) {
                        selectedIndex.value = index;

                        if (selectedIndex.value == 0) {
                          addpreferencesController.level = "Rookie";
                        } else if (selectedIndex.value == 1) {
                          addpreferencesController.level = "Beginner";
                        } else if (selectedIndex.value == 2) {
                          addpreferencesController.level = "Intermediate";
                        } else if (selectedIndex.value == 3) {
                          addpreferencesController.level = "Advanced";
                        } else if (selectedIndex.value == 4) {
                          addpreferencesController.level = "True Beast";
                        }

                        log(addpreferencesController.level.toString());
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Center(
                            child: Text(
                              levels[index],
                              style: TextStyle(
                                  fontSize: index == value ? 24.sp : 24.sp,
                                  color: index == value
                                      ? Colors.black
                                      : Color(0xFF6E6E6E),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter'),
                            ),
                          );
                        },
                        childCount: levels.length,
                      ),
                    );
                  },
                ),
              ],
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
          //         Get.toNamed(AppRoutes.excersicePlace);
          //       },
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
