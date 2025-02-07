import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/widgets/circluar_button.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/widgets/grad_button.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/HomeScreen/home_screen.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import 'package:nicholas_nutrihaven/main.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            width: MediaQuery.sizeOf(context).width,
            "assets/images/background1.png",
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 80,
              // left: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/smalllogo.png"),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to NutriHeaven",
                            style: context.headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RichText(
                              text: TextSpan(
                                  style: context.headlineLarge!
                                      .copyWith(fontSize: 60, height: 1.55),
                                  children: [
                                TextSpan(text: "Your Ultimate \nPath To "),
                                WidgetSpan(
                                    child: Container(
                                        // padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFE4BB49),
                                                Color(0xFFAB7D01)
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.h),
                                          child: Text(
                                            "Health",
                                            style: TextStyle(
                                              fontSize: 60,
                                              color: secondary,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Jockey One",
                                            ),
                                          ),
                                        ))),
                                TextSpan(text: "\nAnd "),
                                WidgetSpan(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFE4BB49),
                                                Color(0xFFAB7D01)
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.h),
                                          child: Text(
                                            "Fitness",
                                            style: TextStyle(
                                                fontSize: 60,
                                                color: secondary,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Jockey One"),
                                          ),
                                        ))),
                              ])),
                          Text(
                            "Lets Start your Fitness Journey",
                            style: context.headlineSmall!
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: CircularButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.introScreen2);
                  },
                  isNext: true),
            ),
          )
        ],
      ),
    );
  }
}
