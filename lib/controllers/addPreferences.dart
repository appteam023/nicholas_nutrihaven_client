import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Data/Repository/addPreferenceRepository.dart';

import '../Data/DataSources/remote/api_constant.dart';
import '../Data/Repository/auth_repository.dart';
import '../Presentation/Auth/SignUp/signup_controller.dart';
import '../Widgets/custom_snackbar.dart';
import '../Widgets/loader_widget.dart';

class AddpreferencesController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  String? gender;

  int? age = 28;
  int? weight = 54;
  String weightUnit = "kg";

  String heighttUnit = "";

  int? heightFeet = 5;
  int? heightInches = 2;
  Map<int,String>? goal;
  Map<int,String>? level;

  String exercisePlace = "";
  String exerciseEquipment = "";

  Map<int, String> goalData = {
    0: "weight_loss",
    1: "weight_gain",
    2: "stay_healthy",
  };
  final Map<int,String> activityLevels = {
    0: 'Rookie',
    1: 'Beginner',
    2: 'Intermediate',
    3: 'Advance',
    4: 'True Beast',
  };

  @override
  void onInit() {
    super.onInit();
    goal = {goalData.entries.first.key : goalData.entries.first.value};
    level = {activityLevels.entries.first.key : activityLevels.entries.first.value};
  }

  void addPreference(String id) async {
    final signUpController = Get.find<SignupController>();
    try {
      var data = {
        "member_full_name": signUpController.emailController?.text.split("@").first ?? "",
        "member_email": signUpController.emailController?.text,
        "member_password": signUpController.passController?.text,
        // "member_profile": "profile_image.jpg",
        "member_gender": gender?.toLowerCase(),
        "member_age": age,
        "member_weight": weight,
        "member_weight_unit": weightUnit,
        "member_height_ft": heightFeet,
        "member_height_in": heightInches,
        "member_goal": goal?.values.first,
        "member_exp": level?.values.first.toLowerCase(),
        "member_excerise_place": exercisePlace
      };

      log(data.toString());
      showLoader(true);

      authRepository.SignupApiRepo(data).then((value) async {
        debugPrint("Calling Success ==> $value");
        debugPrint("Calling Success ==> ${value..runtimeType}");
        if (value.user != null) {
          log("response ==> $value");
          debugPrint("object => $value");

          ApiConstants.userId = value.user!.memberId.toString();
          log("Api constants >>> " + ApiConstants.userId);

          showLoader(false);

          update();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            CustomSnackBar(
              message: "Success 👏, Registered successfully",
            ),
          );
          Get.offAllNamed(AppRoutes.drawer);
          if (kDebugMode) {
            print(value.toString());
          }
        } else {
          showLoader(false);

          update();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            CustomSnackBar(
              message: "${value.message}",
              backgroundColor: Colors.red.withValues(alpha: 0.9),
            ),
          );
        }
      }).onError((error, stackTrace) {
        showLoader(false);
        update();
        if (kDebugMode) {
          print(error.toString());
        }
      });

      // var response = await authRepository.postPreference(data, id);
      //
      // if (response['success'] == true) {
      //   ScaffoldMessenger.of(Get.context!).showSnackBar(
      //       SnackBar(content: Text("Preferences has been updated")));
      //
      //   Get.offAllNamed(AppRoutes.bottomBar);
      // } else {
      //   ScaffoldMessenger.of(Get.context!)
      //       .showSnackBar(SnackBar(content: Text("Something went Wrong")));
      // }
    } catch (e) {
      log(e.toString());
    }
  }
}
