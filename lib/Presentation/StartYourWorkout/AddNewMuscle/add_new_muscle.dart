import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';

import '../../../Utils/Const/asset_const.dart';

class AddNewMuscleScreen extends StatelessWidget {
  const AddNewMuscleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.close,
        title: 'Add New Muscle',
        actionIcon: Icons.search,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Text(
                'Pick the muscle groups you want to workout.',
                style: context.bodyMedium,
              ),
              15.verticalSpace,
              Text(
                'Main Muscle Groups',
                style: context.headlineSmall!.copyWith(color: primary),
              ),
              20.verticalSpace,

              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.67,
                    crossAxisSpacing: 38.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemCount: muscles.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  index == 0 ? themeColor : Colors.transparent,
                              width: index == 0 ? 1.w : 0,
                            ),
                            borderRadius:
                                BorderRadius.circular(index == 0 ? 10.r : 0),
                            color: themeColor,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                muscles[index].image,
                                height: 100.h,
                                fit: BoxFit.cover,
                              ),
                              index == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: yellow.withOpacity(0.5)),
                                      height: 100.h,
                                      width: 100.w,
                                    )
                                  : const SizedBox.shrink(),
                              index == 0
                                  ? Container(
                                      // height: 25.h,
                                      // width: 25.h,
                                      padding: EdgeInsets.all(5.h),
                                      decoration: BoxDecoration(
                                        color: themeColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                        Text(
                          muscles[index].name,
                          style: context.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                        Text(
                          muscles[index].percentage,
                          style: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: grey,
                          ),
                        ),
                      ],
                    );
                  }),
              20.verticalSpace,

              Text(
                'Accessory Muscle Groups',
                style: context.headlineSmall!.copyWith(color: primary),
              ),
              20.verticalSpace,
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.67,
                    crossAxisSpacing: 38.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemCount: muscles.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  index == 0 ? themeColor : Colors.transparent,
                              width: index == 0 ? 1.w : 0,
                            ),
                            borderRadius:
                                BorderRadius.circular(index == 0 ? 10.r : 0),
                            color: themeColor,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                muscles[index].image,
                                height: 100.h,
                                fit: BoxFit.cover,
                              ),
                              index == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: yellow.withOpacity(0.5)),
                                      height: 100.h,
                                      width: 100.w,
                                    )
                                  : const SizedBox.shrink(),
                              index == 0
                                  ? Container(
                                      // height: 25.h,
                                      // width: 25.h,
                                      padding: EdgeInsets.all(5.h),
                                      decoration: BoxDecoration(
                                        color: themeColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                        Text(
                          muscles[index].name,
                          style: context.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                        Text(
                          muscles[index].percentage,
                          style: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: grey,
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(title: "Add 3 Muscles", onTap: () => Get.back(), width: 180.w,),
    );
  }
}

List<Muscle> muscles = [
  Muscle(ImageConst.abs, 'Abs', '100%'),
  Muscle(ImageConst.back, 'Back', '100%'),
  Muscle(ImageConst.bicep2x, 'Biceps', '100%'),
  Muscle(ImageConst.chest, 'Chest', '60%'),
  Muscle(ImageConst.glutes, 'Glutes', '100%'),
  Muscle(ImageConst.hamstrings, 'Hamstrings', '100%'),
  Muscle(ImageConst.quadriceps, 'Quadriceps', '100%'),
  Muscle(ImageConst.shoulders, 'Shoulders', '100%'),
  Muscle(ImageConst.tricepMuscle, 'Triceps', '100%'),
  Muscle(ImageConst.lowerback, 'Lower Back', '100%'),
];

class Muscle {
  String image;

  Muscle(this.image, this.name, this.percentage);

  String name;
  String percentage;
}
