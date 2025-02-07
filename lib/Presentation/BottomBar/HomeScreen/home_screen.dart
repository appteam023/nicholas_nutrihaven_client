import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/HomeScreen/widgets/start_workout_widget.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/HomeScreen/widgets/track_meal_widget.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import '../../../Utils/Const/asset_const.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onTap;

  const HomeScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: darkTheme,
        leading: Image.asset(
          ImageConst.user,
          height: 70.h,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style:
                  context.labelSmall!.copyWith(color: const Color(0xFF919191)),
            ),
            Text(
              'John',
              style: context.titleLarge!
                  .copyWith(fontSize: 20.sp, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              CircleAvatar(
                  radius: 28.r,
                  backgroundColor: secondary.withOpacity(0.1),
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.notification),
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 30,
                      color: secondary,
                    ),
                  )),
              8.horizontalSpace,
              GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                    radius: 28.r,
                    backgroundColor: secondary.withOpacity(0.1),
                    child: Icon(
                      Icons.menu,
                      size: 30,
                      color: secondary,
                    )),
              ),
              10.horizontalSpace
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ///Track Your Meal
                    TrackMealWidget(),
                    10.verticalSpace,
                    Row(
                      children: [
                        ///WorkOut Videos
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.videoCategory);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 30),
                              height: 212.h,
                              // width: 200.w,
                              decoration: BoxDecoration(
                                  color: themeColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 27.r,
                                    backgroundColor: const Color(0xFF315D60),
                                    child: Image.asset(ImageConst.workOut),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    'Workout\nVideos',
                                    style: context.titleLarge!.copyWith(
                                        fontSize: 27.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        10.horizontalSpace,
              
                        ///Food Library
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.foodLibrary);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35.w, vertical: 30.h),
                              height: 212.h,
                              // width: 200.w,
                              decoration: BoxDecoration(
                                  color: themeColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 27.r,
                                    backgroundColor: const Color(0xFF315D60),
                                    child: Image.asset(ImageConst.food),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    'Food\nLibrary',
                                    style: context.titleLarge!.copyWith(
                                        fontSize: 27.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
              
                    ///Start Your WorkOut
                    StartWorkoutWidget(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(1, -0.2),
              // right: 0,

              child: Image.asset(ImageConst.talkButton),
            ),
          ],
        ),
      ),
    );
  }
}
