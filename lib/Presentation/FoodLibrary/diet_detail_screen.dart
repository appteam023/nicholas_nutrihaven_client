import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

import 'food_lib_controller.dart';
import 'recipe_detailed_view.dart';

class DietDetailScreen extends StatelessWidget {
  const DietDetailScreen({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return GetX<FoodLibController>(
      init: Get.find<FoodLibController>(),
      initState: (state) {
        state.controller?.foodItemDetails.value = null;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller?.fetchMenuItemDetails(
              Get.parameters["id"].toString()
          );
        });
      },
      dispose: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller?.foodItemDetails.value = null;
        });
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: themeColor,
          appBar: CustomAppBar(
            title: controller.foodItemDetails.value == null ? 'Error' : "${controller.foodItemDetails.value?.title}",
            // actionIcon: Icons.search,
          ),
          body: controller.foodItemDetails.value != null ?
          GestureDetector(
            onTap: (){
              Get.to(() => RecipeDetailedView());
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.network(
                      "${controller.foodItemDetails.value?.image}",
                      errorBuilder: (context, _, stack) {
                        return Image.asset(
                          ImageConst.foodLib,
                        );
                      },
                      fit: BoxFit.cover,
                    )
                  ),
                ),
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
                        '${controller.foodItemDetails.value?.cookingMinutes} min',
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
                    child: controller.foodItemDetails.value?.extendedIngredients != null &&
                        (controller.foodItemDetails.value?.extendedIngredients?.isNotEmpty ?? false)
                        ? ListView.separated(
                      padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
                      itemCount: controller.foodItemDetails.value?.extendedIngredients?.length ?? 0,
                      itemBuilder: (context, index) {
                        final ingredient = controller.foodItemDetails.value?.extendedIngredients![index];
                        return IngredientTile(
                          title: "${ingredient?.nameClean?.capitalizeFirst ?? ingredient?.nameClean?.capitalizeFirst}",
                          image: "https://api.spoonacular.com/${ingredient?.image}",
                          quantity: "${ingredient?.amount}",
                          unit: "${ingredient?.measures?.us?.unitShort ?? ingredient?.unit}",
                        );
                      },
                      separatorBuilder: (context, index) {
                        return 15.verticalSpace;
                      },
                    ) : Text(
                      'Ingredients not found',
                      style: context.headlineMedium?.copyWith(
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          : Center(
            child: Text(
              'Details not found',
              style: context.headlineMedium,
            ),
          )
        );
      },
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
      contentPadding: EdgeInsets.zero,
      leading: Container(
        decoration: BoxDecoration(
          color: grey.withValues(
            alpha: 0.2,
          ),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(
          10.h,
        ),
        child: Image.asset(
          ImageConst.ingredient1,
          height: 24,
        ),
        // Image.network(
        //   image,
        //   errorBuilder: (context, _, stack) {
        //     return Image.asset(
        //       ImageConst.ingredient1,
        //     );
        //   },
        // ),
      ),
      title: Text(
        title,
        style: context.bodyMedium,
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
                color: primary.withValues(alpha: 0.7),
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
