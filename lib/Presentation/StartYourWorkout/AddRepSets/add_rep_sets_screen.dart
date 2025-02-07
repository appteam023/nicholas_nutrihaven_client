import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignIn/signin.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';

import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_appbar.dart';

class AddRepSetsScreen extends StatelessWidget {
  const AddRepSetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBar(
        title: 'Dumbbell Bicep Curls',
        actionImage: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.instructionVideo);
          },
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
        actionImageBG: secondary.withOpacity(0.1),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Divider(color: grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "3 Sets",
                      style: context.labelSmall!.copyWith(
                          fontWeight: FontWeight.bold, color: darkTheme),
                    ),
                  ),
                  Expanded(flex: 2, child: Divider(color: grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer_off_outlined,
                          color: darkTheme,
                          size: 18.h,
                        ),
                        3.horizontalSpace,
                        Text(
                          "off",
                          style: context.labelSmall!.copyWith(
                              fontWeight: FontWeight.bold, color: darkTheme),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding * 1.2,
                  vertical: verticalPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: grey.withOpacity(0.5)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "First Set",
                    style: context.labelSmall!
                        .copyWith(fontWeight: FontWeight.bold, color: yellow),
                  ),
                  Text(
                    "5 Reps  /  0 Kilos",
                    style: context.labelLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                  ),
                  Text(
                    "Added Weight",
                    style: context.bodySmall!.copyWith(color: grey),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding * 1.2,
                  vertical: verticalPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: grey.withOpacity(0.5)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Second Set",
                    style: context.labelSmall!
                        .copyWith(fontWeight: FontWeight.bold, color: yellow),
                  ),
                  Text(
                    "5 Reps  /  0 Kilos",
                    style: context.labelLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding * 1.2,
                  vertical: verticalPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: grey.withOpacity(0.5)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Second Set",
                    style: context.labelSmall!
                        .copyWith(fontWeight: FontWeight.bold, color: yellow),
                  ),
                  Text(
                    "5 Reps  /  0 Kilos",
                    style: context.labelLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                  ),
                ],
              ),
            ),

            20.verticalSpace,
            SizedBox(
              width: 120.w,
              child: CustomButton(
                title: "+ Add Sets",
                onTap: () {},
              ),
            ),
            20.verticalSpace,
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.instructionVideo);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding*2,),
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Follow & Watch Now",
                          style: context.labelSmall!
                              .copyWith(fontWeight: FontWeight.bold, color: yellow),
                        ),
                        Text(
                          "Instructions & Videos",
                          style: context.labelLarge!
                              .copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: yellowText,
                      child: Icon(Icons.play_arrow,color: Colors.white,),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
