import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';

import '../../../../Utils/Const/color_const.dart';

class AgeSelectorWidget extends StatefulWidget {
  const AgeSelectorWidget({
    super.key,
  });

  @override
  State<AgeSelectorWidget> createState() => _AgeSelectorWidgetState();
}



class _AgeSelectorWidgetState extends State<AgeSelectorWidget> {
  late final AddpreferencesController addPreferencesController;
  final FixedExtentScrollController _controller =
      FixedExtentScrollController(initialItem: 10);

  int? selectedNumber = 28;

  @override
  void initState() {
    super.initState();
    addPreferencesController =  Get.find<AddpreferencesController>();
  }
  // Default selected number
  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.h),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       /// Title Section
    //       80.verticalSpace,
    //       Text(
    //         'What Is Your Age?',
    //         style: context.headlineLarge!
    //             .copyWith(color: primary, fontWeight: FontWeight.w400),
    //       ),
    //       20.verticalSpace,
    //       Text(
    //         'To Give You A Better Experience We\nNeed To Know Your Age',
    //         style: context.bodyMedium!.copyWith(fontFamily: 'Inter'),
    //         textAlign: TextAlign.center,
    //       ),
    //       100.verticalSpace,
    //
    //       /// Age Selector
    //       ValueListenableBuilder<int>(
    //         valueListenable: selectedAgeIndex,
    //         builder: (context, selectedIndex, child) {
    //           int selectedAge = selectedIndex + 18;
    //
    //           return Column(
    //             children: [
    //               /// Horizontal Age Picker with Scrollable Row
    //               SingleChildScrollView(
    //                 scrollDirection: Axis.horizontal,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     _buildAgeOption(selectedIndex - 1, selectedIndex),
    //                     _buildAgeOption(selectedIndex, selectedIndex,
    //                         isSelected: true),
    //                     _buildAgeOption(selectedIndex + 1, selectedIndex),
    //                   ],
    //                 ),
    //               ),
    //               100.verticalSpace,
    //
    //               /// Display Birth Year
    //               Column(
    //                 children: [
    //                   Image.asset(ImageConst.smile),
    //                   10.verticalSpace,
    //                   Text(
    //                     'You Were Born On',
    //                     style: context.titleMedium!.copyWith(
    //                       color: primary,
    //                       fontFamily: 'Inter',
    //                       fontWeight: FontWeight.normal
    //                     )
    //                   ),
    //                   Text(
    //                     '${DateTime.now().year - selectedAge}',
    //                       style: context.titleMedium!.copyWith(
    //                           color: primary,
    //                           fontSize: 18.sp,
    //                           fontFamily: 'Inter',
    //                           fontWeight: FontWeight.bold
    //                       )
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
    selectedNumber = addPreferencesController.age ?? 28;
    return Scaffold(
      body: Column(
        children: [
          80.verticalSpace,

          /// Title
          Text(
            "Age",
            style: context.headlineLarge!
                .copyWith(color: primary, fontWeight: FontWeight.w400),
          ),
          200.verticalSpace,
          SizedBox(
            height: 200.h,
            child: RotatedBox(
            
              quarterTurns: -1, // Rotate the ListWheelScrollView horizontally
              child: ListWheelScrollView.useDelegate(
                controller: _controller,
                itemExtent: 150.h,
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedNumber = 18 + index;
                    addPreferencesController.age = selectedNumber;
                    log(addPreferencesController.age.toString());
                  });
                },
                physics: FixedExtentScrollPhysics(),
                // diameterRatio: 2.5,
                // perspective: 0.01,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    final number = 18 + index;
                    return RotatedBox(
                      quarterTurns: 1, // Rotate the item back to normal
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        // width: 200.w,
                        // height: 200.h,
                        alignment: Alignment.center,
                        decoration: selectedNumber == number
                            ? BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              )
                            : null,
                        child: Text('$number',
                            style: context.headlineLarge!.copyWith(
                                fontSize: 60.h,
                                color: selectedNumber == number
                                    ? Colors.black
                                    : Colors.black26,
                                fontFamily: 'Inter')),
                      ),
                    );
                  },
                  childCount: 83, // For numbers from 18 to 100
                ),
              ),
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
          //         Get.toNamed(AppRoutes.weightInfo);
          //       },
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

// Widget _buildAgeOption(int ageIndex, int selectedIndex,
//     {bool isSelected = false}) {
//   int age = ageIndex + 18;
//
//   if (age < 18 || age > 117)
//     return SizedBox(width: 50.w); // Boundary check for valid age range
//
//   return GestureDetector(
//     onTap: () {
//       selectedAgeIndex.value = ageIndex;
//     },
//     child: Opacity(
//       opacity: isSelected ? 1.0 : 0.5,
//       child: Container(
//         alignment: Alignment.center,
//         width: isSelected ? 180.w : 180.w,
//         height: isSelected ? 180.h : 180.h,
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.grey.shade200 : Colors.transparent,
//           shape: BoxShape.circle,
//         ),
//         child: Text(
//           '$age',
//           style: TextStyle(
//             fontSize: isSelected ? 65.sp : 60.sp,
//             fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
//             fontFamily: 'Inter',
//             color: isSelected ? Colors.black : Colors.grey,
//           ),
//         ),
//       ),
//     ),
//   );
// }
}
