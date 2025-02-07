import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicholas_nutrihaven/Presentation/Splash/splash_controller.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  @override
  final SplashController splashController = Get.put(SplashController());

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(ImageConst.leftlogo),
            Image.asset("assets/images/logo.png"),
            Image.asset("assets/images/rightlogo.png"),
          ],
        ),
      ),
    );
  }
}
