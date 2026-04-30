import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';

import '../../../../Widgets/custom_dropdown_widget.dart';


class WeightInfo extends StatefulWidget {
  const WeightInfo({super.key});

  @override
  State<WeightInfo> createState() => _WeightInfoState();
}


class _WeightInfoState extends State<WeightInfo> {
  late final AddpreferencesController addPreferencesController;
  final FixedExtentScrollController _controller =
      FixedExtentScrollController(initialItem: 144);

  // Start from 54 lbs
  double selectedWeight = 54;
  final double minWeight = 18;

  @override
  void initState() {
    super.initState();
    addPreferencesController =  Get.find<AddpreferencesController>();
  }

  @override
  Widget build(BuildContext context) {
    selectedWeight = addPreferencesController.weight ?? 54.0;
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            80.verticalSpace,

            /// Title
            Text(
              "Weight",
              style: context.headlineLarge!
                  .copyWith(color: primary, fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CustomDropdownWidget<String>(
                    dropdownItems: addPreferencesController.weightUnits,
                    onChanged: (val) {
                      if (val != null && val != addPreferencesController.weightUnit) {
                        setState(() {
                          addPreferencesController.weightUnit = val;
                        });
                      }
                    },
                    selectedValue: addPreferencesController.weightUnit,
                  ),
                ),
              ],
            ),
            200.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                25.horizontalSpace,
                Text(
                  '$selectedWeight',
                  style: context.bodyLarge!
                      .copyWith(fontSize: 50.sp, color: primary),
                ),
                5.horizontalSpace,
                Padding(
                  padding: EdgeInsets.only(left:4, top: 15.h),
                  child: Text(
                    addPreferencesController.weightUnit,
                    style: context.bodyLarge!.copyWith(),
                  ),
                ),
              ],
            ),

            20.verticalSpace,
            Flexible(
              child: SizedBox(
                height: 170.h,
                width: double.infinity,
                child: RotatedBox(
                  quarterTurns: -1, // Rotate for horizontal scroll
                  child: ListWheelScrollView.useDelegate(
                    controller: _controller,
                    itemExtent: 20,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        // if (index % 4 == 0 && index > 0) {
                        //   selectedWeight =  (index / 4) - 4;
                        // } else {
                        //   selectedWeight = selectedWeight + 0.25;
                        // }
                        selectedWeight = minWeight + (index * 0.25);
                        addPreferencesController.weight = selectedWeight;
                        log(addPreferencesController.weight.toString());
                      });
                    },
                    physics: const FixedExtentScrollPhysics(),
                    diameterRatio: 3,
                    perspective: 0.007,
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final weight = index ; // Weight range starts from 18 lbs

                        // Determine if the tick is a major or minor tick
                        bool isMajorTick = weight % 4 == 0;

                        return SizedBox(
                          height: 100,
                          child: RotatedBox(
                            quarterTurns: 1, // Rotate items back to normal
                            child: Column(
                              children: [
                                SizedBox(
                                  height: isMajorTick ? 50 : 30,
                                  child: Container(
                                    width: 2,
                                    color: isMajorTick ? Colors.black : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: 600, // Adjust the range (18 lbs to 217 lbs)
                    ),
                  ),
                ),
              ),
            ),

            // Center indicator line
            Container(
              height: 50,
              width: 2,
              color: primary,
              // margin: EdgeInsets.only(top: -75),
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
            //         Get.toNamed(AppRoutes.heightPicker);
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
