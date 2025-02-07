import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_TextField.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import '../../../Config/AppRoutes/routes_imports.dart';
import '../../../Utils/Const/asset_const.dart';
import '../Widgets/custom_expansion_tile_widget.dart';

class BreakfastMeals extends StatelessWidget {
  const BreakfastMeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBar(
        title: 'Breakfast Meals',
        // actions: [
        // CircleAvatar(
        // radius: 24.r,
        // backgroundColor: secondary.withOpacity(0.1),
        // child: Icon(
        //   Icons.more_vert,
        //   color: secondary,
        // ),
      ),
      // ),
      // 5.horizontalSpace,
      // ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Food Item To Your Breakfast',
                  style: context.headlineSmall!.copyWith(color: primary),
                ),
                20.verticalSpace,
                CustomExpansionTile(
                  title: 'BreakFast',
                  subtitle: 'Statistics',
                  kcalInfo: '800Kcal',
                  intakeInfo: 'Intake calories 20%',
                  recommendedFood: 'Grilled Avocado, Salad, Yogurt',
                  calorieInfo: '450 Kcal to 520 Kcal under',
                  imageTitle: ImageConst.eggs,
                  imageRecommendedFood: ImageConst.foodPot,
                  imageCalories: ImageConst.cal,
                  onTap: () {
                    Get.toNamed(AppRoutes.breakfast);
                  },
                ),
                20.verticalSpace,
                Text(
                  'Select Food Category',
                  style: context.headlineSmall!
                      .copyWith(color: primary, fontSize: 22),
                ),
                20.verticalSpace,

                ///Food Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 140.h,
                      width: 112.w,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConst.drinks),
                          20.verticalSpace,
                          Text(
                            'Drinks',
                            style: context.labelSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 140.h,
                      width: 112.w,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConst.pot),
                          20.verticalSpace,
                          Text(
                            'Drinks',
                            style: context.labelSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 140.h,
                      width: 112.w,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConst.combos),
                          20.verticalSpace,
                          Text(
                            'Drinks',
                            style: context.labelSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                CustomTextField(hintText: 'Enter Food Name Here'),
                Divider(
                  color: grey,
                ),
                10.verticalSpace,
                CustomTextField(hintText: 'Enter Cal'),
                Divider(
                  color: grey,
                ),
                10.verticalSpace,
                CustomTextField(hintText: 'Enter Food Type'),
                Divider(
                  color: grey,
                ),
                40.verticalSpace,
                CustomButton(title: 'Add Food', onTap: () => Get.back(),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
