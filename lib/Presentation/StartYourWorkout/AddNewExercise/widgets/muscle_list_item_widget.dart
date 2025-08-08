import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/add_new_exercise_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/image_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MuscleListItemWidget extends StatelessWidget {
  MuscleListItemWidget({
    super.key,
    required this.muscleName,
    required this.imageUrl,
    required this.muscleId,
  });

  final String muscleName;
  final String imageUrl;
  final int? muscleId;
  final AddNewExerciseController controller =
      Get.find<AddNewExerciseController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedMuscleId!.value == muscleId;
      return GestureDetector(
        onTap: () {
          if (muscleId != null) {
            controller.toggleMuscleSelection(muscleId!);
          } else {
            log('Tapped but muscleId is null');
          }
        },
        child: Card(
          color: grey.withOpacity(0.2),
          elevation: 0,
          child: SizedBox(
            width: 180.w,
            child: Row(
              children: [
                Stack(
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        color: darkTheme,
                        elevation: 0,
                        child: Skeleton.replace(
                          replace: true,
                          height: 64.h,
                          width: 64.w,
                          replacement: Container(color: Colors.grey.shade300),
                          child: ImageWidget(
                            isNetworkImage: true,
                            imageUrl: imageUrl,
                            height: 64.h,
                            width: 64.w,
                          ),
                        )),
                    if (isSelected)
                      Positioned(
                        bottom: -14.h,
                        left: -14.w,
                        child: Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            activeColor: themeColor,
                            value: isSelected,
                            onChanged: (value) {
                              if (muscleId != null) {
                                controller.toggleMuscleSelection(muscleId!);
                              }
                            },
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 5.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(muscleName, style: context.labelLarge),
                    SizedBox(height: 5.h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                        color: grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        '100%',
                        style: context.bodySmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
