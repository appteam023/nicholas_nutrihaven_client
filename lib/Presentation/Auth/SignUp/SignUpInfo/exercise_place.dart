import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/excercise_place_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';

import '../../../../Utils/Const/color_const.dart';

// class ExercisePlace extends StatefulWidget {
//   const ExercisePlace({super.key});

//   @override
//   State<ExercisePlace> createState() => _ExercisePlaceState();
// }

// class _ExercisePlaceState extends State<ExercisePlace> {
//   int currentIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           80.verticalSpace,
//           Text(
//             "Exercise Place",
//             style: context.headlineLarge!
//                 .copyWith(color: primary, fontWeight: FontWeight.w400),
//             textAlign: TextAlign.center,
//           ),
//           20.verticalSpace,
//           Expanded(
//             child: ListView.builder(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: horizontalPadding,
//                 ),
//                 itemCount: plans.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       select(index);
//                     },
//                     child: Stack(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(bottom: 10.h),
//                           width: double.infinity,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 25.w, vertical: 20.h),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(25.r),
//                             color: currentIndex == index
//                                 ? themeColor
//                                 : Colors.grey.shade100,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${plans[index]['title']}',
//                                 style: context.bodyLarge!.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: currentIndex == index
//                                         ? secondary
//                                         : primary),
//                               ),
//                               Text(
//                                 '${plans[index]['desc']}',
//                                 style: currentIndex == index
//                                     ? context.bodySmall!
//                                         .copyWith(color: secondary)
//                                     : context.bodySmall,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                         ),
//                         currentIndex == index
//                             ? Positioned(
//                                 right: 10.w,
//                                 top: 10.h,
//                                 child: Container(
//                                   padding: EdgeInsets.all(3.h),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     color: Colors.green,
//                                   ),
//                                   child: Icon(
//                                     Icons.check,
//                                     color: secondary,
//                                     size: 20.sp,
//                                   ),
//                                 ))
//                             : SizedBox.shrink(),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }

//   select(index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
// }

// List<Map<String, String>> plans = [
//   {
//     "title": 'Large Gym',
//     "desc":
//         'Nutri Haven will complete a starter equipment list based on the location you pick.'
//   },
//   {"title": 'Small Gym', "desc": 'Compact public gyms with limited equipment'},
//   {"title": 'Garage Gym', "desc": 'Barbells, Squat rack, dumbbells and more'},
//   {
//     "title": 'At Home',
//     "desc": 'Limited equipment such as dumbells, bands,  pull-up bars, etc'
//   },
//   {
//     "title": 'Bodyweight Only',
//     "desc": 'Workout anywhere without gym equipment'
//   },
//   {"title": 'Custom', "desc": 'Workout anywhere without gym equipment'},
// ];

class ExercisePlace extends StatefulWidget {
  const ExercisePlace({super.key});

  @override
  State<ExercisePlace> createState() => _ExercisePlaceState();
}

class _ExercisePlaceState extends State<ExercisePlace> {
  late final AddpreferencesController addPreferencesController;
  final ExercisePlaceController controller = Get.put(ExercisePlaceController());
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    addPreferencesController =  Get.find<AddpreferencesController>();
    if(addPreferencesController.exercisePlace.isNotEmpty) {
      currentIndex = controller.exercisePlaces.indexWhere((e) => e.name == addPreferencesController.exercisePlace) ?? -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          80.verticalSpace,
          Text(
            "Exercise Place",
            style: context.headlineLarge!
                .copyWith(color: primary, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          20.verticalSpace,
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.exercisePlaces.isEmpty) {
                return Center(child: Text("No Exercise Places Available"));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                itemCount: controller.exercisePlaces.length,
                itemBuilder: (context, index) {
                  var exercise = controller.exercisePlaces[index];

                  return GestureDetector(
                    onTap: () {
                      select(index);
                      log(index.toString());
                      addPreferencesController.exercisePlace = exercise.name.toString();
                      log(addPreferencesController.exercisePlace);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: currentIndex == index
                                ? themeColor
                                : Colors.grey.shade100,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise.name.toString(),
                                style: context.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: currentIndex == index
                                      ? secondary
                                      : primary,
                                ),
                              ),
                              Text(
                                exercise.description.toString(),
                                style: currentIndex == index
                                    ? context.bodySmall!
                                        .copyWith(color: secondary)
                                    : context.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (currentIndex == index)
                          Positioned(
                            right: 10.w,
                            top: 10.h,
                            child: Container(
                              padding: EdgeInsets.all(3.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.check,
                                color: secondary,
                                size: 20.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void select(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
