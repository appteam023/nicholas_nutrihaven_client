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

class HeightPickerScreen extends StatelessWidget {
  final ValueNotifier<int> selectedFeet = ValueNotifier<int>(5); // Default feet
  final ValueNotifier<int> selectedInches =
      ValueNotifier<int>(2); // Default inches

  HeightPickerScreen({super.key});

  final AddpreferencesController addpreferencesController =
      Get.put(AddpreferencesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            80.verticalSpace,

            /// Title
            Text(
              "Height",
              style: context.headlineLarge!
                  .copyWith(color: primary, fontWeight: FontWeight.w400),
            ),
            150.verticalSpace,

            /// Inches Picker
            _buildPicker(
              itemCount: 1000,
              selectedValue: selectedInches,
              label: 'cm',
              highlightColor: themeColor,
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
            //         Get.toNamed(AppRoutes.goals);
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  /// Picker Widget
  Widget _buildPicker({
    required int itemCount,
    required ValueNotifier<int> selectedValue,
    required String label,
    required Color highlightColor,
  }) {
    return Column(
      children: [
        /// Picker Wheel
        SizedBox(
          width: 156.w,
          height: 300.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Divider Line for Highlight
              Positioned(
                top: 115.h,
                left: 0,
                right: 0,
                child: Container(
                  height: 3,
                  color: highlightColor,
                ),
              ),

              /// ListWheelScrollView
              ValueListenableBuilder<int>(
                valueListenable: selectedValue,
                builder: (context, value, _) {
                  return ListWheelScrollView.useDelegate(
                    physics: const FixedExtentScrollPhysics(),
                    itemExtent: 70.h,
                    controller: FixedExtentScrollController(initialItem: value),
                    onSelectedItemChanged: (index) {
                      selectedValue.value = index;
                      addpreferencesController.height = selectedValue.value;
                      log(addpreferencesController.height.toString());
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${index + 1}',
                                  // Correct numbering offset
                                  style: context.headlineLarge!.copyWith(
                                    fontFamily: 'Inter',
                                    color: index == value
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: index == value ? 58.sp : 43.sp,
                                    // Highlight number size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' $label',
                                  style: context.bodySmall!.copyWith(
                                    fontFamily: 'Inter',
                                    color: index == value
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16.sp,
                                    // Small font size for the label
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      childCount: itemCount, // Ensure proper count
                    ),
                  );
                },
              ),

              /// Divider Line for Highlight
              Positioned(
                top: 189.h,
                left: 0,
                right: 0,
                child: Container(
                  height: 3,
                  color: highlightColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
