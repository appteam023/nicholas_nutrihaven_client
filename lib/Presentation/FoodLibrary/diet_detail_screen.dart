import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

class DietDetailScreen extends StatelessWidget {
  const DietDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      appBar: const CustomAppBar(
        title: 'Keto Diet',
        actionIcon: Icons.search,
      ),
      body: Column(
        children: [
          Center(child: Image.asset(ImageConst.diet)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Row(
              children: [
                Text(
                  'Ingredients',
                  style: context.headlineMedium,
                ),
                const Spacer(),
                Icon(
                  Icons.watch_later_outlined,
                  color: grey,
                ),
                5.horizontalSpace,
                Text(
                  '15 min',
                  style: context.labelSmall!.copyWith(color: grey),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 30.h),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return IngredientTile(
                    title: ingredients[index].title,
                    image: ingredients[index].image,
                    quantity: ingredients[index].quantity,
                    unit: ingredients[index].unit,
                  );
                },
                separatorBuilder: (context, index) {
                  return 15.verticalSpace;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientTile extends StatelessWidget {
  const IngredientTile({
    super.key,
    required this.title,
    required this.image,
    required this.quantity,
    required this.unit,
  });

  final String title;
  final String image;
  final String quantity;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: grey.withOpacity(
            0.2,
          ),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(
          10.h,
        ),
        child: Image.asset(
          image,
        ),
      ),
      title: Text(
        title,
        style: context.bodyLarge,
      ),
      trailing: Text.rich(
        TextSpan(
          text: quantity,
          style: context.titleSmall!
              .copyWith(color: primary, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: ' $unit',
              style: context.bodySmall!.copyWith(
                color: primary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Ingredient> ingredients = [
  Ingredient(
      title: 'Veggie',
      image: ImageConst.ingredient1,
      quantity: '1',
      unit: 'Sliced'),
  Ingredient(
      title: 'Veggie',
      image: ImageConst.ingredient1,
      quantity: '1',
      unit: 'Sliced'),
  Ingredient(
      title: 'Veggie',
      image: ImageConst.ingredient1,
      quantity: '1',
      unit: 'Sliced'),
  Ingredient(
      title: 'Veggie',
      image: ImageConst.ingredient1,
      quantity: '1',
      unit: 'Sliced'),
  Ingredient(
      title: 'Veggie',
      image: ImageConst.ingredient1,
      quantity: '1',
      unit: 'Sliced'),
];

class Ingredient {
  String title;
  String image;
  String quantity;
  String unit;

  Ingredient(
      {required this.title,
      required this.image,
      required this.quantity,
      required this.unit});
}
