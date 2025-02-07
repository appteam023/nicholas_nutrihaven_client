import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import '../../Utils/Const/asset_const.dart';

class SelectYourPlan extends StatefulWidget {
  const SelectYourPlan({super.key});

  @override
  State<SelectYourPlan> createState() => _SelectYourPlanState();
}

class _SelectYourPlanState extends State<SelectYourPlan> {
  bool isTrialEnabled = false; // Toggle switch state

  @override
  Widget build(BuildContext context) {
    // List of feature texts
    final List<String> features = [
      'Feature 1 name here',
      'Feature 2 name here',
      'Feature 3 name here',
      'Feature 4 name here',
    ];

    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  height: 251.h,
                  ImageConst.selectPlan,
                ),
              ),
              15.verticalSpace,
              Text(
                'Unlock all features',
                style: context.headlineLarge,
              ),
              20.verticalSpace,

              /// Features List with Spacing
              Column(
                children: features
                    .map((feature) => Padding(
                  padding: EdgeInsets.only(bottom: 20.h), // Add spacing
                  child: _buildFeatureRow(context, feature),
                ))
                    .toList(),
              ),
              30.verticalSpace,
              Text(
                'Buy for \$9.99/ per month',
                style: context.headlineSmall,
              ),
              40.verticalSpace,
              Container(
                width: 397.w,
                height: 80.h,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Not sure yet?',
                          style: context.titleMedium,
                        ),
                        Text(
                          'Enable free trial',
                          style: context.titleSmall,
                        ),
                      ],
                    ),
                    Switch(
                      value: isTrialEnabled,
                      onChanged: (value) {
                        setState(() {
                          isTrialEnabled = value; // Update the switch state
                        });
                      },
                      activeColor: Colors.blue, // Switch active color
                      inactiveThumbColor: Colors.grey, // Inactive thumb color
                      inactiveTrackColor: Colors.grey.shade400, // Inactive track color
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent, // Transparent background
                  borderRadius: BorderRadius.circular(10.r), // Rounded corners
                  border: Border.all(
                    color: Colors.white, // White border
                    width: 1.0, // Border thickness
                  ),
                ),
              ),

              30.verticalSpace,

              CustomButton(
                title: 'View All Package',
                width: 397.w,
                onTap: () {
                  Get.toNamed(AppRoutes.paymentInformation);
                },
              ),
              20.verticalSpace,
              Text(
                'Privacy Policy  \|  Term of Use  \|  Restore Purchase',
                style: context.titleSmall!.copyWith(color: darkGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper method to create a feature row
  Widget _buildFeatureRow(BuildContext context, String feature) {
    return Row(
      children: [
        Image.asset(ImageConst.points),
        15.horizontalSpace,
        Text(
          feature,
          style: context.titleMedium!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
