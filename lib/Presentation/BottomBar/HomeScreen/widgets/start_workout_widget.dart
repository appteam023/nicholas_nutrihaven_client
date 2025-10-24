import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../../../../Config/AppRoutes/routes_imports.dart';
import '../../../../Utils/Const/asset_const.dart';

class StartWorkoutWidget extends StatelessWidget {
  const StartWorkoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.workoutPlan);
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 20),
            height: 240.h,
            width: 410.w,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFAB7D01), Color(0xFF453200)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Your',
                  style: context.titleLarge!.copyWith(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  'WorkOut',
                  style: context.titleLarge!.copyWith(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.normal),
                ),
                40.verticalSpace,
                Text(
                  'Kickstart Your\nFitness Journey Today!',
                  style: context.titleSmall!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Positioned(
            top: 70,
            bottom: 0,
            right: 0,
            child: Image.asset(
              ImageConst.work,
              height: 155.h,
              width: 255.w,
            ),
          ),
        ],
      ),
    );
  }
}