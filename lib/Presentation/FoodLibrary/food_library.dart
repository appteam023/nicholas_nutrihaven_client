import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import '../../Config/AppRoutes/routes_imports.dart';
import '../../Utils/Const/asset_const.dart';
import '../../Utils/Const/color_const.dart';
import '../../Widgets/custom_dropdown_widget.dart';
import 'data_provider/models/cuisine_model.dart';
import 'food_lib_controller.dart';

class FoodLibrary extends StatelessWidget {
  const FoodLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<FoodLibController>(
      init: Get.find<FoodLibController>(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller?.fetchMenuItems();
        });
      },
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            leadingIcon: Icons.arrow_back,
            actionIcon: Icons.search,
            onActionPressed: controller.toggleVisibility,
            title: 'Food Library',
            searchField: controller.searchFieldVisibility.value,
            searchTFCtrl: controller.searchTFCtrl,
            onChanged: (val) {
              if (val.length >= 2) {
                if (controller.searchQuery.value == val.trim()) {
                  return;
                }
                controller.searchQuery(val);
              } else if (val.isEmpty) {
                controller.searchQuery(val);
              }
            },
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Column(
                children: [
                  CustomDropdownButton<CuisineModel>(
                    hint: 'Select Cuisine',
                    selectedValue: controller.selectedCuisine.value,
                    dropdownItems: CuisineData.cuisineList,
                    buttonHeight: 22,
                    suffixIcon: controller.selectedCuisine.value != null ? IconButton(
                      onPressed: () {
                        controller.selectedCuisine.value = null;
                        controller.fetchMenuItems(reload: true, searchQuery: controller.searchTFCtrl.text);
                      },
                      icon: Icon(
                        Icons.close,
                      ),
                    ) : null,
                    onChanged: (value) {
                      if (controller.selectedCuisine.value == value) {
                        controller.selectedCuisine.value = null;
                      } else {
                        controller.selectedCuisine.value = value;
                      }
                      controller.fetchMenuItems(reload: true, searchQuery: controller.searchTFCtrl.text);
                    },
                    showSearchField: true,
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: controller.listOfRecipeItems.isNotEmpty ?
                    ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 13),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.listOfRecipeItems.length,
                      itemBuilder: (context, index) {
                        final element = controller.listOfRecipeItems[index];
                        return InkWell(
                          onTap: () {
                            controller.selectedRecipe = element;
                            Get.toNamed(
                              AppRoutes.dietDetail,
                              parameters: {
                                'id': element.id.toString(),
                              }
                            );
                          },
                          child: Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                // padding: EdgeInsets.symmetric(
                                //   horizontal: 20, vertical: 15.h
                                // ),
                                height: 180.h,
                                clipBehavior: Clip.antiAlias,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  // color: primary,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Image.network(
                                  "${element.image}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, stack) {
                                    return Image.asset(
                                      ImageConst.foodLib,
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15.h
                                ),
                                height: 180.h,
                                width: MediaQuery.sizeOf(context).width,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${element.title}',
                                        style: context.headlineSmall?.copyWith(
                                          fontSize: 22
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // Text(
                                    //   'The ketogenic diet is a very\nlow-carb, high-fat diet',
                                    //   style: context.titleSmall!
                                    //       .copyWith(fontFamily: 'Inter'),
                                    // ),
                                    10.verticalSpace,
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20.h,
                        );
                      },
                    ) : Center(
                      child: Text(
                        'No recipes found',
                        style: context.headlineMedium?.copyWith(
                          color: grey
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
