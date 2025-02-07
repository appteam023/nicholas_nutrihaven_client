import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../../../Utils/Const/color_const.dart';
import '../meal_tracker_controller.dart';

class ConsumedCalories extends StatelessWidget {
  const ConsumedCalories({
    super.key,
    required this.controller,
  });

  final MealTrackerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final double consumed = controller.consumedCalories.value;
      final double target = controller.targetCalories.value;
      final double progress = consumed / target;
      return Card(
        color: const Color(0xFF002D32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Consumed Today',
                  style: context.labelMedium!.copyWith(color: secondary)
              ),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '${consumed.toInt()} / ',
                            style: context.bodySmall!.copyWith(fontSize: 24, color: secondary)
                        ),
                        TextSpan(
                            text: '${target.toInt()} Cal',
                            style: context.bodySmall!.copyWith(fontSize: 24, color: grey)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20.r),
                value: progress,
                backgroundColor: secondary,
                valueColor:
                AlwaysStoppedAnimation<Color>(Color(0xff28EB67)),
                minHeight: 5,
              ),
            ],
          ),
        ),
      );
    });
  }
}
