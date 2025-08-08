import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';


class WeightInfo extends StatefulWidget {
  const WeightInfo({super.key});

  @override
  State<WeightInfo> createState() => _WeightInfoState();
}


class _WeightInfoState extends State<WeightInfo> {
  late final AddpreferencesController addPreferencesController;
  final FixedExtentScrollController _controller =
      FixedExtentScrollController(initialItem: 36);

  // Start from 54 lbs
  int? selectedWeight = 54;

  @override
  void initState() {
    super.initState();
    addPreferencesController =  Get.find<AddpreferencesController>();
  }

  @override
  Widget build(BuildContext context) {
    selectedWeight = addPreferencesController.weight ?? 54;
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
                  padding: EdgeInsets.only(top: 15.h),
                  child: Text(
                    'lbs',
                    style: context.bodyLarge!.copyWith(),
                  ),
                ),
              ],
            ),

            20.verticalSpace,
            SizedBox(
              height: 150.h,
              width: double.infinity,
              child: RotatedBox(
                quarterTurns: -1, // Rotate for horizontal scroll
                child: ListWheelScrollView.useDelegate(
                  controller: _controller,
                  itemExtent: 20,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedWeight = index + 18;
                      addPreferencesController.weight = selectedWeight;
                      log(addPreferencesController.weight.toString());
                    });
                  },
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 3,
                  perspective: 0.007,
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final weight =
                          index + 50; // Weight range starts from 18 lbs

                      // Determine if the tick is a major or minor tick
                      bool isMajorTick = weight % 5 == 0;

                      return RotatedBox(
                        quarterTurns: 1, // Rotate items back to normal
                        child: Column(
                          children: [
                            SizedBox(
                              height: isMajorTick ? 50 : 30,
                              child: Container(
                                width: 2,
                                color:
                                    isMajorTick ? Colors.black : Colors.black54,
                              ),
                            ),
                            // if (isMajorTick)
                            //   Text(
                            //     '$weight',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                          ],
                        ),
                      );
                    },
                    childCount: 600, // Adjust the range (18 lbs to 217 lbs)
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
