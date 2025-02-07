import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/api_constant.dart';
import '../../../Data/Repository/auth_repository.dart';
import '../../../Utils/Const/asset_const.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_snackbar.dart';
import '../../../Widgets/loader_widget.dart';

class SignupController extends GetxController {
  GlobalKey<FormState>? signUpFormKey;
  TextEditingController? fullnameController;
  TextEditingController? emailController;
  TextEditingController? passController;
  TextEditingController? confirmPass;

  RxBool checkBox = false.obs;
  RxBool isHide = true.obs;
  RxBool isConfirmHide = true.obs;

  void toggleHidePassword() {
    isHide.value = !isHide.value;
  }

  void toggleConfirmHidePassword() {
    isConfirmHide.value = !isConfirmHide.value;
  }

  void togglecheckBox() {
    checkBox.value = !checkBox.value;
  }

  @override
  void onInit() {
    super.onInit();
    signUpFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    fullnameController = TextEditingController();
    passController = TextEditingController();
    confirmPass = TextEditingController();
  }

  void dispose() {
    emailController?.dispose();
    fullnameController?.dispose();
    passController?.dispose();
    confirmPass?.dispose();
    super.dispose();
  }

  final AuthRepository _authRepository = AuthRepository();

  void signup() {
    final Map<String, dynamic> data = {
      "email": emailController?.text.trim(),
      "password": passController?.text.trim(),
      "confirmPassword": confirmPass?.text.trim()
    };
    print('Signup API==> $data');
    showLoader(true);
    _authRepository.SignupApiRepo(data).then((value) async {
      if (value['success'] == true) {
        showLoader(false);
        ApiConstants.userId = value["data"];
        log(">>>" + ApiConstants.userId);
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          CustomSnackBar(
            message: "${value['message']}",
          ),
        );
        Get.toNamed(AppRoutes.signupInfo);
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        showLoader(false);
        update();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          CustomSnackBar(
            message: "${value.message}",
            backgroundColor: yellow,
          ),
        );
      }
    }).onError((error, stackTrace) {
      showLoader(false);
      update();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        CustomSnackBar(
          message: "$error",
          backgroundColor: Colors.red,
        ),
      );
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
