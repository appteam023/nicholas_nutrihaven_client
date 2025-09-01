import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import '../../Config/AppRoutes/routes_imports.dart';
import '../../Utils/Const/asset_const.dart';
import 'food_lib_controller.dart';

class FoodLibrary extends StatelessWidget {
  const FoodLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<FoodLibController>(
      init: FoodLibController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            leadingIcon: Icons.arrow_back,
            actionIcon: Icons.search,
            onActionPressed: controller.toggleVisibility,
            title: 'Food Library',
            searchField: controller.searchFieldVisibility.value,
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
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 13),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.listOfMenuItems.length,
                      itemBuilder: (context, index) {
                        final element = controller.listOfMenuItems[index];
                        return InkWell(
                          onTap: () {
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
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  // color: primary,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Image.network(
                                  "${element.image}",
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
                                      Colors.black.withValues(alpha: 0.2),
                                      Colors.black.withValues(alpha: 0.1),
                                      // Colors.transparent,
                                      Colors.black.withValues(alpha: 0.7),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${element.title} ${element.title}',
                                        style: context.headlineSmall,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // Text(
                                    //   'The ketogenic diet is a very\nlow-carb, high-fat diet',
                                    //   style: context.titleSmall!
                                    //       .copyWith(fontFamily: 'Inter'),
                                    // ),
                                    20.verticalSpace,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4
                                      ),
                                      constraints: BoxConstraints(
                                        minHeight: 26.h,
                                        minWidth: 79.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.8),
                                        borderRadius: BorderRadius.circular(
                                          10.r
                                        )
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            ImageConst.diet, scale: 9,
                                          ),
                                          3.horizontalSpace,
                                          Text(
                                            'Serving: ${element.servings?.size} ${element.servings?.unit}',
                                            style: context.labelSmall!.copyWith(
                                              fontFamily: 'Product Sans',
                                              fontSize: 12.sp
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
