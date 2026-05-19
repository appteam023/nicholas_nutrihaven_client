import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/HomeScreen/home_screen.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/bottom_nav_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../../../Config/session_manager.dart';
import '../../../Helpers/get_storage_helper.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Get.put(BottomNavController());

    return AdvancedDrawer(
      controller: bottomNavController.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 0.7,
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 10),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          color: secondary,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: EdgeInsets.all(20.w),
              //   child: GestureDetector(
              //       onTap: () {
              //         _advancedDrawerController.toggleDrawer();
              //       },
              //       child: const Icon(Icons.close)),
              // ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Image.asset(ImageConst.user),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Hello!'),
                      Text(
                        "${AppSessionManager().getUserData?.memberFullName}!",
                        style: context.titleLarge!.copyWith(
                            color: primary,
                            fontFamily: 'Inter',
                            fontSize: 20.sp),
                      ),
                    ],
                  ),
                ],
              ),
              30.verticalSpace,
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {
                  bottomNavController.advancedDrawerController.toggleDrawer();
                },
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
              ),
              DrawerDivider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                leading: const Icon(Icons.person_2_outlined),
                title: const Text('My Profile'),
              ),
              DrawerDivider(),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                onTap: () {},
                leading: const Icon(CupertinoIcons.chat_bubble),
                title: const Text('Inbox'),
              ),
              const DrawerDivider(),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                onTap: () {
                  Get.toNamed(AppRoutes.workoutVideos);
                },
                leading: const Icon(Icons.play_circle_outline),
                title: const Text('Workout Videos'),
              ),
              const DrawerDivider(),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                onTap: () {
                  Get.toNamed(AppRoutes.dietCuisineSelectionView);
                },
                leading: const Icon(Icons.note_add_outlined),
                title: const Text('Diet Plan'),
              ),
              const DrawerDivider(),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                onTap: () {
                  Get.toNamed(AppRoutes.notification);
                },
                leading: const Icon(Icons.notifications_none),
                title: const Text('Notifications'),
              ),
              const DrawerDivider(),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                onTap: () {},
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Settings'),
              ),
              const Spacer(),
              Container(
                height: 60.h,
                width: 180.w,
                margin: EdgeInsets.only(left: horizontalPadding),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                    gradient: gradientYellow,
                    borderRadius: BorderRadius.circular(50.r)),
                child: GestureDetector(
                  onTap: () async {
                    AppSessionManager().resetAll();
                    removeUser();
                    Get.offAllNamed(AppRoutes.signIn);
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConst.logout,
                        height: 38.h,
                        width: 38.w,
                      ),
                      12.horizontalSpace,
                      Text(
                        'Logout',
                        style: context.titleLarge!.copyWith(
                            // fontFamily: 'Jockey One',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              // CustomButton(title: title)
              const Spacer(),
            ],
          ),
        ),
      ),
      child: HomeScreen(
        onTap: () => _handleMenuButtonPressed(bottomNavController),
      ),
    );
  }

  void _handleMenuButtonPressed(bottomNavController) {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    bottomNavController.advancedDrawerController.value = AdvancedDrawerValue.visible();
    // _advancedDrawerController.showDrawer();
    bottomNavController.isAppBarHide = true;
    bottomNavController.update();
  }
}

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: horizontalPadding,
      endIndent: 120.w,
      color: grey.withValues(alpha: 0.3),
    );
  }
}
