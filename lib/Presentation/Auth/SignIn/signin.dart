import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignIn/signIn_controller.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/signup_controller.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignUp/widgets/grad_button.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/HomeScreen/home_screen.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_TextField.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import 'package:nicholas_nutrihaven/main.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../Utils/Const/asset_const.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Get.put(SignInController());
    final SignupController signUpController = Get.put(SignupController());

    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              forceMaterialTransparency: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                      labelColor: Color(0xff9A8947),
                      indicatorColor: Color(0xff9A8947),
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: Text("Login"),
                        ),
                        Tab(
                          child: Text("Sign up"),
                        ),
                      ]),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                ///LOGIN
                Stack(
                  children: [
                    Image.asset(
                      ImageConst.login,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            themeColor.withOpacity(0.7),
                            themeColor.withOpacity(0.7),
                            themeColor.withOpacity(0.25),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          child: Image.asset("assets/images/profilePic.png"),
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                        )),
                    Positioned(
                      top: 250.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: 290.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Welcome Back, Partner",
                                  style: context.headlineLarge!
                                      .copyWith(fontSize: 50.sp)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                        clipper: DiagonalClipper(),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 100.h, left: 20, right: 10),
                          height: 520.h,
                          width: double.infinity,
                          color: Colors.white,
                          child: Form(
                            key: signInController.logInFormKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.verticalSpace,
                                  Text(
                                    'Email',
                                    style: context.labelSmall!.copyWith(
                                        fontSize: 15.sp,
                                        color: mustardYellow,
                                        fontFamily: 'Product Sans'),
                                  ),
                                  CustomTextField(
                                    hintText: 'Enter Your Email',
                                    controller:
                                        signInController.emailController,
                                  ),
                                  Divider(color: grey.withOpacity(0.4)),
                                  20.verticalSpace,
                                  Text(
                                    'Password',
                                    style: context.labelSmall!.copyWith(
                                        fontSize: 15.sp,
                                        color: mustardYellow,
                                        fontFamily: 'Product Sans'),
                                  ),
                                  Obx(
                                    () => TextFormField(
                                      controller:
                                          signInController.passController,
                                      textAlign: TextAlign.start,
                                      obscureText:
                                          signInController.isHide.value,
                                      scribbleEnabled: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        labelText: "Enter Your Password",
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            signInController.setIsHidePass();
                                          },
                                          icon: Icon(
                                            signInController.isHide.value
                                                ? Icons
                                                    .visibility_off // Eye with slash when hidden
                                                : Icons
                                                    .visibility, // Normal eye when visible
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),

                                  10.verticalSpace,
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                          onPressed: () {
                                            signInController
                                                .forgotPassDialog(context);
                                          },
                                          child: Text(
                                            "Forget Password?",
                                            style: TextStyle(
                                                color: Color(0xff9A8947),
                                                fontFamily: "Product Sans",
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  // 50.verticalSpace,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 40,
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            radius: 30.r,
                                            backgroundColor: Color(0xffD9D9D9),
                                            child: Icon(
                                              Icons.apple,
                                              color: Colors.black,
                                              size: 50.h,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                              radius: 30.r,
                                              backgroundColor:
                                                  Color(0xffE9E9E9),
                                              child: Image.asset(
                                                  "assets/images/googleIcon.png")),
                                        ),
                                        90.horizontalSpace,
                                        GradButton(
                                          title: 'Login',
                                          onTap: () {
                                            signInController.login();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                ///SIGNUP
                Stack(
                  children: [
                    /// Full-width Image
                    Image.asset(
                      ImageConst.signIn2,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),

                    /// Black Overlay with Reduced Opacity
                    Container(
                      width: double.infinity,
                      height: double.infinity, // Matches the image dimensions
                      color: Colors.black
                          .withOpacity(0.5), // Black with 50% opacity
                    ),

                    /// Profile Image at the Top Right
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Image.asset(ImageConst.profile),
                      ),
                    ),

                    /// Welcome Text Positioned
                    Positioned(
                      top: 250.h,
                      left: 20.w, // Adjusted padding for proper positioning
                      right: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hello Rookies,",
                              style: context.headlineLarge!
                                  .copyWith(fontSize: 50.sp)),
                          10.verticalSpace,
                          Text(
                              "Enter your information below or \nlogin with a other account",
                              style: context.titleMedium!
                                  .copyWith(fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),

                    /// Bottom Section with Clipped Background
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                        clipper: DiagonalClipper(),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 100.h,
                            left: 15,
                            right: 15,
                          ),
                          height: 520.h,
                          width: double.infinity,
                          color: Colors.white,
                          child: Form(
                            key: signUpController.signUpFormKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.verticalSpace,

                                  /// Email Input Field
                                  // CustomTextField(hintText: 'Email'),
                                  // Divider(color: grey.withOpacity(0.4)),
                                  // 30.verticalSpace,
                                  TextFormField(
                                    textAlign: TextAlign.start,
                                    controller:
                                        signUpController.emailController,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      labelStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  20.verticalSpace,

                                  /// Password Input Field
                                  Obx(() {
                                    return TextFormField(
                                      textAlign: TextAlign.start,
                                      obscureText:
                                          signUpController.isHide.value,
                                      controller:
                                          signUpController.passController,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            signUpController
                                                .toggleHidePassword();
                                          },
                                          icon: Icon(
                                            signUpController.isHide.value
                                                ? Icons
                                                    .visibility_off // Eye with slash when hidden
                                                : Icons
                                                    .visibility, // Normal eye when visible
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    );
                                  }),
                                  20.verticalSpace,

                                  /// Confirm Password Input Field
                                  Obx(
                                    () => TextFormField(
                                      textAlign: TextAlign.start,
                                      obscureText:
                                          signUpController.isConfirmHide.value,
                                      controller: signUpController.confirmPass,
                                      decoration: InputDecoration(
                                        labelText: "Confirm Password",
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            signUpController
                                                .toggleConfirmHidePassword();
                                          },
                                          icon: Icon(
                                            signUpController.isConfirmHide.value
                                                ? Icons
                                                    .visibility_off // Eye with slash when hidden
                                                : Icons
                                                    .visibility, // Normal eye when visible
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                  70.verticalSpace,

                                  /// Social Login and Next Button Row
                                  Row(
                                    children: [
                                      // Apple Button
                                      GestureDetector(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          radius: 30.h,
                                          backgroundColor: Color(0xffD9D9D9),
                                          child: Icon(
                                            Icons.apple,
                                            color: Colors.black,
                                            size: 50.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20.w),

                                      // Google Button
                                      GestureDetector(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          radius: 30.h,
                                          backgroundColor: Color(0xffE9E9E9),
                                          child: Image.asset(
                                              "assets/images/googleIcon.png"),
                                        ),
                                      ),
                                      Spacer(),

                                      /// Next Button
                                      GradButton(
                                        title: 'Next',
                                        onTap: () {
                                          // Get.offAllNamed(AppRoutes.signupInfo);
                                          signUpController.signup();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 100);
    path.lineTo(size.width, 0); // Adjust the diagonal height here
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: 400.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/correct.png"),
              Text(
                'Congratulations',
                style: context.headlineLarge!.copyWith(color: primary),
              ),
              10.verticalSpace,
              Text("      Payment Success! \n let's setup your account"),
            ],
          ),
        ),
        actions: <Widget>[
          SizedBox(
            height: 20.h,
          ),
          Align(
              alignment: Alignment.center,
              child: CustomButton(
                title: "Create Account",
                width: 250.w,
                onTap: () {
                  Get.toNamed(AppRoutes.signIn);
                },
              ))
        ],
      );
    },
  );
}
