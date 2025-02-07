import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../Utils/Const/asset_const.dart';

class WorkoutLevelCard extends StatelessWidget {
  final num margin;
  final num height;
  const WorkoutLevelCard({

    super.key,
    this.margin = 10,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: margin.w),
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: 20.h),
      height: height.h,
      width: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: AssetImage(
            ImageConst.body,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Image.asset(ImageConst.overlay),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(ImageConst.overlay),
              Text(
                'Beginners Level',
                style: context.labelSmall!.copyWith(
                    color: Color(0xffEBC055),
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    fontFamily: 'Inter'),
              ),
              Text(
                'Chest & Triceps',
                style: context.headlineSmall,
              ),
              40.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius:
                    BorderRadius.circular(10.r)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(ImageConst.kcal),
                    3.horizontalSpace,
                    Text(
                      '500 Kcal',
                      style: context.labelSmall!.copyWith(
                          fontFamily: 'Product Sans',
                          fontSize: 12.sp),
                    )
                  ],
                ),
              ),
              10.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.w, vertical: 10.h),
                // height: 37.h,
                // width: 71.w,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius:
                    BorderRadius.circular(10.r)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(ImageConst.mins),
                    3.horizontalSpace,
                    Text(
                      '50 Min',
                      style: context.labelSmall!.copyWith(
                          fontFamily: 'Product Sans',
                          fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}