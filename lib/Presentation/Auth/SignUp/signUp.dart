import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/api_constant.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/SignUpInfo/exercise_equipments.dart';
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

import '../../../Config/AppRoutes/routes_imports.dart';

class SignupInformationPageView extends StatefulWidget {
  const SignupInformationPageView({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

final AddpreferencesController addpreferencesController =
    Get.put(AddpreferencesController());

class _OnboardingScreenState extends State<SignupInformationPageView> {
  late PageController pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
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
              ExerciseEquipments(),
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
                : yellowText.withOpacity(0.5),
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
          if (_currentPage == 7) {
            var id = ApiConstants.userId;
            log("idd" + id);
            addpreferencesController.addpreference(id);
            // Get.offAllNamed(AppRoutes.bottomBar);
          } else {
            _nextPage(_currentPage + 1);
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
                _currentPage != 7 ? 'Next' : 'Finished',
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
