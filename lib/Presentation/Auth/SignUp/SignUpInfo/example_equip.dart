import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/main.dart';

import '../../../../Utils/Const/color_const.dart';

class ExcerciseEquipmentsExample extends StatelessWidget {
  const ExcerciseEquipmentsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            80.verticalSpace,
            Text(
              "Exercise Equipments",
              style: context.headlineLarge!
                  .copyWith(color: primary, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorColor: themeColor,
                labelColor: themeColor,
                labelStyle: context.bodySmall!
                    .copyWith(fontFamily: 'Inter', fontWeight: FontWeight.w900),
                unselectedLabelStyle:
                    context.bodySmall!.copyWith(fontFamily: 'Inter'),
                tabs: [
                  Tab(
                    text: 'Free Weights',
                  ),
                  Tab(
                    text: 'Benches, Bars & Racks',
                  ),
                  Tab(
                    text: 'Machines',
                  ),
                ]),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: TabBarView(

                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: equipments.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${equipments[index]['title']}',
                                          style: context.headlineSmall!
                                              .copyWith(
                                                  fontSize: 20.sp,
                                                  color: primary),
                                        ),
                                        index == 0
                                            ? SizedBox(
                                                width: 120.w,
                                                child: CheckboxListTile(
                                                  visualDensity: VisualDensity(
                                                      vertical: -4),
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  value: true,
                                                  onChanged: (value) {},
                                                  title: Text(
                                                    'Select All',
                                                    style: context.labelSmall,
                                                  ),
                                                ))
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                    10.verticalSpace,
                                    SizedBox(
                                      width: 1.sw,
                                      child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.end,
                                          // runAlignment: WrapAlignment.spaceBetween,
                                          alignment: WrapAlignment.spaceBetween,
                                          // spacing: 10.w,
                                          children: List.generate(
                                              equipments[index]['products']
                                                  .length, (i) {
                                            return Container(
                                              padding: EdgeInsets.all(10.h),
                                              margin:
                                                  EdgeInsets.only(bottom: 10.h),
                                              decoration: BoxDecoration(
                                                color: equipments[index]
                                                                ['products'][i]
                                                            ['isSelected'] ==
                                                        true
                                                    ? themeColor
                                                    : grey.withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '${equipments[index]['products'][i]['name']}',
                                                    style: context.bodyLarge!
                                                        .copyWith(
                                                      color: equipments[index][
                                                                      'products'][i]
                                                                  [
                                                                  'isSelected'] ==
                                                              true
                                                          ? secondary
                                                          : primary,
                                                      fontWeight: equipments[
                                                                          index]
                                                                      [
                                                                      'products'][i]
                                                                  [
                                                                  'isSelected'] ==
                                                              true
                                                          ? FontWeight.bold
                                                          : null,
                                                    ),
                                                  ),
                                                  40.horizontalSpace,
                                                  Container(
                                                    height: 40.h,
                                                    width: 40.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                    child: Image.asset(
                                                      ImageConst.dumbbell,
                                                      height: 30.h,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(),
                      Column(),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> equipments = [
  {
    "title": 'Dumbbells',
    "products": [
      {
        "name": 'Dumbbells',
        "image": ImageConst.dumbbell,
        "isSelected": true,
      },
    ]
  },
  {
    "title": 'Barbells',
    "products": [
      {
        "name": 'Barbells',
        "image": ImageConst.dumbbell,
        "isSelected": false,
      },
      {
        "name": 'EZ Bar',
        "image": ImageConst.dumbbell,
        "isSelected": false,
      },
      {
        "name": 'Trap Bar',
        "image": ImageConst.dumbbell,
        "isSelected": false,
      },
    ]
  },
  {
    "title": 'Kettlebells',
    "products": [
      {
        "name": 'Kettlebells',
        "image": ImageConst.dumbbell,
        "isSelected": false,
      },
    ]
  },
  {
    "title": 'Medicine Balls',
    "products": [
      {
        "name": 'Medicine Balls',
        "image": ImageConst.dumbbell,
        "isSelected": false,
      },
    ]
  },
];
