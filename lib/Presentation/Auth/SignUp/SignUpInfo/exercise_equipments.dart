// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
// import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
// import 'package:nicholas_nutrihaven/main.dart';

// import '../../../../Utils/Const/color_const.dart';

// class ExerciseEquipments extends StatelessWidget {
//   const ExerciseEquipments({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DefaultTabController(
//         length: 3,
//         child: Column(
//           children: [
//             80.verticalSpace,
//             Text(
//               "Exercise Equipments",
//               style: context.headlineLarge!
//                   .copyWith(color: primary, fontWeight: FontWeight.w400),
//               textAlign: TextAlign.center,
//             ),
//             20.verticalSpace,
//             TabBar(
//                 padding: EdgeInsets.zero,
//                 labelPadding: EdgeInsets.zero,
//                 indicatorColor: themeColor,
//                 labelColor: themeColor,
//                 labelStyle: context.bodySmall!
//                     .copyWith(fontFamily: 'Inter', fontWeight: FontWeight.w900),
//                 unselectedLabelStyle:
//                     context.bodySmall!.copyWith(fontFamily: 'Inter'),
//                 tabs: [
//                   Tab(
//                     text: 'Free Weights',
//                   ),
//                   Tab(
//                     text: 'Benches, Bars & Racks',
//                   ),
//                   Tab(
//                     text: 'Machines',
//                   ),
//                 ]),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: horizontalPadding,
//                   vertical: verticalPadding,
//                 ),
//                 child: TabBarView(

