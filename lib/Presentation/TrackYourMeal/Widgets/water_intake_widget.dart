import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../../../Utils/Const/asset_const.dart';
import '../../../Utils/Const/color_const.dart';

class WaterIntake extends StatelessWidget {
  const WaterIntake({
    super.key,
    required this.glassesConsumed,
    required this.totalGlasses,
    required this.totalConsumed,
    required this.totalGoal,
    required this.glasses,
  });

  final int glassesConsumed;
  final int totalGlasses;
  final double totalConsumed;
  final double totalGoal;
  final List<Map<String, dynamic>> glasses;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top row displaying "3 of 6 glasses consumed"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '$glassesConsumed of $totalGlasses glasses consumed',
                  style: context.labelLarge!
                      .copyWith(fontWeight: FontWeight.w500)),
              Image.asset(ImageConst.glass)
            ],
          ),
          8.verticalSpace,

          /// Displaying the total water consumed and goal
          Row(
            children: [
              Text('${totalConsumed.toStringAsFixed(1)}ML',
                  style: context.labelLarge!
                      .copyWith(color: const Color(0xFF008CC7))),
              Text(' / ${totalGoal.toStringAsFixed(1)}ML',
                  style: context.labelLarge!.copyWith(color: grey)),
            ],
          ),
          16.verticalSpace,
          /// Glasses progress row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: glasses.map((glass) {
              return  Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: glass['isConsumed']
                            ? const Color(0xFFCBF0F8)
                            : const Color(0xFFCBF0F8).withOpacity(0.5),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Image.asset(ImageConst.waterBg),
                        ),
                      ),
                      if (glass['isConsumed']) // Show the icon only if consumed
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.blue.withOpacity(0.4),
                            size: 12,
                          ),
                        ),
                    ],
                  ),
                  4.verticalSpace,
                  Text(
                    '${glass['amount']}ML',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
