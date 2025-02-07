import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';

import '../../../../Config/AppRoutes/routes_imports.dart';
import '../../../../Utils/Const/color_const.dart';
import '../widgets/circluar_button.dart';
import '../widgets/grad_button.dart';

class GenderInfo extends StatefulWidget {
  @override
  _GenderInfoState createState() => _GenderInfoState();
}

final AddpreferencesController addpreferencesController =
    Get.put(AddpreferencesController());

class _GenderInfoState extends State<GenderInfo> {
  String? selectedGender; // Tracks the selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            80.verticalSpace,
            Text(
              'What Is Your Gender?',
              style: context.headlineLarge!
                  .copyWith(color: primary, fontWeight: FontWeight.w400),
            ),
            20.verticalSpace,
            Text(
              'To Give You a Better Experience We \nNeed To Know Your Gender',
              style: context.bodyMedium!.copyWith(fontFamily: 'Inter'),
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            GenderButton(
              icon: Icons.male,
              label: 'Male',
              color: Color(0xFF0060D6),
              isSelected: selectedGender == 'Male',
              onTap: () {
                setState(() {
                  selectedGender = 'Male';
                  addpreferencesController.gender = selectedGender!;
                  log(addpreferencesController.gender);
                });
              },
            ),
            40.verticalSpace,
            GenderButton(
              icon: Icons.female,
              label: 'Female',
              color: Color(0xFFFF38AF),
              isSelected: selectedGender == 'Female',
              onTap: () {
                setState(() {
                  selectedGender = 'Female';
                  addpreferencesController.gender = selectedGender!;
                  log(addpreferencesController.gender);
                });
              },
            ),
            // 100.verticalSpace,
            // Row(
            //   children: [
            //     CircularButton(onTap: () {
            //       print('Button tapped');
            //       Get.toNamed(AppRoutes.signIn);
            //     }),
            //     Spacer(),
            //     GradButton(
            //       title: 'Next',
            //       onTap: () {
            //         Get.toNamed(AppRoutes.ageFinder);
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

/// GenderButton Widget
class GenderButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200.w,
        height: 200.h,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Color(0xffECECEC),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 90),
            10.verticalSpace,
            Text(label,
                style: context.headlineSmall!.copyWith(
                  color: Color(0xFF666666),
                )),
          ],
        ),
      ),
    );
  }
}
