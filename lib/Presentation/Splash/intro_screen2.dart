import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/widgets/circluar_button.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/HomeScreen/home_screen.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:get/get.dart';


class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

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
                            Text("Diet Is Important",
                                style: context.headlineSmall!
                                    .copyWith(color: Colors.white)),
                            SizedBox(
                              height: 10.h,
                            ),
                            RichText(
                                text: TextSpan(
                                    style: context.headlineLarge!.copyWith(
                                        color: Colors.white,
                                        fontSize: 60,
                                        height: 1.55),
                                    children: [
                                  TextSpan(text: "Optimize\n"),
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
                                              "Results",
                                              style: TextStyle(
                                                  fontSize: 60,
                                                  color: secondary,
                                                  fontFamily: 'Jockey One'),
                                            ),
                                          ))),
                                  TextSpan(text: "\nWith Our\n"),
                                  WidgetSpan(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFE4BB49),
                                                    Color(0xFFAB7D01)
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter),
                                              borderRadius:
                                                  BorderRadius.circular(15.r)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.h),
                                            child: Text(
                                              "Meal Tracker",
                                              style: TextStyle(
                                                  fontSize: 60,
                                                  color: secondary,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Jockey One"),
                                            ),
                                          )))
                                ]))
                          ]),
                    )
                  ],
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: CircularButton(
                onTap: (){
                  Get.toNamed(AppRoutes.selectYourPlan);
                },
                isNext: true
              ),
            ),
          )
        ],
      ),
    );
  }
}
