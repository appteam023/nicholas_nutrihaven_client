import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Config/AppRoutes/routes_imports.dart';
import '../../Config/session_manager.dart';
import '../../Helpers/get_storare_helper.dart';

class SplashController extends GetxController {
  RxBool isScale = false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() async {
    Future.delayed(Duration(milliseconds: 1000), () {
      isScale.value = true;
    });

    Future.delayed(Duration(seconds: 3), () {});

    var isWelcome = await getWelcome();
    var user = getUser(); // Ensure this method exists
    debugPrint("user ==> $user");

    debugPrint("isWelcome ==> $isWelcome");
    var isRemember = await getRemember();
    var token = getToken();
    debugPrint("isRemember ==> $isRemember");

    if (isWelcome == false) {
      saveWelcome(isWelcome: true);
      Future.delayed(const Duration(milliseconds: 4000), () async {
        // Get.offAllNamed(AppRoutes.termsCondition);

        // Temporary skip intro screen
        Get.offAllNamed(AppRoutes.introScreen);
      });
    } else {
      if (user != null && isRemember == true && token != null) {
        Future.delayed(const Duration(milliseconds: 3000), () async {
          debugPrint("Welcome to HomeScreen");
          AppSessionManager().setUserToken(token);
          AppSessionManager().setUserID("${user.memberId}");
          AppSessionManager().setUserData = user;
          Get.offAllNamed(AppRoutes.bottomBar);
        });
      } else if (user != null && isRemember == false) {
        Future.delayed(const Duration(milliseconds: 3000), () async {
          Get.offNamed(AppRoutes.signIn);
          debugPrint("$isRemember ==>");
        });
      } else {
        Future.delayed(const Duration(milliseconds: 3000), () async {
          Get.offAllNamed(AppRoutes.signIn);
        });
      }
    }
  }
}
