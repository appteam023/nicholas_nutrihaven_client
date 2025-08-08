import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/api_constant.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/exercise_place.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/gender_info.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/goals.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/height_picker.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/physical_activity.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/weight_info.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/age_selector_widget.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/controllers/addPreferences.dart';


class SignupInformationPageView extends StatefulWidget {
  const SignupInformationPageView({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}


class OnboardingScreenState extends State<SignupInformationPageView> {
  late final AddpreferencesController addPreferencesController;
  late PageController pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    addPreferencesController = Get.put(AddpreferencesController());
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage(int page) {
    // setState(() {
    _currentPage = page;
    // });
    pageController.animateToPage(_currentPage,
        duration: const Duration(milliseconds: 800), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: _onPageChanged,
            children: [
              GenderInfo(),
              const AgeSelectorWidget(),
              WeightInfo(),
              HeightPickerScreen(),
              GoalScreen(),
              PhysicalActivity(),
              const ExercisePlace(),
              // ExerciseEquipments(),
            ],
          ),
          Positioned(
            top: 20.h,
            right: 0,
            left: 0,
            child: _buildPageIndicator(),
          ),
          Positioned(
            bottom: 40.h,
            child: GestureDetector(
              onTap: () {
                if(_currentPage == 0) {
                  Get.back();
                  return;
                }
                _currentPage--;
                pageController.animateToPage(_currentPage--,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.ease);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 60.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                        gradient: gradientYellow,
                        border: Border.all(color: yellow),
                        borderRadius: radius * 2, // Set the border radius
                      ),
                      child: Icon(
                        Icons.adaptive.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    _buildButton(),
                    // _buildPageIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        8,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          height: 10.h,
          width: _currentPage == index ? 40.w : 10.h,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? yellowText
                : yellowText.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Material(
      color: Colors.transparent, // Prevents unnecessary background color
      child: InkWell(
        onTap: () {
          if (_currentPage == 6 && (addPreferencesController.exercisePlace.isNotEmpty)) {
            var id = ApiConstants.userId;
            log("idd $id");
            addPreferencesController.addPreference(id);
            // Get.offAllNamed(AppRoutes.bottomBar);
          } else {
            // if(addPreferencesController.gender == null || addPreferencesController.age == null ||
            //     addPreferencesController.weight == null ||addPreferencesController.heightFeet == null || addPreferencesController.heightInches == null ||
            //     addPreferencesController.goal == null || addPreferencesController.goal!.isEmpty ||
            //     addPreferencesController.level == null || addPreferencesController.level!.isEmpty ||
            //     addPreferencesController.exercisePlace.isEmpty
            // ) {
            //   return;
            // }
            if(addPreferencesController.gender != null && _currentPage == 0) {
              _nextPage(_currentPage + 1);
              return;
            }
            else if(addPreferencesController.age != null && _currentPage == 1) {
              _nextPage(_currentPage + 1);
              return;
            }
            else if(addPreferencesController.weight != null && _currentPage == 2) {
              _nextPage(_currentPage + 1);
              return;
            }
            else if(addPreferencesController.heightFeet != null && _currentPage == 3) {
              _nextPage(_currentPage + 1);
              return;
            }
            else if((addPreferencesController.goal != null && addPreferencesController.goal!.isNotEmpty) && _currentPage == 4) {
              _nextPage(_currentPage + 1);
              return;
            }
            else if((addPreferencesController.level != null && addPreferencesController.level!.isNotEmpty) && _currentPage == 5) {
              _nextPage(_currentPage + 1);
              return;
            }
            // else if((addPreferencesController.exercisePlace.isNotEmpty) && _currentPage == 6) {
            //   _nextPage(_currentPage + 1);
            //   return;
            // }
            // _nextPage(_currentPage + 1);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          height: 60.h,
          decoration: BoxDecoration(
            gradient: gradientYellow,
            borderRadius: radius * 2, // Set the border radius
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentPage != 6 ? 'Next' : 'Finished',
                style: context.headlineSmall!.copyWith(fontSize: 20.sp),
              ),
              10.horizontalSpace,
              Icon(
                Icons.adaptive.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
