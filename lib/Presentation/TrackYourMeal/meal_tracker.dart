import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import '../../Config/AppRoutes/routes_imports.dart';
import '../../Utils/Const/asset_const.dart';
import 'Widgets/consumed_calories_widget.dart';
import 'Widgets/custom_expansion_tile_widget.dart';
import 'Widgets/water_intake_widget.dart';
import 'meal_tracker_controller.dart';

class MealTracker extends StatelessWidget {
  final MealTrackerController controller = Get.put(MealTrackerController());

  @override
  Widget build(BuildContext context) {
    double totalConsumed = 2.6;
    double totalGoal = 5.0;
    int glassesConsumed = 3;
    int totalGlasses = 6;

    List<Map<String, dynamic>> glasses = [
      {'amount': 500, 'isConsumed': true},
      {'amount': 1.5, 'isConsumed': true},
      {'amount': 600, 'isConsumed': false},
      {'amount': 500, 'isConsumed': false},
      {'amount': 400, 'isConsumed': false},
    ];
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBar(
        // leadingOnTap: () {
        //   Get.back();
        // },
        title: 'Meal Tracker',
          // actions: [
          //   CircleAvatar(
          //     radius: 24.r,
          //     backgroundColor: secondary.withOpacity(0.1),
          //     child: Icon(
          //       Icons.more_vert,
          //       color: secondary,
          //     ),
          //   ),
          //   5.horizontalSpace,
          // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Your Progress
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFEFF0F4),
                      radius: 25.r,
                      child: Image.asset(ImageConst.progress),
                    ),
                    10.horizontalSpace,
                    Text('Your Progress', style: context.labelLarge),
                    const Spacer(),

                    /// Date Picker
                    GestureDetector(
                      onTap: () => controller.selectDate(context),
                      child: Container(
                        height: 60.h,
                        width: 148.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF0F4),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(() => Text(
                                  controller.formattedDate,
                                  style: context.labelMedium!
                                      .copyWith(color: darkGrey),
                                )),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,

                /// Nutrition Intake Section
                Text(
                  'Nutrition Intake',
                  style: context.headlineSmall!
                      .copyWith(color: primary, fontWeight: FontWeight.bold),
                ),
                10.verticalSpace,

                /// Consumed Today Widget
                ConsumedCalories(controller: controller),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// First CircularProgressIndicator
                    Container(
                      height: 100.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: grey.withOpacity(0.3),
                            value: 0.53,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xff008CC7)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Calories',
                                style: context.labelLarge!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              Text('530',
                                  style: context.labelLarge!
                                      .copyWith(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    10.horizontalSpace,

                    /// Second CircularProgressIndicator
                    Container(
                      height: 100.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: grey.withOpacity(0.3),
                            value: 0.80,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF28EB67)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Protein',
                                style: context.labelLarge!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              Text('80Cal',
                                  style: context.labelLarge!
                                      .copyWith(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// Third CircularProgressIndicator
                    Container(
                      height: 100.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: grey.withOpacity(0.3),
                            value: 0.65,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0XFFF5B800)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Carbs',
                                style: context.labelLarge!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              Text('173Cal',
                                  style: context.labelLarge!
                                      .copyWith(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    10.horizontalSpace,

                    /// Fourth CircularProgressIndicator
                    Container(
                      height: 100.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: grey.withOpacity(0.3),
                            value: 0.40,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0XFF6D62DA)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Fats',
                                style: context.labelLarge!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              Text('40Cal',
                                  style: context.labelLarge!
                                      .copyWith(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,

                ///Water Intake
                Text(
                  'Water Intake',
                  style: context.headlineSmall!
                      .copyWith(color: primary, fontWeight: FontWeight.bold),
                ),
                20.verticalSpace,
                WaterIntake(
                    glassesConsumed: glassesConsumed,
                    totalGlasses: totalGlasses,
                    totalConsumed: totalConsumed,
                    totalGoal: totalGoal,
                    glasses: glasses),
                20.verticalSpace,

                ///Recent Meal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Meal',
                      style: context.headlineSmall!.copyWith(
                          color: primary, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: context.labelSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
                20.verticalSpace,

                ///Breakfast
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
                10.verticalSpace,
                ///Lunch
                CustomExpansionTile(
                  title: 'Lunch',
                  subtitle: 'Statistics',
                  kcalInfo: '430Kcal',
                  intakeInfo: 'Intake calories 10%',
                  recommendedFood: 'Grilled Avocado, Salad, Yogurt',
                  calorieInfo: '450 Kcal to 520 Kcal under',
                  imageTitle: ImageConst.bread,
                  imageRecommendedFood: ImageConst.foodPot,
                  imageCalories: ImageConst.cal,
                  onTap: () {},

                ),
                10.verticalSpace,
                ///Dinner
                CustomExpansionTile(
                  title: 'Dinner',
                  subtitle: 'Statistics',
                  kcalInfo: '800Kcal',
                  intakeInfo: 'Intake calories 27%',
                  recommendedFood: 'Grilled Avocado, Salad, Yogurt',
                  calorieInfo: '450 Kcal to 520 Kcal under',
                  imageTitle: ImageConst.din,
                  imageRecommendedFood: ImageConst.foodPot,
                  imageCalories: ImageConst.cal,
                  onTap: () {},
                ),
                10.verticalSpace,
                ///Snacks
                CustomExpansionTile(
                  title: 'Snacks',
                  subtitle: 'Statistics',
                  kcalInfo: '200Kcal',
                  intakeInfo: 'Intake calories 5%',
                  recommendedFood: 'Grilled Avocado, Salad, Yogurt',
                  calorieInfo: '450 Kcal to 520 Kcal under',
                  imageTitle: ImageConst.snacks,
                  imageRecommendedFood: ImageConst.foodPot,
                  imageCalories: ImageConst.cal,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
