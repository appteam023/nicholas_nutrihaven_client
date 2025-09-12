import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';

import '../../Widgets/custom_button.dart';
import 'food_lib_controller.dart';

class RecipeDetailedView extends StatelessWidget {
  const RecipeDetailedView({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return GetX<FoodLibController>(
      init: Get.find<FoodLibController>(),
      builder: (controller) {
        return Scaffold(
            // backgroundColor: themeColor,
            appBar: CustomAppBar(
              title: controller.foodItemDetails.value == null ? 'Error' : "${controller.foodItemDetails.value?.title}",
              // actionIcon: Icons.search,
            ),
            body: controller.foodItemDetails.value != null ?
            SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                // color: primary,
                                borderRadius: BorderRadius.circular(10.r),
                                gradient: LinearGradient(
                                  colors: [
                                    // Colors.black.withValues(alpha: 0.7),
                                    Colors.black.withValues(alpha: 0.8),
                                    // Colors.transparent,
                                    Colors.black.withValues(alpha: 0.15),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: Center(
                                child: Image.network(
                                  "${controller.foodItemDetails.value?.image}",
                                  errorBuilder: (context, _, stack) {
                                    return Image.network(
                                      "${controller.selectedRecipe?.image}",
                                      errorBuilder: (context, _, stack) {
                                        return Image.asset(
                                          ImageConst.foodLib,
                                        );
                                      },
                                    );
                                  },
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              decoration: BoxDecoration(
                                // color: Colors.black.withValues(alpha: 0.),
                                borderRadius: BorderRadius.circular(10.r),
                                gradient: LinearGradient(
                                  colors: [
                                    // Colors.black.withValues(alpha: 0.7),
                                    Colors.black.withValues(alpha: 0.7),
                                    // Colors.transparent,
                                    Colors.black.withValues(alpha: 0.15),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                '${controller.foodItemDetails.value?.summary}',
                                style: context.bodySmall,
                                maxLines: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 12
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: grey,
                            ),
                            5.horizontalSpace,
                            Text(
                              '${controller.foodItemDetails.value?.cookingMinutes} min',
                              style: context.labelSmall!.copyWith(color: grey),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.star,
                              color: grey,
                            ),
                            5.horizontalSpace,
                            Text(
                              '${controller.foodItemDetails.value?.aggregateLikes} likes',
                              style: context.labelSmall!.copyWith(color: grey),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.room_service_outlined,
                              color: grey,
                            ),
                            5.horizontalSpace,
                            Text(
                              '${controller.foodItemDetails.value?.servings} Serves',
                              style: context.labelSmall!.copyWith(color: grey),
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      controller.foodItemDetails.value?.instructions != null ?
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r),
                            ),
                          ),
                          child: Text(
                            '${controller.foodItemDetails.value?.instructions}',
                            style: context.bodySmall?.copyWith(
                              color: Colors.black
                            ),
                          ),
                        ),
                      ) : Center(
                        child: Text(
                          'Instructions not found',
                          style: context.headlineMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ) : Center(
              child: Text(
                'Details not found',
                style: context.headlineMedium,
              ),
            ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 60, right: 60),
            child: CustomButton(
              width: 1.sw - horizontalPadding,
              title: 'Finished Cooking',
              onTap: () {
                dialogBuilder(context, controller);
              },
            ),
          ),
        );
      },
    );
  }
  Future<void> dialogBuilder(BuildContext context, FoodLibController controller, ) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,

          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/correct.png"),
                Text(
                  'Congratulations',
                  style: context.headlineLarge!.copyWith(color: primary),
                ),
                10.verticalSpace,
                Text(
                  "You have successfully cooked your ${controller.foodItemDetails.value?.title} diet. Enjoy your meal",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                title: "Continue",
                width: 250.w,
                onTap: () {
                  Get.close(5);
                },
              )
            )
          ],
        );
      },
    );
  }
}

