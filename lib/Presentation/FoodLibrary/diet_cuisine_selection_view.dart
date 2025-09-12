import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Config/AppRoutes/routes_imports.dart';
import '../../Utils/Const/color_const.dart';
import '../../Utils/Extensions/text_extension.dart';
import '../../Widgets/custom_appbar.dart';
import '../../Utils/Const/asset_const.dart';
import 'food_lib_controller.dart';

class DietCuisineSelectionView extends StatelessWidget {
  const DietCuisineSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<FoodLibController>(
      init: FoodLibController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            leadingIcon: Icons.arrow_back,
            title: 'Diet and Cuisine',
          ),
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height ,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildStepperWidget(
                          context, "\t\t\t\tSelect Diet","1", isSelected: controller.stepperCount.value == 1,
                          onTap: () {
                            controller.stepperCount.value = 1;
                          }
                        ),
                        buildStepperWidget(context, "\t\t\t\tSelect Cuisine","2", isSelected: controller.stepperCount.value == 2),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Flexible(
                      child: AnimatedCrossFade(
                        duration: Duration(milliseconds: 800),
                        crossFadeState: controller.stepperCount.value == 1 ?
                          CrossFadeState.showFirst : CrossFadeState.showSecond,
                        firstChild: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: DietData.dietList.map((element) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.stepperCount.value = 2;
                                    controller.selectedDiet.value = element;
                                  },
                                  child: Stack(
                                    fit: StackFit.loose,
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 180.h,
                                        width: MediaQuery.sizeOf(context).width,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          // color: primary,
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: Image.asset(
                                          ImageConst.dietBg,
                                          fit: BoxFit.fitWidth,
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
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                element.name,
                                                style: context.headlineSmall,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                element.description,
                                                style: context.titleSmall?.copyWith(fontFamily: 'Inter'),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          ),
                        ),
                        secondChild: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: CuisineData.cuisineList.map((element) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.grey.shade50,
                                  elevation: 4,
                                  child: ListTile(
                                    onTap: () {
                                      controller.selectedCuisine.value = element;
                                      Get.toNamed(
                                        AppRoutes.foodLibrary,
                                        // parameters: {
                                        //   'id': element.id.toString(),
                                        // }
                                      );
                                    },
                                    leading: Text(element.flagIcon, style: TextStyle(fontSize: 24)),
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          element.name,
                                          style: context.labelLarge?.copyWith(
                                            color: black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList()
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildStepperWidget(BuildContext context, String title, String count, {
    bool isSelected = false, VoidCallback? onTap
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.titleMedium?.copyWith(
                color: isSelected ?  black : grey,
                fontSize: 16,
                letterSpacing: 1,
                height: 0,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2.5,
                  child: Divider(
                    color: isSelected ?  black : grey,
                    thickness: 2,
                    height: 0,
                    indent: 5,
                    endIndent: 10,
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: isSelected ?  black : grey,
                  child: Text(count,style: TextStyle(color: Colors.white),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
