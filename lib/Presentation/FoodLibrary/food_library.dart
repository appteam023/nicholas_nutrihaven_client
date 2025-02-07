import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import '../../Config/AppRoutes/routes_imports.dart';
import '../../Utils/Const/asset_const.dart';
import '../../Utils/Const/color_const.dart';

class FoodLibrary extends StatelessWidget {
  const FoodLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingIcon: Icons.arrow_back,
        actionIcon: Icons.search,
        title: 'Food Library',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.dietList);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15.h),
                        height: 174.h,
                        width: 280.w,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: AssetImage(
                              ImageConst.foodLib,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Standard Diet (SKD)',
                                style: context.headlineSmall),
                            Text(
                              'The ketogenic diet is a very\nlow-carb, high-fat diet',
                              style: context.titleSmall!
                                  .copyWith(fontFamily: 'Inter'),
                            ),
                            20.verticalSpace,
                            Container(
                              height: 26.h,
                              width: 79.w,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(ImageConst.clock),
                                    3.horizontalSpace,
                                    Text(
                                      '50 min',
                                      style: context.labelSmall!.copyWith(
                                          fontFamily: 'Product Sans',
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            10.verticalSpace,
                          ],
                        ),
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
      ),
    );
  }
}
