import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';

import '../../../../Utils/Const/color_const.dart';

class HeightPickerScreen extends StatelessWidget {

  final ValueNotifier<int> selectedFeet = ValueNotifier<int>(5); // Default feet
  final ValueNotifier<int> selectedInches =
      ValueNotifier<int>(2); // Default inches

  HeightPickerScreen({super.key});

  final AddpreferencesController addPreferencesController = Get.find<AddpreferencesController>();

  @override
  Widget build(BuildContext context) {
    selectedFeet.value = (addPreferencesController.heightFeet ?? 4) - 1;
    selectedInches.value = (addPreferencesController.heightInches ?? 1) - 1;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPicker(
                  itemCount: 10,
                  selectedValue: selectedFeet,
                  label: 'ft',
                  highlightColor: themeColor,
                  onSelectedItemChanged: (value) {
                    addPreferencesController.heightFeet = value + 1;
                    log(addPreferencesController.heightFeet.toString());
                  }
                ),
                SizedBox(width: 20,),
                _buildPicker(
                  itemCount: 12,
                  selectedValue: selectedInches,
                  label: 'in',
                  highlightColor: themeColor,
                  onSelectedItemChanged: (value) {
                    addPreferencesController.heightInches = value + 1;
                    log(addPreferencesController.heightInches.toString());
                  }
                ),
              ],
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
    required void Function(int) onSelectedItemChanged,
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
                      onSelectedItemChanged(index);
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
