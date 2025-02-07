import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String kcalInfo;
  final String intakeInfo;
  final String recommendedFood;
  final String calorieInfo;
  final String imageTitle;
  final String imageRecommendedFood;
  final String imageCalories;
  final Color backgroundColor;
  final Color textColor;
  final Color arrowColor;
  final Color borderColor;
  final VoidCallback onTap; // Callback to handle tap

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.kcalInfo,
    required this.intakeInfo,
    required this.recommendedFood,
    required this.calorieInfo,
    required this.imageTitle,
    required this.imageRecommendedFood,
    required this.imageCalories,
    required this.onTap, // Handle the tap outside of this widget
    this.backgroundColor = const Color(0XFFE1F0F2),
    this.textColor = const Color(0xFF5B5B5B),
    this.arrowColor = const Color(0xFF008080), // seaGreen
    this.borderColor = const Color(0xFF707070), // darkGrey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 50),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    kcalInfo,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: arrowColor),
                  ),
                  true ? Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                    color: arrowColor,
                  ):Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 20,
                    color: arrowColor,
                  ),
                ],
              ),
              Text(
                intakeInfo,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(color: borderColor),
              ),
            ],
          ),
          title: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                20.verticalSpace,
                CircleAvatar(
                  radius: 25,
                  backgroundColor: arrowColor,
                  child: Image.asset(imageTitle),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 20.sp),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          childrenPadding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            Row(
              children: [
                15.horizontalSpace,
                Image.asset(
                  imageRecommendedFood,
                  height: 20.h,
                ),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended Food:',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      recommendedFood,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor),
                    ),
                  ],
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              children: [
                15.horizontalSpace,
                Image.asset(
                  imageCalories,
                  height: 20.h,
                ),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calories:',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      calorieInfo,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor),
                    ),
                  ],
                ),
              ],
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
