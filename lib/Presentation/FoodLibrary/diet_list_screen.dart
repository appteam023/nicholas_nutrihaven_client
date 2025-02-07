import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

import '../../Utils/Const/asset_const.dart';
import '../../Utils/Const/color_const.dart';

class DietListScreen extends StatelessWidget {
  const DietListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          leadingIcon: Icons.arrow_back,
          title: 'Keto Diet',
          actionIcon: Icons.search,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.zero,
                        elevation: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  // height: 204.h,
                                  // width: 280.w,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Image.asset(
                                    ImageConst.keto,
                                    height: 166.h,
                                    width: double.maxFinite,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Image.asset(
                                    ImageConst.leftOverlay,
                                    height: 166.h,
                                    // width: 194.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 15.w,
                                  top: 79.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 4.h),
                                        // height: 26.h,
                                        // width: 90.w,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(ImageConst.kcal),
                                              3.horizontalSpace,
                                              Text(
                                                '500 Kcal',
                                                style: context.labelSmall!
                                                    .copyWith(
                                                        fontFamily:
                                                            'Product Sans',
                                                        fontSize: 12.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 4.h),
                                        // height: 26.h,
                                        // width: 80.w,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(ImageConst.mins),
                                              3.horizontalSpace,
                                              Text(
                                                '50 Min',
                                                style: context.labelSmall!
                                                    .copyWith(
                                                        fontFamily:
                                                            'Product Sans',
                                                        fontSize: 12.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 79.h,
                                  right: 20.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.dietDetail);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: horizontalPadding,
                                      ),
                                      height: 60.h,
                                      width: 60.h,
                                      decoration: BoxDecoration(
                                          gradient: gradientYellow,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.adaptive.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                                vertical: verticalPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Standard Ketogenic Diet',
                                    style: context.headlineSmall!
                                        .copyWith(color: primary),
                                  ),
                                  Text(
                                    'Chest & Triceps training is a great way to increase the size and strength of your arms.',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: context.bodyMedium!
                                        .copyWith(color: grey),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