//                     // physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: equipments.length,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           '${equipments[index]['title']}',
//                                           style: context.headlineSmall!
//                                               .copyWith(
//                                                   fontSize: 20.sp,
//                                                   color: primary),
//                                         ),
//                                         index == 0
//                                             ? SizedBox(
//                                                 width: 120.w,
//                                                 child: CheckboxListTile(
//                                                   visualDensity: VisualDensity(
//                                                       vertical: -4),
//                                                   contentPadding:
//                                                       EdgeInsets.zero,
//                                                   value: true,
//                                                   onChanged: (value) {},
//                                                   title: Text(
//                                                     'Select All',
//                                                     style: context.labelSmall,
//                                                   ),
//                                                 ))
//                                             : const SizedBox.shrink(),
//                                       ],
//                                     ),
//                                     10.verticalSpace,
//                                     SizedBox(
//                                       width: 1.sw,
//                                       child: Wrap(
//                                           crossAxisAlignment:
//                                               WrapCrossAlignment.end,
//                                           // runAlignment: WrapAlignment.spaceBetween,
//                                           alignment: WrapAlignment.spaceBetween,
//                                           // spacing: 10.w,
//                                           children: List.generate(
//                                               equipments[index]['products']
//                                                   .length, (i) {
//                                             return Container(
//                                               padding: EdgeInsets.all(10.h),
//                                               margin:
//                                                   EdgeInsets.only(bottom: 10.h),
//                                               decoration: BoxDecoration(
//                                                 color: equipments[index]
//                                                                 ['products'][i]
//                                                             ['isSelected'] ==
//                                                         true
//                                                     ? themeColor
//                                                     : grey.withOpacity(0.3),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10.r),
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Text(
//                                                     '${equipments[index]['products'][i]['name']}',
//                                                     style: context.bodyLarge!
//                                                         .copyWith(
//                                                       color: equipments[index][
//                                                                       'products'][i]
//                                                                   [
//                                                                   'isSelected'] ==
//                                                               true
//                                                           ? secondary
//                                                           : primary,
//                                                       fontWeight: equipments[
//                                                                           index]
//                                                                       [
//                                                                       'products'][i]
//                                                                   [
//                                                                   'isSelected'] ==
//                                                               true
//                                                           ? FontWeight.bold
//                                                           : null,
//                                                     ),
//                                                   ),
//                                                   40.horizontalSpace,
//                                                   Container(
//                                                     height: 40.h,
//                                                     width: 40.h,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10.r),
//                                                     ),
//                                                     child: Image.asset(
//                                                       ImageConst.dumbbell,
//                                                       height: 30.h,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           })),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(),
//                       Column(),
//                     ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// List<Map<String, dynamic>> equipments = [
//   {
//     "title": 'Dumbbells',
//     "products": [
//       {
//         "name": 'Dumbbells',
//         "image": ImageConst.dumbbell,
//         "isSelected": true,
//       },
//     ]
//   },
//   {
//     "title": 'Barbells',
//     "products": [
//       {
//         "name": 'Barbells',
//         "image": ImageConst.dumbbell,
//         "isSelected": false,
//       },
//       {
//         "name": 'EZ Bar',
//         "image": ImageConst.dumbbell,
//         "isSelected": false,
//       },
//       {
//         "name": 'Trap Bar',
//         "image": ImageConst.dumbbell,
//         "isSelected": false,
//       },
//     ]
//   },
//   {
//     "title": 'Kettlebells',
//     "products": [
//       {
//         "name": 'Kettlebells',
//         "image": ImageConst.dumbbell,
//         "isSelected": false,
//       },
//     ]
//   },
//   {
//     "title": 'Medicine Balls',
//     "products": [
//       {
//         "name": 'Medicine Balls',
//         "image": ImageConst.dumbbell,
//         "isSelected": false,
//       },
//     ]
//   },
// ];
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/excersice_equipment_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

class ExerciseEquipments extends StatelessWidget {
  ExerciseEquipments({super.key});

  final ExerciseEquipmentController controller =
      Get.put(ExerciseEquipmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return DefaultTabController(
          length: controller.categories.length,
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
                indicatorColor: themeColor,
                labelColor: themeColor,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                tabs: controller.categories
                    .map((category) => Tab(text: category.category))
                    .toList(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding, vertical: verticalPadding),
                  child: TabBarView(
                    children: controller.categories.map((category) {
                      return ListView.builder(
                        itemCount: category.subCategories.length,
                        itemBuilder: (context, index) {
                          var subCategory = category.subCategories[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    subCategory.subCategory,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 120.w,
                                    child: CheckboxListTile(
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      contentPadding: EdgeInsets.zero,
                                      value:
                                          controller.isAllSelected(subCategory),
                                      onChanged: (value) {
                                        controller.toggleSelectAll(
                                            subCategory, value ?? false);
                                      },
                                      title: Text(
                                        'Select All',
                                        style: context.labelSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              10.verticalSpace,
                              SizedBox(
                                width: double.infinity,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Two items per row
                                    crossAxisSpacing: 10.w,
                                    mainAxisSpacing: 10.h,
                                    childAspectRatio:
                                        2.9, // Adjust ratio to fit content
                                  ),
                                  itemCount: subCategory.items.length,
                                  itemBuilder: (context, index) {
                                    var item = subCategory.items[index];

                                    return SizedBox(
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.toggleSelection(item);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                            color: item.isSelected
                                                ? themeColor
                                                : Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item.name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: item.isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                height: 55.h,
                                                width: 40.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Image.network(
                                                  "https://nutrihaven.testdevlink.net/${item.image}",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // SizedBox(
                              //   width: double.infinity,
                              //   child: Wrap(
                              //     crossAxisAlignment: WrapCrossAlignment.start,
                              //     alignment: WrapAlignment.start,
                              //     spacing: 10.w,
                              //     runSpacing: 10.h,
                              //     children: subCategory.items.map((item) {
                              //       return SizedBox(
                              //         width: (Get.width / 2) - 20,
                              //         child: GestureDetector(
                              //           onTap: () {
                              //             controller.toggleSelection(item);
                              //           },
                              //           child: Container(
                              //             padding: EdgeInsets.all(12.w),
                              //             decoration: BoxDecoration(
                              //               color: item.isSelected
                              //                   ? themeColor
                              //                   : Colors.grey.withOpacity(0.2),
                              //               borderRadius:
                              //                   BorderRadius.circular(10.r),
                              //             ),
                              //             child: Row(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.center,
                              //               children: [
                              //                 Expanded(
                              //                   child: Text(
                              //                     item.name,
                              //                     style: TextStyle(
                              //                       color: item.isSelected
                              //                           ? Colors.white
                              //                           : Colors.black,
                              //                       fontWeight: FontWeight.bold,
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 Container(
                              //                   height: 40.h,
                              //                   width: 40.h,
                              //                   decoration: BoxDecoration(
                              //                     color: Colors.white,
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             10.r),
                              //                   ),
                              //                   child: Image.network(
                              //                     "https://nutrihaven.testdevlink.net/${item.image}",
                              //                     height: 50.h,
                              //                     width: 50.w,
                              //                     fit: BoxFit.contain,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
