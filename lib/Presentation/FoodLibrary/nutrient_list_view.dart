

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../../Utils/Const/color_const.dart';
import '../../Widgets/custom_appbar.dart';
import 'food_lib_controller.dart';

class NutrientListView extends StatelessWidget {
  const NutrientListView({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return GetX<FoodLibController>(
      init: Get.find<FoodLibController>(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Nutrients",
          ),
          body: controller.foodItemDetails.value?.nutrition?.nutrients != null
              && (controller.foodItemDetails.value?.nutrition?.nutrients?.isNotEmpty ?? false) ?
           SafeArea(
             child: RawScrollbar(
               thumbColor: grey,
               child: ListView.builder(
                 padding: EdgeInsets.only(top: 20, bottom: 20),
                 itemCount: (controller.foodItemDetails.value?.nutrition?.nutrients?.length ?? 0),
                 itemBuilder: (context, index) {
                   final element = controller.foodItemDetails.value?.nutrition?.nutrients![index];
                   return Container(
                     margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                     decoration: BoxDecoration(
                       color: Color(0xFFEFF0F4),
                       borderRadius: BorderRadius.all(Radius.circular(20))
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 4.0),
                               child: Text(
                                 "${element?.name}",
                                 style: context.titleMedium?.copyWith(
                                   color: black,
                                   fontSize: 16
                                 ),
                               ),
                             ),
                             Text(
                               "Amount: ${element?.amount ?? "-"}",
                               style: context.bodyMedium?.copyWith(
                                 color: darkGrey,
                                 fontSize: 14
                               ),
                             ),
                             Text(
                               "Daily Needs: ${element?.percentOfDailyNeeds ?? "-"}",
                               style: context.bodyMedium?.copyWith(
                                 color: darkGrey,
                                 fontSize: 14
                               ),
                             ),
                           ],
                         ),
                         Padding(
                           padding: const EdgeInsets.only(top: 6.0),
                           child: Text(
                             "Unit: ${element?.unit ?? "-"}",
                             style: context.bodyMedium?.copyWith(
                               color: darkGrey,
                               fontSize: 14
                             ),
                           ),
                         ),
                       ],
                     ),
                   );
                 }
               ),
             ),
           ): Center(
            child: Text(
              'Nutrients not found',
              style: context.headlineMedium,
            ),
          ),
        );
      },
    );
  }
}