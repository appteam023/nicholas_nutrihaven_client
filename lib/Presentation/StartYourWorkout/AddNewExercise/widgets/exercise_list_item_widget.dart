import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/add_new_exercise_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExerciseListItemWidget extends StatelessWidget {
  final String name;
  final int? exerciseId;

  ExerciseListItemWidget({
    super.key,
    required this.name,
    required this.exerciseId,
  });

  final AddNewExerciseController controller =
      Get.find<AddNewExerciseController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedExerciseId!.value == exerciseId;
      return GestureDetector(
        onTap: () {
          if (exerciseId != null) {
            controller.toggleExerciseSelection(exerciseId!);
          }
        },
        child: Container(
          height: 120.h,
          color: Colors.transparent,
          margin: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              Skeleton.shade(
                child: Container(
                  width: 70.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Stack(
                    children: [
                      const Center(child: Icon(Icons.fitness_center)),
                      if (isSelected)
                        Positioned(
                          bottom: -14.h,
                          right: -14.w,
                          child: Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              activeColor: themeColor,
                              value: isSelected,
                              onChanged: (value) {
                                if (exerciseId != null) {
                                  controller
                                      .toggleExerciseSelection(exerciseId!);
                                }
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              16.horizontalSpace,
              Text(
                name,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    });
  }
}
