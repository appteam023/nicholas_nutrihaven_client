import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/HomeScreen/home_screen.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import 'package:nicholas_nutrihaven/main.dart';
import 'package:get/get.dart';


import '../../Utils/Const/color_const.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            color: themeColor,
            // height: 100.h,
            // width: 400.w,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style: context.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Before you create an account, please read and accept our Terms & Conditions",
                  style: context.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Terms & Conditions",
                      style: context.headlineLarge!.copyWith(color: primary),
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.",
                      style: context.bodyLarge,
                    ),
                    10.verticalSpace,
                    Text(
                      "1. Conditon Of Use",
                      style:
                          context.headlineSmall!.copyWith(color: Colors.black),
                    ),
                    Text(
                        "Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type."),
                    Text(
                      "2. Privacy Policy",
                      style:
                      context.headlineSmall!.copyWith(color: Colors.black),
                    ),
                    Text("Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.",),
                    Text(
                      "3. Intellectual Property",
                      style:
                      context.headlineSmall!.copyWith(color: Colors.black),
                    ),
                    Text("Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.",),

                    65.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        color: Colors.white,
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10.h),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Decline"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r)),
                  minimumSize: Size.fromHeight(55.h),
                  foregroundColor: grey,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ),
            20.horizontalSpace,
            Expanded(
              child: CustomButton(
                title: 'Accept',
                onTap: (){
                  Get.toNamed(AppRoutes.introScreen);
                },
                // width: 100.w,
              ),
            ),
            // Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}
