import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../Utils/Const/color_const.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final bool isGradient;
  final String title;
  final TextStyle? style;
  final VoidCallback? onTap;
  final bool isBordered;
  final bool loading;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    super.key,
    this.width,
    this.height,
    this.isGradient = true,
    required this.title,
    this.style,
    this.onTap,
    this.loading = false,
    this.isBordered = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null && !loading;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width ?? double.infinity,
      height: height,
      margin: margin,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: isEnabled && isGradient ? gradientYellow : gradientGrey,
        borderRadius: radius * 2,
      ),
      child: loading
          ? MaterialButton(
              height: 55.h,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r)),
              onPressed: () {},
              child: isGradient
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'loading',
                            style: style ??
                                context.titleLarge!.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        10.horizontalSpace,
                        SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            color: secondary,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'loading',
                            style: style ?? context.bodyLarge,
                          ),
                        ),
                        10.horizontalSpace,
                        CircularProgressIndicator(
                          strokeWidth: 1,
                          color: secondary,
                        ),
                      ],
                    ),
            )
          : MaterialButton(
              height: 55.h,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r)),
              onPressed: onTap,
              child: isGradient
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        style: style ??
                            context.titleLarge!.copyWith(
                                fontFamily: 'Jockey One',
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                      ),
                    )
                  : FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(title, style: style ?? context.bodyLarge),
                    ),
            ),
    );
  }
}
