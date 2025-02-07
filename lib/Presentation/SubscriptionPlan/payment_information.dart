import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_TextField.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import '../../Utils/Const/asset_const.dart';

class PaymentInformation extends StatelessWidget {
  const PaymentInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBar(
        title: 'Payment Information',
        leadingIcon: Icons.adaptive.arrow_back,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.verticalSpace,

                ///Yearly PLan
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Container(
                        height: 140.h,
                        width: 398.w,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                            color: darkTheme,
                            borderRadius: BorderRadius.circular(22.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yearly Plan',
                              style: context.titleMedium!
                                  .copyWith(color: yellowText),
                            ),
                            10.verticalSpace,
                            RichText(
                              text: TextSpan(
                                text: '\$59.99',
                                style: context.titleLarge!
                                    .copyWith(fontSize: 25.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '/year',
                                    style: context.titleMedium!.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            20.verticalSpace,
                            Text(
                              'Cancel Subscription anytime',
                              style:
                                  context.titleSmall!.copyWith(color: darkGrey),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        right: 40, child: Image.asset(ImageConst.bestValue)),
                    10.verticalSpace,
                  ],
                ),
                20.verticalSpace,

                ///Payment Method
                Text(
                  'Payment Method',
                  style: context.labelLarge!.copyWith(fontSize: 20.sp),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///Google Pay
                    Container(
                      height: 60.h,
                      width: 189.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colors.grey.withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(height: 25.h, ImageConst.google),
                          5.horizontalSpace,
                          Text(
                            'Pay',
                            style: context.labelLarge!.copyWith(
                              fontSize: 22.sp,
                            ),
                          )
                        ],
                      ),
                    ),

                    ///Apple Pay
                    Container(
                      height: 60.h,
                      width: 189.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colors.grey.withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(height: 25.h, ImageConst.apple),
                          5.horizontalSpace,
                          Text(
                            'Pay',
                            style: context.labelLarge!.copyWith(
                              fontSize: 22.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                40.verticalSpace,

                ///Divider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.5.h,
                      width: 149.w,
                      decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                    ),
                    10.horizontalSpace,
                    Text(
                      'or',
                      style: context.labelLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: darkGrey),
                    ),
                    10.horizontalSpace,
                    Container(
                      height: 1.5.h,
                      width: 149.w,
                      decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                    ),
                  ],
                ),
                40.verticalSpace,

                ///Your Card Info
                Text(
                  'Your Card Info',
                  style: context.labelLarge!.copyWith(fontSize: 20.sp),
                ),
                20.verticalSpace,
                CustomTextField(
                    prefix: Icon(Icons.credit_card), hintText: 'Card Number'),
                10.verticalSpace,
                Divider(color: grey.withOpacity(0.4)),
                CustomTextField(
                    prefix: Icon(Icons.person), hintText: 'Card Holder Name'),
                10.verticalSpace,
                Divider(color: grey.withOpacity(0.4)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(hintText: 'Expiry Date'),
                          Container(
                            height: 1.5.h,
                            width: 170.w,
                            decoration:
                                BoxDecoration(color: grey.withOpacity(0.2)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(hintText: 'CVV'),
                          Container(
                            height: 1.5.h,
                            width: 170.w,
                            decoration:
                                BoxDecoration(color: grey.withOpacity(0.2)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                30.verticalSpace,
                CustomButton(
                  title: 'Add Card',
                  onTap: () {
                    _dialogBuilder(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
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
