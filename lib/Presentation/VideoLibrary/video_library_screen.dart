import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

import '../../Config/AppRoutes/routes_imports.dart';
import '../../Utils/Const/asset_const.dart';
import '../../Utils/Const/color_const.dart';
import 'video_library_controller.dart';

class VideoCategoryScreen extends StatelessWidget {
  final ValueNotifier<int> selectedLevelIndex = ValueNotifier<int>(0);

  VideoCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<VideoLibraryController>(
        init: VideoLibraryController(),
        builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Video Library',
            leadingIcon: Icons.arrow_back,
            onLeadingPressed: () {},
            actionIcon: Icons.search,
          ),
          body: SafeArea(
            child: Column(
              children: [
                20.verticalSpace,

                /// Start Your Workout Buttons
                // ValueListenableBuilder<int>(
                //   valueListenable: selectedLevelIndex,
                //   builder: (context, selectedIndex, _) {
                //     return Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         buildLevelButton(0, 'Beginner', selectedIndex, context),
                //         buildLevelButton(1, 'Intermediate', selectedIndex, context),
                //         buildLevelButton(2, 'Advance', selectedIndex, context),
                //       ],
                //     );
                //   },
                // ),
                // 20.verticalSpace,
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.videoCategories.length,
                    itemBuilder: (context, index) {
                      final category = controller.videoCategories[index];
                      return InkWell(
                        onTap: () {
                          controller.selectedCategory = category;
                          Get.toNamed(AppRoutes.chestWorkoutVideos);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 15.h),
                          height: 174.h,
                          width: 280.w,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: NetworkImage(
                                category.categoryImage ?? "",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Beginners Level',
                                    style: context.labelSmall!.copyWith(
                                        color: Color(0xffEBC055),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Inter'),
                                  ),
                                  Text(
                                    '${category.categoryName}',
                                    style: context.headlineSmall,
                                  ),
                                  20.verticalSpace,
                                  Container(
                                    height: 26.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10.r)),
                                    child: Center(
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
                                  ),
                                  10.verticalSpace,
                                  Container(
                                    height: 26.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10.r)),
                                    child: Center(
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
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 20,
                                  top: 55,
                                  child: Image.asset(
                                    height: 41.h,
                                      width: 41.w,
                                      ImageConst.play,
                                  ))
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
        );
      }
    );
  }

  Widget buildLevelButton(
      int index, String title, int selectedIndex, BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        selectedLevelIndex.value = index;
      },
      child: Container(
        height: 35.h,
        width: 125.w,
        decoration: BoxDecoration(
          gradient: isSelected ? gradientYellow : null,
          color: isSelected ? null : primary.withOpacity(0.10),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: Text(
            title,
            style: context.labelSmall!.copyWith(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: isSelected ? secondary : darkGrey,
            ),
          ),
        ),
      ),
    );
  }
}
