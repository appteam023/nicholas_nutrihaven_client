
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Config/AppRoutes/routes_imports.dart';
import '../../Helpers/app_extensions.dart';
import '../../Utils/Const/asset_const.dart';
import '../../Utils/Const/color_const.dart';
import '../../Utils/Extensions/text_extension.dart';
import '../../Widgets/custom_appbar.dart';
import '../../Widgets/custom_button.dart';
import 'diet_detail_screen.dart';
import 'food_lib_controller.dart';
import 'package:nicholas_nutrihaven/Data/Model/FoodLibModels/food_item_details_model.dart';

class RecipeDetailedView extends StatelessWidget {
  const RecipeDetailedView({
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
            // backgroundColor: themeColor,
            appBar: CustomAppBar(
              title: controller.foodItemDetails.value == null ? 'Error' : "${controller.foodItemDetails.value?.title}",
              // actionIcon: Icons.search,
            ),
            body: controller.foodItemDetails.value != null ?
            SingleChildScrollView(
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          // clipBehavior: Clip.antiAlias,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                // color: primary,
                                borderRadius: BorderRadius.circular(20.r),
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
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, _, stack) {
                                        return Image.asset(
                                          ImageConst.foodLib,
                                        );
                                      },
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              decoration: BoxDecoration(
                                // color: Colors.black.withValues(alpha: 0.),
                                borderRadius: BorderRadius.circular(20.r),
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
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Summary",
                              style: context.titleLarge!.copyWith(
                                fontFamily: 'Jockey One',
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                            Spacer(),
                            RepaintBoundary(
                              child: Image.asset(
                                "assets/images/food_lib/gif/score_animated_icon.gif",
                                width: 48,
                                height: 48,
                              ),
                            ),
                            Text(
                              "${controller.foodItemDetails.value?.spoonacularScore?.toStringAsFixed(2) ?? 0}",
                              style: context.titleLarge!.copyWith(
                                fontFamily: 'Jockey One',
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Html(
                          data: '${controller.foodItemDetails.value?.summary}',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10
                        ),
                        child: Text(
                          "Meal Characteristics",
                          style: context.titleLarge!.copyWith(
                            fontFamily: 'Jockey One',
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      Obx(()=> SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(
                            6, 0, 6, 6
                          ),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.vegetarian ?? false),
                                assetName: "1_vegetarian", details: "Vegetarian",  detailsVisibility: controller.mealCharacteristicsDetails[0],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[0] = !controller.mealCharacteristicsDetails[0];
                                }
                              ),
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.vegan ?? false),
                                assetName: "2_vegan", details: "Vegan",  detailsVisibility: controller.mealCharacteristicsDetails[1],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[1] = !controller.mealCharacteristicsDetails[1];
                                }
                              ),
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.glutenFree ?? false),
                                assetName: "3_gluten_free", details: "Gluten Free",  detailsVisibility: controller.mealCharacteristicsDetails[2],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[2] = !controller.mealCharacteristicsDetails[2];
                                }
                              ),
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.dairyFree ?? false),
                                assetName: "4_dairy_free", details: "Dairy Free",  detailsVisibility: controller.mealCharacteristicsDetails[3],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[3] = !controller.mealCharacteristicsDetails[3];
                                }
                              ),
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.veryHealthy ?? false),
                                assetName: "5_very_healthy", details: "Very Healthy",  detailsVisibility: controller.mealCharacteristicsDetails[4],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[4] = !controller.mealCharacteristicsDetails[4];
                                }
                              ),
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.cheap ?? false),
                                assetName: "6_cheap", details: "Cheap",  detailsVisibility: controller.mealCharacteristicsDetails[5],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[5] = !controller.mealCharacteristicsDetails[5];
                                }
                              ),
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.veryPopular ?? false),
                                assetName: "7_very_popular", details: "Very Popular",  detailsVisibility: controller.mealCharacteristicsDetails[6],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[6] = !controller.mealCharacteristicsDetails[6];
                                }
                              ),
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.sustainable ?? false),
                                assetName: "8_sustainable", details: "Sustainable",  detailsVisibility: controller.mealCharacteristicsDetails[7],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[7] = !controller.mealCharacteristicsDetails[7];
                                }
                              ),
                              mealCharacteristicsWidget(
                                context, visible: (controller.foodItemDetails.value?.lowFodmap ?? false),
                                assetName: "9_lowfodmap", details: "Low-FODMAP",  detailsVisibility: controller.mealCharacteristicsDetails[8],
                                onTap: () {
                                  controller.mealCharacteristicsDetails[8] = !controller.mealCharacteristicsDetails[8];
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        padding: EdgeInsets.only(
                          left: 20, right: 20,
                          bottom: 12, top: 16
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            top: BorderSide(
                              color: grey.withValues(alpha: 0.5),
                            )
                          )
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/food_lib/clock.png",
                              color: darkGrey,
                              scale: 2,
                            ),
                            5.horizontalSpace,
                            Text(
                              '${controller.foodItemDetails.value?.cookingMinutes ?? "-"} min',
                              style: context.labelSmall?.copyWith(color: darkGrey),
                            ),
                            const Spacer(),
                            Image.asset(
                              "assets/images/food_lib/cooking_pan.png",
                              color: darkGrey,
                              scale: 2,
                            ),
                            5.horizontalSpace,
                            Text(
                              '${controller.foodItemDetails.value?.nutrition?.caloricBreakdown?.percentFat ?? "-"} kcal',
                              style: context.labelSmall?.copyWith(color: darkGrey),
                            ),
                            const Spacer(),
                            Image.asset(
                              "assets/images/food_lib/servings.png",
                              color: darkGrey,
                              scale: 2,
                            ),
                            5.horizontalSpace,
                            Text(
                              '${controller.foodItemDetails.value?.servings ?? "-"} Serves',
                              style: context.labelSmall?.copyWith(color: darkGrey),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: (controller.foodItemDetails.value?.nutrition?.nutrients.listIsNotNullAndNotEmpty ?? false) ?
                          controller.foodItemDetails.value?.nutrition?.nutrients?.where(
                            (element) => controller.nutrients.entries.any((entry) => element.name?.toLowerCase() == entry.key)
                          ).mapIndexed((i, n) => nutrientWidget(context, n, controller.nutrients[n.name?.toLowerCase()])).toList() ?? [] : []
                        ),
                      ),
                      20.verticalSpace,
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.dietNutrientsDetail);
                          },
                          child: Text(
                            "View Detailed Nutrition",
                            style: context.titleLarge!.copyWith(
                              fontFamily: 'Jockey One',
                              color: black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Column(
                        // alignment: Alignment.topCenter,
                        // clipBehavior: Clip.antiAlias,
                        children: [
                          ExpandableSection(
                            title: 'Ingredients',
                            content: controller.foodItemDetails.value?.extendedIngredients != null &&
                                (controller.foodItemDetails.value?.extendedIngredients?.isNotEmpty ?? false)
                                ? ConstrainedBox(
                                  constraints: const BoxConstraints(maxHeight: 400),
                                  child: ListView.separated(
                                    padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
                                    // shrinkWrap: true,
                                    itemCount: controller.foodItemDetails.value?.extendedIngredients?.length ?? 0,
                                    itemBuilder: (context, index) {
                                    final ingredient = controller.foodItemDetails.value?.extendedIngredients![index];
                                    return IngredientTile(
                                      title: "${ingredient?.nameClean?.capitalizeFirst ?? ingredient?.nameClean?.capitalizeFirst}",
                                      image: "https://api.spoonacular.com/${ingredient?.image}",
                                      quantity: "${ingredient?.amount?.toStringAsFixed(2)}",
                                      unit: "${ingredient?.measures?.us?.unitShort ?? ingredient?.unit}",
                                    );
                                    },
                                    separatorBuilder: (context, index) {
                                      return 15.verticalSpace;
                                    },
                                  ),
                                ) : Center(
                              child: Text(
                                'Ingredients not found',
                                style: context.headlineMedium?.copyWith(
                                  color: grey
                                ),
                              ),
                            ),
                            backgroundColor: const Color(0xFFE3E7DE),
                            initialExpanded: false,
                          ),
                          Transform.translate(
                            offset: Offset(0, -16),
                            child: ExpandableSection(
                              height: 60,
                              title: 'Instruction',
                              content: controller.foodItemDetails.value?.instructions != null ?
                              Html(
                                data: '${controller.foodItemDetails.value?.instructions}',
                              ) : Center(
                                child: Text(
                                  'Instructions not found',
                                  style: context.headlineMedium?.copyWith(
                                    color: grey
                                  ),
                                ),
                              ),
                              backgroundColor: const Color(0xFFBFCFBC),
                              initialExpanded: false,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.r)
                              ),
                            ),
                          ),
                        ],
                      ),
                      40.verticalSpace,
                      // controller.foodItemDetails.value?.instructions != null ?
                      // Flexible(
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: horizontalPadding,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(25.r),
                      //         topRight: Radius.circular(25.r),
                      //       ),
                      //     ),
                      //     child: Html(
                      //       data: '${controller.foodItemDetails.value?.instructions}',
                      //     ),
                      //     // Text(
                      //     //   '${controller.foodItemDetails.value?.instructions}',
                      //     //   style: context.bodySmall?.copyWith(
                      //     //     color: Colors.black
                      //     //   ),
                      //     // ),
                      //   ),
                      // ) : Center(
                      //   child: Text(
                      //     'Instructions not found',
                      //     style: context.headlineMedium,
                      //   ),
                      // )
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

  Widget nutrientWidget(BuildContext context, Nutrients n, String? image) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 12
          ),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 12
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF0F4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Image.asset(
                image ?? "assets/images/explore.png",
                height: 40,
                scale: 2,
              ),
              SizedBox(height: 10,),
              Text(
                "${n.amount ?? "-" } ${n.unit ??"-"}",
                style: context.titleLarge!.copyWith(
                  fontFamily: 'Jockey One',
                  color: black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Text(n.name ?? "",
          style: context.labelSmall?.copyWith(color: black),
        ),
      ],
    );
  }

  Visibility mealCharacteristicsWidget(BuildContext context, {
    bool visible = false, String? assetName, required String details,
    required bool detailsVisibility, required VoidCallback onTap
  }) {
    return Visibility(
      visible: visible && assetName.isNotNullNotEmpty,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          onTap();
        },
        onTapUp: (TapUpDetails details) {
          onTap();
        },
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (detailsVisibility)
                Padding(
                  key: ValueKey(details),
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    details,
                    style: context.bodyMedium?.copyWith(
                      color: black,
                      fontSize: 14
                    ),
                  ),
                )
              else SizedBox(
                key: ValueKey("${details}hidden"),
                height: 24, //width: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CircleAvatar(
                  minRadius: 28,
                  backgroundColor: Color(0xFFEFF0F4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/food_lib/characteristics/$assetName.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
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
                  Get.close(4);
                },
              )
            )
          ],
        );
      },
    );
  }
}


class ExpandableSection extends StatefulWidget {
  final String title;
  final Widget content;
  final Color? backgroundColor;
  final bool initialExpanded;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.content,
    this.backgroundColor,
    this.height = 70,
    this.initialExpanded = false,
    this.borderRadius,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initialExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: widget.height,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius ?? BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.1),
        //     blurRadius: 4,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: context.titleLarge!.copyWith(
                      fontFamily: 'Jockey One',
                      color: black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0, // 0.5 turn = 180 degrees
                    duration: Duration(milliseconds: 300),
                    child: Icon(Icons.keyboard_arrow_down,),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isExpanded ? Container(
              constraints: const BoxConstraints(maxHeight: 400),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SingleChildScrollView(
                child: widget.content
              ),
            ) : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

