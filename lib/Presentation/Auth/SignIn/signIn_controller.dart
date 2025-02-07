import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignIn/signin.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../Config/AppRoutes/routes_imports.dart';
import '../../../Data/DataSources/remote/api_constant.dart';
import '../../../Data/Repository/auth_repository.dart';
import '../../../Helpers/get_storare_helper.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/loader_widget.dart';

class SignInController extends GetxController {
  GlobalKey<FormState>? logInFormKey;
  TextEditingController? emailController;
  TextEditingController? passController;
  final AuthRepository _authRepository = AuthRepository();
  final RxBool _loading = false.obs;
  final RxBool _remember = false.obs;
  final RxBool _isHide = true.obs;
  RxBool get remember => _remember;

  set setRemember(bool val) {
    _remember.value = val;
    update();
  }

  RxBool get isHide => _isHide;

  setIsHidePass() {
    _isHide.value = !_isHide.value;
  }

  void login() async {
    if (logInFormKey!.currentState!.validate()) {
      FocusNode().unfocus();
      // var fcmToken = await NotificationServices().getDeviceToken();

      Map<String, dynamic> data = {
        "email": emailController?.text.trim(),
        "password": passController?.text.trim()
      };

      print('logindata ====== ${data}');
      showLoader(true);

      _authRepository.SigninApiRepo(data).then((value) async {
        debugPrint("Calling Success ==> $value");
        debugPrint("Calling Success ==> ${value..runtimeType}");
        if (value!.success == true) {
          log("response ==> $value");
          debugPrint("object => $value");

          ApiConstants.userId = value.data!.user!.sId!;
          log("Api constants >>> " + ApiConstants.userId);

          // ApiConstants.userData = null;
          // await saveUser(user: value);
          // ApiConstants.userData = getUser();

          /// Save remember me = true
          await setRememberMe(isRemember: true);
          showLoader(false);

          update();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            CustomSnackBar(
              message: "Success 👏, Sign in successfully",
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
              backgroundColor: Colors.red.withOpacity(0.9),
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
    }
  }

  @override
  void onInit() {
    super.onInit();
    logInFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passController = TextEditingController();
    // login();
  }

  forgotPassDialog(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 350.h,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Text(
                  'Password Recovery',
                  style: context.headlineLarge!.copyWith(color: primary),
                )),
                10.verticalSpace,
                Center(
                    child: Text(
                        "Enter Your Email Address to get \n             Verification code")),
                10.verticalSpace,
                TextFormField(
                  textAlign: TextAlign.start,
                  // maxLength: 40,
                  scribbleEnabled: true,

                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey),
                      floatingLabelStyle:
                          context.bodySmall!.copyWith(color: Color(0xff9A8947)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                30.verticalSpace,
                CustomButton(
                  title: "Continue",
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 370.h,
                          width: MediaQuery.sizeOf(context).width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.h, vertical: 20.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Verification Code",
                                  style: context.headlineLarge!
                                      .copyWith(color: primary),
                                ),
                                10.verticalSpace,
                                Text("Enter your verification code sent"),
                                10.horizontalSpace,
                                Text("to your Email"),
                                20.verticalSpace,
                                OtpTextField(
                                  numberOfFields: 5,
                                  borderColor: Color(0xFF512DA8),
                                  showFieldAsBox: true,
                                  onCodeChanged: (String code) {},
                                  onSubmit: (String verificationCode) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Verification Code"),
                                            content: Text(
                                                'Code entered is $verificationCode'),
                                          );
                                        });
                                  },
                                ),
                                40.verticalSpace,
                                CustomButton(title: 'Continue')
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
